#!/bin/bash
# 0.1.0
clear

function help() {
    echo -e "$1\nBye"
    exit
}

function badChoice() {
    clear
    MSG="Invalid Selection ... Please Try Again" ;
}

function chooseDrupalVersion() {
    echo
    echo
    echo "Version de Drupal disponibles : "
    echo "|"
    for var in "${VERSION[@]}"; do
        echo "|- Drupal" $var " : [" $var "]"
    done
    echo
    echo "Quit : [exit]"
    echo
    echo -n $MSG
    echo
    echo
}


echo
echo "#################### Script ############################"
echo "#            Deploy drupal website                     #"
echo "########################################################"

LOGO="Drupal rec Deployment"
VERSION=("6" "7.10" "7.26")
DEFAULT_VERSION=7.26
MSG=

while [[ true ]]; do
    chooseDrupalVersion
    read -e -p "Choississez la version de Drupal [ $DEFAULT_VERSION ]: " -i $DEFAULT_VERSION answer
    MSG=
    case $answer in
        "6")
            BASE_PATH='/var/www/html/drupal/drupal6/sites'
            A_LINK_TO_THE_PATH='.'
            break
            ;;
        "7.10")
            BASE_PATH='/var/www/html/drupal/drupal710/sites'
            A_LINK_TO_THE_PATH='.'
            break
            ;;
        "7.26")
            BASE_PATH='/var/www/html/drupal/drupal726/sites'
            A_LINK_TO_THE_PATH='.'
            break
            ;;
        "exit")
            exit
            ;;
        *) badChoice;;
    esac
done

echo -n "Entrez le nom du site: "
sitename=
while [[ $sitename = "" ]]; do
   read sitename
done

# check if source directory is a directory
if [[ ! -d "$BASE_PATH/$sitename" ]]; then
    printf >&2 "%s n'est pas un répertoire!\n" "$BASE_PATH/$sitename"
    exit
fi

# check if target directory is a symlink
if [[ ! -h "$BASE_PATH/default" ]]; then
    if [[ -e "$BASE_PATH/default" ]]; then
        printf >&2 "%s n'est pas un lien symbolique!\n" "$BASE_PATH/default"
        exit
    fi
else
    printf >&2 "Suppression du lien symbolique\n" "$BASE_PATH/default"
    rm -f "$BASE_PATH/default"
fi

# a_link_to_the_path is a hook
cd $BASE_PATH
ln -s "$A_LINK_TO_THE_PATH/$sitename" "$A_LINK_TO_THE_PATH/default"
cd -
echo "OK!"

