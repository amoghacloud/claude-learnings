# Domain: Cloudflare Workers

---

### Block range limit on public RPCs
- ❌ Never `fromBlock: 0x0` with publicnode — max 49,999 block range, fails silently returning empty results
- ✅ Hardcode a deploy block as scan floor; use Alchemy webhook + D1 for anything ongoing
- 📁 Project: base2048 | Date: 2026-06

---

### Real-time onchain data — webhook over cron scan
- ❌ Never poll `eth_getLogs` on a cron to keep D1 in sync — misses events if deploy block not set, expensive, slow
- ✅ Alchemy Address Activity webhook → worker endpoint → immediate D1 upsert. One-time seed scan at setup only
- 📁 Project: base2048 | Date: 2026-06

---

### Multiple Alchemy webhooks → same endpoint
- ❌ Don't create separate endpoints per webhook
- ✅ One endpoint, try all known signing keys (`ALCHEMY_WEBHOOK_KEY`, `ALCHEMY_NFT_WEBHOOK_KEY`). Route by event type inside handler
- 📁 Project: base2048 | Date: 2026-06

---

### D1 — always use `--remote` flag
- ❌ `npx wrangler d1 execute base2048-db --command "..."` → hits local SQLite, not production
- ✅ Always `--remote`: `npx wrangler d1 execute base2048-db --remote --command "..."`
- 📁 Project: base2048 | Date: 2026-06

---

### KV holder cache invalidation on transfer
- ❌ Don't let stale holder cache persist after NFT transfer — wrong gate decisions for 5 minutes
- ✅ On every Transfer webhook: `await Promise.all([env.KV.delete('hc:' + from), env.KV.delete('hc:' + to)])`
- 📁 Project: base2048 | Date: 2026-06

---

### RPC fallback pattern
- ❌ Never hardcode one RPC — `mainnet.base.org` rate-limits Workers under load
- ✅ Primary (`base-rpc.publicnode.com`) → fallback (`env.ALCHEMY_RPC`). Wrap every RPC call in `ethRpcWithFallback`
- 📁 Project: base2048 | Date: 2026-06

---

### D1 batch writes
- ❌ Don't await individual `DB.prepare().run()` in a loop — slow, not atomic
- ✅ `await env.DB.batch(stmts)` — single round-trip, atomic. Build `stmts[]` first, batch once
- 📁 Project: base2048 | Date: 2026-06
