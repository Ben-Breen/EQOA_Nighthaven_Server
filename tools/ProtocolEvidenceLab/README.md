# Protocol evidence tools

This is a **disposable lab probe**, not the Nighthaven server, account service or a standalone content generator. It is independently authored; it contains no reference game assets, Sandstorm manifest/file entries or external code payloads.

`E01BootstrapResponder.ps1` generates a fixed gzip/XML no-file candidate and original Changes text. It serves only the two approved GET shapes on `198.18.0.1:7000`, only to guest `198.18.0.2`, with four-connection, byte and time limits. The local approved capture harness supplies explicit EFS/operator-only artifact paths and owns network isolation, capture, firewall and recovery. That operator-specific harness and all raw/media files remain outside Git. Do not launch the probe without containment, owned capture and explicit per-run approval. No production/global listener is provided.

Offline checks (validated with PowerShell7.6.5 / .NET10.0.11; private harness pins the executable):

```powershell
./Test-E01BootstrapResponder.ps1
```

These19 checks use synthetic values and loopback sockets only; no TAP bind, emulator boot, firewall rule, DNS or adapter change. `-LibraryOnly` loads the responder functions without listening. Gzip/CRC/HTTP/request validation is tested; original-client interoperability requires its separate evidence record.

The approved U02 run delivered the manifest and Changes responses and reached **Writing game data**, followed by a black screen. Account login is **not confirmed**. The responder is a research artifact; do not treat its selected versions/empty Distribution as a proven minimum or widen its endpoint/request scope to work around an unknown.

See [U02 run card](../../docs/evidence/experiments/E01-U02-bootstrap-response.md) and [result](../../docs/evidence/interpretations/eqoa-frontiers-us-e01-u02-20261031-001.md). Broad server protocol implementation remains gated. The next blocker is the post-update client transition; no account-service cause has been established.
