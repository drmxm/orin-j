FROM ros:humble-ros-base

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    ros-humble-foxglove-bridge \
    ros-humble-image-transport ros-humble-image-transport-plugins \
    netcat-openbsd \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /work
COPY docker/start_infra.sh /start_infra.sh
RUN chmod +x /start_infra.sh
