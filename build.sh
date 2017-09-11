#!/bin/sh

set -e

JDK_BALL=$1/jdk-8u141-linux-x64.tar.gz
VERSION=$2


if [ -f $JDK_BALL ] ; then
    echo "Using $JDK_BALL as builder, copying"
    cp $JDK_BALL .
else
    echo "Path to JDK '$JDK_BALL' is invalid."
    echo "Usage: build.sh  path/to/jdk-8u141-linux-x64.tar.gz  0.0.13"
    exit 23
fi

if [ $VERSION ] ; then
    echo "Version $VERSION is going to be built"
else
    echo "No version tag specified"
    exit 42
fi


PWD=`pwd`

build () {
    cd $1
    cp $JDK_BALL .
    docker build -t retz-build-$1 .

    IMG=`docker run -d=true -v $PWD:/build retz-build-$1 /sbin/init`

    echo "Docker image $IMG started"

    docker exec $IMG git --version
    docker exec $IMG git --work-tree=/retz --git-dir=/retz/.git fetch
    docker exec $IMG git --work-tree=/retz --git-dir=/retz/.git checkout $VERSION
    docker exec $IMG env
    ##docker exec $IMG make -C /retz build
    docker exec $IMG make -C /retz client-jar server-jar
    docker exec $IMG make -C /retz $1
    ## docker exec $IMG ls -R /retz/retz-server/build
    docker exec $IMG cp -r /retz/retz-server/build/distributions /build/
    docker exec $IMG cp -r /retz/retz-server/build/libs/retz-server-${VERSION}-all.jar /build/
    docker exec $IMG cp -r /retz/retz-client/build/distributions /build/
    docker exec $IMG cp -r /retz/retz-client/build/libs/retz-client-${VERSION}-all.jar /build/
    docker exec $IMG cp -r /retz/retz-admin/build/distributions /build/    
    docker stop $IMG

    cd ..
}

build rpm
cp rpm/distributions/*.rpm .
build deb
cp deb/distributions/*.deb .

cp deb/*.jar .

echo "Packages created:"

sha1sum retz-*.rpm
sha1sum retz-*.deb
sha1sum retz-*.jar
