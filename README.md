# Claude Learnings

> Stop correcting AI for the same mistake twice.

Claude Learnings is a Claude Code skill that builds a personal knowledge base from every project you work on. Every correction, every bug fix, every "no not like this" — captured once, applied forever across every future project.

---

## The Problem

You correct Claude. Same mistake, next project — you correct it again. And again. Claude has no memory across projects. Your time is wasted re-teaching what it already learned.

## The Solution

A local knowledge base that:
- **Captures** every correction automatically
- **Organises** by domain (cloudflare-workers, figma, postgres, evm, react — whatever you work in)
- **Loads** relevant past learnings at the start of every new project
- **Grows** smarter with every session, forever

Your learnings stay local. Only the skill is open source.

---

## How It Works

```
You: "no idiot, never scan blocks — use a webhook + D1"
Claude: captures it → cloudflare-workers.md → never does it again in any project
```

Three commands:

| Command | When | What happens |
|---|---|---|
| `/learnings load` | Start of project | Claude reads your past learnings, applies them silently |
| `/learnings capture` | After any correction | Distills the fix into one rule, stores by domain |
| `/learnings close` | End of project | Claude reviews the session, extracts all learnings automatically |

---

## Install

```bash
# 1. Clone the skill
git clone https://github.com/amoghacloud/claude-learnings ~/.claude-learnings

# 2. Install (symlinks the skill into Claude Code)
cd ~/.claude-learnings && bash install.sh
```

That's it. Open any project in Claude Code and run `/learnings load`.

---

## Your Local Knowledge Base

Stored at `~/.claude-learnings/`:

```
~/.claude-learnings/
├── index.md                  ← all your projects + domains at a glance
├── by-project/
│   ├── my-saas-app.md        ← what was learned in that specific project
│   └── my-portfolio.md
└── by-domain/
    ├── cloudflare-workers.md ← applies to every Cloudflare project forever
    ├── figma-to-react.md     ← applies to every design handoff forever
    ├── postgres.md
    └── ...
```

**Nothing in `by-domain/` or `by-project/` is ever shared.** Only the skill behaviour (`skill/SKILL.md`) is open source.

---

## Example Learning

After a correction, Claude stores:

```markdown
## Cloudflare Workers

### Block range limit on public RPCs
- ❌ Never use `fromBlock: 0x0` on publicnode — max 49,999 block range, fails silently with no error
- ✅ Use Alchemy webhook + D1 table for real-time data. Scan only once for initial seed.
- 📁 Project: base2048 | Date: 2026-06
```

Next time you build anything on Cloudflare Workers — Claude already knows this. You never say it again.

---

## Works For Any Domain

- **Crypto / Web3** — EVM, Solana, Cloudflare Workers, NFT contracts
- **Design** — Figma-to-code handoffs, component patterns, CSS gotchas
- **Backend** — Postgres quirks, auth patterns, API design mistakes
- **Mobile** — React Native, Swift, Kotlin platform-specific traps
- **Anything** — the skill is domain-agnostic. Your domains emerge from your work.

---

## Contributing

The skill behaviour (`skill/SKILL.md`) is what you contribute to. If you find a better way to capture, organise, or surface learnings — PR it.

Do not contribute your personal `by-domain/` or `by-project/` files. Those are yours.

---

## License

MIT
