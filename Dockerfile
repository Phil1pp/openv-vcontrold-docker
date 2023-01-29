FROM alpine:latest

RUN apk update && apk add --no-cache libxml2-dev linux-headers git build-base gcc abuild binutils binutils-doc gcc-doc cmake cmake-doc extra-cmake-modules extra-cmake-modules-doc

RUN mkdir openv && \
    cd openv && \
    git clone https://github.com/openv/vcontrold.git && \
    cd vcontrold && \
    rm -rf build && \
    cmake . -DMANPAGES=OFF -DCMAKE_BUILD_TYPE=Release -Bbuild && \
    cmake --build build

FROM alpine:latest
WORKDIR /root/

COPY --from=0 /openv/vcontrold/build/vcontrold /usr/local/sbin/
COPY --from=0 /openv/vcontrold/build/vclient /usr/local/bin/
COPY --from=0 /usr/lib/libxml2.so* /usr/lib/
COPY --from=0 /usr/lib/liblzma.so* /usr/lib/

ADD config /etc/vcontrold/
ADD startup.sh /

EXPOSE 3002/udp
ENTRYPOINT ["sh","/startup.sh"]
