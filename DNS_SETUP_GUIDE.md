# DNS 配置指南

子域名方案的 DNS 配置详细步骤。

## 🎯 目标配置

```
beyond-reading-science.wangyongqing.com  -> GitHub Pages
translation.wangyongqing.com             -> 项目索引页面
```

## 📋 DNS 记录配置

### 方案1：CNAME 记录（推荐）

在你的域名管理面板中添加：

```
记录类型: CNAME
主机记录: beyond-reading-science
记录值: ShepherdWYQ.github.io
TTL: 600 (或默认)
```

### 方案2：A 记录

如果不支持 CNAME，使用 A 记录：

```
记录类型: A
主机记录: beyond-reading-science
记录值: 185.199.108.153
记录值: 185.199.109.153
记录值: 185.199.110.153
记录值: 185.199.111.153
TTL: 600 (或默认)
```

## 🔧 常见域名服务商配置

### 阿里云 DNS

1. 登录阿里云控制台
2. 进入 **域名** > **DNS解析**
3. 选择域名 `wangyongqing.com`
4. 点击 **添加记录**
5. 填写：
   - **记录类型**: CNAME
   - **主机记录**: beyond-reading-science
   - **解析路线**: 默认
   - **记录值**: ShepherdWYQ.github.io
   - **TTL**: 600
6. 点击 **确认**

### 腾讯云 DNS

1. 登录腾讯云控制台
2. 进入 **域名注册** > **我的域名**
3. 点击域名后的 **解析**
4. 点击 **添加记录**
5. 填写：
   - **主机记录**: beyond-reading-science
   - **记录类型**: CNAME
   - **线路类型**: 默认
   - **记录值**: ShepherdWYQ.github.io
   - **TTL**: 600
6. 点击 **保存**

### Cloudflare

1. 登录 Cloudflare 控制台
2. 选择域名 `wangyongqing.com`
3. 进入 **DNS** 标签页
4. 点击 **Add record**
5. 填写：
   - **Type**: CNAME
   - **Name**: beyond-reading-science
   - **Target**: ShepherdWYQ.github.io
   - **Proxy status**: DNS only (灰色云朵)
6. 点击 **Save**

### GoDaddy

1. 登录 GoDaddy 账户
2. 进入 **我的产品** > **DNS**
3. 找到域名 `wangyongqing.com`，点击 **管理**
4. 在 DNS 记录中点击 **添加**
5. 选择：
   - **类型**: CNAME
   - **名称**: beyond-reading-science
   - **值**: ShepherdWYQ.github.io
   - **TTL**: 600 秒
6. 点击 **保存**

### 万网/阿里云万网

1. 登录万网控制台
2. 进入 **域名管理**
3. 找到 `wangyongqing.com`，点击 **管理**
4. 进入 **DNS修改/创建**
5. 添加记录：
   - **记录类型**: CNAME
   - **主机记录**: beyond-reading-science
   - **记录值**: ShepherdWYQ.github.io
6. 点击 **新增**

## 🔍 验证 DNS 配置

### 命令行验证

```bash
# 检查 CNAME 记录
dig beyond-reading-science.wangyongqing.com CNAME

# 检查 A 记录解析
dig beyond-reading-science.wangyongqing.com A

# 使用 nslookup
nslookup beyond-reading-science.wangyongqing.com
```

### 在线工具验证

- [DNS Checker](https://dnschecker.org/)
- [What's My DNS](https://www.whatsmydns.net/)
- [DNS Propagation Checker](https://www.dnsmap.io/)

输入域名：`beyond-reading-science.wangyongqing.com`

## ⏰ DNS 传播时间

- **本地**: 5-10 分钟
- **全球**: 2-24 小时
- **完全传播**: 最多 48 小时

## 🚨 常见问题

### 1. DNS 记录冲突

如果已有 `beyond-reading-science` 记录：
- 删除旧记录
- 添加新的 CNAME 记录

### 2. TTL 设置

- **测试期间**: 设置较短 TTL (300-600秒)
- **稳定后**: 可以设置较长 TTL (3600秒)

### 3. 记录类型选择

- **优先使用**: CNAME 记录
- **备选方案**: A 记录（如果 CNAME 不支持）

## 📊 配置检查清单

- [ ] 添加 CNAME 记录：`beyond-reading-science -> ShepherdWYQ.github.io`
- [ ] 等待 DNS 传播（5-30分钟）
- [ ] 验证解析：`dig beyond-reading-science.wangyongqing.com`
- [ ] 在 GitHub Pages 设置自定义域名
- [ ] 启用 HTTPS
- [ ] 测试访问：`https://beyond-reading-science.wangyongqing.com`

## 🔄 如果配置失败

### 检查步骤

1. **确认记录类型**: CNAME 或 A 记录
2. **检查主机记录**: `beyond-reading-science`（不包含完整域名）
3. **验证记录值**: `ShepherdWYQ.github.io`（不要加 https://）
4. **等待传播**: 至少等待 10-30 分钟
5. **清除 DNS 缓存**: 
   ```bash
   # macOS
   sudo dscacheutil -flushcache
   
   # Windows
   ipconfig /flushdns
   ```

### 联系支持

如果仍有问题：
1. 联系域名服务商技术支持
2. 提供配置截图
3. 说明要配置 GitHub Pages 自定义域名

## 📞 技术支持联系方式

### 主要服务商

- **阿里云**: 95187
- **腾讯云**: 4009100100
- **Cloudflare**: 在线工单系统
- **GoDaddy**: 在线客服

配置完成后，运行验证脚本：
```bash
./scripts/test-domain.sh
```