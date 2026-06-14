# Category playbook — classify the project, then tune emphasis (mildly)

Compile-step 2 asks you to classify the project and tune emphasis. The headline from the benchmark is
that this tuning is a **second-order** lever for a capable model — completeness (L1) matters far more
than the exact ratio, and over-tuning backfires (L2). So **lean mildly, never extremely.** Use this
file to (a) pick the class and (b) get concrete, project-type-specific content for the eight sections.

## The three classes

### 1. Correctness-leaning — *there is a right answer*
Algorithms, data structures, APIs, parsers, schedulers, data pipelines, anything testable.

- **Lean into:** Acceptance criteria, Decomposition, Constraints. **Demand a test or an oracle.**
- **The failure to avoid:** vague, intent-led prompting. In the benchmark, the worst correctness
  outputs came from "just describe the vibe" prompts; the best pinned the exact interface and behavior.
- **Make §2 do the work:** pin the **exact public surface** (names, signatures, types, error contract),
  enumerate **edge cases and boundary behavior**, and state complexity/perf targets. The build agent
  should be scored by a suite, not by eye.
- **§6 is a rigor spec:** invariants, tolerances, determinism, what must never happen.

### 2. Aesthetic-leaning — *judged by taste*
UI, hero sections, brand/identity, posters, motion, video direction, anything evaluated by eye.

- **Lean into:** Goal & Intent and Aesthetic direction. **Give the model room.**
- **The failure to avoid:** over-specifying. The worst aesthetic outputs came from prompts that buried
  the work under acceptance minutiae and constraints; the spec crowded out the art. There is an
  **inverted-U**: some structure helps, spec-domination hurts.
- **Make §6 concrete anyway:** exact palette (hex), typography, spacing, **motion/easing and timing**,
  and a reference mood — but as *direction*, not a checklist that strangles it.
- **§2 stays light but real:** "renders without errors", "all named states present", "reads as
  premium" with a human sign-off — plus the true-surface rule (what a person actually sees).

### 3. Interactive / standard — *the model already handles it well*
Typical app code: CRUD, dashboards-with-known-libs, canvas games, standard integrations.

- **Lean:** keep it **balanced**. In the benchmark this class was nearly insensitive to emphasis —
  the model one-shots it regardless. Don't over-engineer the prompt; spend your words on **what to
  build** (features, data, states), not on how to weight it.
- **The failure to avoid:** wasting effort tuning a prompt for a task the model finds easy.

> Many real projects are a blend (e.g. a data dashboard is *correctness + aesthetic*; a 3D hero is
> *interactive + aesthetic with a correctness spine*). Name the blend and split the lean accordingly —
> e.g. "pin the numbers (correctness) AND give the visual direction room (aesthetic)".

## Concrete content cues by common project type

Use these to fill the sections with specifics instead of generalities.

- **Data dashboard / analytics:** embed the actual dataset inline; state the exact KPI values the
  default view must show; make numerical correctness a hard criterion; require interactions
  (filter/sort/hover) to re-drive every region from one state; demand a self-check that asserts the
  ground-truth numbers (and fails loudly if wrong).
- **Algorithm / API / engine:** pin the exact signatures and the full error/exception contract;
  enumerate boundary cases; require a runnable test; forbid stubbed functions.
- **Marketing / hero / landing UI:** verbatim copy; exact palette + type; named interaction states;
  responsive + a11y as criteria; the *real rendered* surface verified, not just that it built.
- **Poster / brand / generative art:** the creative concept as the win condition; exact palette and
  typographic hierarchy; deterministic, self-contained output; brief-adherence judged + structurally valid.
- **Game (canvas/loop):** the one core mechanic spelled out (controls, win/lose, scoring, feel);
  playable by opening it; juice described; self-contained, no external assets.
- **Media/orchestration plan (e.g. shot lists, pipelines):** required structure in exact order;
  continuity/style rules; per-unit specificity; render-/run-readiness as the bar.

## The one rule that overrides the lean

No matter the class: **completeness and the §2 Definition of Done come first.** Get all eight sections
present and the win conditions checkable, *then* apply a mild lean. A perfectly tuned prompt that omits
a dimension still loses to a complete, balanced one.
