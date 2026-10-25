# Reference dependencies and Nighthaven choices

## Reference inventory

| Dependency/assumption | Evidence | Class | Nighthaven treatment |
|---|---|---|---|
| C# / .NET 6 (`net6.0`) | Both executable projects target `net6.0`; Docker installs SDK 6.0 | IMPLEMENTATION-CHOICE; obsolete lifecycle relative to modern supported .NET | Prefer currently supported .NET when implementation begins; retest wire behavior |
| `MySqlConnector` 0.69.4 | Auth and game project references | IMPLEMENTATION-CHOICE | Reference-only provider evidence; keep the selected Nighthaven provider behind one persistence adapter |
| MariaDB 10.2 compose / 10.3.37 schema dump | `docker-compose.yml`, schema header | IMPLEMENTATION-CHOICE; historical deployment | Serious Nighthaven candidate given reference evidence and operator familiarity; not selected automatically |
| PostgreSQL (candidate) | No PostgreSQL dependency in the surveyed reference projects | IMPLEMENTATION-CHOICE | Candidate only; no unique Nighthaven requirement is demonstrated. Select one backend before persistence implementation |
| `System.IO.Pipelines` 5.0.1 | Both game/auth project references | IMPLEMENTATION-CHOICE | Use only if framing/perf needs it; modern BCL APIs may suffice |
| `System.Configuration.ConfigurationManager` 6.0.1 | Project references and app.config access | IMPLEMENTATION-CHOICE | Typed validated config, environment/secrets provider |
| `NLua` 1.6.0 | Game project reference; many `.lua` scripts | IMPLEMENTATION-CHOICE | Optional isolated scripting boundary after core stability |
| `QuadTrees` 1.0.4 | Game project reference; map/visibility managers | IMPLEMENTATION-CHOICE | Choose spatial index from measured needs |
| `Microsoft.Extensions.ObjectPool` 6.0.4 | Game project reference | IMPLEMENTATION-CHOICE | Optional optimization, not protocol requirement |
| `Z.EntityFramework.Extensions.EFCore` 6.16.1 | Game project reference | IMPLEMENTATION-CHOICE | No evidence it defines protocol; assess whether actually used before adoption |
| `Microsoft.AspNet.WebApi.Client` 5.2.9; `System.ServiceModel.Primitives` 4.8.1 | Project references | UNKNOWN usage in inspected startup/network path | Do not carry without verified use case |
| `BCrypt.Net-Next` 4.0.0 | Game project reference; SQL/account paths reference BCrypt hashes | IMPLEMENTATION-CHOICE for password storage | Use a current password hashing policy; never reuse legacy hash format without migration review |
| `EQOACryptoLibrary` (local) | AES/DES helpers; referenced by auth/game | PROTOCOL-RELEVANT where client crypto interoperability is proven; otherwise UNKNOWN | Preserve only behavior demonstrated necessary by client evidence; isolate crypto/profile implementations |
| Docker Compose / Ubuntu 20.04 / Alpine dnsmasq | Dockerfiles, compose | OBSOLETE / HISTORICAL deployment assumptions | Reproducible, minimal deployment; supported base images; do not require Docker for local protocol tests |
| DNS service (dnsmasq), HTTP patch server | README and compose | IMPLEMENTATION-CHOICE / external client bootstrap | Determine whether required for target client setup; keep out of game-domain runtime |
| GitHub Actions + Docker CI | `.github/workflows/ci.yml` | IMPLEMENTATION-CHOICE | CI should build and exercise isolated protocol/persistence tests; no meaningful assertions shown in reference workflow |
| OS/network assumptions | Docker starts Linux images; UDP code has Windows-specific ICMP workaround behind `Windows` symbol; binds any address | IMPLEMENTATION-CHOICE | Explicit bind addresses and tested Linux/Windows support as needed |

## External ports and environment assumptions

Legacy compose maps DNS UDP/TCP service port 53 (UDP mapping shown), HTTP 7000, auth TCP 9735, world UDP 10070, MariaDB TCP 3306. README tells operators to edit IP values in app config and DNS config. App config contains LAN IPs and placeholder credentials; treat them as unsafe example configuration, never as secrets. Compose exposes DB externally and hard-codes development credentials; Nighthaven should not replicate this exposure.

## Protocol relevance classification

No framework, database, scripting engine, spatial index, container runtime, or logging package is inherently an EQOA protocol requirement. Only implementation behavior at the wire boundary may be compatibility-sensitive. The local crypto library may implement a client-required exchange, but source configuration has decryption disabled, so production necessity is **UNKNOWN**. TCP/UDP choices are confirmed for this reference implementation; whether all endpoints/transports are necessary for a target original client flow remains to be established empirically.

