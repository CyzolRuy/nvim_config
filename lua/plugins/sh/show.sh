#using to add gif in alpha-nvim

#!/bin/bash

filename=$1 

temp_line=""
output_array=()

while IFS= read -r line
do
  if [ "$line" == "" ] 
  then
    output_array+=("$temp_line")
    temp_line=""
  else
    temp_line+="$line"
    temp_line+="\n"
  fi
done < "$filename"

if [ ${#output_array[@]} -eq 0 ];
then
  exit 0
fi

while true; do
  for frame in "${output_array[@]}" 
  do
      clear
      echo -e "$frame"
      sleep 0.05
  done
done
