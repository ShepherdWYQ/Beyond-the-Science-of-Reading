# 部署指南

## 🎯 当前配置

- **域名**: beyond-reading-science.wangyongqing.com
- **部署方式**: GitHub Pages + 自定义域名
- **构建系统**: Jekyll

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
