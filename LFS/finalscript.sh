#!/bin/bash

set -e
set -x

time {

    cd /mnt/lfs/sources/
    tar -xvf tcl-core8.6.6-src.tar.gz
    cd tcl8.6.6/

    cd unix
    ./configure --prefix=/tools
    make
    make install
    chmod -v u+w /tools/lib/libtcl8.6.so
    make install-private-headers
    ln -sv tclsh8.6 /tools/bin/tclsh

#**************************************************************

    cd /mnt/lfs/sources/
    rm -rf tcl8.6.6
    tar -xvf expect5.45.tar.gz
    cd expect5.45

    cp -v configure{,.orig}
    sed 's:/usr/local/bin:/bin:' configure.orig > configure
    ./configure --prefix=/tools       \
                --with-tcl=/tools/lib \
                --with-tclinclude=/tools/include
    make
    make SCRIPTS="" install

#**************************************************************

    cd /mnt/lfs/sources/
    rm -rf expect5.45
    tar -xvf dejagnu-1.6.tar.gz
    cd dejagnu-1.6

    ./configure --prefix=/tools
    make install

#**************************************************************

    cd /mnt/lfs/sources/
    rm -rf dejagnu-1.6
    tar -xvf check-0.11.0.tar.gz
    cd check-0.11.0

    PKG_CONFIG= ./configure --prefix=/tools
    make
    make install

#**************************************************************

    cd /mnt/lfs/sources/
    rm -rf check-0.11.0
    tar -xvf ncurses-6.0.tar.gz
    cd ncurses-6.0

    sed -i s/mawk// configure
    ./configure --prefix=/tools \
                --with-shared   \
                --without-debug \
                --without-ada   \
                --enable-widec  \
                --enable-overwrite
    make
    make install

#**************************************************************

    cd /mnt/lfs/sources/
    rm -rf ncurses-6.0
    tar -xvf bash-4.4.tar.gz
    cd bash-4.4

    ./configure --prefix=/tools --without-bash-malloc
    make
    make install
    ln -sv bash /tools/bin/sh

#**************************************************************

    cd /mnt/lfs/sources/
    rm -rf bash-4.4
    tar -xvf bison-3.0.4.tar.xz
    cd bison-3.0.4

    ./configure --prefix=/tools
    make
    make install

#**************************************************************

    cd /mnt/lfs/sources/
    rm -rf bison-3.0.4
    tar -xvf bzip2-1.0.6.tar.gz
    cd bzip2-1.0.6

    make
    make PREFIX=/tools install

#**************************************************************

    cd /mnt/lfs/sources/
    rm -rf bzip2-1.0.6
    tar -xvf coreutils-8.26.tar.xz
    cd coreutils-8.26

    ./configure --prefix=/tools --enable-install-program=hostname
    make
    make install

#**************************************************************

    cd /mnt/lfs/sources/
    rm -rf coreutils-8.26
    tar -xvf diffutils-3.5.tar.xz
    cd diffutils-3.5

    ./configure --prefix=/tools
    make
    make install

#**************************************************************

    cd /mnt/lfs/sources/
    rm -rf diffutils-3.5
    tar -xvf file-5.30.tar.gz
    cd file-5.30

    ./configure --prefix=/tools
    make
    make install

#**************************************************************

    cd /mnt/lfs/sources/
    rm -rf file-5.30
    tar -xvf findutils-4.6.0.tar.gz
    cd findutils-4.6.0

    ./configure --prefix=/tools
    make
    make install

#**************************************************************

    cd /mnt/lfs/sources/
    rm -rf findutils-4.6.0
    tar -xvf gawk-4.1.4.tar.xz
    cd gawk-4.1.4

    ./configure --prefix=/tools
    make
    make install

#**************************************************************

    cd /mnt/lfs/sources/
    rm -rf gawk-4.1.4
    tar -xvf gettext-0.19.8.1.tar.xz
    cd gettext-0.19.8.1

    cd gettext-tools
    EMACS="no" ./configure --prefix=/tools --disable-shared
    make -C gnulib-lib
    make -C intl pluralx.c
    make -C src msgfmt
    make -C src msgmerge
    make -C src xgettext
    cp -v src/{msgfmt,msgmerge,xgettext} /tools/bin

#**************************************************************

    cd /mnt/lfs/sources/
    rm -rf gettext-0.19.8.1
    tar -xvf grep-3.0.tar.xz
    cd grep-3.0

    ./configure --prefix=/tools
    make
    make install

#**************************************************************

    cd /mnt/lfs/sources/
    rm -rf grep-3.0
    tar -xvf gzip-1.8.tar.xz
    cd gzip-1.8

    ./configure --prefix=/tools
    make
    make install

#**************************************************************

    cd /mnt/lfs/sources/
    rm -rf gzip-1.8
    tar -xvf m4-1.4.18.tar.xz
    cd m4-1.4.18

    ./configure --prefix=/tools
    make
    make install

#**************************************************************

    cd /mnt/lfs/sources/
    rm -rf m4-1.4.18
    tar -xvf make-4.2.1.tar.bz2
    cd make-4.2.1

    ./configure --prefix=/tools --without-guile
    make
    make install

#**************************************************************

    cd /mnt/lfs/sources/
    rm -rf make-4.2.1
    tar -xvf patch-2.7.5.tar.xz
    cd patch-2.7.5

    ./configure --prefix=/tools
    make
    make install

#**************************************************************

    cd /mnt/lfs/sources/
    rm -rf patch-2.7.5
    tar -xvf perl-5.24.1.tar.bz2
    cd perl-5.24.1

    sh Configure -des -Dprefix=/tools -Dlibs=-lm
    make
    cp -v perl cpan/podlators/scripts/pod2man /tools/bin
    mkdir -pv /tools/lib/perl5/5.24.1
    cp -Rv lib/* /tools/lib/perl5/5.24.1

#**************************************************************

    cd /mnt/lfs/sources/
    rm -rf perl-5.24.1
    tar -xvf sed-4.4.tar.xz
    cd sed-4.4

    ./configure --prefix=/tools
    make
    make install

#**************************************************************

    cd /mnt/lfs/sources/
    rm -rf sed-4.4
    tar -xvf tar-1.29.tar.xz
    cd tar-1.29

    ./configure --prefix=/tools
    make
    make install

#**************************************************************

    cd /mnt/lfs/sources/
    rm -rf tar-1.29
    tar -xvf texinfo-6.3.tar.xz
    cd texinfo-6.3

    ./configure --prefix=/tools
    make
    make install

#**************************************************************

    cd /mnt/lfs/sources/
    rm -rf texinfo-6.3
    tar -xvf util-linux-2.29.1.tar.xz
    cd util-linux-2.29.1

    ./configure --prefix=/tools                   \
                --without-python                  \
                --disable-makeinstall-chown       \
                --without-systemdsystemunitdir    \
                --enable-libmount-force-mountinfo \
                PKG_CONFIG=""
    make
    make install

#**************************************************************

    cd /mnt/lfs/sources/
    rm -rf util-linux-2.29.1
    tar -xvf xz-5.2.3.tar.xz
    cd xz-5.2.3

    ./configure --prefix=/tools
    make
    make install

#**************************************************************

    chown -R root:root $LFS/tools

}
