#!/bin/sh

set -eux

srcdir=$(realpath "${1}")
blddir=$(realpath "${2}")

. "${srcdir}"/tools/pgo/options

pgo_data=$(mktemp)
trap "rm -f '${pgo_data}'" EXIT INT HUP TERM

rm -f "${blddir}"/pgo-ok

# To ensure profiling data is generated in the build directory
cd "${blddir}"

"${blddir}"/tools/utils/xtgettcap
"${blddir}"/footclient --version
"${blddir}"/foot \
           --config=/dev/null \
           --override tweak.grapheme-shaping=no \
           --term=xterm \
        sh -c "
          set -eux

         '${srcdir}/tools/generate-alt-random-writes.py' \
            ${script_options} \"${pgo_data}\"

         cat \"${pgo_data}\"
         "
touch "${blddir}"/pgo-ok
