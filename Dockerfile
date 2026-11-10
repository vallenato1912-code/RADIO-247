FROM alpine:latest
RUN apk add --no-cache ffmpeg bash
WORKDIR /app
COPY . .
RUN chmod +x vivo.sh
CMD ./vivo.sh
