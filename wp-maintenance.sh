#  WORDPRESS MAINTENANCE CONTROL SCRIPT  #

path="/var/www/wp"   #set this to your the root directory of your wordpress installation
#make sure there is no / at the end

#  DO NOT CHANGE ANYTHING BELOW UNLESS YOU KNOW WHAT YOU ARE DOING  #

usage() {
    echo "-h or --help           show this help";
    echo "-e or --enable         enable wordpress maintenance mode";
    echo "-d or --disable        disable wordpress maintenance mode";
  exit
}

enable() {
  if [ -f "$path/wp-login.php" ]; then
   if [ -f "$path/.maintenance" ]; then
    echo "Wordpress seems to be in maintenance mode already!"
   else
    echo "<?php \$upgrading = time(); ?>">"$path/.maintenance"
    echo "I turned on wordpress maintenance mode."
   fi
  else
   echo "Could not detect your wordpress installation plase check if your path is correct."
  fi
}

disable() {
  if [ -f "$path/wp-login.php" ]; then
   if [ -f "$path/.maintenance" ]; then
    rm "$path/.maintenance"
    echo "I turned off wordpress maintenance mode."
   else
    echo "Maintenance mode seems to be disabled already!"
   fi
  else
   echo "Could not detect your wordpress installation plase check if your path is correct."
  fi
}


if [ $# -eq 0 ]; then
    usage
fi

while true
do
    case "$1" in
        -e|--enable) enable;;
        -d|--disable) disable;;
        -h|--help)
            usage
            exit;;
        --)
            shift
            break;;
        *)
          exit ;;
    esac
    shift
done
