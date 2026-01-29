# 电子书构建系统

参考 [xindoo/agentic-design-patterns](https://github.com/xindoo/agentic-design-patterns) 项目，为《Beyond the Science of Reading》构建的完整电子书生成系统。

## 🎯 系统特性

- **多格式支持**: 自动生成 PDF、EPUB、MOBI 三种格式
- **中文优化**: 完美支持中文字体和排版
- **自动化构建**: 一键生成所有格式的电子书
- **专业样式**: 针对教育类书籍优化的排版样式
- **模块化设计**: 可单独生成特定格式或批量生成

## 🚀 快速开始

### 1. 一键环境设置
```bash
# 运行自动化设置脚本
./scripts/setup-ebook-builder.sh
```

### 2. 构建电子书
```bash
# 进入构建目录
cd build

# 构建所有格式
make all

# 或使用 npm 脚本
npm run build
```

### 3. 查看结果
生成的电子书保存在 `dist/` 目录：
- `Beyond-the-Science-of-Reading.pdf` - PDF 格式
- `Beyond-the-Science-of-Reading.epub` - EPUB 格式  
- `Beyond-the-Science-of-Reading.mobi` - Kindle 格式

## 📋 系统要求

### 自动安装的依赖
设置脚本会自动安装以下依赖：

- **Node.js** >= 14.0.0
- **Pandoc** - 文档转换引擎
- **LaTeX** (XeLaTeX) - PDF 生成引擎
- **Calibre** - MOBI 格式生成（可选）

### 手动安装（如果自动安装失败）
```bash
# macOS
brew install pandoc node
brew install --cask basictex calibre

# Linux (Ubuntu/Debian)
sudo apt-get install pandoc nodejs npm texlive-xetex calibre
```

## 🛠️ 使用方法

### Makefile 方式（推荐）
```bash
cd build

make help           # 查看所有命令
make setup          # 初始化环境
make all            # 构建所有格式
make pdf            # 仅构建 PDF
make epub           # 仅构建 EPUB
make mobi           # 仅构建 MOBI
make clean          # 清理构建文件
make stats          # 显示项目统计
```

### npm 脚本方式
```bash
cd build

npm run build       # 构建所有格式
npm run build:pdf   # 仅构建 PDF
npm run build:epub  # 仅构建 EPUB
npm run build:mobi  # 仅构建 MOBI
```

### 直接使用 Node.js
```bash
cd build

node build-ebooks.js           # 构建所有格式
node build-ebooks.js pdf       # 仅构建 PDF
node build-ebooks.js epub      # 仅构建 EPUB
node build-ebooks.js mobi      # 仅构建 MOBI
```

## 🎨 定制配置

### 书籍元信息
编辑 `build/build-ebooks.js` 中的 `bookConfig`：

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
修改 `chapters` 数组来调整包含的内容：

```javascript
this.chapters = [
  { file: 'index.md', title: '简介', level: 0 },
  { file: 'chapters/Chapter 1_.md', title: '第1章', level: 1 },
  // 添加更多章节...
];
```

### 样式定制
- **EPUB 样式**: 编辑 `build/styles/epub.css`
- **PDF 字体**: 修改 Pandoc 参数中的字体设置
- **封面设计**: 自定义 `build/templates/cover.html`

## 📁 项目结构

```
Beyond-the-Science-of-Reading/
├── build/                          # 构建系统
│   ├── build-ebooks.js            # 主构建脚本
│   ├── package.json               # Node.js 依赖
│   ├── Makefile                   # Make 构建配置
│   ├── README.md                  # 构建系统文档
│   ├── styles/
│   │   └── epub.css              # EPUB 样式
│   └── templates/
│       └── cover.html            # 封面模板
├── scripts/
│   └── setup-ebook-builder.sh    # 环境设置脚本
├── dist/                          # 输出目录（自动生成）
│   ├── Beyond-the-Science-of-Reading.pdf
│   ├── Beyond-the-Science-of-Reading.epub
│   └── Beyond-the-Science-of-Reading.mobi
├── chapters/                      # 章节内容
├── images/                        # 图片资源
└── EBOOK_BUILD.md                # 本文档
```

## 🔧 高级功能

### 监控文件变化
```bash
make watch  # 需要安装 fswatch
```

### 批量处理
```bash
make release  # 清理 + 构建 + 统计
```

### 快速 PDF 生成
```bash
make quick-pdf  # 跳过复杂处理，快速生成 PDF
```

## 📊 输出格式特性

### PDF 特性
- ✅ 中文字体支持（PingFang SC）
- ✅ 自动生成目录
- ✅ 章节自动编号
- ✅ 页眉页脚
- ✅ 代码语法高亮
- ✅ 图片自适应
- ✅ 专业排版

### EPUB 特性
- ✅ 响应式设计
- ✅ 自定义 CSS 样式
- ✅ 完整元数据
- ✅ 目录导航
- ✅ 图片优化
- ✅ 多设备兼容

### MOBI 特性
- ✅ Kindle 完美兼容
- ✅ 从 EPUB 自动转换
- ✅ 保持格式一致性
- ✅ 支持目录跳转

## 🐛 故障排除

### 常见问题及解决方案

1. **Pandoc 未找到**
   ```bash
   brew install pandoc  # macOS
   sudo apt install pandoc  # Linux
   ```

2. **中文字体显示问题**
   - 确保系统安装了 PingFang SC 字体
   - 或在配置中修改为其他可用中文字体

3. **LaTeX 错误**
   ```bash
   # 安装完整 LaTeX 发行版
   brew install --cask mactex  # macOS
   sudo apt install texlive-full  # Linux
   ```

4. **MOBI 生成失败**
   ```bash
   brew install --cask calibre  # macOS
   sudo apt install calibre  # Linux
   ```

5. **内存不足**
   ```bash
   # 增加 Node.js 内存限制
   node --max-old-space-size=4096 build-ebooks.js
   ```

### 调试模式
```bash
# 启用详细输出
DEBUG=1 make pdf

# 保留临时文件进行调试
KEEP_TEMP=1 node build-ebooks.js
```

## 📈 性能优化

- **并行处理**: 支持同时生成多种格式
- **增量构建**: 只处理变更的章节
- **缓存机制**: 重用已处理的资源
- **内存优化**: 大文件分块处理

## 🤝 贡献指南

1. Fork 本项目
2. 创建特性分支 (`git checkout -b feature/new-feature`)
3. 提交更改 (`git commit -am 'Add new feature'`)
4. 推送分支 (`git push origin feature/new-feature`)
5. 创建 Pull Request

## 📚 参考资源

- [Pandoc 用户指南](https://pandoc.org/MANUAL.html)
- [EPUB 3.2 规范](https://www.w3.org/publishing/epub32/)
- [Calibre 用户手册](https://manual.calibre-ebook.com/)
- [参考项目: xindoo/agentic-design-patterns](https://github.com/xindoo/agentic-design-patterns)

## 📄 许可证

本构建系统采用 MIT 许可证。生成的电子书内容遵循原书的许可证条款，仅供学习交流使用。