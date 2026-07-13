#!/bin/sh

set -ux

srcdir=$(realpath "${1}")
blddir=$(realpath "${2}")

"${srcdir}"/tools/pgo/full-inner.sh "${srcdir}" "${blddir}"
swaymsg exit
