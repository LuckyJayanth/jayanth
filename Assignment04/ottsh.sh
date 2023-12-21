#!/bin/bash

operation=$1
# Adding the connection
function add() {
# now we set the optional parametres if not provided
port=${port:-22}
#now we check the if any parametre is required
if [ -z "${name}" ] || [ -z "${host}" ] || [ -z "${user}" ];
then
	echo "have to give(name,host,name)"
fi
# adding connection to the ssh config file
echo "Host ${name}">>~/.ssh/config
echo "      HostName ${host}">>~/.ssh/config
echo "      User ${user}">>~/.ssh/config
echo "      Port ${port}">>~/.ssh/config
}
#List ssh connection
list() {
	awk '/^host/{print $2}' ~/.ssh/config
}
#updating the ssh connection
function update() {
# now we set the optional parametres if not provided
port=${port:-22}
#now we check the if any parametre is required
if [ -z "${name}" ] || [ -z "${host}" ] || [ -	z "${user}" ];
then
     echo "have to give(name,host,user)"
exit 1
fi
# Check if the connection already exists
    if grep -q "^Host ${name}$" ~/.ssh/config;
    then
        # Update the connection in ~/.ssh/config
        sed -i "/^Host ${name}\$/,/^$/d" ~/.ssh/config
        echo "Host ${name}" >> ~/.ssh/config
        echo "    HostName ${host}" >> ~/.ssh/config
        echo "    User ${user}" >> ~/.ssh/config
        echo "    Port ${port}" >> ~/.ssh/config
        # Add the key file if provided
        if [ -n "${keyFile}" ];
       	then
            echo "IdentityFile ${keyFile}" >> ~/.ssh/config
        fi
        echo "SSH connection ${name} is updated."
	exit 0
    else
        echo "error !!! Server ${name} does not exist. Use 'add' to create a new connection."
        add
        echo "SSH connection ${name} is added."
        exit 1
    fi
}
list() {
        awk '/^Host/{print $2}' ~/.ssh/config
}
detailed() {
config_file=~/.ssh/config
# Check if the config file exists
if [ ! -e "$config_file" ]; then
    echo "Config file $config_file not found."
    exit 1
fi
# Iterate through each host entry in the config file
while IFS= read -r line; do
    if [[ $line == Host* ]]; then
        host_name=$(echo "$line" | awk '{print $2}')
        server_info=$(awk "/^Host $host_name$/,/^$/ && (/^HostName |^User |^Port |^IdentityFile /) {sub(/^[[:space:]]+/, \"\", \$2); printf \"%s \", \$2}" "$config_file")
        server_id=$(echo $server_info | awk '{print $1}')
        host_ip=$(echo $server_info | awk '{print $2}')
        user_name=$(echo $server_info | awk '{print $3}')
        port_no=$(echo $server_info | awk '{print $4}')
        key=$(echo $server_info | awk '{print $5}')
        echo "Host: $host_name"
        echo "  SSH Command: ssh -p ${port_no} ${user_name}@${host_ip}"
        echo "------------------------------------------------------"
    fi
done < "$config_file"
}
while getopts "aUn:h:u:p:i:" opt;
do
	case $opt in
		a)
			action="add"
                        ;;
                U)
                        action="update"
                        ;;
                n)
                        name=$OPTARG
                        ;;
                u)
                        user=$OPTARG
                        ;;
                p)
                        port=$OPTARG
                        ;;
                i)
                        sshkey=$OPTARG
                        ;;
                h)
                        host=$OPTARG
                        ;;
                ?)
			echo "what is $optarg"
                        ;;
	esac
done
if [ "${action}" == "add" ];
then
	add
elif [ "${action}" == "update" ];
then
	update
fi
if [ "${operation}" == "ls" ];
then
	detailed=$2
	if [ "${detailed}" == "-d" ];
	then
		detailed
	else
		awk '/^Host / {print $2}' ~/.ssh/config
	fi
fi
#deleting ssh connection
remove() {
   sed -i "/^$name:/d" ~/.ssh/config
}
if [ ${operation} == "rm" ];
then
	remove
fi
function connectToServer() {
	serverName=$1
    # Check if the server name is provided
    if [ -z "${serverName}" ];
    then
	    echo "Missing server name for connection."
	    exit 1
    fi
    # Check if the server information is available
    if grep -q "^Host ${serverName}$" ~/.ssh/config;
    then
	    echo "Connecting to ${serverName} "
	    ssh ${serverName}
    else
	    echo "[ERROR]: Server information is not available, please add the server first."
	    exit 1
    fi
}

