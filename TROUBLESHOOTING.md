# 故障排除指南 - 解决 404 错误

如果您的网站显示 404 错误，请按照以下步骤逐一检查：

## 🔍 检查步骤

### 步骤 1：确认 GitHub Pages 已启用

1. 进入您的 GitHub 仓库：`https://github.com/ShepherdWYQ/Beyond-the-Science-of-Reading`
2. 点击 `Settings`（设置）标签页
3. 在左侧菜单中找到 `Pages`（页面）
4. 检查 `Source`（源）部分：
   - ✅ **应该选择**：`GitHub Actions`
   - ❌ **不应该选择**：`Deploy from a branch` 或 `None`

**如果还没有启用**：
- 选择 `GitHub Actions` 作为源
- 点击 `Save`（保存）

### 步骤 2：检查 GitHub Actions 构建状态

1. 在仓库页面，点击 `Actions`（操作）标签页
2. 查看最新的工作流运行：
   - ✅ **绿色勾号**：构建成功
   - ❌ **红色叉号**：构建失败（点击查看错误详情）
   - 🟡 **黄色圆圈**：正在构建中（请等待）

**如果构建失败**：
- 点击失败的工作流，查看错误日志
- 常见错误和解决方案见下方

### 步骤 3：检查部署环境权限

1. 在仓库 `Settings` → `Pages` 中
2. 查看是否有权限警告
3. 如果提示需要授权，点击授权按钮

### 步骤 4：等待部署完成

- 首次部署通常需要 **5-10 分钟**
- 后续更新通常需要 **2-5 分钟**
- 部署完成后，网站可能需要 **1-2 分钟** 才能访问

### 步骤 5：确认网站地址

您的网站地址应该是：
```
https://ShepherdWYQ.github.io/Beyond-the-Science-of-Reading
```

**注意**：
- 确保 URL 中的大小写正确
- 确保包含项目名称 `/Beyond-the-Science-of-Reading`

## 🐛 常见问题及解决方案

### 问题 1：GitHub Actions 构建失败

**错误信息**：`bundle install` 失败

**解决方案**：
1. 确保 `Gemfile` 已提交到仓库
2. 检查 `Gemfile` 语法是否正确
3. 如果使用自定义插件，确保它们在 GitHub Pages 支持列表中

**错误信息**：`Jekyll build` 失败

**解决方案**：
1. 检查 `_config.yml` 语法是否正确（YAML 格式）
2. 确保所有引用的文件都存在
3. 检查 Markdown 文件格式是否正确

### 问题 2：GitHub Pages 显示 "Not found"

**可能原因**：
- GitHub Pages 未启用
- 选择了错误的源（应该选择 GitHub Actions）
- 部署环境权限未授权

**解决方案**：
1. 按照步骤 1 重新配置 GitHub Pages
2. 确保选择 `GitHub Actions` 作为源
3. 授权部署环境权限

### 问题 3：网站可以访问但显示空白

**可能原因**：
- `index.md` 文件有问题
- Jekyll 主题未正确加载
- CSS 样式未加载

**解决方案**：
1. 检查 `index.md` 是否有正确的 front matter（`---` 包围的 YAML）
2. 检查 `_config.yml` 中的 `theme` 设置
3. 查看浏览器控制台是否有 JavaScript 错误

### 问题 4：某些页面 404，但首页正常

**可能原因**：
- 文件路径不正确
- 文件名大小写不匹配
- Markdown 链接格式错误

**解决方案**：
1. 检查文件路径是否与链接中的路径匹配
2. GitHub 对大小写敏感，确保文件名大小写正确
3. 使用相对路径，例如：`[链接文本](chapters/Chapter%201.md)`

## 🔧 快速修复命令

如果构建失败，可以尝试：

```bash
# 1. 检查本地构建是否成功
bundle install
bundle exec jekyll build

# 2. 如果有错误，修复后重新提交
git add .
git commit -m "Fix build errors"
git push origin main
```

## 📋 检查清单

在报告问题前，请确认：

- [ ] GitHub Pages 已启用（Settings → Pages）
- [ ] 选择了 `GitHub Actions` 作为源
- [ ] GitHub Actions 构建成功（Actions 标签页显示绿色）
- [ ] 等待了至少 5 分钟让部署完成
- [ ] 使用了正确的 URL：`https://ShepherdWYQ.github.io/Beyond-the-Science-of-Reading`
- [ ] 清除了浏览器缓存（Ctrl+F5 或 Cmd+Shift+R）

## 🆘 仍然无法解决？

如果以上步骤都无法解决问题：

1. **查看 GitHub Actions 日志**：
   - 进入 `Actions` 标签页
   - 点击最新的工作流运行
   - 查看详细的错误信息

2. **检查仓库文件**：
   - 确保所有必需的文件都已提交
   - 确保 `.github/workflows/jekyll.yml` 存在

3. **尝试手动触发部署**：
   - 进入 `Actions` 标签页
   - 选择 "Deploy Jekyll site to Pages" 工作流
   - 点击 "Run workflow" 按钮

4. **提交 Issue**：
   - 在仓库中创建新 Issue
   - 描述问题并附上错误日志

## 📞 获取帮助

- [GitHub Pages 文档](https://docs.github.com/en/pages)
- [Jekyll 文档](https://jekyllrb.com/docs/)
- [GitHub Actions 文档](https://docs.github.com/en/actions)

---

**提示**：大多数 404 问题都是因为 GitHub Pages 未正确启用或构建失败。按照步骤 1 和 2 通常可以解决问题。
