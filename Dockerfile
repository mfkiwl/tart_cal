# Create a docker file for the calibration process.. 
# NOTE. This script executes the calibration process only once.
#
#  Author. Tim Molteno. tim@elec.ac.nz (c) 2018-2022.
#
FROM debian:bullseye
MAINTAINER Tim Molteno "tim@elec.ac.nz"
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y &&  apt-get install -y \
    python3-pip python3-numpy python3-dateutil \
    python3-matplotlib python3-scipy \
    python3-astropy python3-healpy \
    python3-h5py python3-requests \
    python3-pyfftw
    
RUN apt-get clean -y
RUN rm -rf /var/lib/apt/lists/*

# Install tart python packages
RUN pip3 install --no-cache-dir tart tart-tools

WORKDIR /app
COPY raw_cal/*.py ./

# setup working directory
WORKDIR /work

# Add the calibrate script.
ADD tart_calibrate.sh /tart_calibrate.sh
ADD raw_calibrate.sh /raw_calibrate.sh

# CMD sh /tart_calibrate.sh
