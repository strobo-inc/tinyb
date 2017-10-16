FROM strobo/docker-arm-build

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
  oracle-java8-jdk \
&& rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt

RUN mkdir /work
WORKDIR /work

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
    -DCMAKE_CXX_FLAGS="-std=c++11" \
    -DCMAKE_BUILD_TYPE=Release

RUN cd build \
 && make -j2 tinybjar \
 && make -j4

RUN cd build \
 && cpack


RUN [ "cross-build-end" ]
ENTRYPOINT ["/bin/bash"]
