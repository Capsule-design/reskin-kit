---
description: Extract a reference's DESIGN.md + MOTION.md without changing anything (read-only)
argument-hint: <url | screenshot path> [output dir, default ./reskin-refs/<name>]
---

Read-only capture. Build a reusable reference spec from: $ARGUMENTS

Use the **reskin** skill's capture steps only (`~/.claude/skills/reskin/SKILL.md`,
steps 1–3). Then STOP. Do not implement, restyle, or modify any project file.

Produce, in the output dir (default `./reskin-refs/<reference-name>/`):
- `DESIGN.md` — color, type, fonts (+ source/license), spacing, components, breakpoints.
- `MOTION.md` — only if the source is a live URL: detected animation library, easings,
  durations, triggers, smooth-scroll, and the `prefers-reduced-motion` plan.
- `assets/` — fonts/icons/logos/textures captured, with licensing notes.

Rules:
- Live URL → use Chrome MCP to inspect computed styles + the running animation stack.
- Screenshot → capture look only; state clearly that motion can't be captured from a still.
- Make ZERO changes outside the output dir. This command only writes reference files.

End by printing the path to the captured spec so it can be reused later with `/reskin`.
