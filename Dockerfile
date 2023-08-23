FROM ubuntu:22.04
LABEL maintainer="Keith Kyzivat <kamaji@gmail.com>"
RUN apt-get update
RUN apt-get install -y apt-file && apt-file update
RUN apt-get install -y curl fuse fontconfig libgl1 libegl1 libgtk-3-0 libgstreamer1.0-0 libgstreamer-plugins-base1.0-0 libwebkit2gtk-4.0-37
RUN apt-get install -y sudo vim locales
# RUN apt-get update && apt-get install -y sudo curl git-core gnupg locales zsh \
# wget vim \
# git p7zip-full nfs-common libssl-dev "^libxcb.*" libxkbcommon-dev \
# libxkbcommon-x11-dev libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev \
# libdbus-1-dev udev libudev-dev libegl1-mesa-dev libfontconfig1-dev libgbm-dev \
# liblcms2-dev libpci-dev libre2-dev libsnappy-dev libvpx-dev libxkbfile-dev \
# libxshmfence-dev libxss-dev nodejs python3-html5lib libglib2.0-dev \
# libmysqlclient-dev libpq-dev libsqlite3-dev unixodbc-dev libfreetype6-dev \
# libjpeg-dev \
# python3-dev python3-pip virtualenv python3-wheel python-is-python3 python2-dev \
# mesa-common-dev libgl1-mesa-glx libgl1-mesa-dev libegl1-mesa-dev libegl1 \
# libegl-mesa0 libegl-dev libglvnd-dev libgles2-mesa-dev \
# curl libcurl4-openssl-dev libicu-dev zlib1g-dev libgtk-3-dev ninja-build \
# libssl-dev libxcursor-dev libxcomposite-dev libxdamage-dev libxrandr-dev \
# libsrtp2-dev libwebp-dev libjsoncpp-dev libopus-dev \
# libminizip-dev libavutil-dev libavformat-dev libavcodec-dev libevent-dev bison \
# flex gperf libasound2-dev libpulse-dev libxtst-dev libnspr4-dev libnss3-dev \
# libnss3 libopenal-dev libbluetooth-dev libspeechd-dev chrpath gawk texinfo \
# libdouble-conversion-dev libpcre2-dev libsdl2-2.0 libsdl2-dev ruby \
# libxslt1-dev libxml2-dev libhyphen-dev ssh diffstat binfmt-support zstd lz4 \
# libvulkan-dev libdlt-dev \
# build-essential cmake ninja-build libatspi2.0-dev && \
RUN locale-gen en_US.UTF-8
RUN adduser --quiet --disabled-password --home /home/user --gecos "User" user
RUN echo "user:pw" | chpasswd
# The user_allow_other may not be needed. If it is, it is for running without privileged mode.
RUN echo "user_allow_other" >> /etc/fuse.conf
RUN usermod -aG sudo user

#libfontconfig1-dev libfreetype6-dev libx11-dev libx11-xcb-dev libxext-dev \
#libxfixes-dev libxi-dev libxrender-dev libxcb1-dev libxcb-cursor-dev \
#libxcb-glx0-dev libxcb-keysyms1-dev libxcb-image0-dev libxcb-shm0-dev \
#libxcb-icccm4-dev libxcb-sync-dev libxcb-xfixes0-dev libxcb-shape0-dev \
#libxcb-randr0-dev libxcb-render-util0-dev libxcb-util-dev libxcb-xinerama0-dev \
#libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev && \

USER user
RUN mkdir -p ~/.config/BambuStudio
RUN curl -L -o ~/bambustudio.AppImage https://github.com/bambulab/BambuStudio/releases/download/v01.07.04.52/Bambu_Studio_linux_ubuntu-v01.07.04.52.AppImage
RUN chmod u+x ~/bambustudio.AppImage
CMD [ "/home/user/bambustudio.AppImage", "--debug", "4" ]
#CMD [ "dash" ]
#, "-c", "~/bambustudio.AppImage" ]