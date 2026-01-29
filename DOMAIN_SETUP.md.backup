# 域名配置指南

配置 `translation.wangyongqing.com/beyond-reading-science` 的详细步骤。

## 🎯 目标配置

- **根域名**: translation.wangyongqing.com
- **子路径**: /beyond-reading-science  
- **完整地址**: https://translation.wangyongqing.com/beyond-reading-science

## 🔍 检查当前状态

```bash
# 运行域名测试脚本
./scripts/test-domain.sh
```

## ⚙️ DNS 配置

### 方案1：A 记录（推荐）
在域名服务商处添加以下 A 记录：

```
记录类型: A
主机记录: translation
记录值: 185.199.108.153
记录值: 185.199.109.153  
记录值: 185.199.110.153
记录值: 185.199.111.153
```

### 方案2：CNAME 记录
```
记录类型: CNAME
主机记录: translation
记录值: ShepherdWYQ.github.io
```

## 🚀 GitHub Pages 配置

### 1. 仓库设置
在 GitHub 仓库 Settings > Pages 中：

- **Source**: Deploy from a branch
- **Branch**: main / (root)
- **Custom domain**: `translation.wangyongqing.com`
- **Enforce HTTPS**: ✅ 启用

### 2. 验证配置
GitHub 会自动验证域名配置，显示绿色勾号表示成功。

## 📁 项目配置

### Jekyll 配置 (_config.yml)
```yaml
url: https://translation.wangyongqing.com
baseurl: /beyond-reading-science
```

### CNAME 文件
```
translation.wangyongqing.com
```

## 🔄 部署流程

### 1. 配置域名 DNS
按照上面的 DNS 配置添加记录。

### 2. 等待 DNS 传播
DNS 传播通常需要几分钟到几小时。

### 3. 部署网站
```bash
# 部署到自定义域名
./scripts/deploy.sh
```

### 4. 验证访问
访问：https://translation.wangyongqing.com/beyond-reading-science

## 🛠️ 故障排除

### 域名无法访问

1. **检查 DNS 配置**
   ```bash
   # 检查 A 记录
   dig translation.wangyongqing.com
   
   # 检查 CNAME 记录  
   dig translation.wangyongqing.com CNAME
   ```

2. **等待 DNS 传播**
   - 新配置的 DNS 记录需要时间传播
   - 可能需要 5 分钟到 48 小时

3. **检查 GitHub Pages 状态**
   - 访问仓库 Settings > Pages
   - 查看域名验证状态
   - 检查是否有错误提示

### 子路径 404 错误

1. **检查 baseurl 配置**
   ```yaml
   # _config.yml
   baseurl: /beyond-reading-science
   ```

2. **检查链接引用**
   确保所有内部链接使用 `{{ site.baseurl }}` 前缀。

3. **重新构建**
   ```bash
   # 清理并重新构建
   bundle exec jekyll clean
   bundle exec jekyll build
   ```

## 📊 配置验证清单

- [ ] DNS A 记录或 CNAME 记录已配置
- [ ] GitHub Pages 自定义域名已设置
- [ ] CNAME 文件存在于仓库根目录
- [ ] _config.yml 配置正确
- [ ] HTTPS 已启用
- [ ] 域名验证通过（GitHub 显示绿色勾号）

## 🔗 测试链接

配置完成后测试以下链接：

- **根域名**: https://translation.wangyongqing.com
- **项目首页**: https://translation.wangyongqing.com/beyond-reading-science
- **章节页面**: https://translation.wangyongqing.com/beyond-reading-science/chapters/
- **下载页面**: https://translation.wangyongqing.com/beyond-reading-science/downloads/

## 📞 技术支持

如果遇到问题：

1. **运行诊断脚本**
   ```bash
   ./scripts/test-domain.sh
   ```

2. **检查 GitHub Actions 日志**
   访问：https://github.com/ShepherdWYQ/Beyond-the-Science-of-Reading/actions

3. **查看 GitHub Pages 文档**
   https://docs.github.com/en/pages

## 🚨 临时方案

如果域名配置有问题，可以先使用 GitHub Pages 默认域名：

```bash
# 临时部署到默认域名
./scripts/deploy-github.sh

# 访问地址
https://ShepherdWYQ.github.io/Beyond-the-Science-of-Reading
```

等域名配置好后再切换回自定义域名。