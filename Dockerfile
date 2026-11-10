FROM alpine:latest
RUN apk add --no-cache ffmpeg ttf-dejavu fontconfig bash
WORKDIR /app
COPY vivo.sh .
RUN chmod +x vivo.sh
CMD ./vivo.sh
