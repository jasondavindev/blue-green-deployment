# This script shows the HTTP response status
# If empty is printed, then ocurred a error

while true; do
  STATUS=$(curl -Is http://localhost |grep -oP "HTTP\/1\.1\s\K(\d+)")
  echo $STATUS
  sleep 1
done;
