FROM golang:1.22-alpine3.19 as build
WORKDIR /azcopy
RUN apk add --no-cache build-base
COPY v10.26.0.tar.gz .
RUN tar xf v10.26.0.tar.gz --strip 1 \
    && go build -o azcopy \
    && ./azcopy --version

FROM alpine:3.19 as release
COPY --from=build /azcopy/azcopy /usr/local/bin
RUN mkdir /.azcopy && chmod -R 777 /.azcopy
WORKDIR /WORKDIR
CMD [ "/usr/local/bin/azcopy" ]