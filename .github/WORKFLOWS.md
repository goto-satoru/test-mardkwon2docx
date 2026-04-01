# GitHub Actions Workflows

This directory contains automated workflows for converting markdown to Word documents and other formats using GitHub Actions.

## Available Workflows

### 1. `convert-to-docx.yml` — Convert to Word Only

**Purpose:** Automatically converts `sample.md` to `sample.docx` and commits the result.

**Triggers:**
- Push to `main` or `master` branch when `sample.md` changes
- Manual trigger (workflow_dispatch)

**What it does:**
1. Checks out the repository
2. Installs pandoc
3. Converts `sample.md` → `sample.docx`
4. Commits and pushes `sample.docx` if changed

**File:** `.github/workflows/convert-to-docx.yml`

---

### 2. `convert-all-formats.yml` — Convert to Word, PDF, and HTML

**Purpose:** Generates all document formats from `sample.md`.

**Triggers:**
- Push to `main` or `master` branch when `sample.md` changes
- Daily at 2 AM UTC (schedule)
- Manual trigger (workflow_dispatch)

**What it does:**
1. Installs pandoc and wkhtmltopdf
2. Converts to `.docx`, `.pdf`, and `.html`
3. Commits all generated files if changed

**File:** `.github/workflows/convert-all-formats.yml`

---

## Setup Instructions

### Step 1: Initialize Git Repository

```bash
cd /Users/satoru/lab/pandoc
git init
git add .
git commit -m "Initial commit: pandoc workflow setup"
```

### Step 2: Create GitHub Repository

1. Go to [GitHub](https://github.com/new)
2. Create a new repository (e.g., `pandoc-workflow`)
3. Copy the repository URL

### Step 3: Push to GitHub

```bash
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
git branch -M main
git push -u origin main
```

### Step 4: Verify Workflows

1. Go to your GitHub repository
2. Click **Actions** tab
3. You should see the workflow files listed

---

## How to Use

### Automatic Conversion on Push

Simply edit `sample.md` and push to GitHub:

```bash
# Edit your markdown file
nano sample.md

# Commit and push
git add sample.md
git commit -m "Update documentation"
git push
```

The workflow will automatically:
1. Convert the markdown file
2. Generate the Word document
3. Commit and push it back to the repository

### Manual Trigger

To manually run a workflow:

1. Go to **Actions** → Select the workflow
2. Click **Run workflow** → **Run workflow**
3. Check the job status

### View Workflow Results

1. Go to **Actions** tab
2. Click on the workflow run
3. See detailed logs and outputs

---

## Workflow Details

### Permissions

The workflows require `contents: write` permission to push commits back to the repository.

### Git Configuration

The workflows configure Git with:
- `user.email: action@github.com`
- `user.name: GitHub Action`

### Change Detection

The workflows check if files have changed before committing:

```yaml
if: git diff --quiet sample.docx
  then: "No changes"
  else: "Changes detected - commit"
```

This prevents unnecessary commits when the generated file hasn't changed.

---

## Customization

### Change Trigger Events

Edit the `on:` section in the workflow to change triggers:

```yaml
on:
  push:
    branches: [main, develop]  # Add more branches
  pull_request:
    branches: [main]           # Add PR trigger
  schedule:
    - cron: '0 0 * * *'        # Change schedule
```

### Add More Files

To convert multiple markdown files:

```yaml
- name: Convert introduction.md
  run: |
    pandoc introduction.md -o introduction.docx \
      --from markdown --to docx --toc

- name: Convert tutorial.md
  run: |
    pandoc tutorial.md -o tutorial.docx \
      --from markdown --to docx --toc
```

### Customize Pandoc Options

Edit the pandoc command in the workflow:

```yaml
- name: Convert Markdown to Word
  run: |
    pandoc sample.md -o sample.docx \
      --from markdown \
      --to docx \
      --toc \
      --number-sections \
      --reference-doc template.docx  # Add custom template
```

### Add Notifications

Send notifications on success/failure:

```yaml
- name: Notify on success
  if: success()
  run: echo "✅ Conversion successful!"

- name: Notify on failure
  if: failure()
  run: echo "❌ Conversion failed!"
```

---

## Troubleshooting

### Workflow not triggering

- Check that files are in the correct paths
- Verify the `on:` trigger conditions
- Ensure `.github/workflows/` directory exists

### Permission denied when pushing

Add this to your workflow:

```yaml
permissions:
  contents: write
  pull-requests: write
```

### Pandoc not found

Ubuntu runners include most common tools. For macOS runner:

```yaml
runs-on: macos-latest
```

### Commit conflicts

If multiple workflows push simultaneously, add delays:

```yaml
- name: Wait before push
  run: sleep 5
  
- name: Push changes
  run: git push
```

---

## Example Workflow Outputs

### Successful Run

```
✅ Checkout repository
✅ Install dependencies
✅ Verify Pandoc installation
  pandoc 3.1.x 
✅ Convert to Word (.docx)
✅ Check for changes
  changed=true
✅ Configure Git
✅ Commit changes
  [main abc1234] docs: auto-generate sample.docx
✅ Push changes
  abc1234..def5678  main -> main
```

### No Changes

```
✅ Checkout repository
✅ Verify Pandoc installation
✅ Convert to Word (.docx)
✅ Check for changes
  changed=false
⏭️  Skipped: Commit (no changes)
```

---

## Best Practices

1. **Keep triggers specific** — Only trigger on relevant file changes
2. **Use change detection** — Avoid committing when nothing changed
3. **Add meaningful commit messages** — Use prefix like `docs:` or `chore:`
4. **Test locally first** — Run `make docx` locally before pushing
5. **Review generated files** — Ensure output quality before committing
6. **Use scheduled runs** — Run daily/weekly during off-peak hours

---

## Integration with CI/CD

These workflows can integrate with other GitHub Actions:

```yaml
# Example: Run tests before converting
- name: Run tests
  run: npm test

- name: Convert on success
  if: success()
  run: pandoc sample.md -o sample.docx
```

---

## Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [GitHub Actions Syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)
- [Pandoc Documentation](https://pandoc.org/)
- [Webhook Events](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows)

---

**Created:** April 1, 2026  
**Last Updated:** April 1, 2026
