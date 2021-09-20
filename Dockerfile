FROM alpine AS builder

RUN apk add build-base git
RUN git clone https://github.com/esnet/iperf.git
WORKDIR iperf
RUN git checkout tags/3.10.1

RUN ./configure --enable-static "LDFLAGS=--static" --disable-shared --without-openssl; make


FROM scratch

COPY --from=builder /iperf/src/iperf3 /iperf3
USER 1000:1000
ENTRYPOINT ["/iperf3"]
