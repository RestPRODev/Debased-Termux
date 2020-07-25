# Debased FAQ
О Debased и прочее... <br>
# Что такое Debased?
 Debased - это прикладной образ системы linux для Termux, основанный на Debian 10.4 <br>
 Debased можно использовать как обычный Debian. Вам никто не мешает поставить все те-же пакеты что и на Debian  <br>
# Что и как установить?
 Для начала у вас должены быть установлены пакеты wget, proot <br>
 Установить их можно командой *$ apt install wget proot* <br>
 Дальше выполняем все команды по очереди <br>
 1. *$ wget https://raw.githubusercontent.com/RestPRODev/Debased-Termux/master/install.sh* <br>
 2. *$ bash ./install.sh* <br>
 После установки появятся файлы "remove.sh" и "start.sh" а так-же папки "binds" и "file-system" <br>
 "start.sh" - запускает образ Debased <br>
 "remove.sh" удаляет образ Debased <br>
 В папке "file-system" хранится файловая система Debased <br>
 Для запуска образа *$ bash ./start.sh* <br>
 Для удаление образа *$ bash ./remove.sh* <br>
# ВНИММАНИЕ: Поддерживаются только архитектуры ARM64 и ARMHF
