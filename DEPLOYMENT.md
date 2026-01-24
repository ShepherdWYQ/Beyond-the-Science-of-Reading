# 网站发布指南

本文档说明如何将本项目发布为公开可访问的网站。

## 发布方式

本项目支持多种发布方式，推荐使用 **GitHub Pages**（最简单且免费）。

## 方式一：GitHub Pages（推荐）

### 前置要求

1. 拥有 GitHub 账户
2. 项目已推送到 GitHub 仓库

### 步骤

#### 1. 准备 GitHub 仓库

```bash
# 如果还没有初始化 Git
git init
git add .
git commit -m "Initial commit"

# 在 GitHub 上创建新仓库，然后推送
git remote add origin https://github.com/your-username/Beyond-the-Science-of-Reading.git
git branch -M main
git push -u origin main
```

#### 2. 配置 GitHub Pages

有两种方式配置 GitHub Pages：

**方式 A：使用 GitHub Actions（推荐）**

1. 在项目根目录创建 `.github/workflows/jekyll.yml` 文件（已自动创建）
2. 在 GitHub 仓库设置中：
   - 进入 `Settings` → `Pages`
   - 在 `Source` 中选择 `GitHub Actions`
   - 保存设置

**方式 B：使用 main 分支的 /docs 文件夹**

1. 在项目根目录创建 `docs` 文件夹
2. 将需要发布的文件复制到 `docs` 文件夹
3. 在 GitHub 仓库设置中：
   - 进入 `Settings` → `Pages`
   - 在 `Source` 中选择 `main branch / docs folder`
   - 保存设置

#### 3. 更新 _config.yml

更新 `_config.yml` 中的 URL 配置：

```yaml
# 如果使用用户名.github.io 作为域名
url: https://your-username.github.io
baseurl: ""

# 如果使用项目名称作为子路径
url: https://your-username.github.io
baseurl: /Beyond-the-Science-of-Reading
```

#### 4. 访问网站

配置完成后，网站将在以下地址可用：
- `https://your-username.github.io/Beyond-the-Science-of-Reading`（如果使用项目名称）
- 或 `https://your-username.github.io`（如果使用用户名.github.io 仓库）

### 自定义域名（可选）

1. 在项目根目录创建 `CNAME` 文件，内容为您的域名：
   ```
   your-domain.com
   ```

2. 在域名 DNS 设置中添加 CNAME 记录：
   - 类型：CNAME
   - 名称：www（或 @）
   - 值：your-username.github.io

3. 在 GitHub Pages 设置中启用自定义域名

## 方式二：Netlify

### 步骤

1. 访问 [Netlify](https://www.netlify.com/)
2. 使用 GitHub 账户登录
3. 点击 "New site from Git"
4. 选择您的 GitHub 仓库
5. 配置构建设置：
   - Build command: `bundle exec jekyll build`
   - Publish directory: `_site`
6. 点击 "Deploy site"

### 优点

- 自动部署（每次推送自动更新）
- 支持自定义域名
- 免费 SSL 证书
- 更快的构建速度

## 方式三：Vercel

### 步骤

1. 访问 [Vercel](https://vercel.com/)
2. 使用 GitHub 账户登录
3. 点击 "New Project"
4. 导入您的 GitHub 仓库
5. 配置构建设置：
   - Framework Preset: Jekyll
   - Build Command: `bundle exec jekyll build`
   - Output Directory: `_site`
6. 点击 "Deploy"

### 优点

- 极快的部署速度
- 自动部署
- 免费 SSL 证书
- 支持自定义域名

## 方式四：本地构建并上传

### 步骤

1. 安装 Jekyll：
   ```bash
   bundle install
   ```

2. 构建网站：
   ```bash
   bundle exec jekyll build
   ```

3. 构建的文件在 `_site` 目录中

4. 将 `_site` 目录的内容上传到任何静态网站托管服务

## 本地测试

在发布前，建议先在本地测试：

```bash
# 安装依赖
bundle install

# 启动本地服务器
bundle exec jekyll serve

# 访问 http://localhost:4000 查看网站
```

## 常见问题

### 1. Jekyll 构建失败

**问题**：GitHub Pages 构建失败

**解决方案**：
- 检查 `_config.yml` 语法是否正确
- 确保所有插件都在 GitHub Pages 支持的插件列表中
- 查看 GitHub Actions 日志了解详细错误

### 2. 样式丢失

**问题**：网站样式不显示

**解决方案**：
- 检查 `_config.yml` 中的 `baseurl` 配置是否正确
- 确保所有资源路径使用相对路径或 `{{ site.baseurl }}` 变量

### 3. 404 错误

**问题**：某些页面返回 404

**解决方案**：
- 检查文件路径是否正确
- 确保文件名和链接中的路径匹配
- 检查 `SUMMARY.md` 中的链接格式

### 4. 自定义域名不工作

**问题**：自定义域名无法访问

**解决方案**：
- 确保 `CNAME` 文件在仓库根目录
- 检查 DNS 设置是否正确
- 等待 DNS 传播（可能需要几小时）

## 更新网站

### GitHub Pages

每次推送到 main 分支，GitHub Pages 会自动重新构建和部署。

```bash
git add .
git commit -m "Update content"
git push origin main
```

### Netlify/Vercel

这些平台也会自动检测推送并重新部署。

## 性能优化

1. **图片优化**：压缩图片文件大小
2. **启用压缩**：在服务器配置中启用 Gzip 压缩
3. **CDN**：使用 CDN 加速静态资源加载
4. **缓存**：配置适当的缓存策略

## 安全建议

1. **不要提交敏感信息**：确保 `.gitignore` 正确配置
2. **定期更新依赖**：运行 `bundle update` 更新依赖
3. **检查依赖漏洞**：使用 `bundle audit` 检查安全漏洞

## 需要帮助？

如果遇到问题，可以：

1. 查看 [Jekyll 官方文档](https://jekyllrb.com/docs/)
2. 查看 [GitHub Pages 文档](https://docs.github.com/en/pages)
3. 提交 Issue 寻求帮助

---

**提示**：推荐使用 GitHub Pages，因为它与 Jekyll 集成最好，且完全免费。
