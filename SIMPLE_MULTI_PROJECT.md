# 简单多项目方案

针对多项目需求的简单解决方案，避免复杂的子路径配置。

## 🎯 推荐方案

### 方案1：子域名方案（最简单）

每个项目使用独立的子域名：

```
beyond-reading-science.wangyongqing.com    # 本项目
future-project-1.wangyongqing.com          # 未来项目1
future-project-2.wangyongqing.com          # 未来项目2
translation.wangyongqing.com               # 项目索引页面
```

**优点**：
- ✅ 每个项目完全独立
- ✅ GitHub Pages 原生支持
- ✅ 无需复杂配置
- ✅ 易于管理和扩展

**配置**：
- DNS: 每个子域名一个 CNAME 记录
- GitHub: 每个项目一个仓库
- 部署: 标准 GitHub Pages 流程

### 方案2：独立域名方案

为每个项目类别使用独立域名：

```
reading-science.wangyongqing.com           # 阅读科学相关项目
ai-patterns.wangyongqing.com               # AI 模式相关项目
tech-books.wangyongqing.com                # 技术书籍相关项目
```

### 方案3：GitHub Pages 默认域名 + 友好重定向

使用 GitHub Pages 默认域名，配置友好的重定向：

```
ShepherdWYQ.github.io/Beyond-the-Science-of-Reading
ShepherdWYQ.github.io/Future-Project-1
ShepherdWYQ.github.io/Future-Project-2
```

在 `translation.wangyongqing.com` 创建重定向页面。

## 🚀 推荐实施：方案1（子域名）

### 配置步骤

#### 1. 修改当前项目配置
```yaml
# _config.yml
url: https://beyond-reading-science.wangyongqing.com
baseurl: ""
```

#### 2. DNS 配置
```
# A 记录或 CNAME 记录
beyond-reading-science.wangyongqing.com -> ShepherdWYQ.github.io
```

#### 3. GitHub Pages 设置
- Custom domain: `beyond-reading-science.wangyongqing.com`

#### 4. 创建项目索引网站
在 `translation.wangyongqing.com` 创建简单的项目导航页面。
