# Ruby 升级步骤

## 当前状态
- 当前 Ruby 版本：2.6.10（太旧）
- 需要版本：3.0 或更高

## 安装步骤

### 步骤 1：安装 Homebrew

在终端中运行以下命令（需要输入密码）：

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

安装完成后，根据提示将 Homebrew 添加到 PATH。通常需要运行：

```bash
# 对于 Apple Silicon Mac (M1/M2/M3)
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
eval "$(/opt/homebrew/bin/brew shellenv)"

# 对于 Intel Mac
echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zshrc
eval "$(/usr/local/bin/brew shellenv)"
```

### 步骤 2：安装 Ruby

```bash
brew install ruby
```

### 步骤 3：更新 PATH

将新安装的 Ruby 添加到 PATH（根据您的 Mac 类型选择）：

**Apple Silicon Mac (M1/M2/M3):**
```bash
echo 'export PATH="/opt/homebrew/opt/ruby/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

**Intel Mac:**
```bash
echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### 步骤 4：验证安装

```bash
ruby --version
# 应该显示 3.x.x 版本
```

### 步骤 5：重新安装 Bundler

```bash
gem install bundler
```

### 步骤 6：安装项目依赖

```bash
cd /Users/shepherd/Documents/GitHub/Beyond-the-Science-of-Reading
bundle install
```

### 步骤 7：启动 Jekyll 服务器

```bash
bundle exec jekyll serve --livereload
```

## 快速命令（复制粘贴）

如果您已经安装了 Homebrew，可以直接运行：

```bash
# 安装 Ruby
brew install ruby

# 添加到 PATH（Apple Silicon）
echo 'export PATH="/opt/homebrew/opt/ruby/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# 验证
ruby --version

# 安装 bundler
gem install bundler

# 安装项目依赖
cd /Users/shepherd/Documents/GitHub/Beyond-the-Science-of-Reading
bundle install

# 启动服务器
bundle exec jekyll serve --livereload
```

## 如果遇到问题

### 问题 1：找不到 brew 命令

确保 Homebrew 已正确安装并添加到 PATH：
```bash
eval "$(/opt/homebrew/bin/brew shellenv)"  # Apple Silicon
# 或
eval "$(/usr/local/bin/brew shellenv)"     # Intel
```

### 问题 2：Ruby 版本仍然是旧的

检查 PATH 顺序：
```bash
which ruby
# 应该显示 /opt/homebrew/opt/ruby/bin/ruby 或 /usr/local/opt/ruby/bin/ruby
```

### 问题 3：权限问题

如果遇到权限问题，可能需要：
```bash
sudo gem install bundler
```

## 验证

安装完成后，运行：

```bash
ruby --version    # 应该 >= 3.0
bundle --version
bundle exec jekyll --version
```

---

**提示**：安装完成后，重新打开终端窗口以确保 PATH 更新生效。
