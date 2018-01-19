FROM resin/raspberry-pi-openjdk:openjdk-8-jdk

RUN [ "cross-build-start" ]

RUN echo deb http://ftp.debian.org/debian jessie-backports main >>/etc/apt/sources.list \
&& apt-get update && apt-get install -y\
  git \
  cmake \
  libglib2.0-0 \
  libglib2.0-dev \
  make \
  gcc \
  g++ \
  wget \
&& rm -rf /var/lib/apt/lists/*



RUN mkdir /work
WORKDIR /work

#RUN wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" \
#http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-arm32-vfp-hflt.tar.gz

#RUN mkdir -p /usr/java \
#&& cd /usr/java \
#&& tar -xzvf /work/jdk-8u161-linux-arm32-vfp-hflt.tar.gz

#ENV JAVA_HOME=/usr/java/jdk1.8.0_161 PATH=$PATH:$JAVA_HOME/bin

COPY api/ api/
COPY cmake/ cmake/
COPY examples/ examples/
COPY include/ include/
COPY java/ java/
COPY src/ src/

COPY Doxyfile.java.in Doxyfile.java.in
COPY Doxyfile.cpp.in Doxyfile.cpp.in

COPY CMakeLists.txt .

RUN mkdir build \
 && cd build \
 && cmake .. \
    -DBUILDJAVA=ON \
    -DCMAKE_CXX_FLAGS="-std=c++11 -march=armv6" \
    -DCMAKE_C_FLAGS="-march=armv6"\
    -DCMAKE_BUILD_TYPE=Release

RUN cd build \
 && make -j2 tinybjar \
 && make -j4

RUN cd build \
 && cpack


RUN [ "cross-build-end" ]
ENTRYPOINT ["/bin/bash"]
