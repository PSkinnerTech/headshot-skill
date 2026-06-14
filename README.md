# headshot

**A Claude Agent Skill that turns a rough, dictated, or half-formed brief into the perfect one-shot prompt — so your build agent nails the project on the first try.**

You talk; it compiles. Hand `headshot` a voice memo, an STT transcript, or a messy brain-dump of
something you want built, and it produces **one complete, balanced, execution-ready prompt** you can
drop straight into a build agent (Claude Code, Cursor, etc.). The name is the goal: a clean
*headshot* — one shot, project done.

---

## What it actually does

When the skill triggers, Claude stops being a builder and becomes a **prompt compiler**. It:

1. **Extracts** your true intent from the mess — the goal, the audience, the felt quality bar, the
   real deliverables, the constraints, the assets.
2. **Classifies** the project (correctness-leaning / aesthetic-leaning / standard) and tunes the
   prompt's emphasis to fit — *mildly*, because over-tuning backfires.
3. **Asks before guessing.** If anything load-bearing is ambiguous, it asks you up to 5 crisp
   questions first — instead of confidently building the wrong thing.
4. **Calibrates the bar.** It converts vibes ("make it amazing", "100% perfect") into *graded,
   checkable* acceptance criteria, and bakes in an escape hatch so the agent never grinds forever
   toward an impossible target.
5. **Emits** a polished prompt in a fixed eight-section structure:

   `① Mission & intent · ② Definition of Done (graded & checkable) · ③ Inputs & grounding ·`
   `④ Scope & build order · ⑤ Constraints & integrity · ⑥ Aesthetic/domain direction ·`
   `⑦ Self-verification & output contract · ⑧ Approach & escape hatch`

See [`headshot/examples/worked-example.md`](headshot/examples/worked-example.md) for a full
before→after on a real dictated brief.

## The research behind it

`headshot` is not a vibe — every rule it follows is earned from a multi-stage study of why one-shot
prompts succeed and fail:

- **A controlled benchmark of 144 one-shot builds** (6 project categories × 24 prompt variants,
  scored by objective tests and a blind judge panel). Headline finding: **one-shot quality comes from
  *completeness*, not clever emphasis** — a balanced prompt beat tuned ones in 5 of 6 categories, and
  no single-dimension emphasis effect survived multiple-comparison correction. **Over-concentrating**
  on one part of a prompt was the most common cause of a bad result.
- **A forensic dissection** of a long autonomous build, which showed that **anything not in the
  machine-checked definition of done gets silently dropped** (modularity, functionality, the
  human-facing surface), and that an **absolute "100% or nothing" bar** traps an agent into grinding
  an unwinnable target.
- **A lineage analysis** tracing a raw dictation into the rigid execution prompt it produced, which
  isolated the two fatal moves: inheriting an absolute bar, and **deleting the human "ask me first"
  escape hatch.**

Those findings are distilled into the skill's **eight laws** (completeness > emphasis; never
over-concentrate; if it isn't in the Definition of Done it won't get built; cover the true surface;
no absolute bars; keep the human valve; ground in evidence; resolve conflicts first). The full
reasoning, with the specific failure each law prevents, is in
[`headshot/references/laws.md`](headshot/references/laws.md).

## Install

Skills are filesystem-based — copy the `headshot/` folder into a skills directory Claude reads:

```bash
# Personal (available in every project):
cp -r headshot ~/.claude/skills/headshot

# — or — Project-scoped (commit it with a repo):
mkdir -p .claude/skills && cp -r headshot .claude/skills/headshot
```

Claude discovers it automatically. No registry or upload step.

## Use

Just talk to Claude naturally once the skill is installed:

> "Here's my brain dump for a project, turn it into a perfect prompt: *[paste your dictation]*"

> "I dictated this idea — compile it into a one-shot prompt for Claude Code."

The skill triggers on rough briefs, voice memos, STT transcripts, and asks to "compile / optimize /
perfect / one-shot" a prompt. It will ask clarifying questions if needed, then output the
eight-section prompt. Hand that prompt to your build agent.

> Tip: the skill produces the prompt; it does **not** build the project. Run the emitted prompt in a
> fresh session (or a build agent) to do the actual work.

## Repo layout

```
headshot-skill/
├── README.md                          ← you are here
└── headshot/                          ← the skill (copy this into .claude/skills/)
    ├── SKILL.md                       ← the skill definition (frontmatter + instructions)
    ├── references/
    │   ├── laws.md                    ← the 8 laws + the failure each prevents
    │   ├── output-structure.md        ← the 8-section output spec, in detail
    │   └── category-playbook.md       ← classify the project, then tune emphasis
    └── examples/
        └── worked-example.md          ← a dictated brief, compiled end-to-end
```

The skill uses **progressive disclosure**: `SKILL.md` stays lean and loads the `references/` files
only when needed.
