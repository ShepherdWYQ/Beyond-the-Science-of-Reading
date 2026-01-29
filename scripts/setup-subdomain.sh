#!/bin/bash

# 设置子域名方案 - 最简单的多项目解决方案

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

echo -e "${BLUE}🚀 简单多项目方案：子域名配置${NC}"
echo

log_info "推荐的多项目架构："
echo "📚 beyond-reading-science.wangyongqing.com  # 本项目"
echo "🔮 future-project-1.wangyongqing.com       # 未来项目1"
echo "🔮 future-project-2.wangyongqing.com       # 未来项目2"
echo "🏠 translation.wangyongqing.com            # 项目索引"

echo
echo -e "${YELLOW}优点：${NC}"
echo "✅ 每个项目完全独立"
echo "✅ GitHub Pages 原生支持"
echo "✅ 无需复杂配置"
echo "✅ 易于管理和扩展"
echo "✅ 支持独立的 SSL 证书"

echo
read -p "是否配置子域名方案? (y/N): " -n 1 -r
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    log_info "取消配置"
    exit 0
fi

# 配置当前项目为子域名
log_info "配置当前项目为子域名..."

# 更新 Jekyll 配置
cat > _config.yml << 'EOF'
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

# Site settings - 子域名配置
url: https://beyond-reading-science.wangyongqing.com
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

# 更新 CNAME 文件
echo "beyond-reading-science.wangyongqing.com" > CNAME

log_success "配置文件已更新"

# 创建项目索引页面模板
log_info "创建项目索引页面模板..."

mkdir -p project-index-template

cat > project-index-template/index.html << 'EOF'
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>翻译项目 - Translation Projects</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: "PingFang SC", "Helvetica Neue", Arial, sans-serif;
            line-height: 1.6;
            color: #333;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .container {
            background: white;
            padding: 3em;
            border-radius: 15px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            max-width: 800px;
            width: 90%;
        }
        
        h1 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 0.5em;
            font-size: 2.5em;
        }
        
        .subtitle {
            text-align: center;
            color: #7f8c8d;
            margin-bottom: 2em;
            font-size: 1.1em;
        }
        
        .projects {
            display: grid;
            gap: 1.5em;
        }
        
        .project {
            border: 2px solid #ecf0f1;
            border-radius: 10px;
            padding: 2em;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .project::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #3498db, #9b59b6);
        }
        
        .project:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            border-color: #3498db;
        }
        
        .project-title {
            font-size: 1.4em;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 0.5em;
        }
        
        .project-desc {
            color: #666;
            margin-bottom: 1.5em;
            line-height: 1.6;
        }
        
        .project-meta {
            display: flex;
            gap: 1em;
            margin-bottom: 1.5em;
            font-size: 0.9em;
            color: #7f8c8d;
        }
        
        .project-links {
            display: flex;
            gap: 0.8em;
            flex-wrap: wrap;
        }
        
        .project-links a {
            display: inline-flex;
            align-items: center;
            padding: 0.6em 1.2em;
            background: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            transition: all 0.2s;
            font-weight: 500;
        }
        
        .project-links a:hover {
            background: #2980b9;
            transform: translateY(-1px);
        }
        
        .project-links a.secondary {
            background: #95a5a6;
        }
        
        .project-links a.secondary:hover {
            background: #7f8c8d;
        }
        
        .coming-soon {
            opacity: 0.6;
            position: relative;
        }
        
        .coming-soon::after {
            content: '敬请期待';
            position: absolute;
            top: 1em;
            right: 1em;
            background: #f39c12;
            color: white;
            padding: 0.3em 0.8em;
            border-radius: 15px;
            font-size: 0.8em;
            font-weight: bold;
        }
        
        .footer {
            text-align: center;
            margin-top: 3em;
            padding-top: 2em;
            border-top: 1px solid #ecf0f1;
            color: #7f8c8d;
        }
        
        @media (max-width: 600px) {
            .container {
                padding: 2em;
                margin: 1em;
            }
            
            h1 {
                font-size: 2em;
            }
            
            .project-links {
                flex-direction: column;
            }
            
            .project-links a {
                text-align: center;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>翻译项目</h1>
        <p class="subtitle">Translation Projects Collection</p>
        
        <div class="projects">
            <!-- 当前项目 -->
            <div class="project">
                <div class="project-title">Beyond the Science of Reading</div>
                <div class="project-meta">
                    <span>📚 教育类</span>
                    <span>🌟 进行中</span>
                    <span>📅 2025</span>
                </div>
                <div class="project-desc">
                    《Beyond the Science of Reading: Connecting Literacy Instruction to the Science of Learning》中文翻译项目。
                    探讨如何将阅读教学与学习科学相结合，超越传统的"阅读战争"辩论。
                </div>
                <div class="project-links">
                    <a href="https://beyond-reading-science.wangyongqing.com/">📖 在线阅读</a>
                    <a href="https://beyond-reading-science.wangyongqing.com/downloads/">📥 电子书下载</a>
                    <a href="https://github.com/ShepherdWYQ/Beyond-the-Science-of-Reading" class="secondary">💻 GitHub</a>
                </div>
            </div>
            
            <!-- 未来项目占位 -->
            <div class="project coming-soon">
                <div class="project-title">AI 设计模式</div>
                <div class="project-meta">
                    <span>🤖 AI类</span>
                    <span>⏳ 计划中</span>
                    <span>📅 2025</span>
                </div>
                <div class="project-desc">
                    人工智能系统设计模式相关翻译项目，涵盖最新的 AI 架构和实践方法。
                </div>
                <div class="project-links">
                    <a href="#" class="secondary">敬请期待</a>
                </div>
            </div>
            
            <div class="project coming-soon">
                <div class="project-title">技术文档翻译</div>
                <div class="project-meta">
                    <span>📖 技术类</span>
                    <span>⏳ 计划中</span>
                    <span>📅 2025</span>
                </div>
                <div class="project-desc">
                    优秀技术文档和开源项目文档的中文翻译，让更多开发者受益。
                </div>
                <div class="project-links">
                    <a href="#" class="secondary">敬请期待</a>
                </div>
            </div>
        </div>
        
        <div class="footer">
            <p>© 2025 翻译项目合集 | 致力于知识传播与分享</p>
            <p style="margin-top: 0.5em; font-size: 0.9em;">
                所有翻译内容仅供学习交流使用，请尊重原作者版权
            </p>
        </div>
    </div>
</body>
</html>
EOF

log_success "项目索引页面模板已创建: project-index-template/index.html"

# 提交更改
log_info "提交配置更改..."
git add .
git commit -m "Setup subdomain configuration: beyond-reading-science.wangyongqing.com"

if git push origin main; then
    log_success "配置已推送到 GitHub"
else
    log_warning "推送失败，请手动推送: git push origin main"
fi

echo
echo -e "${GREEN}🎉 子域名配置完成！${NC}"
echo
echo -e "${BLUE}📋 下一步操作：${NC}"
echo
echo "1. 📡 DNS 配置："
echo "   添加 CNAME 记录："
echo "   beyond-reading-science.wangyongqing.com -> ShepherdWYQ.github.io"
echo
echo "2. ⚙️  GitHub Pages 设置："
echo "   访问: https://github.com/ShepherdWYQ/Beyond-the-Science-of-Reading/settings/pages"
echo "   Custom domain: beyond-reading-science.wangyongqing.com"
echo
echo "3. 🏠 项目索引页面："
echo "   将 project-index-template/index.html 部署到 translation.wangyongqing.com"
echo
echo "4. 🌐 访问地址："
echo "   项目索引: https://translation.wangyongqing.com"
echo "   本项目: https://beyond-reading-science.wangyongqing.com"
echo
echo -e "${YELLOW}💡 未来添加新项目：${NC}"
echo "1. 创建新仓库"
echo "2. 配置子域名: new-project.wangyongqing.com"
echo "3. 更新项目索引页面"
echo
echo -e "${GREEN}✨ 简单、独立、易扩展！${NC}"