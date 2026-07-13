#!/bin/sh

set -eux

srcdir=$(realpath "${1}")
blddir=$(realpath "${2}")

"${srcdir}"/tools/pgo/full-inner.sh "${srcdir}" "${blddir}"
