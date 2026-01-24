# 项目结构说明

本文档详细说明了本项目的文件组织结构。

## 目录结构

```
Beyond-the-Science-of-Reading/
├── README.md                    # 项目说明文档
├── SUMMARY.md                   # GitBook 目录文件
├── CONTRIBUTING.md              # 贡献指南
├── translation-guide.md         # 翻译规范指南
├── progress.md                  # 翻译进度追踪
├── glossary.md                  # 术语对照表
├── PROJECT_STRUCTURE.md         # 项目结构说明（本文件）
├── _config.yml                  # Jekyll 配置文件
├── Gemfile                      # Ruby 依赖管理
├── CNAME                        # 自定义域名配置（可选）
├── .gitignore                   # Git 忽略文件
├── .gitattributes               # Git 属性配置
├── chapters/                    # 翻译后的章节目录
│   ├── README.md                # 章节说明
│   ├── Beyond the Science of Reading.md
│   ├── Introduction.md
│   ├── Chapter 1_ How Embracing All of the Science of Reading Can Get Us Past the Old Debates.md
│   ├── Chapter 2_ Why the Reading Crisis Is Actually a Learning Crisis.md
│   └── ...                      # 其他章节
├── original/                    # 原文备份目录
│   ├── Beyond the Science of Reading.md
│   ├── Introduction.md
│   ├── Chapter 1_ How Embracing All of the Science of Reading Can Get Us Past the Old Debates.md
│   ├── Chapter 2_ Why the Reading Crisis Is Actually a Learning Crisis.md
│   └── ...                      # 其他原文章节
├── images/                      # 图片资源目录
│   ├── README.md                # 图片目录说明
│   ├── cover.png                # 封面图片
│   ├── chapter-1/               # 第1章图片
│   ├── chapter-2/               # 第2章图片
│   └── ...                      # 其他章节图片
├── _includes/                   # Jekyll 包含文件
│   ├── navigation.html          # 导航菜单
│   └── navigation-en.html       # 英文导航菜单
└── _layouts/                    # Jekyll 布局文件
    └── default.html             # 默认布局模板
```

## 文件说明

### 根目录文件

#### README.md
项目主说明文档，包含项目介绍、目录结构、贡献指南等。

#### SUMMARY.md
GitBook 格式的目录文件，用于生成在线书籍的导航结构。

#### CONTRIBUTING.md
贡献指南，说明如何参与项目翻译。

#### translation-guide.md
翻译规范指南，详细说明翻译要求和注意事项。

#### progress.md
翻译进度追踪文档，记录各章节的翻译状态。

#### glossary.md
术语对照表，统一技术术语的翻译。

#### PROJECT_STRUCTURE.md
项目结构说明文档（本文件）。

#### _config.yml
Jekyll 配置文件，用于 GitHub Pages 网站配置。

#### Gemfile
Ruby 依赖管理文件，定义 Jekyll 和相关依赖。

#### CNAME
自定义域名配置文件（可选），用于 GitHub Pages 自定义域名。

### chapters/ 目录

存放所有翻译后的章节文件。

**命名规范：**
* 前言部分：使用描述性名称（如 `Praise.md`, `Dedication.md`, `Acknowledgments.md`, `Introduction.md`）
* 核心章节：`Chapter X_ Title.md`
* 其他内容：使用描述性名称（如 `References.md`, `Index.md`）

### original/ 目录

存放原文备份文件，保持与 `chapters/` 目录相同的文件结构。

### images/ 目录

存放所有图片资源，按章节组织子目录。

**目录结构：**
```
images/
├── chapter-1/
│   └── image-1.png
├── chapter-2/
│   └── image-2.png
└── ...
```

### _includes/ 目录

Jekyll 包含文件，用于网站模板。

* `navigation.html`：中文导航菜单
* `navigation-en.html`：英文导航菜单

### _layouts/ 目录

Jekyll 布局文件，定义网站页面布局。

* `default.html`：默认页面布局模板

## 文件命名规范

### 章节文件

* 使用英文文件名
* 章节编号使用阿拉伯数字
* 标题中的空格用下划线 `_` 替代
* 特殊字符需要转义或替换

**示例：**
* `Chapter 1_ Prompt Chaining.md`
* `Chapter 18_ Guardrails_Safety Patterns.md`
* `Appendix B_ AI Agent Interaction_ From GUI to Real-World Environments.md`

### 图片文件

* 使用小写字母和连字符
* 使用描述性名称
* 保持文件扩展名（.png, .jpg, .svg 等）

**示例：**
* `prompt-chaining-diagram.png`
* `routing-flowchart.svg`

## 工作流程

1. **翻译新章节**
   * 在 `original/` 目录添加原文
   * 在 `chapters/` 目录创建翻译文件
   * 更新 `progress.md`

2. **添加图片**
   * 在 `images/` 目录创建对应章节子目录
   * 添加图片文件
   * 在章节文件中引用图片

3. **更新进度**
   * 在 `progress.md` 中更新翻译状态
   * 记录译者信息

## 注意事项

* 保持文件命名的一致性
* 确保图片路径正确
* 定期更新 `progress.md`
* 遵循翻译规范

## 相关文档

* [贡献指南](CONTRIBUTING.md)
* [翻译规范](translation-guide.md)
* [术语对照表](glossary.md)
