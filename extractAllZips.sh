#!/bin/bash

helpFunction(){
   echo ""
   echo "Usage: $0 -d directory "
   echo -e "\t-d Directory which include logs as zip. Each log must be a ZIP file."
   exit 1 # Exit script after printing help
}

while getopts "d:" opt
do
   case "$opt" in
      d ) directory="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$directory" ]
then
   echo "Please give a directory!!";
   helpFunction
fi

mkdir extracted_zips

for zip in ./"$directory"/*.zip; do
    zip_extension_removed=${zip::-4} #remove .zip
    onlyZipName=$(echo $zip_extension_removed | cut -d "/" -f3-) #remove ..../ part.
    mkdir extracted_zips/"$onlyZipName"

    echo "[+] extracted_zips/ $onlyZipName created!"
    echo "[!] extraction started..."

    unzip -q -o -B "$zip"  -d extracted_zips/"$onlyZipName" # -B: create new file with file-1, file-2 if it is exists. Ref: https://askubuntu.com/questions/929773/extracting-zip-from-terminal-with-renaming-when-filename-exists
    echo ""
    echo "[+] File opened to extracted_zips/$onlyZipName !!!"
    echo ""
    echo "----------------------------------------------------"
    done;
echo ""
echo "Extraction done."
