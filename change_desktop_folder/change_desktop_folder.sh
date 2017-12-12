#!/bin/bash

# ubuntu 17 de yazdığım Masaüstü klasörünü değiştiren bash betiği
# 
# Masaüstü klasörünü değiştirdikten sonra eğer -nq parametresi eklenmezse
# mevcut oturumu sonlandırır

# kullanımı:
# ./desktop_changer [dizin_adı] [parametre]

# örnek kullanımlar

# dizini değiştir ve çıkış yap
# ./desktop_changer Çalışma_Dizinim

# dizini değiştir çıkış yapma
# ./desktop_changer Çalışma_Dizinim -nq


backup_dir="$HOME/.config/user-dirs_backup/"
backup_file="$backup_dir$(date --rfc-3339 second | tr ' :+' -)_user-dirs.dirs"
desktop_string="XDG_DESKTOP_DIR=\"\$HOME/$1\""
change_file="$HOME/.config/user-dirs.dirs"
old_file=${change_file}_

if [[ -z $1 ]];then
  echo "UYARI: Yetersiz argüman algılandı!"
  exit 1
fi

if [[ ! -d "$HOME/$1"  ]];then
	echo "UYARI: $1, $HOME'da bulunan bir dizin değil!"
	echo "Geçerli bir dizin giriniz!.."
	exit 1
fi

if [[ ! -d $backup_dir ]];then
  mkdir $backup_dir
  echo "backup klasörü ${backup_dir} olarak oluşturuldu!"
fi

if [[ ! $(cp $change_file $backup_file) ]];then
	echo "$change_file 'ın yedeği alındı!"
fi

mv $change_file $old_file

grep -v  ^XDG_DESKTOP_DIR $old_file  >$change_file

rm $old_file

echo $desktop_string >>$change_file


if [[ $2 != "-nq" ]];then
	echo 'Oturum sonlandırılıyor!'
	gnome-session-quit --logout --force
fi
