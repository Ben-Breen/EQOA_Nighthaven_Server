# Protocol analysis and Nighthaven protocol boundary

## Scope and confidence

The reference survey establishes that its world server parses a custom UDP datagram/segment/message format with CRC handling and distinct reliable, unreliable, ping, and state-channel paths. Its account service parses TCP messages. It does **not** establish the complete official EQOA protocol, all client variants, or that every implementation detail is required for compatibility. See [protocol-message-catalog.md](protocol-message-catalog.md).

Labels: **CONFIRMED**, **INFERRED**, **UNKNOWN**, **OBSOLETE / HISTORICAL** as defined in [reference-implementation-analysis.md](reference-implementation-analysis.md).

## Confirmed reference observations

- World transport: UDP socket; compose and app config use local server UDP port 10070. The code binds `IPAddress.Any` after a deliberately forced fallback exception in `SocketManager.Initialize`. Endpoint IDs and other config values are also present. The exact production endpoint topology is **UNKNOWN**.
- Account transport: TCP listener binds any address on port 9735, listen backlog 100. The account listener reads up to 500 bytes per receive and treats each read as one message; whether TCP segmentation/coalescing is safely handled is **UNKNOWN** and deserves testing.
- `ClientPacket.ProcessPacket` reads two 16-bit endpoint values, parses a variable-length segment header, verifies a trailing CRC, then parses the body unless reset. Its code logs CRC failure but continues parsing; handling is not a reliable reject path.
- Segment header uses a 7-bit encoded packed flags/size value; optional instance, reset local endpoint, and remote endpoint are conditionally read. A number of header bits/fields are commented or marked uncertain.
- Segment body parses flags and conditionally reads session ack, arrival number, flush/guaranteed acknowledgements, masks, and message/channel data. Comments question meanings and validation. Do not treat field interpretation as authoritative.
- `MessageType` declares `0xF9` ping, `0xFA` segment reliable, `0xFB` reliable, `0xFC` unreliable; object update channels `0x00..0x17`; client update `0x40`, stat `0x42`, buff `0x43`. Group update aliases `0x40` in the enum, while other code has separate grouping behavior; confirm from captures.
- `RdpCommIn` rejects non-next reliable message sequence numbers, processes ack reports and state channel acks, and contains resend queue handling in `SessionQueues`. Comments explicitly say out-of-order reliables are ignored for now. Exact retransmission timers/limits and protocol correctness are **UNKNOWN** pending source path audit and captures.
- Datagram CRC is calculated over packet bytes excluding the trailing CRC (`ClientPacket` and `RdpCommOut`). Polynomial/initialization/finalization semantics should be documented from `CRCCheck.cs` before implementing independently. CRC is not proof of cryptographic integrity.
- Writers use native unmanaged memory layout for generic primitive writes, with explicit byte swapping in some fields and big-endian helpers in the account service. Do not infer one global endianness; inspect per field and confirm against packet captures.
- Game authentication handler reads a message body after skipping five bytes, then a 32-bit game-code length/string, 32-bit account-name length/string, one skipped byte, 16-byte password, then skips 16 more bytes. This is a source-specific observed parser, not a fully verified client specification. AES decryption is optional and disabled in checked-in config; when disabled it calls `AccountExists`, meaning password verification is bypassed in this mode.
- Character selection/create handlers and server serializers demonstrate fields in [protocol-message-catalog.md](protocol-message-catalog.md). Unknown fields remain explicitly unknown.

## Message families evidenced by dispatch

`GameOpcode` and `ProcessOpcode.OpcodeDictionary` include authentication/version, character list/create/delete/select, chat, target/interact/dialogue, bank/merchant/item/loot, training/class mastery, faction, attack, who/group, and blacksmith repair messages. Many server opcode names exist without corresponding client implementation or a mapped handler. Names and IDs are repository labels; semantics require client/capture validation.

Movement is handled through client unreliable/state update paths, with fields including positional/input state noted in comments. Exact packet field layout and coordinate/angle scaling are **UNKNOWN** here. Object replication has channels 0–23 and server XOR/base acknowledgement logic; precise wire field semantics and limits need more targeted protocol validation.

## Not established by this survey

Encryption/obfuscation on each exchange, compression algorithms and negotiation, authoritative sequence wrap behavior, duplicate/reorder rules, retransmission schedule, reliable segmentation semantics, connection migration, keepalive timeout requirements, character/world handshake order, complete movement representation, opcode version matrix, and behavior across original PS2 disc/revision variants remain **UNKNOWN**. The existence of `UnreliableCompression.cs`, crypto helpers, or config flags does not establish that every path uses them.

## Nighthaven implementation rule

Capture and test first. Build framing and codec tests from independently collected, lawfully available interoperability evidence. Keep a versioned protocol profile with explicit source/capture provenance for every field. Unknown bits should be preserved or rejected only according to observed behavior, not guessed. Keep parsing bounded, validate lengths before allocation, verify integrity before dispatch, and report unknown opcodes without leaking secrets. Protocol models should map to application commands; domain services should not accept raw buffers.

## Catalog

See [protocol-message-catalog.md](protocol-message-catalog.md) for direction, ID, demonstrated purpose/fields, source path and confidence. No undocumented field is inferred to be a protocol fact.

