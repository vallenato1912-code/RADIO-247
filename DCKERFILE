FROM alpine:latest
RUN apk add --no-cache ffmpeg bash
WORKDIR /app
COPY vivo.sh /app/vivo.sh
RUN chmod +x /app/vivo.sh
CMD ["bash","/app/vivo.sh"]
