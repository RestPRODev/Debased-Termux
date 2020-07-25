#!/data/data/com.termux/files/usr/bin/bashx
BOLD='\033[1m'
RED='\033[0;31m' 
LRED='\033[1;31m'
WHITE='\033[1;37m' 
GRAY='\033[0;37m'
YELLOW='\033[1;33m'
BGRED='\033[41m' 
N='\033[0m' 

folder=file-system
if [ -d "$folder" ]; then
	first=1
	echo -en "${LRED}[${BOLD}${WHITE}Debased-Termux${LRED}]${GRAY}: ${WHITE}Пропуск... \n"
fi
tarball="debian-file-system.tar.xz"
if [ "$first" != 1 ];then
	if [ ! -f $tarball ]; then
		echo -en "${LRED}[${BOLD}${WHITE}Debased-Termux${LRED}]${GRAY}: ${WHITE}Загрузка файловой системы... \n"
		case `dpkg --print-architecture` in
		aarch64)
			archurl="arm64" ; arc1="arm64" ;;
	
		arm)
			archurl="armhf" ; arc1="armhf" ;;
	
		*)
		echo -en "${LRED}[${BOLD}${WHITE}Debased-Termux${LRED}]${GRAY}: ${BGRED}${WHITE}Ваша архитектура не поддерживается ${N}\n"
		esac
		wget "https://github.com/RestPRODev/Debased-Termux/raw/master/${arc1}/debased-${archurl}.tar.xz" -O $tarball
	fi
	cur=`pwd`
	mkdir -p "$folder"
	cd "$folder"
	echo -en "${LRED}[${BOLD}${WHITE}Debased-Termux${LRED}]${GRAY}: ${WHITE}Распаковка файловой системы... \n"
	echo -en "${LRED}[${BOLD}${WHITE}Debased-Termux${LRED}]${GRAY}: ${WHITE}Установка... \n"
	proot --link2symlink tar -xJf ${cur}/${tarball}||:
	cd "$cur"
fi
mkdir -p binds
bin=start.sh
cat > $bin <<- EOM
#!/bin/bash
BOLD='\033[1m'
RED='\033[0;31m' 
LRED='\033[1;31m'
WHITE='\033[1;37m' 
GRAY='\033[0;37m'
YELLOW='\033[1;33m'
BGRED='\033[41m' 
N='\033[0m' 
cd \$(dirname \$0)
## unset LD_PRELOAD in case termux-exec is installed
unset LD_PRELOAD
command="proot"
command+=" --link2symlink"
command+=" -0"
command+=" -r $folder"
if [ -n "\$(ls -A binds)" ]; then
    for f in binds/* ;do
      . \$f
    done
fi
command+=" -b /dev"
command+=" -b /proc"
command+=" -b file-system/root:/dev/shm"
command+=" -b /sdcard"
command+=" -w /root"
command+=" /usr/bin/env -i"
command+=" HOME=/root"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" TERM=\$TERM"
command+=" LANG=C.UTF-8"
command+=" /bin/bash --login"
com="\${BGGREEN}$@"
if [ -z "\$1" ];then
    exec \$command
else
    \$command -c "\$com"
fi
EOM
bin2=remove.sh
cat > $bin2 <<-EOM
#!/bin/bash
BOLD='\033[1m'
RED='\033[0;31m' 
LRED='\033[1;31m'
WHITE='\033[1;37m' 
GRAY='\033[0;37m'
YELLOW='\033[1;33m'
BGRED='\033[41m' 
BGGREEN='\033[42m'
N='\033[0m' 
echo -en "${LRED}[${BOLD}${WHITE}Debased-Termux${LRED}]${GRAY}: ${WHITE}Удаление Termux-Debian... ${N}\n"
echo -en "${LRED}[${BOLD}${WHITE}Debased-Termux${LRED}]${GRAY}: ${YELLOW}Будут удалены все данные которые вы записывали на Debased \n"
rm -r debian-binds
echo -en "${LRED}[${BOLD}${WHITE}Debased-Termux${LRED}]${GRAY}: ${WHITE}Удаление файловой системы... \n"
rm -r file-system
echo -en "${LRED}[${BOLD}${WHITE}Debased-Termux${LRED}]${GRAY}: ${WHITE}Удаление установочных файлов... \n"
rm install.sh
rm start.sh
rm remove.sh
echo -en "${LRED}[${BOLD}${WHITE}Debased-Termux${LRED}]${GRAY}: ${LRED}Удалено! ${N}\n"
EOM

termux-fix-shebang $bin
chmod +x $bin
rm $tarball
echo -en "${LRED}[${BOLD}${WHITE}Debased-Termux${LRED}]${GRAY}: ${WHITE}Установлено! \n"
