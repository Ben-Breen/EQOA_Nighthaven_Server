# Box1 comparison through server selection

Reviewed November 8, 2026 (America/Chicago). Session `Box1Meta-20261108T184401025Z`, online Box1 using its existing revival configuration, Frontiers US SLUS-20744 / EEEE1FCC. This session followed verified restoration of [isolated A05](e01-a05-login-parser-20261108.md). The operator used an empty test account, entered credentials directly, reported reaching server selection and closed without selecting a world. The screen result is operator-reported.

Windows Kernel Network ETW started at 18:44:01.685 UTC before the guest launched at 18:44:01.776 UTC. Review selected events by the recorded Box1 process ID and checked the provider's event templates. The capture records network metadata without packet payloads. TCP event pairs were correlated by port tuple, with the known TCP/7000 updater corroborating the port encoding. The derived results omit addresses, ephemeral ports, credentials and account identifiers.

| UTC | Process-attributed observation |
| --- | --- |
| 18:45:17.326–18:45:41.482 | UDP/53 traffic. |
| 18:45:48.729–18:46:05.874 | Five TCP/7000 connections, including two after the TCP/9735 connection began. |
| 18:46:01.588 | TCP connect event to port 9735. |
| 18:46:01.628 | First receive event on that tuple, 40 bytes reported by ETW. |
| 18:46:03.636 | Send event on that tuple, 148 bytes reported. |
| 18:46:03.684 | Second receive event, 168 bytes reported. |
| 18:46:07.191 | TCP/9735 close event. |
| 18:46:29.912–18:46:32.345 | Later bidirectional UDP/10071 traffic, five sends and six receives. |

**CONFIRMED — client/protocol**, bounded to this Box1 environment. The host trace establishes the observed connection and event order. ETW byte counts do not establish application message boundaries or semantics. The timing of login submission and the first visible server list was not independently timestamped. The purpose of UDP/10071 and the exact account responses remain **UNKNOWN**.

In A05 the lab completed its updater and Station Init but returned null while parsing the login page. It produced no observed TCP/9735 attempt. Box1 provides a positive comparator for the later network sequence. The first lab question remains why the original login archive entry is not yielding a parsed page. Box1's online services and resource configuration are separate variables.

Box1 exited normally. The metadata capture stopped and the original Box1 INI and source-card hashes matched after restoration. The restricted ETL SHA-256 is `5443ac30fa819e60052d91808860adb37983de72f76d7e263d9a5397749b1ec8`. No raw evidence is in Git.
