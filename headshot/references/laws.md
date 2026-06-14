# The eight laws — and the real failure each one prevents

Every law in `SKILL.md` is a scar. They come from a controlled benchmark of 144 one-shot builds
(6 project categories × 24 prompt variants, scored objectively and by a blind judge panel) and a
forensic dissection of a long autonomous build that succeeded in parts and failed in others. This
file explains the reasoning so you can apply the laws with judgment instead of rote.

## L1 — Completeness beats emphasis

**What it prevents:** spending the prompt on one fashionable section and assuming that's where quality
comes from. In the benchmark, a *uniform* allocation of emphasis across the eight concerns ranked in
the top quartile in five of six categories, and **zero** single-dimension emphasis effects survived
multiple-comparison correction. Translation: for a capable model, *how completely* you cover the work
matters far more than *which part* you emphasize. Cover everything to sufficiency first.

## L2 — Never over-concentrate

**What it prevents:** the artifact failing exactly where you starved it. Because a prompt is a finite
budget, pouring 40% of it into one concern necessarily drains the others — and the drained concerns
became the failure points. Across the benchmark, the *worst* outputs in nearly every category were
the extreme single-dimension prompts. Balance is not blandness; it is insurance against the
weakest-link failure.

## L3 — If it isn't in the Definition of Done, it won't get built

**What it prevents:** the silent disappearance of qualities the user obviously wanted. In the studied
build, "modular, reusable components" and "the graphs actually work" were stated in prose but never
turned into a checkable gate — so they were quietly under-delivered (modularity stalled at ~65/100)
while the one thing that *was* measured got all the effort. The lesson is blunt: the measured spec is
the real spec. If the user cares about it, it must become a criterion in §2 with a way to verify it.

## L4 — The Definition of Done must cover the TRUE surface

**What it prevents:** shipping a bug the verifier never looks at. The studied build verified a
deterministic *capture* path while the surface a human actually watched ran on different machinery —
and a defect made a signature component invisible for the entire run, scoring "healthy" the whole time
because nothing checked the real surface. If two surfaces exist (a test harness *and* the live UI; a
batch path *and* the interactive one), both go in scope, or the gap becomes the bug.

## L5 — No absolute bars

**What it prevents:** looping forever toward a target that may be physically unreachable. The studied
build inherited a literal "iterate until 100%, less than 100% is not useful" bar, which hardened into a
gate that plateaued well short of 100% and was eventually judged "very likely unwinnable as specified"
(crisp output vs. inherently noisy reference). An absolute with no tolerance budget and no falsifiability
is a trap. Use graded, reality-calibrated thresholds, and *always* add the escape valve: **"if a
criterion is proven infeasible after honest effort, stop and report it with evidence rather than
grinding or silently lowering the bar."**

## L6 — Keep the human valve

**What it prevents:** an agent grinding when it should have asked. The raw brief behind the studied
build actually contained the antidote — "if you have any questions, please ask me first" — but the
refined prompt dropped it for "the only exit is the promise line." With no sanctioned off-ramp, the
agent re-litigated an impossible plateau for multiple iterations and had to improvise its own escape.
Preserve an explicit way to surface blockers and material ambiguity. A prompt that forbids asking is
a prompt that guarantees guessing.

## L7 — Ground in evidence, don't guess

**What it prevents:** plausible-but-wrong output from shallow assumptions. The biggest single quality
jump in the studied build came from *measuring* the reference at full fidelity rather than eyeballing
it (a one-pixel correction, found by comparing real frames, was worth hundreds of passing frames).
Whenever the brief points at real assets, data, designs, or examples, the prompt must tell the agent to
read them first and sample/measure from the source instead of inventing values.

## L8 — Resolve conflicts before building

**What it prevents:** building the wrong thing, confidently. The studied build named one interaction as
"the most important thing," but the actual reference footage showed a *different* interaction — a
contradiction nobody resolved up front, so the delivered work technically matched the priority while
visibly failing the reference, and trust collapsed. Surface ambiguities and internal contradictions
(including assumed-but-unstated context like "you know my style") and resolve them — by reasoning or by
asking — *before* any code is written.

---

## How the laws relate to the eight prompt sections

| Law | Most enforced in |
|---|---|
| L1 Completeness / L2 No over-concentration | the whole prompt being present and balanced (all of §1–§8) |
| L3 Measured qualities | §2 Definition of Done |
| L4 True surface | §2 Definition of Done + §7 Self-verification |
| L5 No absolute bars | §2 (the graded bar + infeasibility-exit clause) |
| L6 Human valve | §2 (infeasibility exit) + §8 (escape hatch) |
| L7 Evidence grounding | §3 Inputs & grounding |
| L8 Resolve conflicts | step 3 of the compile process, surfaced into §3 |

The two clauses people most regret omitting: the **infeasibility exit** in §2 and the **escape hatch**
in §8. Treat them as non-negotiable.
