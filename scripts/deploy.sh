#!/bin/bash

# Beyond the Science of Reading - 部署脚本
# 部署到 reading.wangyongqing.com

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 日志函数
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

# 检查 Git 状态
check_git_status() {
    log_info "检查 Git 状态..."
    
    if [[ -n $(git status --porcelain) ]]; then
        log_warning "工作目录有未提交的更改"
        git status --short
        
        read -p "是否继续部署? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log_info "部署已取消"
            exit 0
        fi
    else
        log_success "工作目录干净"
    fi
}

# 构建 Jekyll 网站
build_jekyll() {
    log_info "构建 Jekyll 网站..."
    
    # 检查 Jekyll 是否安装
    if ! command -v bundle &> /dev/null; then
        log_error "Bundle 未安装，请先运行: gem install bundler"
        exit 1
    fi
    
    # 安装依赖
    if [[ ! -d "vendor/bundle" ]]; then
        log_info "安装 Jekyll 依赖..."
        bundle install
    fi
    
    # 构建网站
    log_info "构建网站..."
    JEKYLL_ENV=production bundle exec jekyll build
    
    log_success "Jekyll 网站构建完成"
}

# 构建电子书
build_ebooks() {
    log_info "构建电子书..."
    
    if [[ -f "build/build-ebooks.js" ]]; then
        cd build
        
        # 检查 Node.js 依赖
        if [[ ! -d "node_modules" ]]; then
            log_info "安装 Node.js 依赖..."
            npm install
        fi
        
        # 构建电子书
        log_info "生成 PDF 和 EPUB..."
        node build-ebooks.js pdf || log_warning "PDF 生成失败"
        node build-ebooks.js epub || log_warning "EPUB 生成失败"
        
        # 复制电子书到网站目录
        if [[ -d "../dist" ]]; then
            mkdir -p ../_site/downloads
            cp -f ../dist/*.pdf ../_site/downloads/ 2>/dev/null || true
            cp -f ../dist/*.epub ../_site/downloads/ 2>/dev/null || true
            cp -f ../dist/*.mobi ../_site/downloads/ 2>/dev/null || true
            log_success "电子书已复制到网站"
        fi
        
        cd ..
    else
        log_warning "未找到电子书构建脚本，跳过电子书生成"
    fi
}

# 部署到 GitHub Pages
deploy_github_pages() {
    log_info "部署到 GitHub Pages..."
    
    # 检查远程仓库
    if ! git remote get-url origin &> /dev/null; then
        log_error "未找到 Git 远程仓库"
        exit 1
    fi
    
    REMOTE_URL=$(git remote get-url origin)
    log_info "远程仓库: $REMOTE_URL"
    
    # 提交更改
    if [[ -n $(git status --porcelain) ]]; then
        log_info "提交更改..."
        git add .
        git commit -m "Deploy: $(date '+%Y-%m-%d %H:%M:%S')"
    fi
    
    # 推送到 GitHub
    log_info "推送到 GitHub..."
    git push origin main
    
    log_success "代码已推送到 GitHub"
}

# 验证部署
verify_deployment() {
    log_info "验证部署..."
    
    # 等待 GitHub Pages 构建
    log_info "等待 GitHub Pages 构建完成..."
    sleep 10
    
    # 检查网站是否可访问
    if curl -s -o /dev/null -w "%{http_code}" https://beyond-reading-science.wangyongqing.com | grep -q "200"; then
        log_success "网站部署成功: https://beyond-reading-science.wangyongqing.com"
    else
        log_warning "网站可能还在构建中，请稍后检查"
        log_info "GitHub Pages 通常需要几分钟时间完成部署"
    fi
}

# 生成下载页面
generate_downloads_page() {
    log_info "生成下载页面..."
    
    mkdir -p downloads
    
    cat > downloads/index.md << 'EOF'
---
layout: default
title: 电子书下载
permalink: /downloads/
---

# 电子书下载

《Beyond the Science of Reading: Connecting Literacy Instruction to the Science of Learning》中文翻译版电子书下载。

## 📚 可用格式

### PDF 格式
- **适用于**: 电脑阅读、打印
- **特点**: 完美排版、支持中文字体
- [📄 下载 PDF](Beyond-the-Science-of-Reading.pdf)

### EPUB 格式  
- **适用于**: 手机、平板、电子书阅读器
- **特点**: 响应式布局、自适应屏幕
- [📱 下载 EPUB](Beyond-the-Science-of-Reading.epub)

### MOBI 格式
- **适用于**: Kindle 设备
- **特点**: Kindle 原生支持
- [📖 下载 MOBI](Beyond-the-Science-of-Reading.mobi)

## 📖 阅读建议

- **在线阅读**: 推荐使用本网站在线阅读，支持搜索和导航
- **离线阅读**: 下载对应格式的电子书到设备
- **打印阅读**: 使用 PDF 格式获得最佳打印效果

## 🔄 更新说明

电子书会随着翻译进度自动更新，建议定期下载最新版本。

**最后更新**: {{ site.time | date: "%Y年%m月%d日" }}

## 📝 版权说明

本翻译项目遵循原书的许可证条款。翻译内容仅供学习交流使用。

---

[← 返回首页]({{ site.baseurl }}/)
EOF

    log_success "下载页面已生成"
}

# 更新导航菜单
update_navigation() {
    log_info "更新导航菜单..."
    
    # 更新 _config.yml 中的导航
    if grep -q "downloads" _config.yml; then
        log_info "导航菜单已包含下载链接"
    else
        # 在导航中添加下载链接
        sed -i.bak '/- title: 术语表/a\
  - title: 电子书下载\
    url: /downloads/' _config.yml
        
        log_success "导航菜单已更新"
    fi
}

# 主函数
main() {
    echo -e "${BLUE}🚀 Beyond the Science of Reading - 部署脚本${NC}"
    echo -e "${BLUE}目标地址: https://beyond-reading-science.wangyongqing.com${NC}"
    echo
    
    # 检查是否在项目根目录
    if [[ ! -f "_config.yml" ]]; then
        log_error "请在项目根目录运行此脚本"
        exit 1
    fi
    
    check_git_status
    generate_downloads_page
    update_navigation
    build_jekyll
    build_ebooks
    deploy_github_pages
    verify_deployment
    
    echo
    log_success "🎉 部署完成！"
    echo
    echo -e "${BLUE}📍 网站地址:${NC}"
    echo "  🌐 主站: https://beyond-reading-science.wangyongqing.com"
    echo "  📚 下载: https://beyond-reading-science.wangyongqing.com/downloads/"
    echo
    echo -e "${BLUE}📋 后续步骤:${NC}"
    echo "  1. 确保域名 beyond-reading-science.wangyongqing.com DNS 指向 GitHub Pages"
    echo "  2. 在 GitHub 仓库设置中配置自定义域名: beyond-reading-science.wangyongqing.com"
    echo "  3. 启用 HTTPS (GitHub Pages 自动配置)"
    echo "  4. 网站将在根路径下访问"
    echo
}

# 错误处理
trap 'log_error "部署过程中发生错误"; exit 1' ERR

# 运行主函数
main "$@"