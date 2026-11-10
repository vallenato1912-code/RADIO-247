#!/bin/bash
echo "=== RADIO 24/7 INICIANDO ==="
ls -lh /app/
if [ -f /app/fondo.jpg ]; then cp /app/fondo.jpg /tmp/fondo.jpg; else ffmpeg -y -f lavfi -i color=c=0xCC0000:s=1280x720 -frames:v 1 /tmp/fondo.jpg; fi
ls -lh /tmp/fondo.jpg
while true; do
  ffmpeg -re -loop 1 -framerate 15 -i /tmp/fondo.jpg -thread_queue_size 1024 -reconnect 1 -reconnect_at_eof 1 -reconnect_streamed 1 -reconnect_delay_max 120 -i https://ny1.radio.primcast.com/8342/stream -c:v libx264 -preset veryfast -b:v 2000k -r 15 -g 30 -pix_fmt yuv420p -c:a aac -b:a 128k -ar 44100 -f flv rtmp://a.rtmp.youtube.com/live2/831u-sm62-e9mb-2pwh-4ksw
  echo "Reconectando en 10s..."
  sleep 10
done
