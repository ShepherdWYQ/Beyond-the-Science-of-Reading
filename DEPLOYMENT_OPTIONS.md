# 部署选项

由于 `translation.wangyongqing.com` 域名无法访问，提供以下部署方案：

## 🎯 推荐方案

### 方案1：GitHub Pages 默认域名（立即可用）
```bash
# 使用 GitHub Pages 默认域名部署
./scripts/deploy-github.sh
```

**访问地址**: `https://ShepherdWYQ.github.io/Beyond-the-Science-of-Reading`

**优点**:
- ✅ 立即可用，无需域名配置
- ✅ 免费 HTTPS 证书
- ✅ 全球 CDN 加速
- ✅ 自动部署

### 方案2：使用现有域名的子路径
如果你有其他可用的域名，可以配置为子路径：

```yaml
# _config.yml
url: https://你的域名.com
baseurl: /beyond-reading-science
```

### 方案3：配置自定义域名
如果要使用自定义域名，需要先配置 DNS：

## 🔧 域名配置步骤

### 1. DNS 配置
在域名服务商处添加以下记录：

```
# A 记录（推荐）
translation.wangyongqing.com -> 185.199.108.153
translation.wangyongqing.com -> 185.199.109.153
translation.wangyongqing.com -> 185.199.110.153
translation.wangyongqing.com -> 185.199.111.153

# 或 CNAME 记录
translation.wangyongqing.com -> ShepherdWYQ.github.io
```

### 2. GitHub Pages 配置
1. 在 GitHub 仓库 Settings > Pages 中
2. 设置 Custom domain: `translation.wangyongqing.com`
3. 启用 "Enforce HTTPS"

### 3. 更新项目配置
```bash
# 创建 CNAME 文件
echo "translation.wangyongqing.com" > CNAME

# 更新 _config.yml
# url: https://translation.wangyongqing.com
# baseurl: /beyond-reading-science
```

## 🚀 快速部署

### 立即部署（推荐）
```bash
# 使用 GitHub Pages 默认域名
./scripts/deploy-github.sh
```

### 自定义域名部署
```bash
# 配置好域名后使用
./scripts/deploy.sh
```

## 📊 部署状态检查

### 检查 GitHub Pages 状态
```bash
# 访问 GitHub Actions 页面
https://github.com/ShepherdWYQ/Beyond-the-Science-of-Reading/actions

# 检查 Pages 设置
https://github.com/ShepherdWYQ/Beyond-the-Science-of-Reading/settings/pages
```

### 验证网站访问
```bash
# 检查默认域名
curl -I https://ShepherdWYQ.github.io/Beyond-the-Science-of-Reading

# 检查自定义域名（如果配置了）
curl -I https://translation.wangyongqing.com/beyond-reading-science
```

## 🛠️ 故障排除

### 常见问题

1. **404 错误**
   - 检查 GitHub Pages 是否启用
   - 确认分支设置为 `main`
   - 等待 GitHub Actions 构建完成

2. **域名无法访问**
   - 检查 DNS 配置是否正确
   - 等待 DNS 传播（最多 48 小时）
   - 验证域名是否已注册和激活

3. **HTTPS 证书问题**
   - GitHub Pages 会自动配置 Let's Encrypt 证书
   - 新域名可能需要几分钟到几小时

### 调试步骤

1. **检查 GitHub Actions 日志**
   ```bash
   # 访问 Actions 页面查看构建日志
   https://github.com/ShepherdWYQ/Beyond-the-Science-of-Reading/actions
   ```

2. **本地测试**
   ```bash
   # 本地构建测试
   bundle exec jekyll serve
   # 访问 http://localhost:4000/Beyond-the-Science-of-Reading
   ```

3. **DNS 检查**
   ```bash
   # 检查 DNS 解析
   nslookup translation.wangyongqing.com
   dig translation.wangyongqing.com
   ```

## 📈 推荐部署流程

### 第一步：立即部署
```bash
# 1. 使用默认域名先部署
./scripts/deploy-github.sh

# 2. 验证网站正常工作
# 访问: https://ShepherdWYQ.github.io/Beyond-the-Science-of-Reading
```

### 第二步：配置自定义域名（可选）
```bash
# 1. 配置 DNS 记录
# 2. 在 GitHub 设置自定义域名
# 3. 更新项目配置
# 4. 重新部署
```

## 📞 技术支持

如果遇到问题：
1. 检查 GitHub Actions 构建日志
2. 验证 DNS 配置
3. 确认域名状态
4. 查看 GitHub Pages 文档

**当前推荐**: 先使用 `./scripts/deploy-github.sh` 部署到默认域名，确保网站正常工作后再考虑自定义域名。