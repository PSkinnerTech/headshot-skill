# The output structure — the eight sections in detail

This is the exact shape of the prompt you emit. Every compiled prompt has these eight sections, in
this order, filled with concrete specifics drawn from the brief. The goal is a prompt that a separate
build agent can run end-to-end with no clarification.

A useful framing: §1–§3 tell the agent *what success is and what it has to work with*; §4–§6 tell it
*what to build and to what standard*; §7–§8 tell it *how to prove it and how to behave*.

---

## §1 — Mission & intent

One tight paragraph. What is being built, for whom, why it matters, and the quality bar **in words**
(the felt standard — "ship-ready", "premium", "obviously correct"). State that the agent is building
the real thing a consumer will use, not a throwaway demo. Keep it short; this section orients, it
does not specify.

## §2 — Definition of Done (graded & checkable) — the heart

The win conditions as a **checklist**, each paired with **how it is verified**. This is where most
prompts fail, so spend the most care here. It must include:

- **Checkable criteria for every quality the user cares about** — including implicit ones (it runs;
  it's modular/reusable; the interaction works; it's accessible). If a quality can't be checked,
  rewrite it until it can.
- **Coverage of the true human-facing surface**, not just a convenient test path. If a human will
  click it, watch it, or install it, that surface is verified here.
- **An explicit "good enough to ship" line** — what state counts as done, in graded terms.
- **Explicit non-goals** — what is deliberately out of scope, so effort isn't wasted.
- **The infeasibility-exit clause** (verbatim intent): *"If a criterion is proven infeasible after
  honest effort — e.g. two iterations with no net gain and the residual shown to be irreducible —
  stop, mark it done-at-floor, and report it with evidence, rather than grinding or silently lowering
  the bar."*

Prefer a small table: `criterion | how it's verified`. Replace any absolute ("100%", "pixel-perfect",
"never fails") with a graded, reality-calibrated threshold.

## §3 — Inputs & grounding

What the agent must read **before writing code**, and the exact assets/data (inline if small).
Demand native-fidelity ingestion and "measure/sample from the source, don't guess" wherever real
material exists. End with the **resolved-unknowns list**: the ambiguities you settled in compile-step 3,
plus any assumptions you had to make — each flagged so the human can correct them. If you asked the
user questions, fold their answers in here.

## §4 — Scope & build order

The explicit parts/components, what is **in** and **out** of scope, and the **order** to build them
(usually: stand up the verification harness and shared scaffolding first, then build highest-priority
pieces, verifying each before moving on). Name the pieces concretely.

## §5 — Constraints & integrity

The guardrails: it must actually build/run/compile; **no placeholders, TODOs, stubs, or lorem**; tech
and dependency limits; and anti-gaming rules ("don't special-case the test", "the verified artifact
must be the real, reusable thing a consumer gets — no faking the output to pass a check"). If there's a
verifier, say it is frozen after review and that the builder never grades its own work. List anything
explicitly forbidden.

## §6 — Aesthetic / domain direction

For creative work: the **taste spec** — exact colors, typography, spacing, motion/easing, reference
mood. For technical work: the **rigor spec** — invariants, edge cases, complexity targets, the error
contract. Sample concrete values from the source where possible rather than describing them vaguely.
When taste and correctness pull against each other, state which governs.

## §7 — Self-verification & output contract

How the agent must **self-check before declaring done**: run it, test it, *view the real surface*
(not just the proxy), and confirm each §2 criterion. Then the **output contract**: the exact
deliverable(s) — file names, formats, paths — and how to **demonstrate it works** (e.g. a smoke test,
a deployed URL, a screenshot, a passing suite). Be unambiguous so there's nothing to interpret.

## §8 — Approach, oversight & escape hatch

Tell the agent to **plan before building**. Authorize scale **only if the project warrants it** —
subagents / parallelism / a verify→fix→re-verify loop — and say to verify between steps and keep the
work in a known-good state each iteration.

### Oversight & steerability — for long autonomous runs, this is the highest-leverage part of the prompt

When the project is a **long autonomous run** (loops or subagents working for a long stretch with the
human away), the bottleneck is no longer "specify the output well" — it's *"keep a long unsupervised
run on track."* The human's ability to **observe and steer** the agent becomes the scarce resource,
so the compiled prompt must hand the agent the machinery to make itself observable. Include all three:

- **Deploy-and-observe.** Don't let the agent grade itself from memory. Tell it to *push, deploy, hit
  the live URL, tail the logs, and iterate until it actually works* — the running environment is a
  more honest verifier than the model's self-assessment.
- **A live, continuously-updated progress surface of the TRUE deliverable.** Have the agent stand up a
  persistent, deployed artifact (the running app / a status page) and keep it current with timestamped
  progress, so a human can open one URL from anywhere and judge — and catch drift *early*. Make it
  publish the **real surface the human judges, not a proxy** (this is law L4: a status page that shows
  machine scores instead of the actual app hides exactly the bugs you need to see). State that
  *publishing progress is not stopping* — the agent keeps working between updates.
- **Verify by inspection, not self-report.** *Open the file, screenshot it, re-run the checks* — force
  a fresh observation, because self-grading from memory is where agents rubber-stamp broken work.

For a **one-shot** (single generation, no human in the loop during the run), keep this section light —
there is no long run to observe, so the deploy/progress machinery is overhead. Match the weight of §8
to the horizon.

### The escape hatch (always include, any horizon)

The **standing escape-hatch rule** (verbatim intent): *"You persist, but you are not trapped. Surface
to the human — ask first, and pause that thread — rather than guessing or grinding, whenever a
criterion hits the infeasibility plateau, a load-bearing assumption proves wrong, or the requirements
are genuinely ambiguous. Report with evidence."* (This is law L6 — and on a long run it is what lets
the human steer without babysitting.)

---

## A note on length and balance

Keep the whole prompt complete but not bloated. If one section balloons while another is a single
line, you have probably over-concentrated (L2) — rebalance. The §2 Definition of Done earns the most
words; §1 and §6 are usually the shortest. Emit the eight sections and nothing else — no preamble,
no "here is your prompt".
