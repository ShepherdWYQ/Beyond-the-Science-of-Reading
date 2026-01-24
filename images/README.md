# 图片资源目录

本目录存放所有章节的图片资源。

## 目录结构

图片按章节组织在对应的子目录中：

```
images/
├── cover.png                    # 封面图片
├── chapter-1/                   # 第1章图片
│   └── prompt-chaining-diagram.png
├── chapter-2/                   # 第2章图片
│   └── routing-flowchart.png
├── chapter-3/                   # 第3章图片
└── ...
```

## 命名规范

* 使用小写字母和连字符
* 使用描述性名称
* 保持文件扩展名（.png, .jpg, .svg 等）

**示例：**
* `prompt-chaining-diagram.png`
* `routing-flowchart.svg`
* `multi-agent-architecture.jpg`

## 图片引用

在章节文件中引用图片时，使用相对路径：

```markdown
![图片描述](images/chapter-1/prompt-chaining-diagram.png)
```

## 图片格式建议

* **图表、流程图**：使用 PNG 或 SVG 格式
* **照片、截图**：使用 JPG 或 PNG 格式
* **图标**：使用 SVG 格式（可缩放）

## 注意事项

* 确保图片文件大小合理（建议 < 1MB）
* 保持图片清晰度
* 为图片添加有意义的文件名
* 在章节文件中为图片添加描述性 alt 文本
