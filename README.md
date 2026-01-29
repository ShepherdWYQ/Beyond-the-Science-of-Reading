# Beyond the Science of Reading（中文翻译项目）

## 👨‍💻 关于项目

本项目是《Beyond the Science of Reading: Connecting Literacy Instruction to the Science of Learning》一书的中文翻译项目。该书由 Natalie Wexler 撰写，探讨了如何将阅读教学与学习科学相结合，超越传统的"阅读战争"辩论。

## 🎯 关于本书

《Beyond the Science of Reading: Connecting Literacy Instruction to the Science of Learning》是一本及时且具有挑战性的教育著作，作者 Natalie Wexler 认为，结束"阅读战争"的最佳方式是认识到学习阅读与一般学习密不可分。

**主要观点：**

* 阅读教学必须与更广泛的学习科学原则相联系
* 仅靠自然拼读法不足以培养熟练的读者
* 强调知识构建、写作教学的重要性
* 采用认知科学指导的读写教学方法

**作者简介：**

Natalie Wexler 是一位教育作家，著有《The Knowledge Gap: The Hidden Cause of America's Broken Education System—and How to Fix It》。她也是《The Writing Revolution 2.0: A Guide to Advancing Thinking Through Writing in All Subjects and Grades》的合著者。

**书籍信息：**

* 出版社：ASCD
* 出版日期：2025年1月21日
* 页数：235页
* ISBN：978-1-4166-3356-3

## 📖 目录结构

### 前言部分

* 赞誉（Praise）
* 献词（Dedication）
* 致谢（Acknowledgments）
* 引言（Introduction）

### 核心章节

1. 第1章：拥抱完整的阅读科学如何让我们超越旧有辩论（How Embracing All of the Science of Reading Can Get Us Past the Old Debates）
2. 第2章：为什么阅读危机实际上是学习危机（Why the Reading Crisis Is Actually a Learning Crisis）
3. （更多章节待补充...）

### 其他内容

* 术语表
* 参考文献
* 索引

## 📁 项目结构

```
Beyond-the-Science-of-Reading/
├── README.md                    # 项目说明文档（本文件）
├── SUMMARY.md                   # GitBook 目录文件
├── CONTRIBUTING.md              # 贡献指南
├── translation-guide.md         # 翻译规范指南
├── progress.md                  # 翻译进度追踪
├── glossary.md                  # 术语对照表
├── PROJECT_STRUCTURE.md         # 项目结构说明
├── QUICK_START.md               # 快速发布指南
├── DEPLOYMENT.md                # 详细发布指南
├── _config.yml                  # Jekyll 配置文件
├── Gemfile                      # Ruby 依赖管理
├── index.md                     # 网站首页
├── chapters/                    # 翻译后的章节目录
│   ├── README.md                # 章节说明
│   └── ...                      # 其他章节和附录
├── original/                    # 原文备份目录
│   └── ...                      # 其他原文章节
├── images/                      # 图片资源目录
│   ├── README.md                # 图片目录说明
│   └── ...                      # 其他章节图片
├── _includes/                   # Jekyll 包含文件
│   ├── navigation.html          # 导航菜单
│   └── navigation-en.html       # 英文导航菜单
└── _layouts/                    # Jekyll 布局文件
    └── default.html             # 默认布局模板
```

## 🌐 在线访问

本项目可部署到 GitHub Pages，可以在线阅读。

**快速发布**：查看 [QUICK_START.md](QUICK_START.md) 了解如何在 5 分钟内发布网站。

**详细指南**：查看 [DEPLOYMENT.md](DEPLOYMENT.md) 了解所有发布选项。

## 📊 翻译进度

查看详细翻译进度请参考 [progress.md](progress.md)

## 🤝 如何贡献

我们欢迎任何形式的贡献！参与方式：

1. **Fork 本仓库**
2. **创建特性分支** (`git checkout -b feature/translate-chapter-xx`)
3. **提交更改** (`git commit -am '完成第XX章翻译'`)
4. **推送分支** (`git push origin feature/translate-chapter-xx`)
5. **创建 Pull Request**

详细贡献指南请参阅 [CONTRIBUTING.md](CONTRIBUTING.md)

## 📝 翻译规范

在开始翻译前，请仔细阅读 [translation-guide.md](translation-guide.md)，主要规范包括：

* **保持原文结构**：段落、标题层级保持一致
* **术语统一**：参考 [glossary.md](glossary.md) 中的术语对照表
* **代码保持原样**：代码示例、命令行等保持英文
* **图片路径**：确保图片引用路径正确指向 `images/` 目录
* **格式规范**：遵循 Markdown 格式规范
* **校对审核**：提交前进行自我校对

## 📚 相关资源

* [ASCD 官方页面](https://ascd.org/books/beyond-the-science-of-reading) - 原书官方信息
* [作者 Natalie Wexler 的个人网站](https://nataliewexler.com/)
* 术语对照表 - 统一的教育术语翻译
* 翻译指南 - 详细的翻译规范和注意事项
* 项目结构说明 - 项目文件组织说明
* GitBook 目录 - 在线书籍的完整目录结构
* Jekyll 配置 - GitHub Pages 网站配置
* 翻译进度追踪 - 实时更新翻译状态

## 🚀 快速开始

### 本地开发

```bash
# 安装依赖
bundle install

# 启动本地服务器
bundle exec jekyll serve

# 访问 http://localhost:4000 查看网站
```

### 电子书生成

```bash
# 一键设置电子书构建环境
./scripts/setup-ebook-builder.sh

# 生成 PDF、EPUB、MOBI 格式电子书
cd build && make all
```

详细说明请查看 [EBOOK_BUILD.md](EBOOK_BUILD.md)

### 发布网站

```bash
# 自动部署到 translation.wangyongqing.com/beyond-reading-science
./scripts/deploy.sh
```

查看 [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md) 了解详细部署步骤。

## 📄 许可证

本翻译项目遵循原书的许可证条款。翻译内容仅供学习交流使用。

---

**注意**：本项目为学习交流目的的翻译项目，如有版权问题请联系处理。
