# Beyond the Science of Reading - 电子书构建系统

参考 [xindoo/agentic-design-patterns](https://github.com/xindoo/agentic-design-patterns) 项目架构，为《Beyond the Science of Reading》构建的自动化电子书生成系统。

## 🎯 功能特性

- **多格式支持**: 自动生成 PDF、EPUB、MOBI 三种格式
- **中文优化**: 完美支持中文字体和排版
- **自动化构建**: 一键生成所有格式的电子书
- **模块化设计**: 可单独生成特定格式
- **样式定制**: 专业的电子书样式和布局
- **依赖检查**: 自动检查和提示所需依赖

## 📋 系统要求

### 必需依赖
- **Node.js** >= 14.0.0
- **Pandoc** - 文档转换引擎
  ```bash
  brew install pandoc
  ```

### 可选依赖
- **Calibre** - 用于生成 MOBI 格式
  ```bash
  brew install --cask calibre
  ```

## 🚀 快速开始

### 1. 安装依赖
```bash
cd build
make setup
```

### 2. 构建电子书
```bash
# 构建所有格式
make all

# 或单独构建
make pdf    # 仅 PDF
make epub   # 仅 EPUB  
make mobi   # 仅 MOBI
```

### 3. 查看结果
生成的电子书将保存在 `dist/` 目录中：
- `Beyond-the-Science-of-Reading.pdf`
- `Beyond-the-Science-of-Reading.epub`
- `Beyond-the-Science-of-Reading.mobi`

## 📚 使用方法

### 命令行方式

```bash
# 使用 Makefile（推荐）
make help           # 查看所有可用命令
make setup          # 初始化环境
make all            # 构建所有格式
make clean          # 清理构建文件

# 使用 Node.js 脚本
cd build
npm run build       # 构建所有格式
npm run build:pdf   # 仅构建 PDF
npm run build:epub  # 仅构建 EPUB
npm run build:mobi  # 仅构建 MOBI
```

### 快速构建

如果只需要 PDF 格式，可以使用快速构建：
```bash
make quick-pdf
```

## 🛠️ 配置说明

### 书籍配置
在 `build-ebooks.js` 中可以修改书籍元信息：

```javascript
this.bookConfig = {
  title: 'Beyond the Science of Reading',
  subtitle: 'Connecting Literacy Instruction to the Science of Learning',
  author: 'Natalie Wexler (原著) | 中文翻译项目',
  language: 'zh-CN',
  // ... 其他配置
};
```

### 章节配置
修改 `chapters` 数组来调整包含的章节：

```javascript
this.chapters = [
  { file: 'index.md', title: '简介', level: 0 },
  { file: 'chapters/Chapter 1_.md', title: '第1章', level: 1 },
  // ... 添加更多章节
];
```

### 样式定制
- **EPUB 样式**: 编辑 `build/styles/epub.css`
- **PDF 样式**: 通过 Pandoc 变量控制
- **封面设计**: 修改 `build/templates/cover.html`

## 📁 项目结构

```
build/
├── build-ebooks.js          # 主构建脚本
├── package.json             # Node.js 依赖配置
├── Makefile                 # Make 构建配置
├── README.md                # 本文档
├── styles/
│   └── epub.css            # EPUB 样式文件
├── templates/
│   └── cover.html          # 封面模板
└── temp/                   # 临时文件目录（自动创建）

dist/                       # 输出目录（自动创建）
├── Beyond-the-Science-of-Reading.pdf
├── Beyond-the-Science-of-Reading.epub
└── Beyond-the-Science-of-Reading.mobi
```

## 🔧 高级功能

### 监控文件变化
```bash
make watch  # 需要安装 fswatch
```

### 项目统计
```bash
make stats  # 显示章节数量、字数等统计信息
```

### 发布准备
```bash
make release  # 清理 + 构建 + 统计
```

## 🎨 样式特性

### PDF 特性
- 中文字体支持（PingFang SC）
- 自动目录生成
- 章节编号
- 页眉页脚
- 代码高亮

### EPUB 特性
- 响应式设计
- 自定义 CSS 样式
- 图片自适应
- 目录导航
- 元数据完整

### MOBI 特性
- Kindle 兼容
- 从 EPUB 自动转换
- 保持格式一致性

## 🐛 故障排除

### 常见问题

1. **Pandoc 未找到**
   ```bash
   brew install pandoc
   ```

2. **中文字体问题**
   - 确保系统安装了 PingFang SC 字体
   - 或修改配置使用其他中文字体

3. **MOBI 生成失败**
   ```bash
   brew install --cask calibre
   ```

4. **内存不足**
   - 对于大文件，可能需要增加 Node.js 内存限制：
   ```bash
   node --max-old-space-size=4096 build-ebooks.js
   ```

### 调试模式
```bash
# 启用详细输出
DEBUG=1 make pdf

# 保留临时文件
KEEP_TEMP=1 node build-ebooks.js
```

## 📖 参考资源

- [Pandoc 用户指南](https://pandoc.org/MANUAL.html)
- [EPUB 规范](https://www.w3.org/publishing/epub32/)
- [Calibre 文档](https://manual.calibre-ebook.com/)
- [参考项目: xindoo/agentic-design-patterns](https://github.com/xindoo/agentic-design-patterns)

## 🤝 贡献指南

1. Fork 本项目
2. 创建特性分支
3. 提交更改
4. 创建 Pull Request

## 📄 许可证

本构建系统遵循 MIT 许可证。生成的电子书内容遵循原书许可证条款。