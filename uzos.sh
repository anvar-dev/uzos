#!/bin/bash
cd "$(dirname "$0")"


#    ______                                __           __
#   / ____/__  ____  ___  ____ ___  ____ _/ /____  ____/ /
#  / / __/ _ \/ __ \/ _ \/ __ `__ \/ __ `/ __/ _ \/ __  /
# / /_/ /  __/ / / /  __/ / / / / / /_/ / /_/  __/ /_/ /
# \____/\___/_/ /_/\___/_/ /_/ /_/\__,_/\__/\___/\__,_/
#
# Copyright to Genemator @genemator | @genemators

ok=`tput setaf 2`
warning=`tput setaf 1`
reset=`tput sgr0`

logom() {
    LOGO="
-----------------------------------------------
                    UZOS
-----------------------------------------------
Improve the Linux alongside Uzbek developers...    
"
    printf "${ok}$LOGO${reset}\n\n"
}

gitm() {

    # Why not logo?
    logom

    # Get all updates from the cloud
    printf "${warning}Fetching up all updates... ${reset}\n"
    git pull
    printf "\n"

    # Add up all files to a commit
    printf "${warning}Adding all files to commit... ${reset}\n"
    git add --all .
    printf "\n"

    # Assigning a commit message
    printf "${warning}Type a commit message here: ${reset}"
    read input
    printf "\n"
    
    # Commiting...
    printf "${warning}Ok, now let's apply this to a commit... ${reset}\n"
    git commit -m "$input"
    printf "\n"

    # Pushing all updates to the cloud
    printf "${warning}Uploading all changes to the cloud ${reset}\n"
    git push -u origin master
    printf "\n"

    # Program is finally happy
    printf "${warning}Job is done!${reset}"
    exit 0
}

cleanm() {

    # Why not logo?
    logom

    printf "${warning}Deleting the worker directory ... ${reset}\n"
    rm -rf ./work
    printf "\n"

    printf "${warning}Deleting the compiled sources ... ${reset}\n"
    rm -rf ./out
    printf "\n"

    exit 0
}

helpm() {

    # Why not logo?
    logom

    # Defining the guide message
    USAGE="
usage: ./uzos.sh [ git | clean | build ]
        
        git         Automates all tasks of git
                    source version control system
        clean       This script should be run in
                    monthly intercel. This script cleans
                    caches of unnesecarry git garbages
        build       build the linux to iso productive
                    format to get a release
    "

    # Let's print the message now
    printf "${ok}$USAGE${reset}"
    exit 0
}

buildm() {

    if ! [ $(id -u) = 0 ]; then
        printf "\n${warning}The script need to be run as root.${reset}\n" >&2
        exit 1
    fi

    # Building the iso output
    printf "\n${warning}Starting the build phase to 'ISO' format ... ${reset}\n"
    mkarchiso -v ./uzos

    # Job is done
    printf "\n${warning}Program has successfully finished its job! ${reset}\n"
    exit 0
}

# If user does not pass some argument, get some help =)
if [ $# -eq 0 ]
then
    helpm
fi

# The place where I capture all arguments
# Execution of all initialized functions
while [ $# -gt 0 ]
do
    key="$1"
    
    case $key in

        # The git case
        git)
            gitm
            break
            ;;

        # Build the iso
        build)
            buildm
            break
            ;;
    
        # The cleaning phase
        clean)
            cleanm
            break
            ;;
    
        # Any exceptional keys
        *)
            helpm
            break
            ;;
    
    esac

done
unset key
