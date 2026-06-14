# Domain: EVM / Base Chain

---

### @noble/secp256k1 v3 — sha256 import path changed
- ❌ `import { sha256 } from '@noble/hashes/sha256'` → not exported from that path in v3
- ✅ `import { sha256 } from '@noble/hashes/sha2.js'` and `import { hmac } from '@noble/hashes/hmac.js'`
- 📁 Project: base2048 | Date: 2026-06

---

### @noble/secp256k1 v3 — hmacSha256 injection
- ❌ `secp256k1.utils.hmacSha256Sync = ...` → property is frozen in v3, throws
- ✅ `secp_hashes.sha256 = sha256; secp_hashes.hmacSha256 = (key, msg) => hmac(sha256, key, msg)`
- 📁 Project: base2048 | Date: 2026-06

---

### @noble/secp256k1 v3 — sign() return value
- ❌ Treating `sign()` return as an object with `.r`, `.s` → it's a Uint8Array in v3
- ✅ Use `format: 'recovered'` → returns 65-byte `[v(1), r(32), s(32)]`. Slice manually
- 📁 Project: base2048 | Date: 2026-06

---

### ERC721 plain — no token enumeration
- ❌ Calling `tokenOfOwnerByIndex` or `tokensOfOwner` on plain OpenZeppelin ERC721 → always reverts
- ✅ Scan Transfer events to build ownership map. Store in D1. Keep live via webhook
- 📁 Project: base2048 | Date: 2026-06

---

### Finding unknown contract function selectors
- ✅ Extract PUSH4 opcodes from bytecode, brute-force match with keccak256 of candidate signatures
- ✅ `from Crypto.Hash import keccak; k.update(b"fn(uint256)"); sel = k.hexdigest()[:8]`
- 📁 Project: base2048 | Date: 2026-06

---

### Leaderboard indexer — deploy block required
- ❌ Cron indexer without `SCORECARD_DEPLOY_BLOCK` set → starts from current head, misses all history
- ✅ Always set deploy block env var OR manually seed `lb:last_block` KV key to first event's block
- 📁 Project: base2048 | Date: 2026-06

---

### personal_sign — message must match exactly
- ❌ Slight difference in message string (case, spacing, newlines) between frontend and worker → always bad signature
- ✅ Skip personal_sign entirely for simple holder checks — just verify `balanceOf` server-side
- 📁 Project: base2048 | Date: 2026-06
