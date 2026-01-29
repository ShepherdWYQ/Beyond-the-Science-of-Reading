# 本地预览指南

本指南将帮助您在本地预览网站更新后的效果。

## 前置要求

1. **安装 Ruby**（如果还没有）
   - macOS: Ruby 通常已预装，或使用 Homebrew: `brew install ruby`
   - 检查版本: `ruby --version`（需要 2.7 或更高版本）

2. **安装 Bundler**（Ruby 包管理器）
   ```bash
   gem install bundler
   ```

## 快速开始

### 步骤 1: 安装依赖

在项目目录下运行：

```bash
cd /Users/shepherd/Documents/GitHub/Beyond-the-Science-of-Reading
bundle install
```

这会安装所有必需的 gem（包括 Jekyll）。

### 步骤 2: 启动本地服务器

```bash
bundle exec jekyll serve
```

### 步骤 3: 访问网站

打开浏览器，访问：

```
http://localhost:4000
```

或者：

```
http://127.0.0.1:4000
```

## 常用命令

### 启动服务器（带实时重载）

```bash
bundle exec jekyll serve --livereload
```

使用 `--livereload` 选项后，修改文件后浏览器会自动刷新。

### 启动服务器（指定端口）

```bash
bundle exec jekyll serve --port 4001
```

### 构建网站（不启动服务器）

```bash
bundle exec jekyll build
```

构建的文件会在 `_site` 目录中。

### 查看帮助

```bash
bundle exec jekyll serve --help
```

## 常见问题

### 问题 1: `bundle: command not found`

**解决方案**：
```bash
gem install bundler
```

### 问题 2: `Could not locate Gemfile`

**解决方案**：
确保您在项目根目录下运行命令：
```bash
cd /Users/shepherd/Documents/GitHub/Beyond-the-Science-of-Reading
```

### 问题 3: 端口已被占用

**解决方案**：
使用不同的端口：
```bash
bundle exec jekyll serve --port 4001
```

### 问题 4: 依赖安装失败

**解决方案**：
```bash
# 清理并重新安装
bundle clean --force
bundle install
```

### 问题 5: 修改后看不到变化

**解决方案**：
1. 停止服务器（Ctrl+C）
2. 删除 `_site` 目录：`rm -rf _site`
3. 重新启动：`bundle exec jekyll serve`

或者使用 `--livereload` 选项自动刷新。

## 开发工作流

### 推荐工作流

1. **启动服务器**（带实时重载）：
   ```bash
   bundle exec jekyll serve --livereload
   ```

2. **编辑文件**：
   - 修改 Markdown 文件
   - 修改 `_config.yml`
   - 修改布局文件

3. **查看效果**：
   - 浏览器会自动刷新（如果使用 `--livereload`）
   - 或手动刷新浏览器

4. **测试完成后**：
   - 停止服务器（Ctrl+C）
   - 提交更改到 Git

## 本地预览 vs GitHub Pages

### 本地预览的优势
- ✅ 即时看到更改
- ✅ 不需要等待 GitHub Actions 构建
- ✅ 可以测试所有功能
- ✅ 可以查看控制台错误

### 注意事项
- 本地预览可能与 GitHub Pages 略有不同
- 某些 GitHub Pages 特定功能可能不可用
- 建议在提交前也在 GitHub Pages 上验证

## 停止服务器

按 `Ctrl+C` 停止本地服务器。

## 需要帮助？

如果遇到问题：
1. 检查 Ruby 版本：`ruby --version`
2. 检查 Bundler 版本：`bundle --version`
3. 查看 Jekyll 文档：https://jekyllrb.com/docs/
4. 查看错误日志中的详细信息

---

**提示**：使用 `--livereload` 选项可以大大提高开发效率！
