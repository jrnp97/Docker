# Dockerfile for configuring a linux debian-based with python2.6 and pip - github:jrnp97
FROM debian:jessie

RUN echo 'deb http://deb.debian.org/debian/ oldstable main contrib non-free' >> /etc/apt/source.list
RUN echo 'deb-src http://deb.debian.org/debian/ oldstable main contrib non-free' >> /etc/apt/source.list

RUN apt-get update && \
    apt-get install -y wget \
    bzip2 \
    gcc-4.8 \
    make \
    curl \
    zlib1g-dev \
    zlibc \
    openssl \
    libssl-dev \
    libsasl2-dev \
    libreadline-dev \ 
    patch \ 
    libsrtp-dev

RUN ln -s /usr/bin/gcc-4.8 /usr/bin/gcc

WORKDIR /tmp/

RUN wget -qO- 'https://www.python.org/ftp/python/2.6.4/Python-2.6.4.tar.bz2' | tar xvfj - 

COPY setup.patch /tmp/setup.patch

WORKDIR /tmp/Python-2.6.4/

RUN patch < /tmp/setup.patch

RUN ldconfig

RUN ./configure \
    --prefix=/opt/python/2.6 \
    --enable-shared \
    --enable-ipv6 \
    --enable-openssl \
    LDFLAGS=-Wl,-rpath=/opt/python/2.6/lib,--disable-new-dtags && \
    make && \
    make install

RUN curl -O 'https://bootstrap.pypa.io/2.6/get-pip.py' && /opt/python/2.6/bin/python2.6 get-pip.py

WORKDIR /

ENV PATH="/opt/python/2.6/bin/:${PATH}"
