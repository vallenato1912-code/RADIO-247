FROM alpine:latest
RUN apk add --no-cache ffmpeg ttf-dejavu fontconfig bash
WORKDIR /app
COPY . .
RUN chmod +x vivo.sh
CMD ["sh","./vivo.sh"]
