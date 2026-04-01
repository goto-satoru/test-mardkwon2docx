.PHONY: help docx pdf html clean all

# Default target
help:
	@echo "Pandoc Document Conversion Workflow"
	@echo "===================================="
	@echo ""
	@echo "Available targets:"
	@echo "  make docx       - Convert sample.md to sample.docx"
	@echo "  make pdf        - Convert sample.md to sample.pdf"
	@echo "  make html       - Convert sample.md to sample.html"
	@echo "  make all        - Generate all formats (docx, pdf, html)"
	@echo "  make clean      - Remove generated files"
	@echo ""
	@echo "Requirements: pandoc (install via 'brew install pandoc' on macOS)"
	@echo ""

# Convert to Word (.docx)
docx: sample.md
	@echo "🔄 Converting sample.md to sample.docx..."
	pandoc sample.md -o sample.docx \
		--from markdown \
		--to docx \
		--toc \
		--number-sections \
		--highlight-style=pygments
	@echo "✅ Generated: sample.docx"

# Convert to PDF
pdf: sample.md
	@echo "🔄 Converting sample.md to sample.pdf..."
	pandoc sample.md -o sample.pdf \
		--from markdown \
		--to pdf \
		--toc \
		--number-sections \
		--highlight-style=pygments
	@echo "✅ Generated: sample.pdf"

# Convert to HTML
html: sample.md
	@echo "🔄 Converting sample.md to sample.html..."
	pandoc sample.md -o sample.html \
		--from markdown \
		--to html \
		--standalone \
		--toc \
		--number-sections \
		--highlight-style=pygments \
		--css=style.css
	@echo "✅ Generated: sample.html"

# Generate all formats
all: docx pdf html
	@echo ""
	@echo "📦 All formats generated successfully!"
	@echo "   - sample.docx"
	@echo "   - sample.pdf"
	@echo "   - sample.html"

# Clean up generated files
clean:
	@echo "🗑️  Cleaning up generated files..."
	rm -f sample.docx sample.pdf sample.html
	@echo "✅ Cleanup complete"

# Watch mode: regenerate on file changes (requires 'fswatch')
watch:
	@echo "👀 Watching for changes (requires fswatch)..."
	@echo "Install fswatch with: brew install fswatch"
	fswatch sample.md | xargs -I {} make all
