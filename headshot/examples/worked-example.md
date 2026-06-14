# Worked example — a dictated brief, compiled

A short, end-to-end demonstration of the `headshot` skill on a fresh voice-memo brief. Notice the
skill **asks before guessing** (the escape hatch) and turns vibes + an absolute bar into graded,
checkable criteria.

---

## The raw dictation (input)

> "Ok so I want a habit tracker, a really clean one, single page, no backend, just runs in the
> browser and saves to local storage. It needs to look absolutely beautiful — like Notion-meets-Things
> clean. You add habits, check them off each day, there's a streak counter and one of those
> GitHub-style contribution heatmaps for the year. Make it perfect, don't stop until it's flawless. Oh
> and checking something off should feel really satisfying — a nice little animation. Use whatever
> framework, maybe React. Has to work on mobile too. Just make it amazing."

---

## Part A — Extraction & classification

- **Goal / why:** a personal daily habit tracker the user runs locally in the browser; private, no
  backend, persists across sessions.
- **Audience:** the user themselves (a personal tool); judged by feel and looks.
- **Felt quality bar (quoted):** *"absolutely beautiful — Notion-meets-Things clean"*, *"feel really
  satisfying"*, *"just make it amazing"*.
- **Named deliverables:** single-page app; add habits; daily check-off; streak counter; year-long
  GitHub-style contribution heatmap; satisfying check-off animation; mobile-friendly; localStorage.
- **Class:** **Interactive/standard with a strong aesthetic lean** — standard browser app the model
  one-shots easily, but success is mostly judged by look and feel. So lean mildly into Intent &
  Aesthetic (§1, §6), keep correctness criteria light but real (§2), don't over-specify.
- **References/assets:** none provided; "Notion-meets-Things" is the only visual anchor.

## Part B — Questions first (the escape hatch), with assumptions

1. **"Single page, no backend, runs in the browser" conflicts with "maybe React"** (React usually
   implies a build step). One self-contained file, or a small React build?
   - *Assumption:* **one self-contained `index.html`** (no build, no backend) — it best satisfies
     "just runs in the browser". Vanilla JS + inline CSS.
2. **What defines "perfect / flawless"** for a personal tool? (Literal perfection isn't a usable bar.)
   - *Assumption:* graded — all features work, persists across reloads, looks clean on desktop and
     mobile, zero console errors. Ship at that bar; don't grind cosmetics forever.
3. **Heatmap scope** — current calendar year, rolling 365 days, or since first use?
   - *Assumption:* **trailing 365 days** ending today.
4. **Streak definition** — consecutive days all habits done, or per-habit streaks?
   - *Assumption:* **per-habit current streak** (consecutive days that habit was checked, ending today).

## Part C — The compiled one-shot prompt (output)

### §1 — Mission & intent
Build a beautiful, single-page personal **habit tracker** that runs entirely in the browser with no
backend and persists to `localStorage`. The bar is a tool the user would actually enjoy opening daily:
calm, clean, "Notion-meets-Things" restraint, with a check-off that feels satisfying. Ship-ready
personal software, not a tech demo.

### §2 — Definition of Done (graded & checkable)
| Criterion | How it's verified |
|---|---|
| Add / rename / delete habits; they persist across a full page reload | Add 3 habits, reload — all present with state intact (localStorage). |
| Daily check-off toggles per habit for "today"; reflected immediately | Click a habit's today cell — it toggles and the UI updates with no reload. |
| Per-habit **current streak** = consecutive checked days ending today, correct across a month boundary | Seed a known history; assert the displayed streak equals the hand-computed value. |
| **Trailing-365-day** GitHub-style heatmap per habit, intensity by completion | Heatmap renders 365 cells; a checked day shows filled, an unchecked day empty. |
| Satisfying check-off **animation** (~150–250ms, eased; respects `prefers-reduced-motion`) | Visible on toggle; disabled when reduced-motion is set. |
| Looks clean and works on **mobile** (≥320px) and desktop; no horizontal scroll | Render at 320px and 1280px — layout holds, tap targets ≥44px. |
| Runs with **zero console errors** by opening the file directly | Open `index.html` via `file://`; console is clean. |

**Good enough to ship:** all rows pass; it reads as calm and clean on both viewports. **Non-goals:**
no accounts, sync, backend, reminders/notifications, or multi-device. **Infeasibility exit:** if any
criterion proves infeasible after honest effort, stop and report it with evidence rather than grinding.

### §3 — Inputs & grounding
No external assets. Visual anchor: Notion/Things — generous whitespace, soft neutral palette, one
restrained accent, system font stack. Don't invent a heavy design; sample restraint from that
reference. **Resolved assumptions (correct me if wrong):** single self-contained `index.html`, no build;
"perfect" = the graded bar above; heatmap = trailing 365 days; streak = per-habit consecutive days.

### §4 — Scope & build order
1. Data model + localStorage load/save (habits, per-day completion map). 2. Core UI: habit list + add
form + today check-off. 3. Streak computation. 4. Year heatmap. 5. Animation + reduced-motion. 6.
Mobile layout pass. In scope: the above. Out: anything in non-goals.

### §5 — Constraints & integrity
Exactly one self-contained `index.html` (inline CSS + JS), no backend, no network requests, no build
step. No placeholders/TODOs/lorem; every feature real and wired to real state. Don't fake the heatmap
with a static image — render it from the data.

### §6 — Aesthetic / domain direction
Calm and minimal: off-white background (~`#FAFAF8`), ink `#1A1A1A`, muted secondary text, ONE accent
(a soft green, e.g. `#34D399`) used only for completion/heatmap intensity. System font stack, generous
spacing, ~12px radius, subtle borders over shadows. The check-off animation is the one moment of
delight — a quick scale/fill pop, never janky.

### §7 — Self-verification & output contract
Before declaring done: open `index.html`, add/check/reload to confirm persistence, verify a seeded
streak and the heatmap counts, toggle reduced-motion, and check 320px + 1280px with the console open.
**Deliverable:** one file, `index.html`, self-contained. Demonstrate it works by listing the manual
checks you ran and their results.

### §8 — Approach & escape hatch
This is a single-file app — no subagents or loops needed; plan the data model first, then build in the
§4 order, checking each feature as you go. **Escape hatch:** you persist toward the graded bar but you
are not trapped — if a criterion proves infeasible, or an assumption in §3 turns out wrong, or a
requirement is genuinely ambiguous, stop and surface it with evidence rather than guessing or grinding.
