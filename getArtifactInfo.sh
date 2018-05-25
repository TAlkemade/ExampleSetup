#!/bin/bash

# Collects artifact info from a file
# artifactinfo: groupId, artifactId, version [,packaging]

# Requirement Grep needs to include PCRE (Perl Compatible Regular Expressions)
# Lookbehind/lookforwards


#Configuration
file=BillOfMaterials.txt

tmpFile="__tmpINFO__.txt"
tmpArtFile="__tmpArtINFO__.txt"

# Replace new-lines with a space, and save in tmpFile
#perl -pe 's/\n/ /' < ${file} > ${tmpFile}
echo $(cat ${file}) > ${tmpFile}


# perl -pe 's/\n/ /' BillOfMaterials.txt #Remove newlines

#NOT SUFFICIENT: Matches pattern until next newline, matches greedy,
# sed -n '/<artifact>/,/<\/artifact>/p' BillOfMaterials.txt


# grep requires text to be on 1 line
grep -oP '(?<=<artifact>).*(?=<\/artifact>)' ${tmpFile} > ${tmpArtFile}

# groupId=$(grep -oP '(?<=<groupId>).*(?=<\/groupId>)' ${tmpArtFile})
# artifactId=$(grep -oP '(?<=<artifactId>).*(?=<\/artifactId>)' ${tmpArtFile})
# version=$(grep -oP '(?<=<version>).*(?=<\/version>)' ${tmpArtFile})

artifact=$(cat ${tmpArtFile})

# Alternative: Substring Removal from front and end
groupId=${artifact#*<groupId>}
groupId=${groupId%*</groupId>*}

artifactId=${artifact#*<artifactId>}
artifactId=${artifactId%*</artifactId>*}

version=${artifact#*<version>}
version=${version%*</version>*}

echo ${groupId}
echo ${artifactId}
echo ${version}

# clean
rm ${tmpFile} ${tmpArtFile}
