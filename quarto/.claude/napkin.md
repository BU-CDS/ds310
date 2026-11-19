# Napkin Runbook

## Curation Rules
- Re-prioritize on every read.
- Keep recurring, high-value notes only.
- Max 10 items per category.
- Each item includes date + "Do instead".

## Execution & Validation (Highest Priority)
1. **[2026-11-18] Reveal slides need a real browser, not a file URL**
   Do instead: render with `quarto render`, serve `_site` over http, and open the slide hash (for example `#/mapreduce`). Check the slide with every fragment visible, not only the first build.

## Shell & Command Reliability
1. **[2026-11-18] `quarto render` dies in the sandbox while copying reveal assets**
   Do instead: rerun `quarto render` outside the sandbox. A local `python -m http.server` only sees files if its cwd is actually `_site` or the repo root you intend.

## Domain Behavior Guardrails
1. **[2026-11-18] Wide reveal columns wrap instead of sitting side by side**
   Do instead: give the slide an id and set `.reveal #slide-id .columns { display: flex; align-items: center; }` with `.column { min-width: 0; }` and a max-height on the figure.
2. **[2026-11-18] An included SVG is reparsed, and a blank line closes it**
   Do instead: keep a stepped or scripted SVG as its own file and emit it with the `raw-svg` filter (`filters/raw-svg.lua`) so quotes, `viewBox`, and the drawing stay intact. A `{{< include >}}` of that file is parsed as Markdown.

## User Directives
1. **[2026-11-18] New figures in this deck can be drawn more carefully than the existing flat diagrams**
   Do instead: use a self-contained SVG with the deck's Helvetica and a small palette, and keep labels large enough to read from the back of the room.
