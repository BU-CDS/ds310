# DS310 — Data Mechanics: Course Slides

Source for the DS310 (*Data Mechanics*, Boston University) lecture slides. Each
lecture is a [Quarto](https://quarto.org/) markdown file that renders to a
[reveal.js](https://revealjs.com/) deck; together they publish as a single
website with a landing page linking every deck.

Topics run from database design and the relational model through SQL, storage
and indexing, query processing, transactions and concurrency control, recovery
and logging, warehousing and OLAP, and distributed and NoSQL systems.

## Repository layout

```
quarto/
  index.qmd          # landing page (renders as HTML, not a deck)
  L01-*.qmd … L24-*.qmd   # one Quarto file per lecture deck
  _quarto.yml        # project config: render list, navbar, shared revealjs options
  custom.scss        # slide theme overrides
  images/            # figures referenced by the decks
  _site/             # local build output (generated; not the published site)
.github/workflows/publish.yml   # CI that renders and publishes the site
```

Two conventions worth knowing before you edit:

- **`_quarto.yml` sets `format: revealjs` only.** Listing `html` there too would
  make every deck render to both formats and collide on the same `.html` output.
  HTML pages such as `index.qmd` opt in with `format: html` in their own front
  matter.
- **Per-deck options live in each deck's front matter** (theme, slide size,
  chalkboard, transitions) and are merged with the project-level settings.

## Building the slides

Install [Quarto](https://quarto.org/docs/get-started/) (v1.4 or newer), then
from the repository root:

```bash
# render the whole site into quarto/_site
quarto render quarto

# live preview with auto-reload while you edit
quarto preview quarto

# render or preview a single deck (much faster)
quarto render quarto/L07-Indexing.qmd
quarto preview quarto/L07-Indexing.qmd
```

Open `quarto/_site/index.html` to browse the rendered site locally.

A new lecture file is only built if it is added to the `project.render` list in
[_quarto.yml](quarto/_quarto.yml); add it to the `website.navbar` menus and to
[index.qmd](quarto/index.qmd) as well so it is reachable from the site.

### Publishing

Publishing is automated. [.github/workflows/publish.yml](.github/workflows/publish.yml)
runs on every push to `main` that touches `quarto/**` (or the workflow itself),
renders the project with Quarto, and pushes the result to the `gh-pages` branch,
which GitHub Pages serves. The workflow can also be started manually from the
Actions tab (`workflow_dispatch`). You never need to commit built output —
`_site/` is build product, and the published site comes from CI.

## Contributing via fork and pull request

Direct pushes to `main` are not expected; changes come in as pull requests from
a fork.

**1. Fork the repository.** Click **Fork** on the GitHub repository page. That
gives you `https://github.com/<your-username>/ds310`.

**2. Clone your fork and add the original as `upstream`.**

```bash
git clone https://github.com/<your-username>/ds310.git
cd ds310
git remote add upstream https://github.com/<original-owner>/ds310.git
git remote -v   # origin = your fork, upstream = the original
```

**3. Sync before you start, so your branch begins from current `main`.**

```bash
git fetch upstream
git checkout main
git merge upstream/main
```

**4. Create a branch for your change.** One topic per branch keeps review
simple.

```bash
git checkout -b fix/L07-indexing-typo
```

**5. Edit and verify.** Make your edits in `quarto/`, then confirm the affected
deck still renders cleanly before committing:

```bash
quarto render quarto/L07-Indexing.qmd
```

**6. Commit and push to your fork.**

```bash
git add quarto/L07-Indexing.qmd
git commit -m "L07: fix off-by-one in B+ tree fanout example"
git push -u origin fix/L07-indexing-typo
```

**7. Open the pull request.** GitHub shows a "Compare & pull request" banner
after the push; otherwise go to your fork and click **Contribute → Open pull
request**. Set the base to `<original-owner>/ds310` `main` and the compare
branch to your branch. In the description, say which lecture(s) you touched,
what changed, and why — and mention that you rendered the deck locally.

**8. Respond to review.** Push follow-up commits to the same branch; the PR
updates automatically.

```bash
git add -u && git commit -m "Address review comments" && git push
```

If `main` moves while your PR is open and GitHub reports a conflict, update your
branch and resolve it locally:

```bash
git fetch upstream
git merge upstream/main   # fix any conflicts, then commit
git push
```

**9. Merge.** A maintainer merges the PR into `main`. That push triggers the
publish workflow, which re-renders the site and updates the `gh-pages` branch —
the change appears on the live site within a few minutes. After the merge you
can delete your branch and re-sync your fork:

```bash
git checkout main
git fetch upstream && git merge upstream/main
git push origin main
git branch -d fix/L07-indexing-typo
```

### Notes for slide edits

- Keep images in `quarto/images/` and reference them with relative paths.
- Don't commit `quarto/_site/` or `quarto/.quarto/` — they are generated.
- Styling changes belong in `quarto/custom.scss` rather than inline HTML, so all
  decks stay consistent.
