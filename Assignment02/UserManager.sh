#!/bin/bash

case "$1" in
	"addTeam")
		grp=$2
		sudo groupadd "${grp}" && echo "Team ${grp} added." || echo "Failed to add team."
		;;
        "addUser")
                usr=$2
                grp=$3
                sudo useradd -m "${usr}" -g "${grp}" -s /bin/bash && sudo chmod -R 751 /home/"${usr}" && echo "User ${usr} added." || echo "Failed to add user."
                ;;
        "changeShell")
		shell=$2
                usr=$3
		sudo usermod -s "${shell}" "${usr}" && echo "shell changed" || echo "shell not changed"
                #sudo chsh /bin/bash -s "$2" && echo "Shell changed for user $2." || echo "Failed to change shell."
                ;;
        "changePasswd")
                sudo passwd "$2" && echo "Password changed for user $2." || echo "Failed to change password."
                ;;
        "delUser")
                sudo userdel -r "$2" && echo "User $2 deleted." || echo "Failed to delete user."
                ;;
        "delTeam")
                sudo groupdel "$2" && echo "Team $2 deleted." || echo "Failed to delete team."
                ;;
        "lsUser")
                sudo getent passwd | cut -d: -f1
                ;;
        "lsTeam")
                sudo getent group | cut -d: -f1
                ;;
        "addgroup")
		#add directories in /et/skel for when we create a user automatically those directories will be assigned to that user
		grp_name=$2
                sudo mkdir /etc/skel/${grp_name} && echo "groupadd is done" || echo "groupadd not done"
                ;;
        *)
                echo "Usage: $0 {addTeam|addUser|changeShell|changePasswd|delUser|delTeam|lsUser|lsTeam|addgroup} <arguments>"
                ;;
esac
