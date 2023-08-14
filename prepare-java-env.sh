#!/bin/bash

# Author : Shane Paulus
# Copyright (c) https://shanepaulus.co.za

echo "This script hass been designed to prepare a Java dev environment by doing the following:"
echo "  1. Download and extract Intellij Community Edition (Intellij is the BEST)."
echo "  2. Download and extract Gradle (latest)."
echo "  3. Download and extract Maven (latest)."
echo "Do you want to continue? (Y/n)"

# TODO: incorperate installing Java itself openjdk-17-jdk

read prompt

# Check if the input matches any of the specified conditions
if [ "$prompt" = "y" ] || [ "$prompt" = "Y" ] || [ "$prompt" = "" ] 
then
    # TODO: implement logic
fi