while true; do
  echo $(curl -Is http://localhost |grep -oP "HTTP\/1\.1\s\K(\d+)")
  sleep 1
done;
