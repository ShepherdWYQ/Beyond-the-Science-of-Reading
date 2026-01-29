# 多项目子路径部署方案

针对 `https://translation.wangyongqing.com/beyond-reading-science` 的多项目架构解决方案。

## 🎯 目标架构

```
translation.wangyongqing.com/
├── /                           # 项目索引页面
├── /beyond-reading-science/    # 本项目
├── /future-project-1/          # 未来项目1
└── /future-project-2/          # 未来项目2
```

## 🔍 问题分析

GitHub Pages 自定义域名 + 子路径的技术限制：
1. **自定义域名通常部署到根路径**
2. **子路径需要特殊配置或代理**
3. **GitHub Pages 不直接支持多项目子路径**

## 🚀 推荐解决方案

### 方案1：GitHub Pages + Nginx 代理（推荐）

#### 步骤1：项目部署到 GitHub Pages 默认域名
```bash
# 运行修复脚本，选择方案1
./scripts/fix-subpath-deployment.sh
```

项目将部署到：`https://ShepherdWYQ.github.io/Beyond-the-Science-of-Reading`

#### 步骤2：配置 Nginx 代理
在 `translation.wangyongqing.com` 服务器上配置：

```nginx
server {
    listen 80;
    listen 443 ssl;
    server_name translation.wangyongqing.com;
    
    # SSL 配置
    ssl_certificate /path/to/ssl/cert.pem;
    ssl_certificate_key /path/to/ssl/key.pem;
    
    # 根路径 - 项目索引页面
    location = / {
        root /var/www/translation-index;
        index index.html;
    }
    
    # Beyond Reading Science 项目
    location /beyond-reading-science/ {
        proxy_pass https://ShepherdWYQ.github.io/Beyond-the-Science-of-Reading/;
        proxy_set_header Host ShepherdWYQ.github.io;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        
        # 处理相对路径
        sub_filter 'href="/' 'href="/beyond-reading-science/';
        sub_filter 'src="/' 'src="/beyond-reading-science/';
        sub_filter_once off;
    }
    
    # 未来项目示例
    location /future-project-1/ {
        proxy_pass https://username.github.io/Future-Project-1/;
        proxy_set_header Host username.github.io;
        # ... 类似配置
    }
}
```

### 方案2：使用 GitHub Actions 自动部署

创建 GitHub Actions 工作流，自动构建并部署到自定义服务器：

```yaml
# .github/workflows/deploy.yml
name: Deploy to Custom Domain

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    
    - name: Setup Ruby
      uses: ruby/setup-ruby@v1
      with:
        ruby-version: 3.0
        bundler-cache: true
    
    - name: Build Jekyll
      run: |
        bundle exec jekyll build
        
    - name: Deploy to Server
      uses: appleboy/scp-action@v0.1.4
      with:
        host: ${{ secrets.HOST }}
        username: ${{ secrets.USERNAME }}
        key: ${{ secrets.SSH_KEY }}
        source: "_site/*"
        target: "/var/www/translation.wangyongqing.com/beyond-reading-science/"
```

## 🛠️ 实施步骤

### 立即执行
```bash
# 运行修复脚本
./scripts/fix-subpath-deployment.sh

# 选择方案1：GitHub Pages 默认域名
```

### 服务器配置
1. **在 translation.wangyongqing.com 服务器上安装 Nginx**
2. **配置上述 Nginx 代理规则**
3. **创建项目索引页面**
4. **配置 SSL 证书**

### 项目索引页面
```html
<!-- /var/www/translation-index/index.html -->
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>翻译项目</title>
</head>
<body>
    <h1>翻译项目</h1>
    <ul>
        <li><a href="/beyond-reading-science/">Beyond the Science of Reading</a></li>
        <li><a href="/future-project-1/">未来项目1</a></li>
    </ul>
</body>
</html>
```

## 🔧 配置验证

### 测试步骤
1. **GitHub Pages 部署**：
   ```
   https://ShepherdWYQ.github.io/Beyond-the-Science-of-Reading
   ```

2. **Nginx 代理测试**：
   ```bash
   curl -I https://translation.wangyongqing.com/beyond-reading-science/
   ```

3. **完整访问测试**：
   ```
   https://translation.wangyongqing.com/beyond-reading-science/
   ```

## 📋 未来项目添加流程

### 新项目部署
1. **创建新的 GitHub 仓库**
2. **部署到 GitHub Pages**：`username.github.io/New-Project`
3. **添加 Nginx 代理规则**：
   ```nginx
   location /new-project/ {
       proxy_pass https://username.github.io/New-Project/;
       # ... 配置
   }
   ```
4. **更新项目索引页面**

### 配置模板
```bash
# 为新项目创建配置
./scripts/add-new-project.sh project-name github-repo-url
```

## 🚨 故障排除

### 常见问题
1. **代理路径问题**：检查 Nginx 配置中的路径重写
2. **SSL 证书**：确保 translation.wangyongqing.com 有有效证书
3. **CORS 问题**：可能需要添加 CORS 头

### 调试命令
```bash
# 检查 Nginx 配置
nginx -t

# 查看 Nginx 日志
tail -f /var/log/nginx/error.log

# 测试代理
curl -v https://translation.wangyongqing.com/beyond-reading-science/
```

## 📞 技术支持

如果需要帮助：
1. 运行 `./scripts/fix-subpath-deployment.sh` 获取详细指导
2. 检查 GitHub Actions 构建日志
3. 验证 Nginx 配置和服务器状态

这个方案可以完美支持多项目架构，每个项目都有独立的子路径！