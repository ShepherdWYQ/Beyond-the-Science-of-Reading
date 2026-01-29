#!/bin/bash

# 修复 GitHub Pages 配置脚本

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

echo -e "${BLUE}🔧 修复 GitHub Pages 配置${NC}"
echo

# 检查当前状态
log_info "检查当前配置..."
echo "当前 _config.yml 配置:"
grep -A 2 -B 2 "url:\|baseurl:" _config.yml

echo
echo "CNAME 文件内容:"
cat CNAME

echo

# 问题诊断
log_info "问题诊断:"
echo "1. http://translation.wangyongqing.com/ ✅ 可访问"
echo "2. https://translation.wangyongqing.com/beyond-reading-science ❌ 404"
echo

log_warning "可能的问题:"
echo "- GitHub Pages 自定义域名未正确配置"
echo "- SSL 证书未生成"
echo "- 子路径配置问题"

echo

# 解决方案
log_info "解决方案:"

echo
echo -e "${YELLOW}步骤 1: 检查 GitHub Pages 设置${NC}"
echo "访问: https://github.com/ShepherdWYQ/Beyond-the-Science-of-Reading/settings/pages"
echo "确认:"
echo "  ✓ Source: Deploy from a branch"
echo "  ✓ Branch: main"
echo "  ✓ Custom domain: translation.wangyongqing.com"
echo "  ✓ Enforce HTTPS: 启用"

echo
echo -e "${YELLOW}步骤 2: 等待 SSL 证书生成${NC}"
echo "GitHub Pages 需要时间为自定义域名生成 SSL 证书"
echo "通常需要 10-30 分钟"

echo
echo -e "${YELLOW}步骤 3: 验证部署${NC}"
echo "检查以下地址:"
echo "  1. http://translation.wangyongqing.com (应该重定向到 HTTPS)"
echo "  2. https://translation.wangyongqing.com (根域名)"
echo "  3. https://translation.wangyongqing.com/beyond-reading-science (目标地址)"

echo
echo -e "${YELLOW}步骤 4: 如果仍然 404，尝试以下操作${NC}"

# 创建临时修复
log_info "创建临时修复配置..."

# 备份当前配置
cp _config.yml _config.yml.backup

# 创建根路径配置
cat > _config.yml.root << 'EOF'
# Jekyll Configuration for GitHub Pages

title: Beyond the Science of Reading
description: Beyond the Science of Reading - Connecting Literacy Instruction to the Science of Learning 中文翻译项目
author: Beyond the Science of Reading

# GitHub Pages settings
github: [metadata]

# Plugins (确保这些 gem 在 Gemfile 中)
plugins:
  - jekyll-feed
  - jekyll-sitemap
  - jekyll-seo-tag

# Site settings - 根路径配置（临时修复）
url: https://translation.wangyongqing.com
baseurl: ""

# Build settings
markdown: kramdown
highlighter: rouge

# Exclude from processing
exclude:
  - Gemfile
  - Gemfile.lock
  - node_modules
  - vendor/bundle/
  - vendor/cache/
  - vendor/gems/
  - vendor/ruby/
  - .git
  - .gitignore
  - README.md
  - translation-guide.md
  - PROJECT_STRUCTURE.md
  - DEPLOYMENT.md
  - QUICK_START.md
  - TROUBLESHOOTING.md
  - FIX_404.md
  - BUILD_FIX.md
  - PAGE_FIX.md

# Kramdown settings
kramdown:
  input: GFM
  hard_wrap: false
  syntax_highlighter: rouge

# Navigation
navigation:
  - title: 首页
    url: /
  - title: 目录
    url: /SUMMARY.html
  - title: 贡献指南
    url: /CONTRIBUTING.html
  - title: 翻译进度
    url: /progress.html
  - title: 术语表
    url: /glossary.html
  - title: 电子书下载
    url: /downloads/
EOF

echo
read -p "是否切换到根路径配置以修复 404? (y/N): " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    log_info "切换到根路径配置..."
    cp _config.yml.root _config.yml
    
    log_info "提交更改..."
    git add _config.yml
    git commit -m "Fix 404: Switch to root path configuration"
    
    if git push origin main; then
        log_success "配置已更新并推送"
        echo
        echo -e "${GREEN}新的访问地址:${NC}"
        echo "  https://translation.wangyongqing.com"
        echo
        echo -e "${YELLOW}等待 2-5 分钟后访问${NC}"
    else
        log_error "推送失败，请手动推送"
    fi
else
    log_info "保持当前配置"
    rm _config.yml.root
fi

echo
log_info "清理临时文件..."
rm -f _config.yml.root

echo
echo -e "${BLUE}📋 下一步操作:${NC}"
echo "1. 等待 GitHub Pages 重新构建 (2-5 分钟)"
echo "2. 检查 GitHub Actions 构建状态"
echo "3. 访问网站验证修复效果"
echo "4. 如果需要，可以稍后恢复子路径配置"

echo
echo -e "${BLUE}🔗 有用的链接:${NC}"
echo "GitHub Pages 设置: https://github.com/ShepherdWYQ/Beyond-the-Science-of-Reading/settings/pages"
echo "构建状态: https://github.com/ShepherdWYQ/Beyond-the-Science-of-Reading/actions"
echo "网站地址: https://translation.wangyongqing.com"