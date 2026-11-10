#!/bin/bash
echo "=== RADIO INICIANDO 24/7 ==="
echo "Creando fondo..."
# Crea fondo rojo simple primero (este nunca falla)
ffmpeg -y -f lavfi -i color=c=0xCC0000:s=1280x720 -frames:v 1 /tmp/fondo.jpg
# Ahora intenta ponerle texto, si falla sigue con el fondo rojo
FONT="/usr/share/fonts/ttf-dejavu/DejaVuSans-Bold.ttf"
if [ -f "$FONT" ]; then
  ffmpeg -y -i /tmp/fondo.jpg -vf "drawtext=fontfile=$FONT:text='RADIO EN VIVO':fontcolor=white:fontsize=120:x=(w-text_w)/2:y=250,drawtext=fontfile=$FONT:text='ABC CARDINAL 730 AM':fontcolor=white:fontsize=60:x=(w-text_w)/2:y=450" /tmp/fondo2.jpg && mv /tmp/fondo2.jpg /tmp/fondo.jpg
fi
ls -lh /tmp/fondo.jpg
echo "=== INICIANDO STREAM A YOUTUBE ==="
while true; do
  ffmpeg -re -loop 1 -framerate 15 -i /tmp/fondo.jpg -thread_queue_size 1024 -reconnect 1 -reconnect_at_eof 1 -reconnect_streamed 1 -reconnect_delay_max 120 -i https://ny1.radio.primcast.com/8342/stream -c:v libx264 -preset veryfast -b:v 2000k -r 15 -g 30 -pix_fmt yuv420p -c:a aac -b:a 128k -ar 44100 -f flv rtmp://a.rtmp.youtube.com/live2/831u-sm62-e9mb-2pwh-4ksw
  echo "Corte detectado, reconectando en 10s..."
  sleep 10
done
