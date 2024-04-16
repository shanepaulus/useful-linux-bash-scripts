#!/bin/sh

# Author : Shane Paulus
# Copyright (c) https://shanepaulus.uk

FileName=~/.ssh/config
echo "This script is executed to modify the file $FileName file by adding known hosts."
echo "What is does is add ease of convenience - you no longer have to execute 'ssh user@host'.."
echo "Do you want to continue? (Y/n)"
read ContinuePrompt

if [[ "$ContinuePrompt" == "y" || "$ContinuePrompt" == "Y" ||  "$ContinuePrompt" == "" ]]
then
    echo "I really hope you know what you're doing..!"
    echo "Checking if file '$FileName' exists..."
    sleep 0.500   #This is happening waaay too fast

    if [ -f $FileName ]
    then
        echo "File found. Appending to the file!"
    else
        echo "File not found. Creating new file..."
        sleep 0.500
        touch $FileName
    fi

    HostName=""

    while [[ "$HostName" != "X" && "$HostName" != "x" ]]
    do
        echo "Please enter the hostname you would like assign an ip address to (Or X to to quit):"
        read HostName
        sleep 0.500

        if [[ "$HostName" == "X" || "$HostName" == "x" ]]
        then
            break
        else 
            echo "Please assign the ip address to map to host '$HostName':"
            read IpAddress
            sleep 0.500

            echo "Please enter the username to connect to '$HostName':"
            read User

            echo "Assigning user $User connect to host '$HostName' on ip $IpAddress..."
            sleep 0.500

            ServerConfig="Host $HostName\n    HostName $IpAddress\n    User $User"
            echo -e "$ServerConfig" >> $FileName
        fi
    done
fi

echo "Goodbye..."