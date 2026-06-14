# Domain: Frontend Web3 / Game UI

---

### CSSStyleDeclaration setter trap — don't intercept display
- ❌ `Object.getOwnPropertyDescriptor(CSSStyleDeclaration.prototype, 'display')` → returns undefined in Chrome → crashes with "Cannot read properties of undefined (reading 'set')"
- ✅ Use `setInterval` polling at 150ms to detect overlay state changes. Check `el.style.display === 'flex'`
- 📁 Project: base2048 | Date: 2026-06

---

### Game lives — never auto-consume silently
- ❌ Auto-using a life when game-over triggers without player input → feels like a bug, player loses lives without knowing
- ✅ Always show game-over overlay first. Show "Use a Life (X left)" button. Player clicks to consume
- 📁 Project: base2048 | Date: 2026-06

---

### Wrapping game.js functions
- ✅ Wrap with IIFE: `window.fn = (function() { const orig = window.fn; return function() { ...; orig(); }; })()`
- ✅ Wrap in DOMContentLoaded or after game.js script tag — never before
- 📁 Project: base2048 | Date: 2026-06

---

### Wallet address casing
- ❌ Mixing checksummed and lowercase wallet addresses in comparisons → always false
- ✅ `.toLowerCase()` both sides at every comparison and storage point
- 📁 Project: base2048 | Date: 2026-06

---

### Overlay display via inline style not class
- ❌ Toggling CSS classes for overlays when game.js sets `el.style.display` inline → class toggle has no effect
- ✅ Always set `el.style.display = 'flex'/'none'` directly. Inline style overrides class
- 📁 Project: base2048 | Date: 2026-06
