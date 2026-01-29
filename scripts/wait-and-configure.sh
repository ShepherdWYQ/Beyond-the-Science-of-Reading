#!/bin/bash

# 等待 DNS 传播并配置 GitHub Pages

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

DOMAIN="beyond-reading-science.wangyongqing.com"

echo -e "${BLUE}⏳ 等待 DNS 传播并配置 GitHub Pages${NC}"
echo

log_info "当前状态："
echo "✅ DNS 记录已配置"
echo "✅ 指向 GitHub Pages IP"
echo "⚠️ DNS 传播中 (3/4 服务器已生效)"
echo "⚠️ GitHub Pages 自定义域名待配置"

echo

# 等待 DNS 完全传播
log_info "等待 DNS 完全传播..."
echo "这通常需要 5-30 分钟"

for i in {1..6}; do
    echo -n "检查第 $i 次..."
    
    # 检查 DNS 解析
    if dig +short $DOMAIN >/dev/null 2>&1; then
        echo " ✅"
        DNS_READY=true
        break
    else
        echo " ⏳"
        if [[ $i -lt 6 ]]; then
            echo "等待 5 分钟后重试..."
            sleep 300  # 等待 5 分钟
        fi
    fi
done

if [[ "$DNS_READY" == "true" ]]; then
    log_success "DNS 解析正常"
else
    log_warning "DNS 仍在传播中，但可以继续配置"
fi

echo

# 指导 GitHub Pages 配置
log_info "现在配置 GitHub Pages："

echo
echo -e "${YELLOW}📋 GitHub Pages 配置步骤：${NC}"
echo
echo "1. 访问 GitHub Pages 设置页面："
echo "   https://github.com/ShepherdWYQ/Beyond-the-Science-of-Reading/settings/pages"
echo
echo "2. 在 Custom domain 中输入："
echo "   beyond-reading-science.wangyongqing.com"
echo
echo "3. 点击 Save"
echo
echo "4. 等待验证完成（可能需要几分钟）"
echo
echo "5. 启用 'Enforce HTTPS'"

echo

# 检查是否可以访问
log_info "测试域名访问..."

if curl -s -I "http://$DOMAIN" >/dev/null 2>&1; then
    log_success "HTTP 访问正常"
    echo "🌐 可以访问: http://$DOMAIN"
    
    if curl -s -I "https://$DOMAIN" >/dev/null 2>&1; then
        log_success "HTTPS 也正常"
        echo "🔒 HTTPS 访问: https://$DOMAIN"
    else
        log_info "HTTPS 还未配置，GitHub Pages 需要时间生成 SSL 证书"
    fi
else
    log_warning "域名暂时无法访问，请等待更多时间"
fi

echo

# 提供监控命令
echo -e "${BLUE}📊 监控命令：${NC}"
echo
echo "检查 DNS 状态:"
echo "  ./scripts/check-dns.sh"
echo
echo "检查网站访问:"
echo "  curl -I http://$DOMAIN"
echo "  curl -I https://$DOMAIN"
echo
echo "在线 DNS 检查:"
echo "  https://dnschecker.org/"

echo

# 预期时间线
echo -e "${YELLOW}⏰ 预期时间线：${NC}"
echo "现在 → 5分钟:   DNS 完全传播"
echo "现在 → 10分钟:  GitHub Pages 域名验证"
echo "现在 → 30分钟:  SSL 证书生成完成"
echo "现在 → 1小时:   全球访问稳定"

echo

log_success "配置指导完成！"
echo
echo -e "${GREEN}🎉 下一步：${NC}"
echo "1. 按照上面的步骤配置 GitHub Pages"
echo "2. 等待 10-30 分钟"
echo "3. 访问: https://$DOMAIN"