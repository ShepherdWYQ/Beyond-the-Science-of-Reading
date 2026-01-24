---
layout: default
title: 贡献指南
permalink: /CONTRIBUTING.html
---

# 贡献指南

感谢您对本翻译项目的关注！我们欢迎任何形式的贡献。

## 如何贡献

### 1. Fork 本仓库

首先，在 GitHub 上 Fork 本仓库到您的账户。

### 2. 克隆仓库

```bash
git clone https://github.com/your-username/Beyond-the-Science-of-Reading.git
cd Beyond-the-Science-of-Reading
```

### 3. 创建特性分支

```bash
git checkout -b feature/translate-chapter-xx
```

### 4. 开始翻译

* 选择一个章节进行翻译
* 参考 `translation-guide.md` 了解翻译规范
* 参考 `glossary.md` 确保术语统一
* 在 `progress.md` 中更新翻译进度

### 5. 提交更改

```bash
git add .
git commit -m '完成第XX章翻译'
```

### 6. 推送分支

```bash
git push origin feature/translate-chapter-xx
```

### 7. 创建 Pull Request

在 GitHub 上创建 Pull Request，详细描述您的更改。

## 翻译规范

在开始翻译前，请仔细阅读 `translation-guide.md`。

### 基本原则

1. **保持原文结构**：段落、标题层级保持一致
2. **术语统一**：参考 `glossary.md` 中的术语对照表
3. **代码保持原样**：代码示例、命令行等保持英文
4. **图片路径**：确保图片引用路径正确指向 `images/` 目录
5. **格式规范**：遵循 Markdown 格式规范
6. **校对审核**：提交前进行自我校对

### 文件命名规范

* 章节文件：`Chapter X_ Title.md`
* 附录文件：`Appendix X_ Title.md`
* 其他文件：使用描述性名称

### 提交信息规范

* 翻译新章节：`完成第XX章翻译`
* 修正错误：`修正第XX章翻译错误`
* 更新术语：`更新术语表`
* 其他改进：`改进XXX`

## 代码规范

* 使用 UTF-8 编码
* 使用 LF 换行符
* Markdown 文件末尾保留一个空行

## 问题反馈

如果您发现问题或有建议，请：

1. 在 Issues 中创建新问题
2. 详细描述问题或建议
3. 如果可能，提供修复方案

## 审核流程

1. 提交 Pull Request
2. 维护者审核
3. 根据反馈进行修改
4. 审核通过后合并

感谢您的贡献！
