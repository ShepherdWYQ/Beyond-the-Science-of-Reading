# 构建错误修复说明

## 已修复的问题

### 1. Jekyll 版本
- 将 Jekyll 版本从 `~> 4.3` 降级到 `~> 4.2`（更稳定）

### 2. 工作流改进
- 添加了 `bundle install` 步骤确保依赖正确安装
- 添加了 `--verbose` 标志以便查看详细错误信息

### 3. 配置文件优化
- 改进了插件配置注释
- 排除了更多不需要处理的文件

## 下一步操作

### 1. 提交修复

```bash
git add .
git commit -m "Fix Jekyll build errors"
git push origin main
```

### 2. 检查构建状态

1. 访问：`https://github.com/ShepherdWYQ/Beyond-the-Science-of-Reading/actions`
2. 等待新的构建完成（约 5 分钟）
3. 查看是否成功（绿色勾号）

### 3. 如果仍然失败

请查看构建日志中的具体错误信息，常见错误包括：

**错误：`Could not locate Gemfile`**
- 确保 `Gemfile` 已提交到仓库

**错误：`Liquid Exception`**
- 检查 Markdown 文件中的语法错误
- 确保所有 front matter（`---`）格式正确

**错误：`Theme minima not found`**
- 确保 `Gemfile` 中包含 `gem "minima"`

**错误：`404` 或文件未找到**
- 检查文件路径是否正确
- 确保所有引用的文件都存在

## 本地测试

在推送前，可以在本地测试：

```bash
# 安装依赖
bundle install

# 构建网站
bundle exec jekyll build

# 如果有错误，会显示详细信息
```

## 需要帮助？

如果构建仍然失败，请：
1. 复制完整的错误信息
2. 告诉我具体是哪个步骤失败
3. 我可以帮您进一步诊断问题
