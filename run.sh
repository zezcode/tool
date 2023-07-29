red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}
blue(){
    echo -e "\033[34m\033[01m$1\033[0m"
}
purple(){
    echo -e "\033[35m\033[01m$1\033[0m"
}

# cài đặt aapanel quốc tế
function aapanelgoc(){
yum install -y wget && wget -O install.sh http://www.aapanel.com/script/install_6.0_en.sh && bash install.sh aapanel
red "Đã cài đặt thành công aaPanel"
}

# cài đặt bản aapanel bản tàu khựa
function aapanelTQ(){  
yum install -y wget && wget -O install.sh http://download.bt.cn/install/install_6.0.sh && sh install.sh
red "Đã cài đặt aaPanel bản Trung thành công"
}

# bẻ khoá aapanel bản hiện tại
function panelcrack(){  
bash <(curl -Ls https://raw.githubusercontent.com/ht4g/tool/main/crack.sh)
red "Đã crack aaPanel xong, vui lòng login lại aaPanel"
}
# mở chặn speedtest
function unspeedtest(){
iptables -F && clear && echo "Đã mở khoá speedtest !"
cd /etc/iptables
rm rules.v4 rules.v6
}



# gỡ cài đặt aapanel
function uninstall(){
service bt stop && chkconfig --del bt && rm -f /etc/init.d/bt && rm -rf /www/server/panel
red "Gỡ cài đặt hoàn tất"
}

# giới hạn tốc độ băng thông
function limit(){
sudo apt-get update
sudo apt-get install iproute2
sudo tc qdisc add dev eth0 root tbf rate 100mbit burst 128kbit latency 200ms
green "Thiết lập giới hạn tốc độ băng thông (100Mbps) thành công!"
}
# xóa giới hạn tốc độ băng thông
function unlimit(){
sudo tc qdisc del dev eth0 root
green "Xóa giới hạn tốc độ băng thông thành công!"
}
# chặn speedtest
function blockspeed(){
bash <(curl -Ls https://raw.githubusercontent.com/ht4g/tool/main/blockspt.sh)
}

function hacap(){
wget -O "/root/LinuxPanel_EN-6.8.23.zip" "https://github.com/AZZ-vopp/code-/raw/main/LinuxPanel_EN-6.8.23.zip"
blue "Đang tải tệp zip."
unzip LinuxPanel_EN-6.8.23.zip
cd /root/panel
wget -O "/root/panel/confhacap.sh" "https://raw.githubusercontent.com/AZZ-vopp/code-/main/confhacap.sh" 
bash "/root/panel/confhacap.sh"
red "Hạ cấp hoàn tất"
rm /root/LinuxPanel_EN-6.8.23.zip /root/panel/ -rf
}
function speedtest(){
curl -Lso- bench.sh | bash
}



# menu
function start_menu(){
    clear
    purple " Chào mừng bạn đến với tool HT4GVPN."
    yellow " ————————————————————————————————————————————————"
    green " 1. Giới hạn tốc độ băng thông (100Mbps)"
    green " 2. Xóa giới hạn tốc độ băng thông"
    green " 3. Speedtest"
    green " 4. Chặn Speedtest"
    green " 5. Mở khoá chặn Speedtest"
    yellow " ————————————————————————————————————————————————"
    green " 6. Cài đặt aaPanel bản gốc (cho CentOS)"
    green " 7. Crack bản aaPanel hiện tại (Ưu tiên cài mới) "
    green " 8. Hạ cấp xuống bản ổn định 6.8.23 (Một số chỗ tiếng Trung)"   
    green " 9. Cài đặt aaPanel bản Trung (Cho CentOS)"
    yellow " ————————————————————————————————————————————————"
    green " 10. Gỡ cài đặt bản aaPanel hiện tại"
    green " 0. Thoát giao diện tool"

    echo
    read -p "Vui lòng chọn chức năng:" menuNumberInput
    case "$menuNumberInput" in
        1 )
           limit
	    ;;
        2 )
           unlimit
        ;;
        3 )
           speedtest
        ;;
        4 )
           blockspeed
        ;;
        5 )
           unspeedtest
        ;;
        6 )
           aapanelgoc
        ;;
        7 )
           panelcrack
        ;;
        8 )
           hacap
        ;;
        9 )
           aapanelTQ
        ;;
	    10 )
           uninstall
        ;;
        0 )
            exit 1
        ;;
        * )
            clear
            red "Vui lòng nhập đúng số"
            start_menu
        ;;
    esac
}
start_menu "first"
