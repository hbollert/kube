#!/bin/bash

if (( $EUID != 0 )); then
    exit 1
fi

RUNNING=$(uname -r | cut -d'.' -f2,3,4,5)
RPM=$(rpm -qa | grep kernel)

for kernel in $RPM; do
        CHECK=$(echo $kernel | cut -d'.' -f2,3,4,5)
        if [[ $CHECK < $RUNNING ]]; then
                yum autoremove -y $kernel
        fi
done

exit 0
