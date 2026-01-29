#!/bin/bash

# 测试域名配置脚本

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

echo -e "${BLUE}🔍 测试域名配置${NC}"
echo

# 测试根域名
log_info "测试根域名: translation.wangyongqing.com"
if curl -s -I https://translation.wangyongqing.com | head -n 1; then
    log_success "根域名可访问"
else
    log_error "根域名无法访问"
fi

echo

# 测试子路径
log_info "测试子路径: translation.wangyongqing.com/beyond-reading-science"
if curl -s -I https://translation.wangyongqing.com/beyond-reading-science | head -n 1; then
    log_success "子路径可访问"
else
    log_warning "子路径暂时无法访问（可能还未部署）"
fi

echo

# DNS 检查
log_info "检查 DNS 解析"
if nslookup translation.wangyongqing.com; then
    log_success "DNS 解析正常"
else
    log_error "DNS 解析失败"
fi

echo

# 检查是否指向 GitHub Pages
log_info "检查是否指向 GitHub Pages"
IP_ADDRESSES=$(dig +short translation.wangyongqing.com)
GITHUB_IPS=("185.199.108.153" "185.199.109.153" "185.199.110.153" "185.199.111.153")

if [[ -n "$IP_ADDRESSES" ]]; then
    echo "当前 IP 地址: $IP_ADDRESSES"
    
    for ip in $IP_ADDRESSES; do
        if [[ " ${GITHUB_IPS[@]} " =~ " ${ip} " ]]; then
            log_success "IP $ip 指向 GitHub Pages"
            GITHUB_PAGES_CONFIGURED=true
        else
            log_warning "IP $ip 不是 GitHub Pages IP"
        fi
    done
    
    if [[ "$GITHUB_PAGES_CONFIGURED" == "true" ]]; then
        log_success "域名已正确配置指向 GitHub Pages"
    else
        log_error "域名未指向 GitHub Pages"
        echo
        echo -e "${YELLOW}需要配置以下 A 记录:${NC}"
        for github_ip in "${GITHUB_IPS[@]}"; do
            echo "  translation.wangyongqing.com -> $github_ip"
        done
    fi
else
    log_error "无法获取 IP 地址"
fi

echo

# 检查 CNAME 记录
log_info "检查 CNAME 记录"
CNAME_RECORD=$(dig +short translation.wangyongqing.com CNAME)
if [[ -n "$CNAME_RECORD" ]]; then
    echo "CNAME 记录: $CNAME_RECORD"
    if [[ "$CNAME_RECORD" == *"github.io"* ]]; then
        log_success "CNAME 指向 GitHub Pages"
    else
        log_warning "CNAME 不指向 GitHub Pages"
    fi
else
    log_info "未配置 CNAME 记录（使用 A 记录）"
fi

echo

# 总结
echo -e "${BLUE}📋 配置建议:${NC}"
echo

if [[ "$GITHUB_PAGES_CONFIGURED" == "true" ]]; then
    log_success "域名配置正确，可以部署"
    echo "  运行: ./scripts/deploy.sh"
else
    log_warning "需要先配置域名 DNS"
    echo
    echo -e "${YELLOW}DNS 配置选项 1 - A 记录:${NC}"
    echo "  translation.wangyongqing.com -> 185.199.108.153"
    echo "  translation.wangyongqing.com -> 185.199.109.153"
    echo "  translation.wangyongqing.com -> 185.199.110.153"
    echo "  translation.wangyongqing.com -> 185.199.111.153"
    echo
    echo -e "${YELLOW}DNS 配置选项 2 - CNAME 记录:${NC}"
    echo "  translation.wangyongqing.com -> ShepherdWYQ.github.io"
    echo
    echo -e "${YELLOW}临时方案:${NC}"
    echo "  使用 GitHub Pages 默认域名: ./scripts/deploy-github.sh"
fi