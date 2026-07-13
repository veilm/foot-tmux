#!/bin/sh

set -eux

srcdir=$(realpath "${1}")
blddir=$(realpath "${2}")

. "${srcdir}"/tools/pgo/options

pgo_data=$(mktemp)
trap "rm -f ${pgo_data}" EXIT INT HUP TERM

rm -f "${blddir}"/pgo-ok

"${srcdir}"/tools/generate-alt-random-writes.py \
           --rows=67 \
           --cols=135 \
           ${script_options} \
           "${pgo_data}"

# To ensure profiling data is generated in the build directory
cd "${blddir}"

"${blddir}"/tools/utils/xtgettcap
"${blddir}"/footclient --version
"${blddir}"/foot --version
"${blddir}"/pgo "${pgo_data}"

touch "${blddir}"/pgo-ok
