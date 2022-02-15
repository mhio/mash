#!/usr/bin/env bash
set -ueo pipefail
dateTime(){ date -u '+%Y-%m-%dT%H:%M:%SZ'; }
rundir=$(cd -P -- "$(dirname -- "$0")" && printf '%s\n' "$(pwd -P)")
cd "$rundir"

# {make.sh user}

CONTAINER_NAME="aws-api-cli"
IMAGE_NAME="${CONTAINER_NAME}"
IMAGE_REPO="me/${IMAGE_NAME}"
IMAGE_TAG="latest"

# Examples

run:watch () {
  nodemon -e sh,ts,json -i .git -x "$@"
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


# Project

# dump just the header
run:header () {
  set +x #output based
  awk 'BEGIN {
    exit_code = 1
  }
  {
    print $0
    if ( $0 ~ /^# \{make\.sh user\}/ ) {
      exit_code = 0;
      exit 0;
    }
  }
  END {
    if ( exit_code != 0 ) print "ERROR: No make.sh \"user\" mark";
    exit exit_code;
  }' make.sh
}

# dump just the footer
run:footer () {
  set +x # output based
  awk 'BEGIN {
    wait = 1
  }
  {
    if ( $0 ~ /^# \{make\.sh common\}/ ) wait = 0;
    if ( wait == 0 ) print $0;
  }
  END {
    if ( wait == 1) print "ERROR: No make.sh \"common\" mark";
    exit wait;
  }' make.sh
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

