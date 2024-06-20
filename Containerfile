FROM quay.io/centos/centos:stream9

ARG ROS2_DISTRO=iron
ARG ROS2_FLAVOR=desktop

RUN dnf install -y langpacks-en glibc-langpack-en passwd

ENV LANG=en_US.UTF-8

RUN locale

RUN dnf install -y 'dnf-command(config-manager)' && \
dnf config-manager --set-enabled crb

RUN dnf install -y epel-release epel-next-release

COPY files/ /

RUN curl --output /etc/pki/rpm-gpg/RPM-GPG-KEY-ros  https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc && \
dnf makecache

RUN dnf install -y \
  cmake \
  gcc-c++ \
  git \
  make \
  patch \
  python3-colcon-common-extensions \
  python3-flake8-builtins \
  python3-flake8-comprehensions \
  python3-flake8-docstrings \
  python3-flake8-import-order \
  python3-flake8-quotes \
  python3-mypy \
  python3-pip \
  python3-pydocstyle \
  python3-pytest \
  python3-pytest-repeat \
  python3-pytest-rerunfailures \
  python3-rosdep \
  python3-setuptools \
  python3-vcstool \
  wget

# install some pip packages needed for testing and
# not available as RPMs
RUN python3 -m pip install \
  flake8-blind-except==0.1.1 \
  flake8-class-newline \
  flake8-deprecated

RUN dnf update -y && \
dnf install -y ros-${ROS2_DISTRO}-${ROS2_FLAVOR}
