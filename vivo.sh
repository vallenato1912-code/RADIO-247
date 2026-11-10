#!/bin/bash
echo "=== RADIO 24/7 ==="
cp /app/fondo.jpg /tmp/fondo.jpg || ffmpeg -y -f lavfi -i color=c=0xCC0000:s=1280x720 -frames:v 1 /tmp/fondo.jpg
ls -lh /tmp/fondo.jpg
while true; do
ffmpeg -re -loop 1 -framerate 15 -i /tmp/fondo.jpg -reconnect 1 -reconnect_at_eof 1 -reconnect_streamed 1 -reconnect_delay_max 120 -i https://ny1.radio.primcast.com/8342/stream -c:v libx264 -preset veryfast -b:v 2000k -r 15 -c:a aac -b:a 128k -ar 44100 -f flv rtmp://a.rtmp.youtube.com/live2/831u-sm62-e9mb-2pwh-4ksw
sleep 10
done
