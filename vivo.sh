#!/bin/bash
echo "=== CREANDO FONDO RADIO EN VIVO ==="
ffmpeg -y -f lavfi -i color=c=0x111111:s=1280x720 -frames:v 1 -vf "drawtext=text='RADIO EN VIVO':fontcolor=white:fontsize=130:x=(w-text_w)/2:y=280:box=1:boxcolor=red@0.9:boxborderw=20,drawtext=text='ABC CARDINAL 730 AM':fontcolor=white:fontsize=70:x=(w-text_w)/2:y=480:box=1:boxcolor=black@0.7:boxborderw=10" /tmp/fondo.jpg
echo "=== INICIANDO RADIO 24/7 ==="
while true; do
  ffmpeg -re -loop 1 -framerate 30 -i /tmp/fondo.jpg -thread_queue_size 2048 -reconnect 1 -reconnect_at_eof 1 -reconnect_streamed 1 -reconnect_delay_max 120 -i https://ny1.radio.primcast.com/8342/stream -c:v libx264 -preset ultrafast -b:v 2500k -r 30 -g 60 -pix_fmt yuv420p -c:a aac -b:a 128k -ar 44100 -f flv rtmp://a.rtmp.youtube.com/live2/831u-sm62-e9mb-2pwh-4ksw
  echo "Corte detectado, reconectando en 10s..."
  sleep 10
done
