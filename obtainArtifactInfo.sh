#!/bin/bash

# Collects artifact info from a file
# artifactinfo: groupId, artifactId, version [,packaging]

# Requirement Grep needs to include PCRE (Perl Compatible Regular Expressions)
# Lookbehind/lookforwards


# Configuration
fileName=BillOfMaterials.txt
base="http://localhost:8081/repository/SAMPLE-REL"

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

# Obtain all infofields (groupId, artifactId, version) from artifacts
artifacts=()
for ((i=0;i<numArtifacts;i++));do
    infoStrings[i]=${infoStrings[i]#*<groupId>}
    artifacts[i]=${artifacts[i]}" "${infoStrings[i]%%</groupId>*}

    infoStrings[i]=${infoStrings[i]#*<artifactId>}
    artifacts[i]=${artifacts[i]}" "${infoStrings[i]%%</artifactId>*}

    infoStrings[i]=${infoStrings[i]#*<version>}
    artifacts[i]=${artifacts[i]}" "${infoStrings[i]%%</version>*}
done


for ((i=0;i<numArtifacts;i++));do
    info=${artifacts[i]}
    info=($info)
    groupId=${info[0]/.//}
    artifactId=${info[1]}
    version=${info[2]}

    repoURL="${base}/${groupId}/${artifactId}/${version}/${artifactId}-${version}.jar"
    # echo ${repoURL}
    curl -X GET -f ${repoURL} -O
done

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
