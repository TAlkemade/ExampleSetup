#!/bin/bash

# Collects artifact info from a file
# artifactinfo: groupId, artifactId, version [,packaging]

# Requirement Grep needs to include PCRE (Perl Compatible Regular Expressions)
# Lookbehind/lookforwards


# Configuration
fileName=BillOfMaterials.txt

# Put content of file into a string
fileString=$(cat ${fileName})

# Seperate artifactCollection
artifactCollection=${fileString#*<artifactCollection>}
artifactCollection=${artifactCollection%</artifactCollection>*}

# Count number of artifacts, here string used as file input
numArtifacts=$(grep -o "<artifact>" <<< ${artifactCollection} | wc -l)

# Obtain all seperate artifact-strings in array
infoStrings=()
for ((i=0;i<numArtifacts;i++));do
    infoStrings[i]=${artifactCollection#*<artifact>}
    infoStrings[i]=${infoStrings[i]%%</artifact>*}
    # Update collection
    artifactCollection=${artifactCollection#*</artifact>}
done

artifacts=()
components=(groupId artifactId version)
for ((i=0;i<1;i++));do
    infoStrings[i]=${infoStrings[i]#*<groupId>}
    artifacts[i]=${artifacts[i]}${infoStrings[i]%%</groupId>*}

    infoStrings[i]=${infoStrings[i]#*<artifactId>}
    artifacts[i]=${artifacts[i]}${infoStrings[i]%%</artifactId>*}

    infoStrings[i]=${infoStrings[i]#*<version>}
    artifacts[i]=${artifacts[i]}${infoStrings[i]%%</version>*}
done

echo ${artifacts[0]}

# echo ${artifactStrings[0]}
# echo next
# echo ${artifactStrings[1]}
# echo next2
# echo ${artifactStrings[@]}
# echo next3


#
# for a in ${artifacts[@]};do
#     echo "${a}"
#     echo next
# done



# # grep requires text to be on 1 line
# grep -oP '(?<=<artifact>).*(?=<\/artifact>)' ${tmpFile} > ${tmpArtFile}
#
# # groupId=$(grep -oP '(?<=<groupId>).*(?=<\/groupId>)' ${tmpArtFile})
# # artifactId=$(grep -oP '(?<=<artifactId>).*(?=<\/artifactId>)' ${tmpArtFile})
# # version=$(grep -oP '(?<=<version>).*(?=<\/version>)' ${tmpArtFile})
#
# artifact=$(cat ${tmpArtFile})
#
# # Alternative: Substring Removal from front and end
# groupId=${artifact#*<groupId>}
# groupId=${groupId%*</groupId>*}
#
# artifactId=${artifact#*<artifactId>}
# artifactId=${artifactId%*</artifactId>*}
#
# version=${artifact#*<version>}
# version=${version%*</version>*}
#
# echo ${groupId}
# echo ${artifactId}
# echo ${version}
#
# # clean
# rm ${tmpFile} ${tmpArtFile}
