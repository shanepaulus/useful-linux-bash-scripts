#!/bin/bash

# Author : Shane Paulus
# Copyright (c) https://shanepaulus.uk

intellij_path="/opt/idea"
gradle_path="/opt/gradle"
maven_path="/opt/maven"

echo "This script has been designed to prepare a Java dev environment by doing the following:"
echo "  1. Download and extract Intellij Community Edition (Intellij is the BEST)."
echo "  2. Download and extract Gradle (latest)."
echo "  3. Download and extract Maven (latest)."
echo "Do you want to continue? (Y/n)"

# TODO: incorporate installing Java itself openjdk-17-jdk

read prompt

function ensure_directories_exists() {
    local path=$1
    
    if [ -d "$path" ]
    then
        echo "Path $path already exists. Removing contents..."
        sudo rm -rf $path/*
    else
        echo "The path $path does not exist!"
        echo "Creating the directory...."
        sudo mkdir $path
    fi
}

# Check if the input matches any of the specified conditions
if [ "$prompt" = "y" ] || [ "$prompt" = "Y" ] || [ "$prompt" = "" ] 
then
    ensure_directories_exists $intellij_path
    ensure_directories_exists $gradle_path
    ensure_directories_exists $maven_path

    # Download Intellij
    sleep 0.500
    echo "Downloading Intellij....."
    curl -o idea.tar.gz -L "https://download.jetbrains.com/idea/ideaIC-2024.1.3.tar.gz"
    sudo tar -xvzf idea.tar.gz -C $intellij_path
    sudo mv -f $intellij_path/idea*/* $intellij_path
    sudo rm -rf $intellij_path/idea*

    # Download Gradle
    sleep 0.500
    echo "Downloading Gradle....."
    curl -o gradle.zip -L "https://services.gradle.org/distributions/gradle-8.2.1-bin.zip"
    sudo unzip gradle.zip -d $gradle_path
    sudo mv -f $gradle_path/gradle*/* $gradle_path
    sudo rm -rf $gradle_path/gradle*

    # Download Maven
    sleep 0.500
    echo "Downloading Maven....."
    curl -o maven.tar.gz -L "https://dlcdn.apache.org/maven/maven-3/3.9.4/binaries/apache-maven-3.9.4-bin.tar.gz"
    sudo tar -xvzf maven.tar.gz -C $maven_path
    sudo mv -f $maven_path/apache-maven*/* $maven_path
    sudo rm -rf $maven_path/apache-maven*



    # Write ENV variables to the environment file
    if ! grep -q "^GRADLE_HOME=" /etc/environment; 
    then
        echo 'GRADLE_HOME="/opt/gradle/bin"' | sudo tee -a /etc/environment >/dev/null
    fi

    if ! grep -q "^MAVEN_HOME=" /etc/environment; 
    then
        echo 'MAVEN_HOME="/opt/maven/bin"' | sudo tee -a /etc/environment >/dev/null
    fi

    if ! grep -q "PATH=\$PATH:\$GRADLE_HOME:\$MAVEN_HOME" /etc/environment; 
    then
        echo 'PATH=$PATH:$GRADLE_HOME:$MAVEN_HOME' | sudo tee -a /etc/environment >/dev/null
    fi

    source /etc/environment

    # Clean downloaded files and folders...
    rm -rf idea*
    rm -rf gradle*
    rm -rf maven*

    echo "Doing a version check on installed tools...."
    gradle -v
    mvn --version

    echo "Launching Intellij...."

    $intellij_path/bin/idea.sh
fi


