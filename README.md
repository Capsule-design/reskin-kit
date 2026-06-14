# Reskin Kit

A Claude Code skill + slash commands that restyle an existing site/app to match a
reference's **look and feel — including animation**. It captures the look
(`DESIGN.md`), the motion (`MOTION.md`), fonts, and assets from a live URL or
screenshot, then applies them to your project's presentation layer **without
touching app logic** (routes, auth, Supabase wiring stay intact).

Why this exists: a static `DESIGN.md` library (e.g. `awesome-claude-design`) nails
the *look* but has no concept of animation, so reskins come out sitting still. This
adds motion capture (detects GSAP / Framer Motion / Lenis / Lottie / Three.js),
fonts, accessibility (`prefers-reduced-motion`), and a build-integrity check.

## Commands
- **`/reskin <url|screenshot> [component|page|site]`** — restyle the current project
  to match a reference (look + motion). Works on a git branch; verifies the build.
- **`/capture-design <url|screenshot> [outdir]`** — read-only. Extracts `DESIGN.md`
  + `MOTION.md` + assets into a folder and changes nothing. Use it to build your own
  reference library, then feed those specs to `/reskin` later.

---

## Install

### Option A — one-line bootstrap (best for many machines)
Once this is a git repo (see "Publish" below) and you've set the repo URL in
`bootstrap.sh`:

```bash
curl -fsSL https://raw.githubusercontent.com/<you>/reskin-kit/main/bootstrap.sh | bash
```

Or without editing the file:

```bash
RESKIN_REPO=git@github.com:<you>/reskin-kit.git \
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/<you>/reskin-kit/main/bootstrap.sh)"
```

It clones to a temp dir, installs into `~/.claude`, and cleans up.

### Option B — local install (no repo needed)
```bash
cd reskin-kit && chmod +x install.sh && ./install.sh
```

### Forge (Mac Studio, over Tailscale)
```bash
scp -r reskin-kit forge:~/ && ssh forge 'cd ~/reskin-kit && chmod +x install.sh && ./install.sh'
```
…or just run the bootstrap one-liner on the Forge once the repo exists.

### Update / uninstall
```bash
./install.sh              # update to this version
./install.sh --uninstall  # remove skill + commands
```
With the repo, updating any machine is: `git pull && ./install.sh` (or re-run bootstrap).

---

## Publish as a git repo (enables the bootstrap)

From inside this folder:

```bash
git init && git add -A && git commit -m "Reskin Kit"
# with GitHub CLI:
gh repo create reskin-kit --private --source=. --push
# or manually:
git remote add origin git@github.com:<you>/reskin-kit.git && git push -u origin main
```

Then edit `REPO_URL` in `bootstrap.sh` to your repo (or always pass `RESKIN_REPO=`).

---

## Use

```text
/reskin https://thesite.com page          # match a live site (look + motion)
/reskin ./ref.png component               # match a screenshot (look only)
/capture-design https://thesite.com       # save a reusable reference spec, change nothing
```

Or say it in plain language — "make this look like <site>", "port the animation from <url>".

## Requirements
- **Claude Code** on the machine.
- **Chrome MCP** connected for live-URL capture (needed for motion — a screenshot
  can't show animation).
- A **git** repo in the target project (the reskin works on a branch for safety).

## What it will and won't do
- ✅ Capture color, type, fonts, spacing, components, responsive breakpoints.
- ✅ Detect the animation stack and port the motion with the matching library.
- ✅ Respect `prefers-reduced-motion`; keep contrast accessible.
- ✅ Work on a branch; leave logic/routes/data untouched; verify the app still builds.
- ⚠️ Flag heavy motion (Three.js / bespoke GSAP) as a manual pass instead of faking it.
- ⚠️ Refuse to 1:1 pixel-clone a recognizable real brand for a client deliverable
  without confirming — capturing *language* is fine, wholesale cloning is an IP risk.

## Files
```
reskin-kit/
├─ bootstrap.sh            # curl | bash one-liner (clone + install)
├─ install.sh             # local installer (idempotent)
├─ README.md
├─ .gitignore
├─ skills/reskin/
│  ├─ SKILL.md
│  └─ references/
│     ├─ DESIGN.template.md
│     ├─ MOTION.template.md
│     └─ library-cheatsheet.md
└─ commands/
   ├─ reskin.md
   └─ capture-design.md
```
