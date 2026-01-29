#!/bin/bash

# DNS 配置检查脚本

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

log_error() {
    echo -e "${RED}❌ $1${NC}"
}

DOMAIN="beyond-reading-science.wangyongqing.com"
TARGET="ShepherdWYQ.github.io"

echo -e "${BLUE}🔍 DNS 配置检查${NC}"
echo -e "${BLUE}域名: $DOMAIN${NC}"
echo -e "${BLUE}目标: $TARGET${NC}"
echo

# 检查 CNAME 记录
log_info "检查 CNAME 记录..."
CNAME_RESULT=$(dig +short $DOMAIN CNAME 2>/dev/null || echo "")

if [[ -n "$CNAME_RESULT" ]]; then
    if [[ "$CNAME_RESULT" == "$TARGET." ]] || [[ "$CNAME_RESULT" == "$TARGET" ]]; then
        log_success "CNAME 记录配置正确: $CNAME_RESULT"
        DNS_CONFIGURED=true
    else
        log_warning "CNAME 记录存在但不正确: $CNAME_RESULT"
        log_warning "应该指向: $TARGET"
    fi
else
    log_info "未找到 CNAME 记录，检查 A 记录..."
fi

# 检查 A 记录
log_info "检查 A 记录解析..."
A_RECORDS=$(dig +short $DOMAIN A 2>/dev/null || echo "")

if [[ -n "$A_RECORDS" ]]; then
    echo "A 记录解析结果:"
    echo "$A_RECORDS" | while read ip; do
        echo "  $ip"
    done
    
    # 检查是否包含 GitHub Pages IP
    GITHUB_IPS=("185.199.108.153" "185.199.109.153" "185.199.110.153" "185.199.111.153")
    GITHUB_IP_FOUND=false
    
    for github_ip in "${GITHUB_IPS[@]}"; do
        if echo "$A_RECORDS" | grep -q "$github_ip"; then
            log_success "找到 GitHub Pages IP: $github_ip"
            GITHUB_IP_FOUND=true
            DNS_CONFIGURED=true
        fi
    done
    
    if [[ "$GITHUB_IP_FOUND" == "false" ]]; then
        log_warning "A 记录不指向 GitHub Pages"
        echo "GitHub Pages IP 地址:"
        for github_ip in "${GITHUB_IPS[@]}"; do
            echo "  $github_ip"
        done
    fi
else
    log_error "未找到 A 记录解析"
fi

echo

# 检查域名是否可访问
log_info "检查域名访问性..."

if curl -s -I "https://$DOMAIN" >/dev/null 2>&1; then
    log_success "HTTPS 访问正常"
    HTTPS_WORKING=true
elif curl -s -I "http://$DOMAIN" >/dev/null 2>&1; then
    log_warning "HTTP 可访问，但 HTTPS 可能还未配置"
    log_info "GitHub Pages 需要时间生成 SSL 证书"
else
    log_warning "域名暂时无法访问（可能还在传播中）"
fi

echo

# 检查 DNS 传播状态
log_info "检查全球 DNS 传播状态..."

# 使用多个 DNS 服务器检查
DNS_SERVERS=("8.8.8.8" "1.1.1.1" "114.114.114.114" "223.5.5.5")
PROPAGATED_COUNT=0

for dns_server in "${DNS_SERVERS[@]}"; do
    result=$(dig @$dns_server +short $DOMAIN 2>/dev/null || echo "")
    if [[ -n "$result" ]]; then
        echo "  $dns_server: ✅ $result"
        ((PROPAGATED_COUNT++))
    else
        echo "  $dns_server: ❌ 无解析结果"
    fi
done

if [[ $PROPAGATED_COUNT -eq ${#DNS_SERVERS[@]} ]]; then
    log_success "DNS 已在所有测试服务器传播"
elif [[ $PROPAGATED_COUNT -gt 0 ]]; then
    log_warning "DNS 部分传播 ($PROPAGATED_COUNT/${#DNS_SERVERS[@]})"
    log_info "请等待更多时间让 DNS 完全传播"
else
    log_error "DNS 尚未传播到测试服务器"
fi

echo

# 总结和建议
log_info "配置总结:"

if [[ "$DNS_CONFIGURED" == "true" ]]; then
    log_success "DNS 记录配置正确"
else
    log_error "DNS 记录需要配置"
    echo
    echo -e "${YELLOW}需要在域名管理面板添加以下记录:${NC}"
    echo
    echo -e "${BLUE}方案1 - CNAME 记录 (推荐):${NC}"
    echo "  记录类型: CNAME"
    echo "  主机记录: beyond-reading-science"
    echo "  记录值: ShepherdWYQ.github.io"
    echo
    echo -e "${BLUE}方案2 - A 记录:${NC}"
    echo "  记录类型: A"
    echo "  主机记录: beyond-reading-science"
    echo "  记录值: 185.199.108.153"
    echo "  记录值: 185.199.109.153"
    echo "  记录值: 185.199.110.153"
    echo "  记录值: 185.199.111.153"
fi

echo

if [[ "$HTTPS_WORKING" == "true" ]]; then
    log_success "网站已可访问: https://$DOMAIN"
else
    echo -e "${YELLOW}下一步操作:${NC}"
    echo "1. 确保 DNS 记录配置正确"
    echo "2. 等待 DNS 传播 (5-30分钟)"
    echo "3. 在 GitHub Pages 设置自定义域名"
    echo "4. 等待 SSL 证书生成 (10-30分钟)"
    echo "5. 访问: https://$DOMAIN"
fi

echo

# 提供有用的链接
echo -e "${BLUE}🔗 有用的链接:${NC}"
echo "DNS 传播检查: https://dnschecker.org/"
echo "GitHub Pages 设置: https://github.com/ShepherdWYQ/Beyond-the-Science-of-Reading/settings/pages"
echo "详细配置指南: DNS_SETUP_GUIDE.md"

echo

# 如果需要，提供重新检查命令
if [[ "$DNS_CONFIGURED" != "true" ]] || [[ "$HTTPS_WORKING" != "true" ]]; then
    echo -e "${YELLOW}💡 配置完成后，重新运行此脚本检查:${NC}"
    echo "  ./scripts/check-dns.sh"
fi