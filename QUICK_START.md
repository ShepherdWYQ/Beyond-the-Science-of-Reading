# 快速发布指南

本指南将帮助您在 5 分钟内将项目发布为公开网站。

## 🚀 快速步骤（GitHub Pages）

### 第一步：准备 GitHub 仓库

1. **在 GitHub 上创建新仓库**
   - 访问 https://github.com/new
   - 仓库名称：`Beyond-the-Science-of-Reading`
   - 选择 Public（公开）
   - 不要初始化 README、.gitignore 或 license（因为本地已有）

2. **推送代码到 GitHub**

   在项目目录下运行：

   ```bash
   # 如果还没有初始化 Git
   git init
   git add .
   git commit -m "Initial commit: Beyond the Science of Reading translation project"
   
   # 添加远程仓库
   git remote add origin https://github.com/ShepherdWYQ/Beyond-the-Science-of-Reading.git
   git branch -M main
   git push -u origin main
   ```

### 第二步：配置 GitHub Pages

1. **进入仓库设置**
   - 在 GitHub 仓库页面，点击 `Settings`（设置）
   - 在左侧菜单中找到 `Pages`（页面）

2. **启用 GitHub Pages**
   - 在 `Source`（源）部分，选择 `GitHub Actions`
   - 保存设置（无需其他操作）

3. **等待自动部署**
   - GitHub Actions 会自动开始构建
   - 查看 `Actions` 标签页了解构建进度
   - 通常 2-5 分钟后完成

### 第三步：更新配置（重要）

在第一次推送后，需要更新 `_config.yml` 中的 URL：

1. **编辑 `_config.yml`**
   
   找到以下行（应该已经是正确的）：
   
   ```yaml
   url: https://ShepherdWYQ.github.io
   baseurl: /Beyond-the-Science-of-Reading
   ```
   
   ✅ 配置已经更新为您的用户名，无需修改。

2. **提交更改**
   
   ```bash
   git add _config.yml
   git commit -m "Update site URL configuration"
   git push origin main
   ```

### 第四步：访问网站

部署完成后，您的网站将在以下地址可用：

```
https://ShepherdWYQ.github.io/Beyond-the-Science-of-Reading
```

🎉 恭喜！您的网站已经可以访问了。

## ✅ 检查清单

在发布前，请确认：

- [ ] 代码已推送到 GitHub
- [ ] GitHub Pages 已启用（使用 GitHub Actions）
- [ ] `_config.yml` 中的 URL 已更新为您的用户名
- [ ] GitHub Actions 构建成功（在 Actions 标签页查看）
- [ ] 网站可以正常访问

## 🔄 更新网站

每次更新内容后，只需：

```bash
git add .
git commit -m "Update content"
git push origin main
```

GitHub Pages 会自动重新构建和部署（通常 2-5 分钟）。

## 🎨 自定义域名（可选）

如果您有自己的域名，可以：

1. **创建 CNAME 文件**
   
   在项目根目录创建 `CNAME` 文件，内容为您的域名：
   ```
   your-domain.com
   ```

2. **配置 DNS**
   
   在您的域名注册商处添加 CNAME 记录：
   - 类型：CNAME
   - 名称：www（或 @）
   - 值：ShepherdWYQ.github.io

3. **在 GitHub 中启用**
   
   - 推送 CNAME 文件到仓库
   - 在 GitHub Pages 设置中，自定义域名会自动检测

## 🐛 常见问题

### 问题 1：构建失败

**解决**：
- 检查 `Actions` 标签页中的错误信息
- 确保 `_config.yml` 语法正确
- 确保所有必需的文件都已提交

### 问题 2：网站显示 404

**解决**：
- 确认 GitHub Pages 已启用
- 检查 `_config.yml` 中的 URL 配置
- 等待几分钟让 DNS 生效

### 问题 3：样式丢失

**解决**：
- 检查 `baseurl` 配置是否正确
- 确保所有资源路径使用相对路径

## 📚 更多信息

详细说明请查看 [DEPLOYMENT.md](DEPLOYMENT.md)

## 🆘 需要帮助？

如果遇到问题：
1. 查看 GitHub Actions 日志（在 `Actions` 标签页）
2. 查看 [GitHub Pages 文档](https://docs.github.com/en/pages)
3. 提交 Issue 寻求帮助

---

**提示**：首次部署可能需要 5-10 分钟，之后每次更新通常只需 2-5 分钟。
