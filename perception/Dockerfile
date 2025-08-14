FROM ros:humble-ros-base

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    ros-humble-usb-cam \
    ros-humble-image-transport ros-humble-image-transport-plugins \
    ros-humble-cv-bridge \
    v4l-utils \
  && rm -rf /var/lib/apt/lists/*
  
COPY start.sh /start.sh
RUN chmod +x /start.sh

WORKDIR /work
