#!/bin/bash
echo "=== RADIO 24/7 ABC CARDINAL ==="

# Crea la imagen roja con letras SIN necesidad de subir foto
ffmpeg -y -f lavfi -i color=c=0xB50000:s=1280x720:d=1 -vf "drawtext=font='DejaVu Sans':text='• EN VIVO':fontcolor=white:fontsize=38:x=(w-text_w)/2:y=90,drawtext=font='DejaVu Sans':text='RADIO EN VIVO':fontcolor=white:fontsize=110:x=(w-text_w)/2:y=300:style=Bold,drawtext=font='DejaVu Sans':text='ABC CARDINAL 730 AM':fontcolor=white:fontsize=56:x=(w-text_w)/2:y=460,drawtext=font='DejaVu Sans':text='24/7 • TRANSMITIENDO EN VIVO':fontcolor=white:fontsize=30:x=(w-text_w)/2:y=620" -frames:v 1 /tmp/fondo.jpg

ls -lh /tmp/fondo.jpg

while true; do
  ffmpeg -re -loop 1 -framerate 15 -i /tmp/fondo.jpg -thread_queue_size 1024 -reconnect 1 -reconnect_at_eof 1 -reconnect_streamed 1 -reconnect_delay_max 120 -i https://ny1.radio.primcast.com/8342/stream -c:v libx264 -preset veryfast -b:v 2000k -r 15 -g 30 -pix_fmt yuv420p -c:a aac -b:a 128k -ar 44100 -f flv rtmp://a.rtmp.youtube.com/live2/831u-sm62-e9mb-2pwh-4ksw
  echo "Reconectando en 10s..."
  sleep 10
done
