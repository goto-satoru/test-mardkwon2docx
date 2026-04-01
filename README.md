# Markdown to Word (.docx) Workflow

This repository contains a sample workflow for converting markdown documents to MS Word format using **pandoc**.

## Quick Start

### 1. Install Pandoc

**macOS:**
```bash
brew install pandoc
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt-get install pandoc
```

**Windows:**
```bash
choco install pandoc
```

Or download from: https://pandoc.org/installing.html

### 2. Convert Markdown to Word

```bash
make docx
```

This generates `sample.docx` from `sample.md`.

## File Structure

```
pandoc/
├── sample.md          # Sample markdown document
├── Makefile          # Build automation
├── README.md         # This file
└── style.css         # (Optional) CSS for HTML output
```

## Available Commands

| Command | Description |
|---------|-------------|
| `make docx` | Convert to Word (.docx) |
| `make pdf` | Convert to PDF |
| `make html` | Convert to HTML |
| `make all` | Generate all formats |
| `make clean` | Remove generated files |
| `make help` | Show help message |
| `make watch` | Auto-regenerate on file changes |

## What's Included in sample.md

The sample markdown file demonstrates:

- ✅ Headers and sections
- ✅ Bold, italic, and code formatting
- ✅ Lists (ordered and unordered)
- ✅ Tables
- ✅ Code blocks with syntax highlighting
- ✅ Links and references
- ✅ Block quotes
- ✅ Horizontal rules
- ✅ Metadata headers

## Pandoc Command Breakdown

The basic command used:

```bash
pandoc sample.md -o sample.docx \
  --from markdown \           # Input format
  --to docx \                 # Output format
  --toc \                     # Generate table of contents
  --number-sections \         # Number sections automatically
  --highlight-style=pygments  # Code syntax highlighting
```

## Advanced Usage

### Custom Styling

To apply custom Word styles, create a reference document:

```bash
pandoc -D docx > reference.docx
# Edit reference.docx in Word to customize styles
pandoc sample.md -o sample.docx --reference-doc=reference.docx
```

### Add Metadata

Include YAML front matter in your markdown:

```yaml
---
title: My Document
author: John Doe
date: April 1, 2026
---

# Content here
```

### Command Line Options

```bash
# With metadata from file
pandoc sample.md -o sample.docx \
  --metadata-file=metadata.yaml

# With template
pandoc sample.md -o sample.docx \
  --reference-doc=template.docx

# Preserve formatting
pandoc sample.md -o sample.docx \
  --preserve-tabs

# Extract footnotes
pandoc sample.md -o sample.docx \
  --extract-media=./media
```

## Complete Workflow Example

For a larger project, you might structure it like:

```bash
project/
├── src/
│   ├── intro.md
│   ├── chapter1.md
│   ├── chapter2.md
│   └── conclusion.md
├── output/
├── templates/
│   └── reference.docx
└── Makefile
```

Makefile for combining files:

```makefile
SOURCES = src/intro.md src/chapter1.md src/chapter2.md src/conclusion.md

output/document.docx: $(SOURCES)
	pandoc $(SOURCES) -o output/document.docx --reference-doc=templates/reference.docx
```

## Windows Scripts

If you prefer batch scripts instead of Make:

**convert.bat:**
```batch
@echo off
pandoc sample.md -o sample.docx ^
  --from markdown ^
  --to docx ^
  --toc ^
  --number-sections
echo Conversion complete!
```

**convert.ps1:**
```powershell
pandoc sample.md -o sample.docx `
  --from markdown `
  --to docx `
  --toc `
  --number-sections
Write-Host "Conversion complete!"
```

## Troubleshooting

**"pandoc: command not found"**
- Install pandoc using the commands above
- Verify installation: `pandoc --version`

**Math formulas not rendering in Word**
- Use `--webtex` or `--katex` flags
- Example: `pandoc sample.md -o sample.docx --webtex`

**Images not embedding**
- Place images in the same directory or use absolute paths
- Use `--embed-resources` flag (pandoc 3.0+)

**Want to include a table of contents but it's not appearing**
- Add `--toc` flag to the command
- Ensure your markdown has proper heading structure

## Next Steps

1. **Edit sample.md** - Modify to your needs
2. **Run `make docx`** - Generate your Word document
3. **Open in Word** - Review and make final edits if needed
4. **Add to automation** - Integrate into CI/CD pipeline

## Resources

- [Pandoc Documentation](https://pandoc.org/)
- [Markdown Guide](https://www.markdownguide.org/)
- [Pandoc User Manual](https://pandoc.org/MANUAL.html)
- [Creating Custom Styles](https://pandoc.org/MANUAL.html#producing-word-documents)

## Tips

💡 **Pro tip:** Keep your markdown source-controlled (Git) and regenerate documents as needed. This ensures your documents always reflect your current content.

💡 **Pro tip:** Use pandoc with templates for consistent branding across documents.

💡 **Pro tip:** For collaborative editing, convert to .docx, edit in Word, then re-convert for the next iteration.

---

**Created:** April 1, 2026  
**Last Updated:** April 1, 2026
