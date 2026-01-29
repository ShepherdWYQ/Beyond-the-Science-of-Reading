#!/bin/bash

# 修复子路径部署问题
# 目标: https://translation.wangyongqing.com/beyond-reading-science

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

echo -e "${BLUE}🔧 修复子路径部署问题${NC}"
echo -e "${BLUE}目标: https://translation.wangyongqing.com/beyond-reading-science${NC}"
echo

# 问题分析
log_info "问题分析:"
echo "GitHub Pages 自定义域名 + 子路径的常见问题:"
echo "1. 自定义域名通常部署到根路径"
echo "2. 子路径需要特殊配置"
echo "3. 可能需要使用 GitHub Pages 默认域名 + 自定义域名代理"

echo

# 解决方案1: 使用 GitHub Pages 默认域名 + 子路径
log_info "解决方案1: 使用 GitHub Pages 默认域名"

# 删除 CNAME 文件，使用默认域名
if [[ -f "CNAME" ]]; then
    log_info "备份并删除 CNAME 文件..."
    cp CNAME CNAME.backup
    rm CNAME
fi

# 更新配置为 GitHub Pages 默认域名
cat > _config.yml.github << 'EOF'
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

# Site settings - GitHub Pages 默认域名 + 子路径
url: https://ShepherdWYQ.github.io
baseurl: /Beyond-the-Science-of-Reading

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
echo -e "${YELLOW}选择部署方案:${NC}"
echo "1. GitHub Pages 默认域名 (立即可用)"
echo "   访问地址: https://ShepherdWYQ.github.io/Beyond-the-Science-of-Reading"
echo
echo "2. 自定义域名 + Nginx 代理 (需要服务器配置)"
echo "   访问地址: https://translation.wangyongqing.com/beyond-reading-science"
echo
echo "3. 创建多项目索引页面 (推荐)"
echo "   根域名显示项目列表，子路径访问具体项目"

read -p "请选择方案 (1/2/3): " -n 1 -r
echo

case $REPLY in
    1)
        log_info "选择方案1: GitHub Pages 默认域名"
        
        # 使用 GitHub Pages 默认域名配置
        cp _config.yml.github _config.yml
        
        log_info "提交更改..."
        git add .
        git commit -m "Use GitHub Pages default domain with subpath"
        
        if git push origin main; then
            log_success "部署成功!"
            echo
            echo -e "${GREEN}访问地址:${NC}"
            echo "https://ShepherdWYQ.github.io/Beyond-the-Science-of-Reading"
            echo
            echo -e "${YELLOW}然后可以配置 Nginx 代理:${NC}"
            echo "translation.wangyongqing.com/beyond-reading-science -> ShepherdWYQ.github.io/Beyond-the-Science-of-Reading"
        else
            log_error "推送失败"
        fi
        ;;
        
    2)
        log_info "选择方案2: 配置 Nginx 代理"
        
        # 恢复自定义域名配置
        if [[ -f "CNAME.backup" ]]; then
            cp CNAME.backup CNAME
        else
            echo "translation.wangyongqing.com" > CNAME
        fi
        
        # 创建 Nginx 配置示例
        cat > nginx-proxy-config.txt << 'EOF'
# Nginx 配置示例
# 在 translation.wangyongqing.com 服务器上配置

server {
    listen 80;
    listen 443 ssl;
    server_name translation.wangyongqing.com;
    
    # SSL 配置
    ssl_certificate /path/to/ssl/cert.pem;
    ssl_certificate_key /path/to/ssl/key.pem;
    
    # 根路径显示项目索引
    location / {
        root /var/www/translation-index;
        index index.html;
    }
    
    # 代理到 GitHub Pages
    location /beyond-reading-science/ {
        proxy_pass https://ShepherdWYQ.github.io/Beyond-the-Science-of-Reading/;
        proxy_set_header Host ShepherdWYQ.github.io;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        
        # 重写路径
        proxy_redirect https://ShepherdWYQ.github.io/Beyond-the-Science-of-Reading/ /beyond-reading-science/;
    }
}
EOF
        
        log_success "Nginx 配置已生成: nginx-proxy-config.txt"
        echo
        echo -e "${YELLOW}需要在服务器上配置 Nginx 代理${NC}"
        ;;
        
    3)
        log_info "选择方案3: 创建多项目架构"
        
        # 创建项目索引页面
        mkdir -p projects-index
        
        cat > projects-index/index.html << 'EOF'
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>翻译项目 - Translation Projects</title>
    <style>
        body {
            font-family: "PingFang SC", "Helvetica Neue", Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            max-width: 800px;
            margin: 0 auto;
            padding: 2em;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        
        .container {
            background: white;
            padding: 2em;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        
        h1 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 2em;
        }
        
        .project {
            border: 1px solid #e1e8ed;
            border-radius: 8px;
            padding: 1.5em;
            margin-bottom: 1.5em;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        
        .project:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        
        .project-title {
            font-size: 1.3em;
            font-weight: bold;
            color: #3498db;
            margin-bottom: 0.5em;
        }
        
        .project-desc {
            color: #666;
            margin-bottom: 1em;
        }
        
        .project-links a {
            display: inline-block;
            padding: 0.5em 1em;
            margin-right: 0.5em;
            background: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: background 0.2s;
        }
        
        .project-links a:hover {
            background: #2980b9;
        }
        
        .footer {
            text-align: center;
            margin-top: 2em;
            color: #666;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>翻译项目 Translation Projects</h1>
        
        <div class="project">
            <div class="project-title">Beyond the Science of Reading</div>
            <div class="project-desc">
                《Beyond the Science of Reading: Connecting Literacy Instruction to the Science of Learning》中文翻译项目
            </div>
            <div class="project-links">
                <a href="/beyond-reading-science/">在线阅读</a>
                <a href="/beyond-reading-science/downloads/">电子书下载</a>
                <a href="https://github.com/ShepherdWYQ/Beyond-the-Science-of-Reading">GitHub</a>
            </div>
        </div>
        
        <!-- 未来项目占位 -->
        <div class="project" style="opacity: 0.6;">
            <div class="project-title">未来项目 1</div>
            <div class="project-desc">即将推出的翻译项目...</div>
            <div class="project-links">
                <a href="#" style="background: #95a5a6;">敬请期待</a>
            </div>
        </div>
        
        <div class="project" style="opacity: 0.6;">
            <div class="project-title">未来项目 2</div>
            <div class="project-desc">即将推出的翻译项目...</div>
            <div class="project-links">
                <a href="#" style="background: #95a5a6;">敬请期待</a>
            </div>
        </div>
        
        <div class="footer">
            <p>© 2025 翻译项目 | 仅供学习交流使用</p>
        </div>
    </div>
</body>
</html>
EOF
        
        log_success "项目索引页面已创建"
        echo
        echo -e "${YELLOW}多项目架构说明:${NC}"
        echo "1. 根域名 (translation.wangyongqing.com) 显示项目列表"
        echo "2. 子路径访问具体项目:"
        echo "   - /beyond-reading-science/ -> 本项目"
        echo "   - /future-project-1/ -> 未来项目1"
        echo "   - /future-project-2/ -> 未来项目2"
        ;;
        
    *)
        log_info "取消操作"
        ;;
esac

# 清理临时文件
rm -f _config.yml.github

echo
echo -e "${BLUE}📋 推荐的多项目架构:${NC}"
echo
echo "1. 使用 GitHub Pages 默认域名部署各个项目"
echo "2. 在 translation.wangyongqing.com 配置 Nginx 代理"
echo "3. 根路径显示项目索引，子路径代理到对应项目"
echo
echo -e "${YELLOW}Nginx 代理配置示例:${NC}"
echo "location /beyond-reading-science/ {"
echo "    proxy_pass https://ShepherdWYQ.github.io/Beyond-the-Science-of-Reading/;"
echo "}"
echo
echo "location /future-project/ {"
echo "    proxy_pass https://username.github.io/Future-Project/;"
echo "}"