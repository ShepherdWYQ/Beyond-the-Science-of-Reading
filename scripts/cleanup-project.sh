#!/bin/bash

# 项目清理脚本 - 删除无效内容，精简项目结构

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

echo -e "${BLUE}🧹 项目结构清理${NC}"
echo

# 1. 删除重复和临时文件
log_info "删除重复和临时文件..."

DUPLICATE_FILES=(
    "DEPLOYMENT_GUIDE.md.backup"
    "DEPLOYMENT.md.backup" 
    "DOMAIN_SETUP.md.backup"
    "generate-pdf-pandoc.sh"
    "generate-pdf.js"
    "package.json"
)

for file in "${DUPLICATE_FILES[@]}"; do
    if [[ -f "$file" ]]; then
        rm "$file"
        echo "  🗑️  删除: $file"
    fi
done

# 2. 删除过时的文档文件
log_info "删除过时的文档文件..."

OUTDATED_DOCS=(
    "BUILD_FIX.md"
    "FIX_404.md" 
    "FIXES_SUMMARY.md"
    "INSTALL_RUBY.md"
    "LOCAL_PREVIEW.md"
    "PAGE_FIX.md"
    "RUBY_UPGRADE.md"
    "TROUBLESHOOTING.md"
    "DEPLOYMENT_OPTIONS.md"
    "MULTI_PROJECT_SETUP.md"
    "SIMPLE_MULTI_PROJECT.md"
    "DNS_SETUP_GUIDE.md"
    "DOMAIN_SETUP.md"
)

for file in "${OUTDATED_DOCS[@]}"; do
    if [[ -f "$file" ]]; then
        rm "$file"
        echo "  🗑️  删除: $file"
    fi
done

# 3. 清理scripts目录
log_info "清理scripts目录..."

OUTDATED_SCRIPTS=(
    "scripts/fix-404-links.sh"
    "scripts/fix-github-pages.sh"
    "scripts/fix-subpath-deployment.sh"
    "scripts/monitor-deployment.sh"
    "scripts/quick-deploy.sh"
    "scripts/test-fix.sh"
    "scripts/wait-and-configure.sh"
    "scripts/generate-downloads.sh"
    "scripts/check-dns.sh"
    "scripts/test-domain.sh"
)

for script in "${OUTDATED_SCRIPTS[@]}"; do
    if [[ -f "$script" ]]; then
        rm "$script"
        echo "  🗑️  删除: $script"
    fi
done

# 4. 保留核心scripts
log_info "保留的核心脚本:"
CORE_SCRIPTS=(
    "scripts/deploy.sh"
    "scripts/deploy-github.sh" 
    "scripts/setup-ebook-builder.sh"
    "scripts/setup-subdomain.sh"
)

for script in "${CORE_SCRIPTS[@]}"; do
    if [[ -f "$script" ]]; then
        echo "  ✅ 保留: $script"
    fi
done

# 5. 合并重复的部署文档
log_info "合并部署文档..."

cat > DEPLOYMENT.md << 'EOF'
# 部署指南

## 🎯 当前配置

- **域名**: beyond-reading-science.wangyongqing.com
- **部署方式**: GitHub Pages + 自定义域名
- **构建系统**: Jekyll + 电子书自动生成

## 🚀 快速部署

```bash
# 自动部署
./scripts/deploy.sh

# 或使用 GitHub Pages 默认域名
./scripts/deploy-github.sh
```

## ⚙️ 配置要求

### DNS 配置
```
记录类型: CNAME
主机记录: beyond-reading-science
记录值: ShepherdWYQ.github.io
```

### GitHub Pages 设置
- Custom domain: `beyond-reading-science.wangyongqing.com`
- Enforce HTTPS: 启用

## 📚 电子书构建

```bash
# 设置构建环境
./scripts/setup-ebook-builder.sh

# 生成电子书
cd build && make all
```

详细说明请查看 [EBOOK_BUILD.md](EBOOK_BUILD.md)
EOF

# 6. 精简README
log_info "精简README文档..."

cat > README.md << 'EOF'
# Beyond the Science of Reading（中文翻译项目）

《Beyond the Science of Reading: Connecting Literacy Instruction to the Science of Learning》中文翻译项目。

## 🌐 在线访问

**网站地址**: https://beyond-reading-science.wangyongqing.com

## 📚 关于本书

- **作者**: Natalie Wexler
- **出版社**: ASCD
- **出版日期**: 2025年1月21日
- **ISBN**: 978-1-4166-3356-3

## 🚀 快速开始

### 在线阅读
直接访问网站：https://beyond-reading-science.wangyongqing.com

### 电子书下载
访问下载页面：https://beyond-reading-science.wangyongqing.com/downloads/

### 本地开发
```bash
# 安装依赖
bundle install

# 启动本地服务器
bundle exec jekyll serve
```

### 部署网站
```bash
./scripts/deploy.sh
```

## 📁 项目结构

```
├── _config.yml          # Jekyll 配置
├── _includes/           # 页面组件
├── _layouts/            # 页面布局
├── chapters/            # 翻译章节
├── downloads/           # 电子书下载
├── build/               # 电子书构建系统
├── scripts/             # 部署脚本
├── SUMMARY.md           # 目录
├── glossary.md          # 术语表
└── progress.md          # 翻译进度
```

## 🤝 参与贡献

查看 [CONTRIBUTING.md](CONTRIBUTING.md) 了解如何参与翻译。

## 📄 许可证

本翻译项目遵循原书的许可证条款，仅供学习交流使用。
EOF

# 7. 精简项目结构文档
log_info "更新项目结构文档..."

cat > PROJECT_STRUCTURE.md << 'EOF'
# 项目结构说明

## 📁 目录结构

```
Beyond-the-Science-of-Reading/
├── _config.yml                 # Jekyll 配置文件
├── _includes/                  # Jekyll 组件
│   └── navigation.html         # 导航菜单
├── _layouts/                   # Jekyll 布局
│   └── default.html            # 默认布局
├── chapters/                   # 翻译章节
│   ├── README.md               # 章节说明
│   └── *.md                    # 各章节文件
├── downloads/                  # 电子书下载
│   ├── index.md                # 下载页面
│   └── *.pdf/*.epub/*.mobi     # 电子书文件
├── build/                      # 电子书构建系统
│   ├── build-ebooks.js         # 构建脚本
│   ├── Makefile                # Make 配置
│   └── styles/                 # 样式文件
├── scripts/                    # 部署和工具脚本
│   ├── deploy.sh               # 主部署脚本
│   └── setup-ebook-builder.sh # 构建环境设置
├── images/                     # 图片资源
├── SUMMARY.md                  # 网站目录
├── glossary.md                 # 术语表
├── progress.md                 # 翻译进度
├── CONTRIBUTING.md             # 贡献指南
├── DEPLOYMENT.md               # 部署指南
├── EBOOK_BUILD.md              # 电子书构建指南
└── README.md                   # 项目说明
```

## 🔧 核心文件说明

### 配置文件
- `_config.yml`: Jekyll 网站配置
- `Gemfile`: Ruby 依赖管理
- `CNAME`: 自定义域名配置

### 内容文件
- `index.md`: 网站首页
- `chapters/*.md`: 翻译章节内容
- `SUMMARY.md`: 完整目录结构
- `glossary.md`: 专业术语对照表

### 构建系统
- `build/`: 电子书自动生成系统
- `scripts/`: 部署和维护脚本

### 文档
- `README.md`: 项目总览
- `CONTRIBUTING.md`: 贡献指南
- `DEPLOYMENT.md`: 部署说明
- `EBOOK_BUILD.md`: 电子书构建指南
EOF

echo

# 8. 显示清理结果
log_success "项目清理完成！"

echo
echo -e "${GREEN}📊 清理统计:${NC}"
echo "🗑️  删除重复文件: ${#DUPLICATE_FILES[@]} 个"
echo "🗑️  删除过时文档: ${#OUTDATED_DOCS[@]} 个" 
echo "🗑️  删除过时脚本: ${#OUTDATED_SCRIPTS[@]} 个"
echo "✅ 保留核心脚本: ${#CORE_SCRIPTS[@]} 个"
echo "📝 更新核心文档: 3 个"

echo
echo -e "${BLUE}📁 精简后的项目结构:${NC}"
echo "├── 配置文件 (Jekyll, Git, 域名)"
echo "├── 内容文件 (章节, 页面, 文档)"  
echo "├── 构建系统 (电子书生成)"
echo "├── 部署脚本 (核心功能)"
echo "└── 资源文件 (图片, 样式)"

echo
echo -e "${YELLOW}📋 下一步操作:${NC}"
echo "1. 检查清理结果"
echo "2. 提交更改: git add . && git commit -m 'Clean up project structure'"
echo "3. 推送代码: git push origin main"

echo
log_success "项目结构已优化，更加简洁易维护！"