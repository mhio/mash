#!/usr/bin/env bash
set -ueo pipefail
rundir=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)")
cd "$rundir"

# {make.sh user}

CONTAINER_NAME="aws-api-cli"
IMAGE_NAME="${CONTAINER_NAME}"
IMAGE_REPO="me/${IMAGE_NAME}"
IMAGE_TAG="latest"

run:nodemon () {
  nodemon -x "docker stop \"${CONTAINER_NAME}\";
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

run:whatever:seconds(){
  DATE=$(date +%s)
  echo "$DATE" "$@"
}


# {make.sh common}

run:help(){
  set +x
  echo "Commands:"
  declare -F | awk '/^declare -f run:/ { printf("  %s\n", substr($0,16)); }'
  exit 1
}
[ -z "${1:-}" ] && run:help
cmd=$1
shift
set -x
run:"$cmd" "$@"

