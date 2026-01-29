# 部署指南

本项目配置为部署到 `translation.wangyongqing.com/beyond-reading-science`。

## 🎯 部署配置

- **域名**: translation.wangyongqing.com
- **路径**: /beyond-reading-science
- **完整地址**: https://translation.wangyongqing.com/beyond-reading-science

## 🚀 快速部署

### 自动部署（推荐）
```bash
# 运行自动部署脚本
./scripts/deploy.sh
```

### 手动部署
```bash
# 1. 构建网站
bundle exec jekyll build

# 2. 提交并推送代码
git add .
git commit -m "Deploy to translation.wangyongqing.com/beyond-reading-science"
git push origin main
```

## ⚙️ GitHub Pages 设置

### 1. 仓库设置
在 GitHub 仓库的 Settings > Pages 中：

- **Source**: Deploy from a branch
- **Branch**: main
- **Folder**: / (root)
- **Custom domain**: translation.wangyongqing.com

### 2. DNS 配置
需要在域名服务商处配置：

```
# A 记录
translation.wangyongqing.com -> 185.199.108.153
translation.wangyongqing.com -> 185.199.109.153
translation.wangyongqing.com -> 185.199.110.153
translation.wangyongqing.com -> 185.199.111.153

# 或者 CNAME 记录（如果有主域名）
translation.wangyongqing.com -> username.github.io
```

## 📁 文件配置

### Jekyll 配置 (_config.yml)
```yaml
url: https://translation.wangyongqing.com
baseurl: /beyond-reading-science
```

### CNAME 文件
```
translation.wangyongqing.com
```

## 🔗 访问地址

部署完成后，网站将在以下地址访问：

- **主页**: https://translation.wangyongqing.com/beyond-reading-science
- **章节**: https://translation.wangyongqing.com/beyond-reading-science/chapters/
- **下载**: https://translation.wangyongqing.com/beyond-reading-science/downloads/
- **术语表**: https://translation.wangyongqing.com/beyond-reading-science/glossary.html

## 🛠️ 故障排除

### 常见问题

1. **404 错误**
   - 检查 `baseurl` 配置是否正确
   - 确认 GitHub Pages 已启用
   - 等待 DNS 传播（最多 24 小时）

2. **CSS/JS 资源加载失败**
   - 检查 `_config.yml` 中的 `url` 和 `baseurl` 配置
   - 确保所有链接使用 `{{ site.baseurl }}` 前缀

3. **自定义域名不工作**
   - 检查 DNS 配置
   - 确认 CNAME 文件存在且内容正确
   - 在 GitHub 仓库设置中重新配置自定义域名

### 调试步骤

1. **本地测试**
   ```bash
   # 使用生产环境配置测试
   JEKYLL_ENV=production bundle exec jekyll serve
   # 访问 http://localhost:4000/beyond-reading-science
   ```

2. **检查构建日志**
   - 在 GitHub 仓库的 Actions 标签页查看构建日志
   - 查找错误信息和警告

3. **验证配置**
   ```bash
   # 检查 Jekyll 配置
   bundle exec jekyll doctor
   
   # 验证 HTML
   bundle exec htmlproofer ./_site --disable-external
   ```

## 📊 部署状态检查

### 自动检查脚本
```bash
# 检查网站是否可访问
curl -I https://translation.wangyongqing.com/beyond-reading-science

# 检查 DNS 解析
nslookup translation.wangyongqing.com

# 检查 SSL 证书
openssl s_client -connect translation.wangyongqing.com:443 -servername translation.wangyongqing.com
```

### 手动检查清单
- [ ] GitHub Pages 已启用
- [ ] 自定义域名已配置
- [ ] DNS 记录已设置
- [ ] HTTPS 已启用
- [ ] 网站可正常访问
- [ ] 所有页面链接正常
- [ ] 电子书下载功能正常

## 🔄 更新部署

### 内容更新
```bash
# 1. 更新内容
git add .
git commit -m "Update content"

# 2. 自动部署
./scripts/deploy.sh
```

### 配置更新
如需更改域名或路径：

1. 修改 `_config.yml` 中的 `url` 和 `baseurl`
2. 更新 `CNAME` 文件
3. 重新部署

## 📚 相关资源

- [GitHub Pages 文档](https://docs.github.com/en/pages)
- [Jekyll 文档](https://jekyllrb.com/docs/)
- [自定义域名配置](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site)

## 📞 技术支持

如遇到部署问题，请检查：
1. GitHub Actions 构建日志
2. 浏览器开发者工具控制台
3. DNS 传播状态
4. SSL 证书状态