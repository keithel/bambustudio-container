FROM ubuntu:22.04
LABEL maintainer="Keith Kyzivat <kamaji@gmail.com>"
RUN apt-get update && apt-get install -y apt-file && apt-file update
RUN apt-get install -y curl fuse fontconfig libgl1 libegl1 libgtk-3-0 libgstreamer1.0-0 libgstreamer-plugins-base1.0-0 libwebkit2gtk-4.0-37  sudo vim locales && locale-gen en_US.UTF-8
RUN adduser --quiet --disabled-password --home /home/user --gecos "User" user && echo "user:pw" | chpasswd && usermod -aG sudo user
# The user_allow_other may not be needed. If it is, it is for running without privileged mode.
RUN echo "user_allow_other" >> /etc/fuse.conf

#USER user
RUN mkdir -p ~/.config/BambuStudio
RUN curl -L -o ~/bambustudio.AppImage https://github.com/bambulab/BambuStudio/releases/download/v01.07.04.52/Bambu_Studio_linux_ubuntu-v01.07.04.52.AppImage
RUN chmod u+x ~/bambustudio.AppImage
#CMD [ "/home/user/bambustudio.AppImage", "--debug", "4" ]
CMD [ "/root/bambustudio.AppImage", "--debug", "4" ]
#CMD [ "dash" ]
#, "-c", "~/bambustudio.AppImage" ]
