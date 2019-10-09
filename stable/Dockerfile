# docker run -d \
#    --rm \
#    -v /etc/localtime:/etc/localtime:ro \
#    -v /etc/machine-id:/etc/machine-id:ro \
#    -v /tmp/.X11-unix:/tmp/.X11-unix \
#    -e "DISPLAY=unix${DISPLAY}" \
#    -e GDK_SCALE \
#    -e GDK_DPI_SCALE \
#    -v /dev/shm:/dev/shm \
#    --device /dev/snd \
#    --device /dev/dri \
#    --device /dev/video0 \
#    --group-add audio \
#    --group-add video \
#    --name celestia \
#    "${DOCKER_REPO_PREFIX}/celestia" "$@"

ARG CELESTIA_VERSION="1.6.1"

FROM alpine AS builder

ARG CELESTIA_VERSION
ENV CELESTIA_VERSION "${CELESTIA_VERSION}"

RUN apk update && apk --no-cache add --virtual .build-dependencies \
    cmake \
    make \
    g++ \
    git \
    && apk --no-cache add \
    glew-dev \
    jpeg-dev \
    libpng-dev \
    libtheora-dev \
    mesa-gl \
    mesa-dri-intel \
    eigen-dev \
    qt5-qtbase-dev \
    qt5-qttools-dev \
    qt5-qtlocation \
    lua5.3-dev \
    lua-dev \
    ca-certificates \
    ttf-dejavu \
    && git clone --branch ${CELESTIA_VERSION} --depth 1 --recurse-submodules https://github.com/CelestiaProject/celestia \
    && cd celestia \
	&& cmake . -DENABLE_GTK=OFF -DENABLE_QT=ON \
	&& make \
    && make install \
    && cd .. \
    && rm -rf celestia \
    && apk del .build-dependencies \
    && rm -rf /var/cache/*

FROM alpine

ARG CELESTIA_VERSION

COPY --from=builder /usr/local/share/celestia /usr/local/share/celestia
COPY --from=builder /usr/local/bin /usr/local/bin

RUN apk update && apk --no-cache add \
    glew-dev \
    jpeg \
    libpng \
    libtheora \
    mesa-gl \
    mesa-dri-intel \
    eigen \
    qt5-qtbase \
    qt5-qttools \
    qt5-qtlocation \
    lua5.3-dev \
    lua-dev \
    ca-certificates \
    ttf-dejavu \
    && addgroup celestia \
    && adduser -G celestia -s /bin/sh -D celestia
    
USER celestia

ENTRYPOINT ["celestia-qt"]

LABEL org.opencontainers.image.title="Celestia" \
    org.opencontainers.image.description="Celestia in Docker" \ 
    org.opencontainers.image.url="https://github.com/westonsteimel/docker-celestia" \ 
    org.opencontainers.image.source="https://github.com/westonsteimel/docker-celestia" \
    org.opencontainers.image.version="${CELESTIA_VERSION}" \
    version="${CELESTIA_VERSION}"

