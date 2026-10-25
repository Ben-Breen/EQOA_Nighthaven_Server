# Reference protocol/message catalog

This catalog is a source-derived index, not a complete protocol specification. “Direction” is based on class/dispatch names. Exact field meanings are only stated where source comments or code directly demonstrate them. Source paths are relative to `EQOAGameServer/`. IDs are repository enum values and must be validated against original-client captures.

Every `CONFIRMED` label in this catalog means **CONFIRMED — reference**: it describes code in that repository, not confirmed original-client semantics. No entry here is **CONFIRMED — client/protocol**.

## Framing and transport records

| Record | Direction | Identifier | Demonstrated content | Source | Confidence / unknowns |
|---|---|---|---|---|---|
| Game datagram | Both | No single message opcode | 16-bit local and remote endpoint values; segment header; body; trailing 32-bit CRC in parser/writer paths | `ReturnHome/EQOAProto-C-Sharp/Server/Network/ClientPacket.cs`, `RdpComm.cs` | CONFIRMED for implementation. Endianness per field and CRC parameters need additional audit/capture; parser logs CRC failure without clear rejection |
| Segment header | Both | Packed flags/size | 7-bit encoded packed value; optional instance; reset local endpoint; remote endpoint when remote flag set | `.../Network/SegmentHeader.cs` | CONFIRMED parser behavior; several flag/field meanings commented as uncertain |
| Segment body | Both | Flags byte | optional session ack, arrival number, flush ack, guaranteed ack/mask, state ack/message data | `.../Network/SegmentBody.cs`, `RdpComm.cs` | CONFIRMED code paths; exact semantics and completeness UNKNOWN |
| Reliable message header | Both | `0xFB` in enum | Reliable message type and sequence/length processing | `.../Network/MessageType.cs`, `Message.cs`, `SessionQueues.cs` | CONFIRMED enum/handling; precise header form varies in code and needs capture validation |
| Segment reliable | Both | `0xFA` | Dedicated segmented reliable path; outbound queue special handling | Same | CONFIRMED code branch; segmentation semantics UNKNOWN |
| Unreliable | Both | `0xFC` | Unreliable message class; client path logs rather than opcode dispatch in RdpComm | Same | CONFIRMED implementation path; semantics incomplete |
| Ping | Both | `0xF9` | Ping handling and sequence participation | `RdpComm.cs`, `MessageType.cs` | CONFIRMED branch; payload meaning UNKNOWN |
| World update channels | Both | `0x00..0x17`; `0x40`, `0x42`, `0x43` | Object channels, client update, stat/buff channels; channel ack/XOR base state | `MessageType.cs`, `ServerObjectUpdate.cs`, `ServerStatUpdate.cs` | CONFIRMED enum and code use; full field layouts UNKNOWN |

## Application messages visible in source

| Name / source class | Direction | ID | Purpose and observed fields | Source | Confidence / notes |
|---|---|---:|---|---|---|
| `Authenticate` | Client → server | `0x0904`; alias `0x0001` | Handler skips 5 bytes, reads 32-bit game-code length + string, then account-name length + string, skips one byte, reads 16-byte password, skips 16 bytes | `Server/Opcodes/Opcodes.cs`; `.../Messages/Client/ClientAuthenticate.cs` | CONFIRMED parser code. Exact field meanings, encryption, padding and security behavior UNKNOWN; config disables game AES by default |
| `DiscVersion` | Both | `0x0000` | Version handling exists; game versions enum includes Frontiers `0x25`, vanilla `0x12` | `.../Opcodes/Opcodes.cs`; `.../Messages/Client/ClientDiscVersion.cs` | CONFIRMED names/constants; client compatibility matrix UNKNOWN |
| `CharacterSelect` | Server → client | `0x002C` | List count, repeated character name, server ID, model/class/race/level, appearance fields, equipment model/color fields; several values marked unknown in serializer | `.../Opcodes/Messages/Server/ServerCreateCharacterList.cs` | CONFIRMED serializer writes; exact client schema/interpretation UNKNOWN |
| `CreateCharacter` | Client → server | `0x002B` | Reads length-prefixed name, 7-bit values for level/race/class/gender/appearance/human type, then seven 32-bit training values | `.../Messages/Client/ClientCreateCharacter.cs` | CONFIRMED parser behavior; unusual length/encoding semantics require capture validation |
| `SELECTED_CHAR` | Client → server | `0x002A` | Routed to character change/selection handler | `Opcodes.cs`, `OpcodeOperations.cs` | CONFIRMED route; payload fields not cataloged here |
| `DeleteCharacter` / `DelCharacter` | Client → server / server response | client `0x002D`; server name `0x002F` | Delete and name-taken messages exist | Opcode files, client handlers | CONFIRMED IDs/names; field schema UNKNOWN |
| `Attack` | Client → server | `0x000F` | Reads one 32-bit target ID; invokes `TakeDamage` with hard-coded 500 damage in observed handler | `.../Messages/Client/ClientAttack.cs` | CONFIRMED implementation. Not evidence of production combat rules |
| `ClientSayChat` | Client → server | `0x000B` | Say chat handler registered | `Opcodes.cs`, `OpcodeOperations.cs`, `Chat/` | CONFIRMED route; exact payload schema not enumerated |
| `ClientShout` | Client → server | `0x0C01` | Shout is explicitly described as global for now | `Opcodes.cs`, `Chat/ShoutChat.cs` | CONFIRMED implementation note; not evidence of intended range semantics |
| `Target` | Client → server | `0x0760` | Target handler; client source discards first 4 bytes as a counter | Opcode files, `.../Messages/Client/ClientPlayerTarget.cs` | CONFIRMED code/comment; counter meaning UNKNOWN |
| `Interact` | Client → server | `0x0004` | Routed to actor interaction handler | Opcode files, `ClientInteractActor.cs` | CONFIRMED route; subfields not exhaustively documented |
| `MerchantBuy` / `MerchantSell` | Client → server | `0x004A` / `0x004B` | Buy/sell item handlers registered | Opcode files, `ClientInteractItem.cs` | CONFIRMED routes; transaction field details UNKNOWN |
| `BankUI` / bank transfer | Client → server | `0x124D`; deposit `0x1255` | Bank interaction and tunar/item transfer handlers exist | Opcode files, `ClientBank.cs` | CONFIRMED routes; payload details UNKNOWN |
| `ClientLoot` / close / open | Client → server | `0x0019`, `0x0016`, `0x0015` | Loot handlers for item, close, and loot-box request | Opcode files, `ClientLoot.cs` | CONFIRMED route names; field format UNKNOWN |
| `GroupInvite`, accept, leave, disband | Client → server | `0x0625`, `0x0622`, `0x0623`, `0x0627` | Group operation handlers registered | Opcode files, `ClientGroup.cs` | CONFIRMED routes; group state/reliability semantics UNKNOWN |
| `WhoList` | Client → server | `0x0E01` | Who-list handler registered | Opcode files, `ClientWhoListRequest.cs` | CONFIRMED route; fields UNKNOWN |
| `CharacterDied` | Server → client | `0x005E` | Server serializer exists | Opcode files, server message class | CONFIRMED name/ID; respawn flow UNKNOWN |
| `Teleport` | Server → client | `0x07F6` | Server serializer exists | Opcode files, `ServerTeleportPlayer.cs` | CONFIRMED name/ID; exact field semantics UNKNOWN |
| `MemoryDump` | Server → client | `0x000D` | Segment-reliable large response class | `ServerMemoryDump.cs`, `Opcodes.cs` | CONFIRMED class/type; content meaning requires further analysis |

## Explicit unknowns

This catalog does not establish a full opcode set, every message direction, field lengths for every handler, endianness globally, optional-field conditions, error responses, client revision differences, or what messages are required in a complete login/world-entry flow. Unmapped enum values must not be assumed implemented. `OpcodeOperations.ProcessOpcodes` catches all errors and routes through an unknown-opcode response, so runtime behavior may hide handler failures.

