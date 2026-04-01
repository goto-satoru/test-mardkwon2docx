#!/bin/bash

# Markdown to Word Conversion Script
# This script converts markdown files to various formats using pandoc

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
INPUT_FILE="${1:-sample.md}"
OUTPUT_FORMAT="${2:-docx}"
OUTPUT_FILE="sample.${OUTPUT_FORMAT}"

# Function to check if pandoc is installed
check_pandoc() {
    if ! command -v pandoc &> /dev/null; then
        echo -e "${RED}❌ Pandoc is not installed${NC}"
        echo -e "${YELLOW}Install it with:${NC}"
        echo "  macOS:  brew install pandoc"
        echo "  Linux:  sudo apt-get install pandoc"
        echo "  Windows: choco install pandoc"
        exit 1
    fi
}

# Function to print usage
usage() {
    cat << EOF
${BLUE}Markdown to Document Converter${NC}

Usage: $0 [input_file] [format]

Formats:
  docx  - Microsoft Word (default)
  pdf   - PDF
  html  - HTML

Examples:
  $0                          # Convert sample.md to sample.docx
  $0 myfile.md docx          # Convert myfile.md to myfile.docx
  $0 myfile.md pdf           # Convert myfile.md to myfile.pdf
  $0 myfile.md html          # Convert myfile.md to myfile.html

EOF
}

# Function to convert file
convert() {
    local input="$1"
    local format="$2"
    local output="sample.${format}"
    
    # Check if input file exists
    if [ ! -f "$input" ]; then
        echo -e "${RED}❌ Error: File '$input' not found${NC}"
        exit 1
    fi
    
    echo -e "${BLUE}🔄 Converting $input to $output...${NC}"
    
    case "$format" in
        docx)
            pandoc "$input" -o "$output" \
                --from markdown \
                --to docx \
                --toc \
                --number-sections \
                --highlight-style=pygments
            ;;
        pdf)
            pandoc "$input" -o "$output" \
                --from markdown \
                --to pdf \
                --toc \
                --number-sections \
                --highlight-style=pygments
            ;;
        html)
            pandoc "$input" -o "$output" \
                --from markdown \
                --to html \
                --standalone \
                --toc \
                --number-sections \
                --highlight-style=pygments \
                --css=style.css
            ;;
        *)
            echo -e "${RED}❌ Unknown format: $format${NC}"
            usage
            exit 1
            ;;
    esac
    
    echo -e "${GREEN}✅ Generated: $output${NC}"
}

# Function to convert all formats
convert_all() {
    local input="$1"
    
    echo -e "${BLUE}📦 Converting to all formats...${NC}"
    echo ""
    
    for format in docx pdf html; do
        convert "$input" "$format"
        echo ""
    done
    
    echo -e "${GREEN}✅ All formats generated successfully!${NC}"
}

# Main execution
main() {
    check_pandoc
    
    # Handle help flag
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        usage
        exit 0
    fi
    
    # Handle all flag
    if [ "$OUTPUT_FORMAT" = "all" ]; then
        convert_all "$INPUT_FILE"
    else
        convert "$INPUT_FILE" "$OUTPUT_FORMAT"
    fi
}

main "$@"
