---
description: Reskin the current project to match a reference's look AND feel (incl. animation)
argument-hint: <url | screenshot path | brand name> [scope: component|page|site]
---

Load and run the **reskin** skill (`~/.claude/skills/reskin/SKILL.md`) against this
reference: $ARGUMENTS

Follow the skill's pipeline exactly. Non-negotiables:
- Work on a new git branch; touch only the presentation layer — never app logic,
  routes, auth, or data wiring (e.g. Supabase).
- Produce BOTH `DESIGN.md` (look) and, if the source is a live URL, `MOTION.md`
  (feel) — detect the animation library and port the motion, not just the styling.
- Gate every animation behind `prefers-reduced-motion`.
- Before implementing, show the section→component plan and flag any effects that
  need a manual pass (Three.js / heavy GSAP).
- Verify with the screenshot-compare loop and confirm the app still builds.

If no scope is given, ask: component, page, or whole site?
