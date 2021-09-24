PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
install_tmp='/tmp/bt_install.pl'
public_file=/tmp/public.sh

if [ ! -f $public_file ];then
        wget -O $public_file http://download.bt.cn/install/public.sh -T 5;
fi

. $public_file
download_Url=$NODE_URL
# 此脚本会自动在服务器上安装防火墙、任务管理器、基线扫描等插件（改插件名称就可以）
plugins=("btwaf" "task_manager" "san_security" "bt_security" "resource_manager" "syssafe")
for ((i=0;i<$#plugins[@];i++))
do
    cd /tmp
    plugin_download_url="${download_Url}/install/plugin/${plugins[i]}/install.sh"
    echo $plugin_download_url
    wget -O "${plugins[i]}_install.sh" $plugin_download_url
    sh "${plugins[i]}_install.sh" install
    rm -rf "${plugins[i]}_install.sh"
done
