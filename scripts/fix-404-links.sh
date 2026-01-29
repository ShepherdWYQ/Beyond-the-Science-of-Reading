#!/bin/bash

# 修复 404 链接问题
# 当从子路径配置改为根路径时，需要更新所有内部链接

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

echo -e "${BLUE}🔧 修复 404 链接问题${NC}"
echo

log_info "问题分析："
echo "当 baseurl 从 '/beyond-reading-science' 改为 '' 时"
echo "所有使用 {{ site.baseurl }} 的链接都会失效"

echo

log_info "检查当前配置..."
echo "当前 _config.yml 中的 baseurl:"
grep "baseurl:" _config.yml || echo "未找到 baseurl 配置"

echo

# 检查问题文件
log_info "检查可能有问题的文件..."

PROBLEM_FILES=()

# 检查导航文件
if [[ -f "_includes/navigation.html" ]]; then
    if grep -q "site.baseurl" "_includes/navigation.html"; then
        PROBLEM_FILES+=("_includes/navigation.html")
        echo "❌ _includes/navigation.html 包含 site.baseurl"
    fi
fi

# 检查布局文件
if [[ -f "_layouts/default.html" ]]; then
    if grep -q "site.baseurl" "_layouts/default.html"; then
        PROBLEM_FILES+=("_layouts/default.html")
        echo "❌ _layouts/default.html 包含 site.baseurl"
    fi
fi

# 检查主要页面
for file in index.md chapters/*.md *.md; do
    if [[ -f "$file" ]] && grep -q "site.baseurl" "$file"; then
        PROBLEM_FILES+=("$file")
        echo "❌ $file 包含 site.baseurl"
    fi
done

echo

if [[ ${#PROBLEM_FILES[@]} -eq 0 ]]; then
    log_info "未发现明显的链接问题，检查其他可能原因..."
    
    # 检查 permalink 配置
    log_info "检查 permalink 配置..."
    if grep -r "permalink:" . --include="*.md" --include="*.html"; then
        echo
        log_warning "发现 permalink 配置，可能需要调整"
    fi
    
    # 检查导航配置
    log_info "检查导航配置..."
    if grep -A 10 "navigation:" _config.yml; then
        echo
        log_warning "检查导航 URL 是否正确"
    fi
else
    log_warning "发现 ${#PROBLEM_FILES[@]} 个文件需要修复"
    
    echo
    read -p "是否自动修复这些文件? (y/N): " -n 1 -r
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        log_info "开始修复文件..."
        
        for file in "${PROBLEM_FILES[@]}"; do
            log_info "修复文件: $file"
            
            # 备份原文件
            cp "$file" "$file.backup"
            
            # 修复链接
            # 将 {{ site.baseurl }}/ 替换为 /
            sed -i.tmp 's|{{ site.baseurl }}/|/|g' "$file"
            # 将 {{site.baseurl}}/ 替换为 /
            sed -i.tmp 's|{{site.baseurl}}/|/|g' "$file"
            # 将单独的 {{ site.baseurl }} 替换为空
            sed -i.tmp 's|{{ site.baseurl }}||g' "$file"
            sed -i.tmp 's|{{site.baseurl}}||g' "$file"
            
            # 清理临时文件
            rm -f "$file.tmp"
            
            log_success "已修复: $file"
        done
        
        log_success "所有文件修复完成"
    else
        log_info "跳过自动修复"
    fi
fi

echo

# 检查和修复导航配置
log_info "检查导航配置..."

if grep -q "navigation:" _config.yml; then
    log_info "当前导航配置:"
    grep -A 20 "navigation:" _config.yml
    
    echo
    log_warning "确保导航 URL 以 / 开头，例如:"
    echo "  - title: 首页"
    echo "    url: /"
    echo "  - title: 目录"
    echo "    url: /SUMMARY.html"
fi

echo

# 检查重要页面的 permalink
log_info "检查重要页面的 permalink..."

IMPORTANT_FILES=("index.md" "SUMMARY.md" "glossary.md" "progress.md")

for file in "${IMPORTANT_FILES[@]}"; do
    if [[ -f "$file" ]]; then
        if grep -q "permalink:" "$file"; then
            echo "$file permalink:"
            grep "permalink:" "$file"
        else
            echo "$file: 无 permalink 配置"
        fi
    fi
done

echo

# 提供手动修复指导
log_info "手动修复指导:"
echo
echo "1. 检查 _includes/navigation.html:"
echo "   将所有 {{ site.baseurl }}/page.html 改为 /page.html"
echo
echo "2. 检查 _layouts/default.html:"
echo "   将所有 {{ site.baseurl }}/assets/ 改为 /assets/"
echo
echo "3. 检查 _config.yml 导航配置:"
echo "   确保所有 url 以 / 开头"
echo
echo "4. 检查页面 permalink:"
echo "   确保 permalink 以 / 开头"

echo

# 重新构建和测试
log_info "修复完成后的测试步骤:"
echo
echo "1. 重新构建网站:"
echo "   bundle exec jekyll build"
echo
echo "2. 本地测试:"
echo "   bundle exec jekyll serve"
echo "   访问 http://localhost:4000"
echo
echo "3. 提交更改:"
echo "   git add ."
echo "   git commit -m 'Fix 404 links for root path deployment'"
echo "   git push origin main"
echo
echo "4. 等待 GitHub Pages 重新部署 (2-5分钟)"
echo
echo "5. 测试线上网站:"
echo "   https://beyond-reading-science.wangyongqing.com"

echo

# 常见问题解决
echo -e "${YELLOW}🚨 常见问题解决:${NC}"
echo
echo "如果仍有 404 问题:"
echo "1. 检查文件名大小写 (GitHub Pages 区分大小写)"
echo "2. 确保文件扩展名正确 (.html vs .md)"
echo "3. 检查 front matter 中的 permalink"
echo "4. 清除浏览器缓存"

echo

log_success "404 修复指导完成！"