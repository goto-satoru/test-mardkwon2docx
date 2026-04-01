# 🚀 Quick Start Guide

## What You Have

Your pandoc workspace now includes:

### 📄 Core Files
- **sample.md** — Professional markdown document (118 lines)
- **sample.docx** — Generated Word document (ready to download)

### 🛠️ Build Tools
- **Makefile** — Unix/Mac build automation
- **convert.sh** — Bash script for conversion
- **metadata.yaml** — Document metadata template

### 📚 Documentation
- **README.md** — Complete guide (223 lines)
- **style.css** — HTML styling

---

## Common Tasks

### 1. Generate Word Document

```bash
make docx
```

Output: `sample.docx`

### 2. Generate All Formats (Word, PDF, HTML)

```bash
make all
```

Output: `sample.docx`, `sample.pdf`, `sample.html`

### 3. Using the Bash Script

```bash
# Convert to Word
./convert.sh sample.md docx

# Convert to PDF
./convert.sh sample.md pdf

# Convert to HTML
./convert.sh sample.md html
```

### 4. Clean Up Generated Files

```bash
make clean
```

### 5. View Available Commands

```bash
make help
```

---

## Workflow for Your Documents

### Step 1: Create/Edit Markdown
Edit `sample.md` with your content. Markdown syntax:

```markdown
# Heading 1
## Heading 2

**Bold text**
*Italic text*
`code`

- List item
- Another item

[Link](https://example.com)

| Column 1 | Column 2 |
|----------|----------|
| Value 1  | Value 2  |
```

### Step 2: Generate Word Document

```bash
make docx
```

### Step 3: Open and Edit in Word

The generated `.docx` is fully editable in Microsoft Word or compatible software.

---

## Advanced Usage

### Custom Document Styling

Generate a Word template:

```bash
pandoc -D docx > reference.docx
```

Edit `reference.docx` in Word, then use it for all future conversions by updating the Makefile to include:

```makefile
pandoc sample.md -o sample.docx \
  --reference-doc=reference.docx
```

### Multiple Markdown Files

Combine multiple files into one document:

```bash
pandoc file1.md file2.md file3.md -o output.docx
```

### Add Metadata

Include YAML front matter in your markdown:

```yaml
---
title: My Document
author: Your Name
date: 2026-04-01
---

# Content starts here
```

---

## System Requirements

✅ **Installed:** Pandoc 3.9.0.2

For other systems:
- **macOS:** `brew install pandoc`
- **Linux:** `sudo apt-get install pandoc`
- **Windows:** `choco install pandoc`

---

## File Size Reference

| File | Size | Purpose |
|------|------|---------|
| sample.md | 3.1 KB | Markdown source |
| sample.docx | 13 KB | Generated Word document |
| style.css | 3.4 KB | HTML styling |
| Makefile | 1.9 KB | Build automation |
| README.md | 4.9 KB | Full documentation |

---

## Next Steps

1. ✅ **Edit sample.md** — Add your own content
2. ✅ **Run `make docx`** — Generate the Word file
3. ✅ **Open in Word** — Review and make final edits
4. ✅ **Automate** — Integrate into your workflow

## Tips & Tricks

💡 Use `make watch` to auto-regenerate on file changes (requires `brew install fswatch`)

💡 Keep markdown files in version control (Git) — they're small and trackable

💡 Use pandoc filters for advanced customization

💡 Test documents locally before sharing

---

## Troubleshooting

**Getting "pandoc: command not found"?**
```bash
brew install pandoc
```

**Want to see all pandoc options?**
```bash
pandoc --help
```

**Need to adjust formatting?**
Edit the Makefile flags or see the full documentation in README.md

---

**Created:** April 1, 2026  
**Status:** ✅ Ready to use
