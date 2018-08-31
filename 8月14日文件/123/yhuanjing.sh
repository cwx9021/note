#!/bin/bash
#设置开机启动服务
systemctl enable  chronyd
systemctl enable  NetworkManager
systemctl enable  sshd
systemctl enable  firewalld

echo "    "
echo "    "
echo "    "
for i in {1..5}
do
    echo "|+|"
done
echo "    "
echo "    "
echo "    "

echo "配置主机名"
sleep 2
#获取编号
read -p "请输入您所在的教室ID号[0-99]:" ID
read -p "请输入您所坐的机位号 [01-99]:" PID

#进行修改
echo "正在更改计算机名，请稍等...."
chattr -i /etc/sysconfig/network
hostnamectl set-hostname room"$ID"pc"$PID"
echo "NETWORKING=yes" > /etc/sysconfig/network
echo "HOSTNAME=room"$ID"pc"$PID"" >> /etc/sysconfig/network
chattr +i /etc/sysconfig/network
chattr -i /etc/hostname
echo "room"$ID"pc"$PID".tedu.cn" > /etc/hostname
chattr +i /etc/hostname
sleep  0.5
echo "计算机名已更改成功！YES！！"

echo "    "
echo "    "
echo "    "
for i in {1..5}
do
    echo "|+|"
done
echo "    "
echo "    "
echo "    "

echo "锁定开机自动检测脚本"
sleep 2
chattr +i /etc/bashrc
chattr +i /etc/profile
chattr +i /var/lib/libvirt/images/iso/*

echo "    "
echo "    "
echo "    "
for i in {1..5}
do
    echo "|+|"
done
echo "    "
echo "    "
echo "    "

echo "修改远程端口"
sleep 2
sed -i '16s/#/Port 7920/'  /etc/ssh/sshd_config
systemctl restart sshd


echo "    "
echo "    "
echo "    "
for i in {1..5}
do
    echo "|+|"
done
echo "    "
echo "    "
echo "    "

echo "设置安全防护!!!"
sleep 2

systemctl start firewalld
read -p "请输入当前课室的网段编号[十一教即 211]" IPD
firewall-cmd  --set-default-zone=trusted
for abc in 201 202 203 204 205 206 207 208 209 210 211 212 213 
do
    if [ $abc -eq $IPD ];then
        continue 
    else
        firewall-cmd  --add-source=176.121.$abc.0/24 --permanent  --zone=block
    fi
done

firewall-cmd  --reload


echo "    "
echo "    "
echo "    "
for i in {1..5}
do
    echo "|+|"
done
echo "    "
echo "    "
echo "    "
sleep 2
echo "配置桌面环境"
wget ftp://176.121.0.120/software/tedu-wallpaper-2018.png
cp tedu-wallpaper-2018.png  /var/lib/libvirt/images/
rm -rf tedu-wallpaper-2018.png
rm -rf /usr/share/backgrounds/tedu-wallpaper-01.png
ln -s /var/lib/libvirt/images/tedu-wallpaper-2018.png  /usr/share/backgrounds/tedu-wallpaper-01.png


echo "    "
echo "    "
echo "    "
for i in {1..5}
do
    echo "|+|"
done
echo "    "
echo "    "
echo "    "
sleep 2
echo "配置rhce环境"
rm -rf /content
cp -r /var/lib/libvirt/images/content   /
wget ftp://176.121.0.120/software/software/lab2.tar.gz
wget ftp://176.121.0.120/software/software/rht-labcheck.tar.gz
tar xvPf rht-labcheck.tar.gz
tar xvPf lab2.tar.gz
sleep 2
rm -rf lab2.tar.gz
rm -rf rht-labcheck.tar.gz

echo "    "
echo "    "
echo "    "
for i in {1..5}
do
    echo "|+|"
done
echo "    "
echo "    "
echo "    "
sleep 2
shutdown -r +1 "系统将在一分钟后重启，请不要做任何操作！！" &
rm -rf yhuanjing.sh



