#!/bin/bash
echo "RADIO CON CARTEL"
ls -lh /app/fondo.jpg
cp /app/fondo.jpg /tmp/fondo.jpg
while true; do
ffmpeg -re -loop 1 -framerate 15 -i /tmp/fondo.jpg -reconnect 1 -reconnect_at_eof 1 -i https://ny1.radio.primcast.com/8342/stream -c:v libx264 -preset veryfast -b:v 2000k -c:a aac -b:a 128k -f flv rtmp://a.rtmp.youtube.com/live2/831u-sm62-e9mb-2pwh-4ksw
sleep 10
done
