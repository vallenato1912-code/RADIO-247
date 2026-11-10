#!/bin/bash
echo "INICIANDO RADIO 24/7 ESTABLE"
mkdir -p /tmp/www
echo "OK RADIO CARDINAL" > /tmp/www/index.html
PORT=${PORT:-10000}
busybox httpd -f -p $PORT -h /tmp/www &

ffmpeg -y -f lavfi -i color=c=0xB50000:s=1280x720:r=15 -frames:v 1 -vf "drawtext=fontfile=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf:text='ABC CARDINAL 730 AM':fontcolor=white:fontsize=60:x=(w-text_w)/2:y=320, drawtext=fontfile=/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf:text='EN VIVO 24/7':fontcolor=white:fontsize=40:x=(w-text_w)/2:y=400" /tmp/fondo.jpg

while true; do
echo "TRANSMITIENDO..."
ffmpeg -re -loop 1 -framerate 15 -i /tmp/fondo.jpg -reconnect 1 -reconnect_at_eof 1 -reconnect_streamed 1 -reconnect_delay_max 10 -i https://ny1.radio.primcast.com/8342/stream -c:v libx264 -preset veryfast -b:v 1000k -maxrate 1000k -bufsize 2000k -r 15 -g 30 -keyint_min 30 -pix_fmt yuv420p -c:a aac -b:a 128k -ar 44100 -f flv rtmp://a.rtmp.youtube.com/live2/831u-sm62-e9mb-2pwh-4ksw || true
echo "SE CORTÓ, REINICIANDO EN 3 SEG..."
sleep 3
done

