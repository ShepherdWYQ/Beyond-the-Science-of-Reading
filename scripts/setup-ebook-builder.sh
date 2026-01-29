#!/bin/bash

# Beyond the Science of Reading - 电子书构建环境设置脚本
# 参考 xindoo/agentic-design-patterns 项目架构

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

# 检查操作系统
check_os() {
    log_info "检查操作系统..."
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
        log_success "检测到 macOS"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="linux"
        log_success "检测到 Linux"
    else
        log_error "不支持的操作系统: $OSTYPE"
        exit 1
    fi
}

# 检查并安装 Homebrew (macOS)
install_homebrew() {
    if [[ "$OS" == "macos" ]]; then
        if ! command -v brew &> /dev/null; then
            log_info "安装 Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            log_success "Homebrew 安装完成"
        else
            log_success "Homebrew 已安装"
        fi
    fi
}

# 检查并安装 Node.js
install_nodejs() {
    log_info "检查 Node.js..."
    
    if ! command -v node &> /dev/null; then
        log_info "安装 Node.js..."
        
        if [[ "$OS" == "macos" ]]; then
            brew install node
        elif [[ "$OS" == "linux" ]]; then
            # 使用 NodeSource 仓库安装最新 LTS
            curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
            sudo apt-get install -y nodejs
        fi
        
        log_success "Node.js 安装完成"
    else
        NODE_VERSION=$(node --version)
        log_success "Node.js 已安装: $NODE_VERSION"
    fi
    
    # 检查版本
    NODE_MAJOR_VERSION=$(node --version | cut -d'.' -f1 | sed 's/v//')
    if [[ $NODE_MAJOR_VERSION -lt 14 ]]; then
        log_error "Node.js 版本过低，需要 >= 14.0.0"
        exit 1
    fi
}

# 检查并安装 Pandoc
install_pandoc() {
    log_info "检查 Pandoc..."
    
    if ! command -v pandoc &> /dev/null; then
        log_info "安装 Pandoc..."
        
        if [[ "$OS" == "macos" ]]; then
            brew install pandoc
        elif [[ "$OS" == "linux" ]]; then
            sudo apt-get update
            sudo apt-get install -y pandoc
        fi
        
        log_success "Pandoc 安装完成"
    else
        PANDOC_VERSION=$(pandoc --version | head -n1)
        log_success "Pandoc 已安装: $PANDOC_VERSION"
    fi
}

# 检查并安装 LaTeX (用于 PDF 生成)
install_latex() {
    log_info "检查 LaTeX..."
    
    if ! command -v xelatex &> /dev/null; then
        log_info "安装 LaTeX..."
        
        if [[ "$OS" == "macos" ]]; then
            # 安装 BasicTeX (较小的 LaTeX 发行版)
            brew install --cask basictex
            
            # 更新 PATH
            export PATH="/usr/local/texlive/2023basic/bin/universal-darwin:$PATH"
            
            # 安装必要的包
            sudo tlmgr update --self
            sudo tlmgr install xecjk
            sudo tlmgr install ctex
            sudo tlmgr install collection-fontsrecommended
            
        elif [[ "$OS" == "linux" ]]; then
            sudo apt-get install -y texlive-xetex texlive-fonts-recommended texlive-lang-chinese
        fi
        
        log_success "LaTeX 安装完成"
    else
        log_success "LaTeX 已安装"
    fi
}

# 检查并安装 Calibre (可选，用于 MOBI)
install_calibre() {
    log_info "检查 Calibre..."
    
    if ! command -v ebook-convert &> /dev/null; then
        log_warning "Calibre 未安装，将无法生成 MOBI 格式"
        
        read -p "是否安装 Calibre? (y/N): " -n 1 -r
        echo
        
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            log_info "安装 Calibre..."
            
            if [[ "$OS" == "macos" ]]; then
                brew install --cask calibre
            elif [[ "$OS" == "linux" ]]; then
                sudo apt-get install -y calibre
            fi
            
            log_success "Calibre 安装完成"
        else
            log_warning "跳过 Calibre 安装，将无法生成 MOBI 格式"
        fi
    else
        CALIBRE_VERSION=$(ebook-convert --version | head -n1)
        log_success "Calibre 已安装: $CALIBRE_VERSION"
    fi
}

# 安装 Node.js 依赖
install_node_dependencies() {
    log_info "安装 Node.js 依赖..."
    
    cd build
    
    if [[ ! -f "package.json" ]]; then
        log_error "未找到 package.json 文件"
        exit 1
    fi
    
    npm install
    log_success "Node.js 依赖安装完成"
    
    cd ..
}

# 创建必要的目录
create_directories() {
    log_info "创建必要的目录..."
    
    mkdir -p build/temp
    mkdir -p dist
    mkdir -p images
    
    log_success "目录创建完成"
}

# 下载 Pandoc 模板 (可选)
download_templates() {
    log_info "检查 Pandoc 模板..."
    
    TEMPLATE_DIR="$HOME/.pandoc/templates"
    EISVOGEL_TEMPLATE="$TEMPLATE_DIR/eisvogel.latex"
    
    if [[ ! -f "$EISVOGEL_TEMPLATE" ]]; then
        log_info "下载 Eisvogel 模板..."
        
        mkdir -p "$TEMPLATE_DIR"
        
        curl -L https://raw.githubusercontent.com/Wandmalfarbe/pandoc-latex-template/master/eisvogel.tex \
            -o "$EISVOGEL_TEMPLATE"
        
        log_success "Eisvogel 模板下载完成"
    else
        log_success "Pandoc 模板已存在"
    fi
}

# 测试构建环境
test_build_environment() {
    log_info "测试构建环境..."
    
    cd build
    
    # 测试 Node.js 脚本
    if node -e "console.log('Node.js 测试通过')"; then
        log_success "Node.js 环境正常"
    else
        log_error "Node.js 环境异常"
        exit 1
    fi
    
    # 测试 Pandoc
    if pandoc --version > /dev/null; then
        log_success "Pandoc 环境正常"
    else
        log_error "Pandoc 环境异常"
        exit 1
    fi
    
    cd ..
}

# 生成示例电子书
generate_sample() {
    log_info "生成示例电子书..."
    
    cd build
    
    # 创建简单的测试文档
    cat > temp/test.md << 'EOF'
---
title: "测试文档"
author: "电子书构建系统"
date: "$(date)"
---

# 测试文档

这是一个测试文档，用于验证电子书构建系统是否正常工作。

## 功能测试

- **粗体文本**
- *斜体文本*
- `代码文本`

### 列表测试

1. 第一项
2. 第二项
3. 第三项

### 代码块测试

```javascript
console.log("Hello, World!");
```

## 中文测试

这是中文内容测试，包含各种标点符号：，。！？；：""''（）【】

测试完成。
EOF

    # 生成测试 PDF
    if pandoc temp/test.md -o ../dist/test.pdf --pdf-engine=xelatex --variable mainfont="PingFang SC"; then
        log_success "示例 PDF 生成成功: dist/test.pdf"
    else
        log_warning "示例 PDF 生成失败，但环境基本正常"
    fi
    
    # 清理测试文件
    rm -f temp/test.md
    
    cd ..
}

# 显示完成信息
show_completion_info() {
    echo
    log_success "🎉 电子书构建环境设置完成！"
    echo
    echo -e "${BLUE}📚 使用方法:${NC}"
    echo "  cd build"
    echo "  make help          # 查看所有可用命令"
    echo "  make all           # 构建所有格式"
    echo "  make pdf           # 仅构建 PDF"
    echo "  make epub          # 仅构建 EPUB"
    echo
    echo -e "${BLUE}📁 输出目录:${NC}"
    echo "  dist/              # 生成的电子书文件"
    echo
    echo -e "${BLUE}🔧 配置文件:${NC}"
    echo "  build/build-ebooks.js    # 主构建脚本"
    echo "  build/styles/epub.css    # EPUB 样式"
    echo
    if [[ -f "dist/test.pdf" ]]; then
        echo -e "${GREEN}✅ 示例文件已生成: dist/test.pdf${NC}"
    fi
}

# 主函数
main() {
    echo -e "${BLUE}🚀 Beyond the Science of Reading - 电子书构建环境设置${NC}"
    echo -e "${BLUE}参考项目: xindoo/agentic-design-patterns${NC}"
    echo
    
    check_os
    install_homebrew
    install_nodejs
    install_pandoc
    install_latex
    install_calibre
    create_directories
    install_node_dependencies
    download_templates
    test_build_environment
    generate_sample
    show_completion_info
}

# 错误处理
trap 'log_error "安装过程中发生错误，请检查上面的错误信息"; exit 1' ERR

# 运行主函数
main "$@"