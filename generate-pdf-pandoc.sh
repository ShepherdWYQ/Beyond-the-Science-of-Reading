#!/bin/bash

# Beyond the Science of Reading PDF生成脚本
# 使用Pandoc生成高质量PDF

echo "开始生成PDF..."

# 检查pandoc是否安装
if ! command -v pandoc &> /dev/null; then
    echo "错误: 未找到pandoc，请先安装:"
    echo "brew install pandoc"
    exit 1
fi

# 创建临时目录
mkdir -p temp

# 合并所有markdown文件
echo "合并Markdown文件..."

# 创建完整的文档
cat > temp/complete-book.md << 'EOF'
---
title: "Beyond the Science of Reading"
subtitle: "Connecting Literacy Instruction to the Science of Learning"
author: "Natalie Wexler (原著) | 中文翻译项目"
date: "2025年"
documentclass: book
geometry: margin=2cm
fontsize: 11pt
linestretch: 1.2
toc: true
toc-depth: 3
numbersections: true
---

EOF

# 添加主要内容
if [ -f "index.md" ]; then
    echo "添加首页内容..."
    echo -e "\n\\pagebreak\n" >> temp/complete-book.md
    sed '/^---$/,/^---$/d' index.md >> temp/complete-book.md
fi

if [ -f "chapters/Beyond the Science of Reading.md" ]; then
    echo "添加书籍介绍..."
    echo -e "\n\\pagebreak\n" >> temp/complete-book.md
    sed '/^---$/,/^---$/d' "chapters/Beyond the Science of Reading.md" >> temp/complete-book.md
fi

# 添加已有章节
for chapter in chapters/Chapter*.md; do
    if [ -f "$chapter" ]; then
        echo "添加章节: $(basename "$chapter")"
        echo -e "\n\\pagebreak\n" >> temp/complete-book.md
        sed '/^---$/,/^---$/d' "$chapter" >> temp/complete-book.md
    fi
done

# 添加术语表
if [ -f "glossary.md" ]; then
    echo "添加术语表..."
    echo -e "\n\\pagebreak\n" >> temp/complete-book.md
    cat glossary.md >> temp/complete-book.md
fi

# 生成PDF
echo "生成PDF文件..."

pandoc temp/complete-book.md \
    -o "Beyond-the-Science-of-Reading.pdf" \
    --pdf-engine=xelatex \
    --variable mainfont="PingFang SC" \
    --variable sansfont="PingFang SC" \
    --variable monofont="SF Mono" \
    --variable CJKmainfont="PingFang SC" \
    --toc \
    --toc-depth=3 \
    --number-sections \
    --highlight-style=github \
    --template=eisvogel \
    --listings \
    --metadata-file=temp/metadata.yaml 2>/dev/null || \
pandoc temp/complete-book.md \
    -o "Beyond-the-Science-of-Reading.pdf" \
    --pdf-engine=xelatex \
    --variable mainfont="PingFang SC" \
    --variable sansfont="PingFang SC" \
    --variable monofont="SF Mono" \
    --variable CJKmainfont="PingFang SC" \
    --toc \
    --toc-depth=3 \
    --number-sections \
    --highlight-style=github

# 检查是否成功生成
if [ -f "Beyond-the-Science-of-Reading.pdf" ]; then
    echo "✅ PDF生成成功: Beyond-the-Science-of-Reading.pdf"
    echo "文件大小: $(du -h Beyond-the-Science-of-Reading.pdf | cut -f1)"
else
    echo "❌ PDF生成失败"
    exit 1
fi

# 清理临时文件
rm -rf temp

echo "完成!"