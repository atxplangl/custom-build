#!/bin/bash -x
########################################################################################################################
#Shell script for standard rpm targets used for driving the rpm packaging process
########################################################################################################################

########################################################################################################################
#Set variables required for build process
########################################################################################################################
TOPDIR=`pwd`/.rpm
TMPDIR=/var/tmp
#(NAME Must match exactly your .spec file name)
NAME=`cat *.spec | grep Name: | cut -d " " -f2` 
VERSION=`cat *.spec | grep Version: | head -1 | cut -d " " -f2`
RELEASE=01

########################################################################################################################
#Clean up an previous rpm builds
#rpmclean
########################################################################################################################
if [ -e $NAME-$VERSION.tar.gz ]
then
        rm -rf $NAME-$VERSION.tar.gz
fi
if [ -e $NAME-$VERSION ]
then
        rm -rf $NAME-$VERSION
fi
if [ -e $TMPDIR/$NAME-$VERSION ]
then
        rm -rf $TMPDIR/$NAME-$VERSION
fi

########################################################################################################################
#rpm-prep-topdir target
#Sets up the _topdir for rpm dynamically as a .rpm directory where you are
########################################################################################################################
rm -rf $TOPDIR
mkdir -p $TOPDIR
mkdir $TOPDIR/SOURCES
mkdir $TOPDIR/SPECS
mkdir $TOPDIR/RPMS
mkdir $TOPDIR/BUILD
mkdir $TOPDIR/SRPMS

########################################################################################################################
#rpm target
#Creates a tar.gz of your current directory as the source of your rpm
#Copies your source and spec file to _topdir
#Calls rpm build command
########################################################################################################################
mkdir $TMPDIR/$NAME-$VERSION
cp -R -p ./* $TMPDIR/$NAME-$VERSION
mv $TMPDIR/$NAME-$VERSION .
tar zcfv $NAME-$VERSION.tar.gz $NAME-$VERSION --exclude *.svn
mv $NAME-$VERSION.tar.gz $TOPDIR/SOURCES/
rm -rf $NAME-$VERSION
cp $NAME.spec $TOPDIR/SPECS/
rpmbuild -ba --define "_topdir $TOPDIR/" --define "rpmname $NAME" --define "rpmversion $VERSION" --define "rpmrelease $RELEASE$AutoRelease" $NAME.spec
