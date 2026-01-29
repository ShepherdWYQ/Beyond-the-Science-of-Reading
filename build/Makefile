# Beyond the Science of Reading - 电子书构建 Makefile
# 参考 xindoo/agentic-design-patterns 项目架构

.PHONY: all pdf epub mobi clean setup install check-deps help

# 默认目标
all: pdf epub mobi

# 设置变量
PROJECT_ROOT := $(shell pwd)/..
BUILD_DIR := $(PROJECT_ROOT)/build
DIST_DIR := $(PROJECT_ROOT)/dist
NODE_BIN := $(BUILD_DIR)/node_modules/.bin

# 颜色定义
RED := \033[31m
GREEN := \033[32m
YELLOW := \033[33m
BLUE := \033[34m
RESET := \033[0m

# 帮助信息
help:
	@echo "$(BLUE)Beyond the Science of Reading - 电子书构建系统$(RESET)"
	@echo ""
	@echo "$(GREEN)可用命令:$(RESET)"
	@echo "  $(YELLOW)make setup$(RESET)     - 安装依赖并检查环境"
	@echo "  $(YELLOW)make all$(RESET)       - 构建所有格式 (PDF + EPUB + MOBI)"
	@echo "  $(YELLOW)make pdf$(RESET)       - 仅构建 PDF"
	@echo "  $(YELLOW)make epub$(RESET)      - 仅构建 EPUB"
	@echo "  $(YELLOW)make mobi$(RESET)      - 仅构建 MOBI"
	@echo "  $(YELLOW)make clean$(RESET)     - 清理构建文件"
	@echo "  $(YELLOW)make check-deps$(RESET) - 检查系统依赖"
	@echo "  $(YELLOW)make help$(RESET)      - 显示此帮助信息"
	@echo ""
	@echo "$(GREEN)系统要求:$(RESET)"
	@echo "  - Node.js >= 14.0.0"
	@echo "  - Pandoc (brew install pandoc)"
	@echo "  - Calibre (brew install --cask calibre) - 可选，用于 MOBI"

# 安装和设置
setup: install check-deps
	@echo "$(GREEN)✅ 环境设置完成$(RESET)"

install:
	@echo "$(BLUE)📦 安装 Node.js 依赖...$(RESET)"
	cd $(BUILD_DIR) && npm install

check-deps:
	@echo "$(BLUE)🔍 检查系统依赖...$(RESET)"
	@command -v node >/dev/null 2>&1 || { echo "$(RED)❌ Node.js 未安装$(RESET)"; exit 1; }
	@command -v pandoc >/dev/null 2>&1 || { echo "$(RED)❌ Pandoc 未安装，请运行: brew install pandoc$(RESET)"; exit 1; }
	@command -v ebook-convert >/dev/null 2>&1 || echo "$(YELLOW)⚠️  Calibre 未安装，无法生成 MOBI 格式: brew install --cask calibre$(RESET)"
	@echo "$(GREEN)✅ 依赖检查完成$(RESET)"

# 构建目标
pdf:
	@echo "$(BLUE)📄 构建 PDF 电子书...$(RESET)"
	cd $(BUILD_DIR) && node build-ebooks.js pdf
	@echo "$(GREEN)✅ PDF 构建完成$(RESET)"

epub:
	@echo "$(BLUE)📱 构建 EPUB 电子书...$(RESET)"
	cd $(BUILD_DIR) && node build-ebooks.js epub
	@echo "$(GREEN)✅ EPUB 构建完成$(RESET)"

mobi:
	@echo "$(BLUE)📖 构建 MOBI 电子书...$(RESET)"
	cd $(BUILD_DIR) && node build-ebooks.js mobi
	@echo "$(GREEN)✅ MOBI 构建完成$(RESET)"

# 清理
clean:
	@echo "$(BLUE)🧹 清理构建文件...$(RESET)"
	rm -rf $(BUILD_DIR)/temp
	rm -rf $(BUILD_DIR)/node_modules
	rm -rf $(DIST_DIR)
	@echo "$(GREEN)✅ 清理完成$(RESET)"

# 快速构建脚本
quick-pdf:
	@echo "$(BLUE)⚡ 快速 PDF 构建（使用 Pandoc）...$(RESET)"
	mkdir -p $(DIST_DIR)
	pandoc $(PROJECT_ROOT)/index.md $(PROJECT_ROOT)/chapters/*.md \
		-o $(DIST_DIR)/Beyond-the-Science-of-Reading-Quick.pdf \
		--pdf-engine=xelatex \
		--variable mainfont="PingFang SC" \
		--variable CJKmainfont="PingFang SC" \
		--toc \
		--number-sections
	@echo "$(GREEN)✅ 快速 PDF 构建完成$(RESET)"

# 开发模式
dev: setup
	@echo "$(BLUE)🚀 启动开发模式...$(RESET)"
	cd $(BUILD_DIR) && npm run build

# 发布准备
release: clean setup all
	@echo "$(BLUE)📦 准备发布包...$(RESET)"
	@if [ -d "$(DIST_DIR)" ]; then \
		echo "$(GREEN)📚 生成的电子书文件:$(RESET)"; \
		ls -la $(DIST_DIR)/; \
		echo ""; \
		echo "$(GREEN)📊 文件大小统计:$(RESET)"; \
		du -h $(DIST_DIR)/*; \
	else \
		echo "$(RED)❌ 没有找到生成的文件$(RESET)"; \
	fi

# 测试构建
test:
	@echo "$(BLUE)🧪 测试构建环境...$(RESET)"
	@make check-deps
	@echo "$(GREEN)✅ 环境测试通过$(RESET)"

# 监控文件变化（需要 fswatch）
watch:
	@echo "$(BLUE)👀 监控文件变化...$(RESET)"
	@command -v fswatch >/dev/null 2>&1 || { echo "$(RED)❌ fswatch 未安装，请运行: brew install fswatch$(RESET)"; exit 1; }
	fswatch -o $(PROJECT_ROOT)/chapters/ $(PROJECT_ROOT)/*.md | xargs -n1 -I{} make pdf

# 统计信息
stats:
	@echo "$(BLUE)📊 项目统计信息$(RESET)"
	@echo "$(GREEN)章节文件数量:$(RESET) $$(find $(PROJECT_ROOT)/chapters -name "*.md" | wc -l)"
	@echo "$(GREEN)总字数统计:$(RESET) $$(find $(PROJECT_ROOT) -name "*.md" -exec wc -w {} + | tail -1)"
	@echo "$(GREEN)图片文件数量:$(RESET) $$(find $(PROJECT_ROOT)/images -type f | wc -l)"
	@if [ -d "$(DIST_DIR)" ]; then \
		echo "$(GREEN)生成的电子书:$(RESET)"; \
		ls -1 $(DIST_DIR)/ 2>/dev/null || echo "  无"; \
	fi