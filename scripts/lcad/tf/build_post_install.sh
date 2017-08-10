#!/bin/bash


################################################################################


echo
echo '##########################'
echo '# Repository settings    #'
echo '##########################'
echo

# Installs add-apt-repository
apt-get update && apt-get install -y software-properties-common python-software-properties

# Needed by libfaac
echo 'deb http://archive.ubuntu.com/ubuntu trusty multiverse' >> /etc/apt/sources.list

# Needed for gcc 4.9, which is required to compile linuxcan
# See: https://gist.github.com/rutsky/bc40c6b4bee0ab5f9ee4
add-apt-repository -y ppa:ubuntu-toolchain-r/test

# Needed for Oracle JDK
add-apt-repository -y ppa:webupd8team/java

# Needed for PCL
add-apt-repository -y ppa:v-launchpad-jochen-sprickerhof-de/pcl

# Enable automatic Java installation
echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections

# Update package list
apt-get update


################################################################################


echo
echo '#######################################'
echo '# Environment setup                   #'
echo '#######################################'
echo

# Install tools and library dependencies
apt-get install -y \
    build-essential byacc cmake \
    cmake-gui doxygen flex \
    freeglut3 freeglut3-dev g++-4.9 \
    gimp git imagemagick \
    libavcodec-dev libavformat-dev libboost-all-dev \
    libcurl3 libcurl3-nss libcurl4-nss-dev \
    libdc1394-22 libdc1394-22-dev libdc1394-utils \
    libeigen2-dev libeigen3-dev libespeak-dev \
    libfaac-dev libfftw3-dev libflann-dev \
    libforms-dev libglade2-0 libglade2-dev \
    libglew-dev libglew1.5 libglew1.5-dev \
    libglewmx1.5 libglewmx1.5-dev libgsl0-dev \
    libgsl0ldbl libgtk2.0-dev libgtkglext1 \
    libgtkglext1-dev libgtkglextmm-x11-1.2-0 libgtkglextmm-x11-1.2-dev \
    libimlib2 libimlib2-dev libjasper-dev \
    libjpeg-dev libkml-dev libkml0 \
    libmagick++-dev libncurses5 libncurses5-dev \
    libopencore-amrnb-dev libopencore-amrwb-dev libopenexr-dev \
    libpcl-all libqt4-dev libqt4-opengl-dev \
    libsuitesparse-dev libswscale-dev libtbb-dev libtheora-dev \
    libtiff4-dev liburiparser-dev liburiparser1 \
    libusb-1.0-0 libusb-1.0-0-dev libusb-dev \
    libv4l-dev libvorbis-dev libvtk5-dev \
    libwrap0 libwrap0-dev libx264-dev \
    libxi-dev libxi6 libxmu-dev \
    libxmu6 libxvidcore-dev meld \
    nano oracle-jdk7-installer python-dev \
    python-numpy python-tk qt-sdk \
    qt4-qmake screen sphinx-common \
    swig tcpd tcsh texlive-latex-extra \
    unzip vim wget yasm zlib1g-dev

# Configure default compiler versions
# See: http://askubuntu.com/a/26518/623119
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 20
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 10
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 20
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.9 10
update-alternatives --install /usr/bin/cc cc /usr/bin/gcc 30
update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 30
update-alternatives --set cc /usr/bin/gcc
update-alternatives --set c++ /usr/bin/g++
echo 2 | update-alternatives --config gcc
echo 2 | update-alternatives --config g++


# Setup screen
echo 'shell $DOKKA_SHELL' >> /etc/screenrc

################################################################################


echo
echo '#######################################'
echo '# Build packages                      #'
echo '#######################################'
echo

cd /usr/local/

# Install the bullet physics library
wget -nc https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/bullet/bullet-2.78-r2387.tgz
tar -xvf bullet-2.78-r2387.tgz && mv bullet-2.78 bullet
(cd bullet ; ./configure ; make && make install)

# Install linuxcan
wget -nc https://sites.google.com/site/xperronisvault/home/linuxcan-gcc4.9.tar.gz
tar -zxf linuxcan-gcc4.9.tar.gz
(cd linuxcan ; make && make install)

# Install FANN
wget -nc http://downloads.sourceforge.net/project/fann/fann/2.2.0/FANN-2.2.0-Source.tar.gz
tar -zxf FANN-2.2.0-Source.tar.gz
mkdir FANN-2.2.0-Source/build
(cd FANN-2.2.0-Source/build ; cmake .. ; make && make install)

# Install OpenCV
wget -nc wget http://downloads.sourceforge.net/project/opencvlibrary/opencv-unix/2.4.9/opencv-2.4.9.zip
unzip opencv-2.4.9.zip
mkdir opencv-2.4.9/build
(cd opencv-2.4.9/build ; cmake -D WITH_TBB=ON -D WITH_CUDA=OFF -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON -D WITH_QT=ON -D WITH_OPENGL=ON .. ; make && make install)
echo '/usr/local/lib' >> /etc/ld.so.conf.d/opencv.conf
ldconfig

# Download CARMEN and install dependencies
LCAD_SRC=/home/erios/LCAD/src
CARMEN_HOME=$LCAD_SRC/carmen_lcad
test -e $CARMEN_HOME || (cd $LCAD_SRC && git clone https://github.com/LCAD-UFES/carmen_lcad.git)
( \
    cd $CARMEN_HOME/ubuntu_packages ; \
    dpkg -i imlib_1.9.15-20_amd64.deb ; \
    dpkg -i imlib-devel_1.9.15-20_amd64.deb ; \
    test -e flycapture2-2.5.3.4-amd64 || tar -xvf flycapture2-2.5.3.4-amd64-pkg.tgz ; \
    cd flycapture2-2.5.3.4-amd64/ ; \
    apt-get install -y libglademm-2.4-1c2a libglademm-2.4-dev libgtkmm-2.4-dev ; \
    sh install_flycapture.sh \
)

# Setup paths
ln -s /usr/lib64/libgdk_imlib.so.1.9.15 /usr/lib64/libgdk_imlib.a
ln -s /usr/lib/x86_64-linux-gnu/libboost_thread.so /usr/lib/x86_64-linux-gnu/libboost_thread-mt.so

# Kinect libraries
( \
    mkdir /usr/local/tplib ; \
    cd /usr/local/tplib ; \
    git clone git://github.com/OpenKinect/libfreenect.git ; \
    mkdir libfreenect/build ; \
    cd libfreenect/build ; \
    cmake .. ; \
    cp src/libfreenect.pc /usr/local/tplib/ ; \
    make ; \
    cp ../src/libfreenect.pc.in src/libfreenect.pc ; \
    cp ../fakenect/fakenect.sh.in fakenect/fakenect.sh ; \
    make install ; \
    ldconfig /usr/local/lib64/ \
)

# G2O 14.04
svn co https://svn.openslam.org/data/svn/g2o
( \
    cd g2o/trunk/build/ ; \
    cmake ../ -DBUILD_CSPARSE=ON -DG2O_BUILD_DEPRECATED_TYPES=ON -DG2O_BUILD_LINKED_APPS=ON ; \
    make && make install \
)

# dlib
git clone https://github.com/davisking/dlib.git
mkdir dlib/build
(cd dlib/build ; cmake .. ; make && make install)
