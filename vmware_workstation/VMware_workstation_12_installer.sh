#!/bin/bash
# bu script parametre olarak aldığı, daha önceden indirilmiş vmware...bundle
# dosyasını kurmaya yardımcı olası iin yazılmıştır

echo "Gcc ve build-essential kuruluyor..."
sudo apt-get install gcc build-essential

echo "Yetkilendirme ayarlanıyor..."
sudo chmod 750 $1

echo "VMware kurulumu için arayüz başlatılıyor..."
sudo $1
