#!/usr/bin/env bash
set -ue
rundir=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)")
cd "$rundir"

# Custom run:

CONTAINER_NAME="aws-api-cli"
IMAGE_NAME="${CONTAINER_NAME}"
IMAGE_REPO="me/${IMAGE_NAME}"
IMAGE_TAG="latest"

run:nodemon () {
  nodemon -x "docker stop "${CONTAINER_NAME}";
   ./make.sh build \
   && ./make.sh docker"
}

run:build () {
  docker build --tag "${IMAGE_REPO}:${IMAGE_TAG}" .
}

run:docker () {
  docker run --tty \
   --env DEBUG=true \
   --rm \
   --name "${CONTAINER_NAME}" \
   "${IMAGE_REPO}:${IMAGE_TAG}" \
   "$@"
}

run:whatever(){
  DATE=$(date +%Y%m%d)
  echo $DATE
}

run:whatever:seconds(){
  DATE=$(date +%s)
  echo $DATE
}


# Common run:

run:help(){
  set +x
  echo "Commands:"
  declare -F | awk '/^declare -f run:/ { printf("  %s\n", substr($0,16)); }'
}

if [ -n "${1:-}" ]; then
  cmd=$1
  shift
else
  cmd=help
fi

set -x

run:$cmd "$@"

