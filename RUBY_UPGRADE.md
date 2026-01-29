# Ruby 升级指南

## 问题

当前 Ruby 版本（2.6.10）太旧，无法安装 Jekyll 所需的依赖。需要升级到 Ruby 3.0 或更高版本。

## 解决方案

### 方案 1：使用 Homebrew 安装 Ruby（推荐，最简单）

```bash
# 1. 安装 Homebrew（如果还没有）
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. 安装 Ruby
brew install ruby

# 3. 添加到 PATH（根据提示添加到 ~/.zshrc 或 ~/.bash_profile）
echo 'export PATH="/opt/homebrew/opt/ruby/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# 4. 验证安装
ruby --version  # 应该显示 3.x.x

# 5. 重新安装 bundler
gem install bundler

# 6. 安装项目依赖
cd /Users/shepherd/Documents/GitHub/Beyond-the-Science-of-Reading
bundle install

# 7. 启动服务器
bundle exec jekyll serve --livereload
```

### 方案 2：使用 rbenv（Ruby 版本管理器）

```bash
# 1. 安装 rbenv
brew install rbenv ruby-build

# 2. 初始化 rbenv
echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc
source ~/.zshrc

# 3. 安装 Ruby 3.1
rbenv install 3.1.7

# 4. 设置为全局版本
rbenv global 3.1.7

# 5. 验证
ruby --version

# 6. 安装 bundler
gem install bundler

# 7. 安装项目依赖
cd /Users/shepherd/Documents/GitHub/Beyond-the-Science-of-Reading
bundle install

# 8. 启动服务器
bundle exec jekyll serve --livereload
```

### 方案 3：临时使用系统 Ruby（不推荐，但可以快速测试）

如果不想升级 Ruby，可以暂时修改 Gemfile 使用更旧的 Jekyll 版本：

```ruby
# 在 Gemfile 中使用
gem "jekyll", "~> 3.8"
gem "minima", "~> 2.5"
```

但这种方法可能无法完全支持所有功能。

## 推荐方案

**推荐使用方案 1（Homebrew）**，因为：
- 最简单直接
- 不需要版本管理
- 适合大多数用户

## 验证安装

升级后，运行：

```bash
ruby --version  # 应该显示 3.0 或更高
bundle --version
bundle install
bundle exec jekyll serve --livereload
```

## 需要帮助？

如果遇到问题，请检查：
1. Ruby 版本：`ruby --version`
2. Bundler 版本：`bundle --version`
3. 错误信息中的具体提示
