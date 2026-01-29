#!/bin/bash

# 选择部署方式脚本

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

echo -e "${BLUE}🚀 选择部署方式${NC}"
echo

log_info "当前可用的部署选项："
echo
echo "1. 子域名部署 (推荐)"
echo "   域名: https://beyond-reading-science.wangyongqing.com"
echo "   需要: DNS配置"
echo
echo "2. GitHub Pages 默认域名"
echo "   域名: https://ShepherdWYQ.github.io/Beyond-the-Science-of-Reading"
echo "   需要: 无额外配置"
echo

read -p "请选择部署方式 (1/2): " -n 1 -r
echo

case $REPLY in
    1)
        log_info "选择子域名部署..."
        
        # 配置为子域名
        echo "beyond-reading-science.wangyongqing.com" > CNAME
        
        # 更新Jekyll配置
        sed -i.bak 's|url: https://ShepherdWYQ.github.io|url: https://beyond-reading-science.wangyongqing.com|g' _config.yml
        sed -i.bak 's|baseurl: "/Beyond-the-Science-of-Reading"|baseurl: ""|g' _config.yml
        
        log_success "已配置为子域名部署"
        echo
        echo -e "${YELLOW}📋 DNS 配置要求:${NC}"
        echo "记录类型: CNAME"
        echo "主机记录: beyond-reading-science"
        echo "记录值: ShepherdWYQ.github.io"
        echo
        echo -e "${YELLOW}📋 GitHub Pages 设置:${NC}"
        echo "Custom domain: beyond-reading-science.wangyongqing.com"
        echo
        ;;
        
    2)
        log_info "选择GitHub Pages默认域名..."
        
        # 删除CNAME文件
        rm -f CNAME
        
        # 更新Jekyll配置
        sed -i.bak 's|url: https://beyond-reading-science.wangyongqing.com|url: https://ShepherdWYQ.github.io|g' _config.yml
        sed -i.bak 's|baseurl: ""|baseurl: "/Beyond-the-Science-of-Reading"|g' _config.yml
        
        log_success "已配置为GitHub Pages默认域名"
        echo
        echo -e "${YELLOW}📋 GitHub Pages 设置:${NC}"
        echo "Custom domain: 留空"
        echo
        ;;
        
    *)
        log_warning "无效选择，保持当前配置"
        exit 0
        ;;
esac

# 清理备份文件
rm -f _config.yml.bak

# 提交更改
log_info "提交配置更改..."
git add .
git commit -m "Update deployment configuration"

if git push origin main; then
    log_success "配置已推送到GitHub"
else
    log_warning "推送失败，请手动推送: git push origin main"
fi

echo
case $REPLY in
    1)
        echo -e "${GREEN}🌐 网站地址: https://beyond-reading-science.wangyongqing.com${NC}"
        ;;
    2)
        echo -e "${GREEN}🌐 网站地址: https://ShepherdWYQ.github.io/Beyond-the-Science-of-Reading${NC}"
        ;;
esac

echo
log_success "部署配置完成！"