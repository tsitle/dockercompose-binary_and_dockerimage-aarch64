#! /bin/bash

#
# by TS, Apr 2019
#

VAR_MYNAME="$(basename "$0")"

# ----------------------------------------------------------

# Outputs CPU architecture string
#
# @param string $1 debian_rootfs|debian_dist
#
# @return int EXITCODE
function _getCpuArch() {
	case "$(uname -m)" in
		x86_64*)
			echo -n "amd64"
			;;
		aarch64*)
			if [ "$1" = "debian_rootfs" ]; then
				echo -n "arm64v8"
			elif [ "$1" = "debian_dist" ]; then
				echo -n "arm64"
			else
				echo "$VAR_MYNAME: Error: invalid arg '$1'" >/dev/stderr
				return 1
			fi
			;;
		armv7*)
			if [ "$1" = "debian_rootfs" ]; then
				echo -n "arm32v7"
			elif [ "$1" = "debian_dist" ]; then
				echo -n "armhf"
			else
				echo "$VAR_MYNAME: Error: invalid arg '$1'" >/dev/stderr
				return 1
			fi
			;;
		*)
			echo "$VAR_MYNAME: Error: Unknown CPU architecture '$(uname -m)'" >/dev/stderr
			return 1
			;;
	esac
	return 0
}

_getCpuArch debian_dist >/dev/null || exit 1

TMP_CPUARCH="$(_getCpuArch debian_dist)"
if [ "$TMP_CPUARCH" != "arm64" ]; then
	echo "$VAR_MYNAME: Error: Unsupported CPU architecture '$TMP_CPUARCH'. Aborting." >/dev/stderr
	echo "$VAR_MYNAME: This script must run on an AARCH64/ARM64v8/ARM64 host" >/dev/stderr
	exit 1
fi

# ----------------------------------------------------------

cd build-ctx || exit 1

# ----------------------------------------------------------

LVAR_IMAGE_NAME="docker-compose-aarch64-builder-native"
LVAR_IMAGE_VER="1.24.0"

echo -e "$VAR_MYNAME: Building Docker Image '${LVAR_IMAGE_NAME}:${LVAR_IMAGE_VER}'...\n"
docker build \
	--build-arg DOCKER_COMPOSE_VER="$LVAR_IMAGE_VER" \
	-t "$LVAR_IMAGE_NAME":"$LVAR_IMAGE_VER" \
	. || exit 1

cd ..
docker run --rm -v "$(pwd)/dist":/dist "$LVAR_IMAGE_NAME":"$LVAR_IMAGE_VER" || exit 1

echo -e "\n$VAR_MYNAME: File has been created in ./dist/"
