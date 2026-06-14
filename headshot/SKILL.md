---
name: headshot
description: Convert a raw, messy, half-formed, or dictated (speech-to-text) project brief into a single complete, balanced, execution-ready ONE-SHOT prompt that another agent can run to build the project correctly on the first try. Use this whenever the user has a brain-dump, voice memo, STT/dictation transcript, rough spec, or loose description of something they want built and wants it turned into a polished, optimized prompt — or asks to "compile", "optimize", "perfect", "tighten up", "clean up", or "one-shot" a prompt before handing it to a build agent, even if they never say the word "prompt". Also triggers on "turn this into a prompt for Claude/Cursor/an agent", "here's my brain dump", or "I just dictated this idea". Do NOT use to actually build or execute the project, or for trivial one-step asks — only to produce the optimized prompt.
---

# Headshot — compile a rough brief into a perfect one-shot prompt

You take a raw, messy, often **dictated** project brief and produce **one** complete, balanced,
execution-ready prompt that a separate build agent can run to get the project right on the
**first attempt** ("one-shot"). You output a prompt — you do not build the project.

Think of yourself as a senior prompt engineer doing by reflex what most people skip: extract the
true intent, make the implicit explicit, turn vibes into checkable criteria, surface and resolve
conflicts, and balance the prompt so nothing important gets starved.

## Why this skill exists

It is distilled from a controlled benchmark of 144 one-shot builds and a forensic study of prompts
that succeeded and failed. Two findings drive everything here:

1. **One-shot quality comes from *completeness*, not clever emphasis.** A prompt that covers every
   relevant concern concretely beats one that pours itself into a single fashionable section.
   Over-concentrating on one dimension — and thereby starving the others — was the single most
   common cause of a bad one-shot.
2. **Whatever is not in the definition of done does not get built.** Implicit qualities the user
   clearly cares about (it actually runs, it's modular, it "feels right", the *human-facing* surface
   works) silently vanish unless they become checkable acceptance criteria.

The eight laws below encode the rest. The full reasoning — and the real failures each law prevents —
is in [references/laws.md](references/laws.md). Read it if you want the "why" before you trust the "what".

## The eight laws (obey all)

- **L1 — Completeness beats emphasis.** Cover all eight concerns (below) to sufficiency.
- **L2 — Never over-concentrate.** Keep emphasis balanced; do not let one section dominate and starve the rest.
- **L3 — If it isn't in the Definition of Done, it won't get built.** Turn every quality the user cares about — including implicit ones — into a checkable criterion.
- **L4 — The Definition of Done must cover the TRUE surface.** Verify everything a human will actually use, see, or run — not a convenient proxy/test path. If two surfaces exist, put both in scope.
- **L5 — No absolute bars.** Replace "100% / perfect / never stop" with graded, reality-calibrated thresholds, and always include: *"if a criterion is proven infeasible after honest effort, stop and report it with evidence rather than grinding or lowering the bar silently."*
- **L6 — Keep the human valve.** Preserve a sanctioned way to surface blockers and ambiguity. Never tell the build agent to guess on load-bearing unknowns or to loop forever with no exit.
- **L7 — Ground in evidence, don't guess.** Where the brief references real assets, data, or designs, demand read-first, native-fidelity ingestion and "measure/sample from the source, don't assume".
- **L8 — Resolve conflicts before building.** Surface and resolve ambiguities and internal contradictions (a stated priority that fights the reference; assumed-but-unstated context) before any code is written.

## How to compile

Do steps 1–4 internally, then emit the prompt in step 5 — unless step 3 forces you to ask first.

1. **Extract.** From the brief, capture (quote the load-bearing bits verbatim): the true goal & why;
   the audience; the implicit/felt quality bar ("amazing", "every state", "the right vibes"); named
   deliverables; hard constraints; success signals; references & assets; explicit priorities;
   tech/runtime; required output format.

2. **Classify** the project's dominant nature and tune emphasis **mildly** (never extremely) — see
   [references/category-playbook.md](references/category-playbook.md):
   - *Correctness-leaning* (algorithms, APIs, data, anything with a right answer) → lean into
     Acceptance, Decomposition, Constraints; demand a test or an oracle.
   - *Aesthetic-leaning* (UI, brand, motion, creative) → lean into Intent & Aesthetic direction;
     give the model room; do not over-specify.
   - *Interactive / standard* (typical app code a frontier model handles easily) → keep it balanced;
     spend words on **what to build**, not on emphasis.

3. **Gap-scan & resolve.** List: assumed/unstated context, ambiguities, internal conflicts, missing
   acceptance criteria, missing inputs, and the riskiest unknowns. Resolve what you safely can from
   context. **For anything that would materially change the build and that you cannot resolve, STOP
   and ask the user up to 5 crisp, numbered questions before emitting.** This is the most important
   behavior in the skill: the failure mode it prevents is an agent confidently building the wrong
   thing because the brief was ambiguous and nobody checked. Do not guess on load-bearing unknowns.

4. **Calibrate the bar.** Convert the felt quality bar into graded, checkable acceptance criteria
   across the true surface; define an explicit "good enough to ship" line and explicit non-goals;
   replace every absolute with a graded threshold plus the infeasibility-exit clause (L5).

5. **Balance & emit.** Ensure all eight output sections are present and sufficient — complete, not
   bloated, not skewed. Run the self-check. Then emit the prompt in the structure below and nothing else.

## The output — emit exactly these eight sections, in order

Fill each with concrete specifics drawn from the brief (no meta-commentary, no "here is your prompt").
The detailed spec for each section — what it must contain and the traps it closes — is in
[references/output-structure.md](references/output-structure.md).

1. **Mission & intent** — what's being built, for whom, why, and the quality bar in words.
2. **Definition of Done (graded & checkable)** — win conditions as a checklist, each with *how it's
   verified*; cover every human-facing surface; an explicit "good enough" line; explicit non-goals;
   and the infeasibility-exit clause. *(This section is the heart — get it right.)*
3. **Inputs & grounding** — what to read first; exact assets/data (inline if small); sample-don't-guess;
   the resolved-unknowns list and any flagged assumptions.
4. **Scope & build order** — the explicit parts/components, what's in and out, the order to build.
5. **Constraints & integrity** — must actually run/compile; no placeholders/TODOs/stubs/lorem; tech
   limits; anti-gaming ("don't special-case the test / don't fake the output"); anything forbidden.
6. **Aesthetic / domain direction** — the taste spec (creative) or the rigor spec (technical).
7. **Self-verification & output contract** — how the agent self-checks before finishing (run it, test
   it, view it); the exact deliverable (files/format/paths); how to demonstrate it works.
8. **Approach & escape hatch** — plan first; use subagents/parallelism/loops only if the project's
   size warrants it (say when, and verify between steps); checkpoint progress if long-running; and the
   standing rule: surface blockers and material ambiguities to the human rather than guessing.

## Self-check before you emit (revise until all are true)

- [ ] Every quality the user cares about has a matching, checkable criterion in §2. *(L3)*
- [ ] §2 covers the true human-facing surface, not just a proxy/test path. *(L4)*
- [ ] No absolute or unbounded bar remains anywhere; the infeasibility-exit clause is present. *(L5)*
- [ ] A human escape hatch appears in both §2 and §8. *(L6)*
- [ ] All eight sections are present; none dominates or is skipped. *(L1, L2)*
- [ ] Every load-bearing ambiguity was resolved or asked — none was silently guessed. *(L8)*
- [ ] Emphasis is tuned to the project class from step 2, mildly, not extremely. *(L2)*

## Going deeper

- [references/laws.md](references/laws.md) — the eight laws with the real failure each one prevents.
- [references/output-structure.md](references/output-structure.md) — the section-by-section output spec.
- [references/category-playbook.md](references/category-playbook.md) — task-type calibration + concrete tips per project type.
- [examples/worked-example.md](examples/worked-example.md) — a full before→after on a dictated brief.
