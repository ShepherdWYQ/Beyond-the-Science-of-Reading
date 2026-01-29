#!/bin/bash

# 快速部署脚本 - 解决404问题

echo "🚀 快速部署到 GitHub Pages"
echo

# 检查Git状态
if [[ -n $(git status --porcelain) ]]; then
    echo "📝 提交更改..."
    git add .
    git commit -m "Fix 404: Deploy to translation.wangyongqing.com/beyond-reading-science"
fi

# 推送代码
echo "📤 推送代码到 GitHub..."
if git push origin main; then
    echo "✅ 代码推送成功"
else
    echo "❌ 推送失败，请检查网络连接"
    echo "💡 手动操作："
    echo "   1. 访问 https://github.com/ShepherdWYQ/Beyond-the-Science-of-Reading"
    echo "   2. 上传更改的文件"
    echo "   3. 或者稍后重试: git push origin main"
    exit 1
fi

echo
echo "⏳ 等待 GitHub Pages 构建..."
sleep 10

echo
echo "🔧 请手动配置 GitHub Pages："
echo "   1. 访问: https://github.com/ShepherdWYQ/Beyond-the-Science-of-Reading/settings/pages"
echo "   2. Source: Deploy from a branch"
echo "   3. Branch: main"
echo "   4. Custom domain: translation.wangyongqing.com"
echo "   5. 启用 Enforce HTTPS"

echo
echo "🌐 部署完成后访问:"
echo "   https://translation.wangyongqing.com/beyond-reading-science"

echo
echo "📊 检查构建状态:"
echo "   https://github.com/ShepherdWYQ/Beyond-the-Science-of-Reading/actions"