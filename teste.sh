#!/bin/bash
  

cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1

find lib/ -name *.dart -print0 | while read -d $'\0' file
do
        name="$(basename ${file})"
        grep -rn -F -q "${name}" lib/
        if [ $? -ne 0 ]
        then
                    if [ "$file" != "lib//main.dart" ]
                        then
                          echo "Unused file: ${file}"
                          rm "./$file"
                  fi
        fi
done