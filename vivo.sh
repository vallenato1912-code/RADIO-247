 #!/bin/bash
echo "RADIO CARDINAL 730 AM - ESTABLE 24/7"
mkdir -p /tmp/www
echo "Radio Cardinal 730 AM - OK - 24/7" > /tmp/www/index.html
PORT=${PORT:-10000}
busybox httpd -p $PORT -h /tmp/www &
echo "Web en puerto $PORT"

ffmpeg -y -f lavfi -i color=c=0xB50000:s=1280x720:r=15 -frames:v 1 -vf "drawtext=fontfile=/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf:text='• EN VIVO':fontcolor=white:fontsize=36:x=(w-text_w)/2:y=90, drawtext=fontfile=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf:text='RADIO EN VIVO':fontcolor=white:fontsize=115:x=(w-text_w)/2:y=280, drawtext=fontfile=/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf:text='ABC CARDINAL 730 AM':fontcolor=white:fontsize=52:x=(w-text_w)/2:y=450, drawtext=fontfile=/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf:text='24/7 - TRANSMITIENDO EN VIVO':fontcolor=white:fontsize=28:x=(w-text_w)/2:y=600" /tmp/fondo.jpg

while true; do
ffmpeg -thread_queue_size 1024 -fflags +genpts -probesize 32 -analyzeduration 0 -re -loop 1 -framerate 15 -i /tmp/fondo.jpg -thread_queue_size 1024 -reconnect 1 -reconnect_at_eof 1 -reconnect_streamed 1 -reconnect_delay_max 5 -i https://ny1.radio.primcast.com/8342/stream -c:v libx264 -preset ultrafast -tune stillimage -b:v 1200k -r 15 -g 30 -pix_fmt yuv420p -c:a aac -b:a 96k -ar 44100 -ac 2 -af aresample=async=1:min_hard_comp=0.100000:first_pts=0 -max_interleave_delta 100M -bufsize 4000k -f flv rtmp://a.rtmp.youtube.com/live2/831u-sm62-e9mb-2pwh-4ksw
echo "RECONECTANDO EN 5 SEG..."
sleep 5
done
