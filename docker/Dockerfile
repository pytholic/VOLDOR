FROM nvidia/cuda:11.1.1-cudnn8-devel-ubuntu18.04

LABEL maintainer='rajahaseeb147@gmail.com'

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y \
        sudo  \
        build-essential \
        cmake \
        git \
        libeigen3-dev \
        libgoogle-glog-dev \
        libopencv-dev \
        libsuitesparse-dev \
        libboost-all-dev \
        mesa-utils \
        python3-dev \
        python3-numpy \
        python-numpy \
        python3-opencv \
        python3-pip \
        python3-pyproj \
        python3-scipy \
        python3-yaml \
        python3-opengl \
        curl \
        wget \
        vim \
        unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
RUN python3 -m pip install --upgrade pip

RUN mkdir -p /root/

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root/
   
# Install Ceres 2
RUN mkdir -p /source && cd /source && \
    curl -L http://ceres-solver.org/ceres-solver-2.0.0.tar.gz | tar xz && \
    cd /source/ceres-solver-2.0.0 && \
    mkdir -p build && cd build && \
    cmake .. -DCMAKE_C_FLAGS=-fPIC -DCMAKE_CXX_FLAGS=-fPIC -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF && \
    make -j4 install && \
    cd / && rm -rf /source/ceres-solver-2.0.0

# Install VOLDOR
RUN git clone https://github.com/pytholic/VOLDOR.git && \
    python3 -m pip install -r /root/VOLDOR/slam_py/install/requirements.txt && \
    cd /root/VOLDOR/slam_py/install  && python3 setup_linux_full.py build_ext -i && cp pyvoldor_full.cpp pyvoldor_full.cpython-36m-x86_64-linux-gnu.so pyvoldor_full.pyx libgpu-kernels.so /root/VOLDOR/demo/

# Install pyDBoW3
RUN git clone https://github.com/pytholic/pyDBoW3.git && \
    cd /root/pyDBoW3 && \
    . ./build.sh && \
    cp /root/pyDBoW3/build/pyDBoW3.so /root/VOLDOR/demo/
    
# Define default command.
CMD ["bash"]
