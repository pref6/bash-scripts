#!/usr/bin/env bash

function menuprincipal () {
clear
TIME=1
echo " "
echo $0
echo " "
echo "Выберите функцию ниже:

    1 - Проверить процессор
    2 - Проверить системное ядро
    3 - Проверить установленное ПО
    4 - Версия ОС
    5 - Проверить количество ОЗУ
    6 - Проверить серийный номер
    7 - Проверить IP системы
    0 - Выход"
echo " "
echo -n "Выберите опцию: "
read opcao
case $opcao in
    1)
        function processador () {
            CPU_INFO=`cat /proc/cpuinfo | grep -i "^model name" | cut -d ":" -f2 | sed -n '1p'`
            echo "Модель процессора: $CPU_INFO"
            sleep $TIME
        }   
        processador
        read -n 1 -p "<Enter> для главного меню"
        menuprincipal
        ;;

    2)
        function kernel () {
            #RED HAT: cat /etc/redhat-release
            KERNEL_VERSION_UBUNTU=`uname -r`
            KERNEL_VERSION_CENTOS=`uname -r`
            if [ -f /etc/lsb-release ]
            then
                echo "Версия ядра: $KERNEL_VERSION_UBUNTU"
            else
                echo "Версия ядра: $KERNEL_VERSION_CENTOS"
            fi
        }
        kernel
        read -n 1 -p "<Enter> для главного меню"
        menuprincipal
        ;;

    3)
        function softwares () {
            #while true; do
            TIME=3
            echo " "
            echo "Выберите опцию ниже для списка программ!
            
            1 - Список программ Ubuntu
            2 - Список программ Fedora
            3 - Установить программы
            4 - Назад к меню"
            echo " "
            echo -n "Выберите опцию: "
            read alternative
            case $alternative in
                1)
                    echo "Список всех программ в системе Ubuntu..."
                    sleep $TIME
                    dpkg -l > /tmp/programs.txt
                    echo "Программы перечислены и доступны в /tmp"
                    sleep $TIME
                    echo " "
                                        echo "Назад к меню!" | tr [a-z] [A-Z]
                    sleep $TIME
                    ;;
                2)
                    echo "Список всех программ в системе Fedora..."
                    sleep $TIME
                    yum list installed > /tmp/programs.txt
                    echo "Программы перечислены и доступны в /tmp"
                    sleep $TIME
                    ;;
                3)
                    echo "Установка программ..."
                    LIST_OF_APPS="pinta brasero gimp vlc inkscape blender filezilla"
                    #Используйте команду aptitude для циклов программ.
                    apt install aptitude -y
                    aptitude install -y $LIST_OF_APPS
                    ;;
                4)
                    echo "Назад к главному меню..."
                    sleep $TIME
                    ;;   
            esac
        #Завершение
        }       
        softwares
        menuprincipal
        ;;
    
    4)
        function sistema () {
            VERSION=`cat /etc/os-release | grep -i ^PRETTY`
            if [ -f /etc/os-release ]
            then
                echo "Версия системы: $VERSION"
            else
                echo "Система не поддерживается"
            fi
        }
        sistema
        read -n 1 -p "<Enter> для главного меню"
        menuprincipal
        ;;


    5)
        function memory () {
            MEMORY_FREE=`free -m  | grep ^Mem | tr -s ' ' | cut -d ' ' -f 4`
            #MEMORY_TOTAL=
            #MEMORY_USED=
            echo "Проверка памяти системы..."
            echo "Свободная память: $MEMORY_FREE"   
        }
        memory
        read -n 1 -p "<Enter> для главного меню"
        menuprincipal
        ;;

    6)
        function serial () {
            SERIAL_NUMBER=`dmidecode -t 1 | grep -i serial`
            echo $SERIAL_NUMBER
        }
        serial
        read -n 1 -p "<Enter> для главного меню"
        menuprincipal
        ;;

    7)
        function ip () {
            IP_SISTEMA=`hostname -I`
            echo "IP-адрес системы: $IP_SISTEMA"
        }
        ip
        read -n 1 -p "<Enter> для главного меню"
        menuprincipal
        ;;

    0) 
        echo "Выход из системы..."
        sleep $TIME
        exit 0
        ;;

    *)
        echo "Неверная опция, попробуйте снова!"
        ;;
esac
}
menuprincipal