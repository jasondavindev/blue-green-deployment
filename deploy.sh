CONTAINER_PREFIX="bluegreen"
CURRENT_VERSION=$(docker ps|grep --max-count=1 -oP "${CONTAINER_PREFIX}_app_\K(.*)" || echo "green")
NEW_VERSION=$([ "$CURRENT_VERSION" == "green" ] && echo "blue" || echo "green")

function redirect_traffic {
  echo "Redirect traffic"
  sed "s/CURRENT_VERSION/$NEW_VERSION/g" docker/nginx/original.conf > docker/nginx/default.conf
  docker exec -ti "${CONTAINER_PREFIX}_nginx" service nginx reload
  exitcode=$?
  return $exitcode
}

echo "Current version: $CURRENT_VERSION"
echo "New version: $NEW_VERSION"

NGINX_IS_RUNNING=$(docker ps|grep --max-count=1 -oP "${CONTAINER_PREFIX}_nginx")

echo "Starting deploy"

if [ "$NGINX_IS_RUNNING" == "${CONTAINER_PREFIX}_nginx" ]
then
  echo "Deploy blue-green"
  docker-compose -f docker/docker-compose.yml up -d "app-${NEW_VERSION}"

  while [ "`docker inspect -f {{.State.Status}} ${CONTAINER_PREFIX}_app_${NEW_VERSION}`" != "running" ]; do
    sleep 1;
    echo "Waiting container to be healthy"
  done;

  redirect_traffic
else
  echo "First deploy"

  docker-compose -f docker/docker-compose.yml down
  sed "s/CURRENT_VERSION/$NEW_VERSION/g" docker/nginx/original.conf > docker/nginx/default.conf
  docker-compose -f docker/docker-compose.yml up -d
fi

echo "Kill old container"

docker rm -f "${CONTAINER_PREFIX}_app_${CURRENT_VERSION}"