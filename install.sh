#!/bin/sh
# NetWiz 一键安装脚本

echo -e "\033[36m[NetWiz]\033[0m 正在启动网络向导一键安装..."

# 发布在 release 的 v1.0.0 版本下
IPK_URL="https://github.com/你的GitHub用户名/luci-app-netwiz/releases/download/v1.0.0/luci-app-netwiz_1.0.0-1_all.ipk"
TMP_FILE="/tmp/netwiz.ipk"

echo ">> 正在从 GitHub 下载最新版本..."
wget -qO $TMP_FILE $IPK_URL

if [ ! -f "$TMP_FILE" ]; then
    echo -e "\033[31m[错误]\033[0m 下载失败，请检查网络或链接是否正确！"
    exit 1
fi

echo ">> 正在安全安装包..."
opkg update > /dev/null 2>&1
opkg install $TMP_FILE

# 赋予后端脚本执行权限
chmod +x /usr/libexec/rpcd/netwiz

echo ">> 正在清理缓存并重启服务..."
rm -f $TMP_FILE
rm -rf /tmp/luci-indexcache*
rm -rf /tmp/luci-modulecache/
/etc/init.d/rpcd restart

echo -e "\033[32m[安装完成!]\033[0m"
echo "请刷新路由器后台网页，在【系统】菜单下即可体验 NetWiz 网络向导。"