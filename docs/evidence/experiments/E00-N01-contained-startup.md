# E00-N01 — one contained network-startup test

Prepared 2026-10-28. **PREPARED / NOT RUN.** This card specifies one cold start to qualify guest addressing, DNS visibility and the next bootstrap blocker. No guest, capture, listener or network configuration was started or changed during preparation. Existing [R01–R03 controls](../interpretations/eqoa-frontiers-us-e00-offline-20261028-001.md) remain complete within their offline scope.

## Scope and address plan

**NIGHTHAVEN DECISION — proposed isolated test configuration:** use the existing TAP subnet for the guest and local DNS. The operator's later steering favors progress toward a playable client/server slice and questions using the Wi-Fi endpoint for this experiment. Keep `192.168.0.13` as a provisional later deployment address; this test does not depend on it or send traffic through Wi-Fi.

| Role | Planned value |
|---|---|
| PCSX2 backend / interface | TAP / Nighthaven E00 TAP; identify its current component/GUID from the existing lab record |
| Host TAP IPv4 | `198.18.0.1/24`; existing assignment, no host default gateway or DNS on this interface |
| PS2 guest IPv4 | `198.18.0.2/24`, supplied by explicit internal DHCP settings below |
| Guest gateway | `198.18.0.1`; permits attempted off-subnet frames to reach TAP, with host forwarding disabled |
| Guest primary DNS | `198.18.0.1` |
| Guest secondary DNS | None; no fallback to household/public DNS |
| DNS responder | Existing Technitium DNS Server 15.6.2, temporarily restricted to the lab configuration below |
| Application/game server | None running or introduced by this test; no guessed account/game ports |

Host inventory at preparation: Wi-Fi owns `192.168.0.13/24`, TAP owns `198.18.0.1/24`, PCSX2 is closed and Technitium is stopped. These are operational observations, not client/protocol claims. Preserve Wi-Fi addressing; no duplicate address, bridge, NAT or weak-host change is part of this plan.

## Exact emulator settings

Keep the same legally held client, executable, isolated BIOS/sidecars and modified-card seed as R01–R03. Preserve those original inputs and restore fresh active clones. Keep cheats, patches, game fixes and fast boot disabled. Use the saved **EQOA 2** profile; whether it requests automatic addressing is an observation to make, not an assumption established by its name.

The proposed `[DEV9/Eth]` overlay is:

```ini
EthApi = TAP
InterceptDHCP = true
PS2IP = 198.18.0.2
AutoMask = false
Mask = 255.255.255.0
AutoGateway = false
Gateway = 198.18.0.1
ModeDNS1 = Manual
DNS1 = 198.18.0.1
ModeDNS2 = Manual
DNS2 = 0.0.0.0
EthLogDHCP = true
EthLogDNS = true
```

Retain the dedicated TAP GUID in `EthDevice`. Keep `EthEnable=false` during preparation/after cleanup; set it true only for the authorized captured run, with PCSX2 closed. Hash the complete actual INI and active inputs before boot. The overlay is configuration, not a new protocol implementation. It controls DHCP offers; it cannot override a statically configured PS2 profile. If the guest uses another address or does not request DHCP, retain that evidence and stop rather than editing the card mid-run or claiming adoption.

**CONFIRMED — reference (PCSX2 v2.8.2 source):** TAP supplies no IP override, and internal DHCP uses configured `PS2IP` for the offered address. Thus the prior `PS2IP=0.0.0.0` can produce a zero-address offer on this path; whether that caused the earlier failures remains UNKNOWN. [TAP initialization](https://github.com/PCSX2/pcsx2/blob/v2.8.2/pcsx2/DEV9/Win32/tap-win32.cpp#L516-L524), [DHCP configuration/reply](https://github.com/PCSX2/pcsx2/blob/v2.8.2/pcsx2/DEV9/InternalServers/DHCP_Server.cpp#L38-L91). DNS mode values are strings: [settings serialization](https://github.com/PCSX2/pcsx2/blob/v2.8.2/pcsx2/Pcsx2Config.cpp#L1225-L1275). Exact source/binary correspondence and the client's response remain INFERRED/UNKNOWN.

## Containment and permitted traffic

Before execution, save the current service/adapter/settings states and exact rollback steps in restricted local storage. Disable external physical links for this short session, retain TAP, and verify no active alternate uplink/default route, bridge, native forwarding, ICS or RRAS. Keep WinNAT stopped; unavailable NAT-table enumeration remains UNKNOWN. Include VPN/virtual uplinks if present. Physical disconnection contains the emulator's possible host-resolver path as well as TAP traffic; a guest gateway is not permission to forward packets.

| Traffic | Policy |
|---|---|
| ARP on the isolated TAP link | Permit address/gateway resolution; retain probe frames, including zero-address probes |
| DHCP client/server exchange | Permit inside PCSX2's internal DHCP path, including bootstrap broadcasts; do not start a Windows DHCP server |
| Guest `198.18.0.2` → TAP host `198.18.0.1`, UDP/TCP 53 and corresponding replies | Permit local DNS only; scope any needed temporary host firewall allowance to TAP, these addresses and port 53 |
| Operator DNS health check to the lab resolver | Permit and label separately from guest evidence |
| Any other IPv4/IPv6, household LAN, Internet, historical/revival endpoints | No delivery outside the lab; observe attempted TAP frames without forwarding them. No public DNS fallback, game/database/admin exposure or broad firewall disablement |

Temporarily configure the installed DNS responder for `198.18.0.1:53` only, recursion `Deny`, query logging enabled to the EFS raw directory, no forwarding/proxy/secondary/stub-zone egress or automatic network updates. Preserve its prior settings/service state and firewall rules for restoration; keep configuration backups/tokens restricted outside Git rather than importing household zones into evidence. Its management endpoint must remain loopback-only. Official [Technitium 15.6.2 API documentation](https://github.com/TechnitiumSoftware/DnsServer/blob/v15.6.2/APIDOCS.md) defines local endpoints, recursion policy and logging.

The installed Windows service can create broad inbound firewall allowances at startup, according to its [versioned worker source](https://github.com/TechnitiumSoftware/DnsServer/blob/v15.6.2/DnsServerWindowsService/DnsServiceWorker.cs#L46-L50). Start/configure it only while external links are disabled; inspect and restrict any resulting rules to the permitted TAP DNS traffic **before boot**. Save exact changed/created rule identities for rollback. Do not launch an assumed portable console binary: the installed inventory did not contain `DnsServerApp`. This is a concrete application side effect to accommodate once, not a new research track.

An operator-created `nighthaven.test` zone with `capture.nighthaven.test A 198.18.0.1` can supply a local health check. Unconfigured client names must not be wildcard-remapped or forwarded; record the actual negative response. Do not fabricate a DNAS success response or configure another revival project's service as an upstream. This may expose a legitimate next blocker rather than allow full bootstrap, which is an acceptable diagnostic result.

The existing offline helper stops DNS and runs three repetitions. **Do not invoke it unchanged for N01.** The old preflight's blanket DNS-listener rejection also conflicts with this explicitly scoped local responder. Apply this card through a reviewed one-run procedure; do not remove those earlier safety checks globally or silently change their meaning. Preparation of this card does not authorize the live run or its temporary DNS/network changes.

## Capture boundary

Start one full-packet PktMon capture of the verified TAP component **before guest boot**, with no capture filters hiding attempted destinations. Keep ETL, converted pcapng, DNS logs, emulator logs, screenshots and manifests in a new operator/SYSTEM-only EFS session directory under the existing raw store, outside Git. Recheck only the specific execution prerequisites: elevated PktMon access/idle state, target component, effective containment and encrypted storage.

**CONFIRMED — reference (PCSX2 source):** TAP inspects outgoing DNS/DHCP before interception. The enabled log flags provide semantic observations before that boundary. Internal DHCP frames may remain absent from TAP; these parsed logs supplement raw packets and never replace or reconstruct them. UDP DNS sent to the actual TAP host should proceed to TAP, whereas requests to internal `192.0.2.1` may be intercepted. [TAP ordering](https://github.com/PCSX2/pcsx2/blob/v2.8.2/pcsx2/DEV9/Win32/tap-win32.cpp#L575-L586), [inspection/internal handler](https://github.com/PCSX2/pcsx2/blob/v2.8.2/pcsx2/DEV9/net.cpp#L194-L223), [DHCP logger](https://github.com/PCSX2/pcsx2/blob/v2.8.2/pcsx2/DEV9/InternalServers/DHCP_Logger.cpp#L184-L206).

Record that blind spot explicitly; no broad instrumentation framework is required before this attempt. Host-origin health-check/noise frames must be distinguished from guest frames. Packet bytes remain authoritative; logs and decoded annotations are separate evidence with their own hashes/version/assumptions.

## Single-run procedure and stop condition

1. With PCSX2 closed, preserve recovery/settings snapshots and apply the bounded lab network/DNS configuration. Verify the local health-check DNS response without upstream access; record it as operator traffic, not guest traffic. If the responder cannot be made local-only, stop before guest boot.
2. Freeze/hash the corrected INI and fresh card/BIOS inputs. Start capture, then launch the isolated runtime for one cold boot. Retain UTC start events and an operator input/screen timeline.
3. Accept the EULA if prompted, choose **Play**, then the saved network profile **EQOA 2**. PCSX2 must still select **Nighthaven E00 TAP**. Record F8 screenshots of EULA, profile selection, connecting and the next stable result.
4. Observe DHCP logs for the offered address and subsequent guest-source IPv4 on TAP. Observe the first DNS question/reply or first direct bootstrap attempt; do not enable a patch, change DNS mappings or attempt login within this run.
5. Stop at the earliest of: first observed non-DNS bootstrap attempt; next stable error/login/credential screen; wrong guest address/backend; containment/capture failure; **90 seconds after network-profile activation**; or **360 seconds after launch**. If a first attempt is not visible live, the timer/screen bound still applies and packet review identifies it afterward. No credentials are entered. Close the VM normally; force termination only as bounded recovery if normal closure fails, marking that deviation.
6. Stop only the owned capture, preserve/hash outputs and conversion/loss reports, restore `EthEnable=false`, and restore DNS configuration/service state **before** restoring original external adapter states. Verify cleanup against the saved snapshot, without enabling adapters/services that were originally off. Preserve C: BitLocker state; no disk encryption change is part of the test.

## Result and handoff

The measurable network-path result is **an actual guest-originated IPv4 packet with source `198.18.0.2`, plus a correlated DNS request/reply or identified first blocked bootstrap attempt**, linked to screen timing and immutable artifact hashes. An offered DHCP lease alone does not prove adoption. A negative DNS reply qualifies a working DNS exchange, not a correct EQOA service answer. If the client bypasses DNS or fails earlier, record that narrower result and the exact next blocker.

This is one qualification run under changed settings. It does not establish DNAS compatibility, a functioning Nighthaven server, original-hardware behavior or a playable baseline. Do not automatically close E00: the existing plan requires three comparable cold starts without configuration changes, so the earlier differently configured controls cannot silently become three repetitions of this corrected setup. If N01 works, freeze its profile and report the smallest remaining repeatability evidence needed; do not loop through more unchanged failures. E01 timeline experiments follow the E00 review, using this observable network path and investigating the actual next blocker. Architecture Gate #2 stays PASS, Evidence Acquisition OPEN, Protocol Implementation CLOSED until the applicable evidence and implementation authorization exist.
