#!/bin/bash
cd /root
gradle_package=`curl -s http://services.gradle.org/distributions --list-only | sed -n 's/.*\(gradle-.*.all.zip\).*/\1/p' | egrep -v "milestone|rc" | head -1`
gradle_version=`echo ${gradle_package} | cut -d "-" -f 1,2`
mkdir /opt/gradle
curl -L -Of http://services.gradle.org/distributions/${gradle_package}
unzip -oq ./${gradle_package} -d /opt/gradle
ln -sfnv ${gradle_version} /opt/gradle/latest
printf "export GRADLE_HOME=/opt/gradle/latest\nexport PATH=\$PATH:\$GRADLE_HOME/bin" > /etc/profile.d/gradle.sh
. /etc/profile.d/gradle.sh
hash -r ; sync
# check installation
gradle -v

