#!/bin/zsh

script_dir=$(dirname ${0:A})
projectfolder=$(dirname $script_dir)

help () {
  echo "usage: assemble.sh [-s] --separate"
  echo 
  echo "builds separate CIS Benchmark Script from the fragements."
  exit
}

buildScript () {
    # destination
    endPath=${projectfolder}/Build
    mkdir -p ${endPath}
    endResult=${endPath}/CISBenchmarkScript.sh

    # add shebang
    echo "#!/bin/zsh" > ${endResult}
    echo >> ${endResult}

    # add version and date
    version=$(cat "${projectfolder}/Fragments/Version.sh")
    versiondate=$(date +%F) 
    echo "VERSION=\"$version\"" >> ${endResult}
    echo "VERSIONDATE=\"$versiondate\"" >> ${endResult}
    echo >> ${endResult}

    # add header
    cat ${projectfolder}/Fragments/Header.sh >> ${endResult}

    # loop over fragments
    for filePath in ${projectfolder}/Fragments/OrgScores/OrgScore*.sh; do

        # fragment name
        fileName=$(basename ${filePath})
        echo "Add ${fileName} to script"

        # add script
        tail -n +7 ${filePath} >> ${endResult}
        echo >> ${endResult}

    done

    # add footer
    cat ${projectfolder}/Fragments/Footer.sh >> ${endResult}

    # make script executable
    chmod +x ${endResult}
}

# build seperate Scripts
buildSeperateScript () {
    # loop over fragments
    for filePath in ${projectfolder}/Fragments/OrgScores/OrgScore*.sh; do

        # fragment name
        fileName=$(basename ${filePath})

        # destination
        endPath=${projectfolder}/Build/Scripts
        mkdir -p ${endPath}
        endResult="${endPath}/${fileName}"

        # add shebang
        echo "#!/bin/zsh" > ${endResult}
        echo >> ${endResult}

        # add version and date
        version=$(cat "${projectfolder}/Fragments/Version.sh")
        versiondate=$(date +%F)
        echo "VERSION=\"$version\"" >> ${endResult}
        echo "VERSIONDATE=\"$versiondate\"" >> ${endResult}
        echo >> ${endResult}

        # add header
        cat ${projectfolder}/Fragments/Header.sh >> ${endResult}
        
        # add script
        tail -n +7 ${filePath} >> ${endResult}
        echo >> ${endResult}

        # add footer
        cat ${projectfolder}/Fragments/Footer.sh >> ${endResult}
        
        # make script executable
        chmod +x ${endResult}

        echo "${fileName} created"
    done
}

case $1 in 
    -s | --separate)
       buildSeperateScript
    ;;
    -h | --help)
        help
    ;;
    *)
        buildScript
    ;;
esac