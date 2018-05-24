#!/bin/bash

# Usage ./collectNexus groupId artifactId version [packaging]
# Example: ./collectNexus com.amis project 1.0.0 .jar

# Collects given Artifact from NexusRepo

#RepoURL is of form {repoBaseURL}/${groupId}/${artifactId}/${version}/${artifactId}-${version}${packaging}

base=http://localhost:8081/repository/SAMPLE-REL

# Replace . with / for directory structure
groupId=${1/.//}
artifactId=${2}
version=${3}
packaging=${4}

# Assign default value packaging=.jar if empty
if [ $packaging -n ];then
	packaging=".jar"
fi

repoURL="${base}/${groupId}/${artifactId}/${version}/${artifactId}-${version}${packaging}"

echo ${repoURL}
