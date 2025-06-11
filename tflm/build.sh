#!/usr/bin/env bash


set -e

# -----------------------------------------------------------------------------


#
# Porting Dependencies for TensorFlow Lite Micro (TFLM)
#


# -----------------------------------------------------------------------------

download_and_extract() {
    local name="$1"
    local version="$2"
    local url="$3"
    local archive="$name-${version}.tar.gz"
    local src_dir="${PREFIX_PORT_BUILD}/${name}-${version}"
    local dst_dir="${PREFIX_PORT_BUILD}/${name}"

    echo ">>> Fetching ${name}"

    mkdir -p "$dst_dir"

    if [ ! -f "${PREFIX_PORT}/${archive}" ]; then
        echo ">>> Downloading ${name}..."
        wget "$url" -O "${PREFIX_PORT}/${archive}" --no-check-certificate
    fi

    if [ ! -d "$src_dir" ]; then
        echo ">>> Unpacking ${name}..."
        tar zxf "${PREFIX_PORT}/${archive}" -C "${PREFIX_PORT_BUILD}"
        mv "${src_dir}"/* "${dst_dir}/"
    fi

    echo ">>> ${name^} installed!"
}

download_and_extract "flatbuffers" "23.5.26" "https://github.com/google/flatbuffers/archive/refs/tags/v23.5.26.tar.gz"
download_and_extract "ruy" "master" "https://github.com/google/ruy/archive/refs/heads/master.tar.gz"
download_and_extract "gemmlowp" "master" "https://github.com/google/gemmlowp/archive/refs/heads/master.tar.gz"
download_and_extract "kissfft" "131" "https://github.com/mborgerding/kissfft/archive/refs/tags/v131.tar.gz"

# -----------------------------------------------------------------------------


#
# Porting TensorFlow Lite Micro (TFLM)
#


# -----------------------------------------------------------------------------


TFLM_REPO_REF="main"
TFLM_ARCHIVE="tflite-micro-${TFLM_REPO_REF}.tar.gz"
PKG_URL="https://github.com/tensorflow/tflite-micro/archive/refs/heads/${TFLM_REPO_REF}.tar.gz"


PREFIX_TFLM_SRC="${PREFIX_PORT_BUILD}/tflite-micro-${TFLM_REPO_REF}"
PREFIX_TFLM_BUILD="${PREFIX_TFLM_SRC}/build"
PREFIX_TFLM_MARKERS="${PREFIX_PORT_BUILD}/markers/tflm"


mkdir -p "${PREFIX_PORT_BUILD}" "${PREFIX_TFLM_MARKERS}"

#
# Download and unpack
#

if [ ! -f "${PREFIX_PORT}/${TFLM_ARCHIVE}" ]; then
   echo ">>> Downloading: ${PKG_URL}"
   if ! wget "${PKG_URL}" -O "${PREFIX_PORT}/${TFLM_ARCHIVE}" --no-check-certificate; then
       echo "!!! Error: ${PKG_URL}"
       exit 1
   fi
fi


if [ ! -d "${PREFIX_TFLM_SRC}" ]; then
   echo ">>> Unpacking TFLM..."
   tar zxf "${PREFIX_PORT}/${TFLM_ARCHIVE}" -C "${PREFIX_PORT_BUILD}"
fi


#
# Patching
#

# --- Patching TFLM

if [ -d "${PREFIX_PORT}/patches" ]; then
   for patchfile in "${PREFIX_PORT}/patches/"*.patch; do
       [ -f "$patchfile" ] || continue
       marker="${PREFIX_TFLM_MARKERS}/$(basename "$patchfile").applied"
       if [ ! -f "$marker" ]; then
           echo ">>> Applying patch: $patchfile"
           patch -d "${PREFIX_TFLM_SRC}" -p1 < "$patchfile"
           touch "$marker"
       fi
   done
fi

# --- Patching TFLM's third_party/kissfft 
if [ -f "${PREFIX_TFLM_SRC}/third_party/kissfft/kissfft.patch" ]; then
    echo ">>> Patching KissFFT from TFLM: third_party/kissfft"
    patch -d "${PREFIX_PORT_BUILD}/kissfft/" -p1 < "${PREFIX_TFLM_SRC}/third_party/kissfft/kissfft.patch"
fi

#
# Add CMakeLists.txt
#

echo ">>> Copying CMakeLists.txt"
cp -v "${BASH_SOURCE%/*}/CMakeLists.txt" "${PREFIX_TFLM_SRC}/CMakeLists.txt"


#
# Configureation of compilation tools
#
export CC="${CROSS}gcc"
export CXX="${CROSS}g++"
# export AR="${CROSS}ar" #TODO Why not working ? #Tested only on Docker 
export AR="$(command -v arm-phoenix-ar)"
export LD="${CROSS}ld"
# export RANLIB="${CROSS}ranlib"  #TODO Why not working ? #Tested only on Docker
export RANLIB="$(command -v arm-phoenix-ranlib)"

# Flags
CFLAGS_TFLM="${CFLAGS} -Os -ffunction-sections -fdata-sections -fno-exceptions -fno-rtti"
LDFLAGS_TFLM="${LDFLAGS} -Wl,--gc-sections -lm -lstdc++"


#
# Building TFLM library
#

echo ">>> Building TFLite Micro"
mkdir -p "${PREFIX_TFLM_BUILD}"
pushd "${PREFIX_TFLM_BUILD}"


cmake \
 -DCMAKE_C_COMPILER="${CC}" \
 -DCMAKE_CXX_COMPILER="${CXX}" \
 -DCMAKE_AR="${AR}" \
 -DCMAKE_RANLIB="${RANLIB}" \
 -DCMAKE_C_FLAGS="${CFLAGS_TFLM}" \
 -DCMAKE_CXX_FLAGS="${CFLAGS_TFLM}" \
 -DCMAKE_EXE_LINKER_FLAGS="${LDFLAGS_TFLM}" \
 -DCMAKE_SYSTEM_NAME="Generic" \
 -DCMAKE_BUILD_TYPE=Release \
 -DCMAKE_INSTALL_PREFIX="${PREFIX_PORT_BUILD}" \
 ..


make -j8
make install


popd


echo ">>> TensorFlow Lite Micro installed!"
