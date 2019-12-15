#!/bin/bash

# Ubuntu specific dependencies
if [ -f /etc/os-release ]; then
  eval "$(grep '^ID=' /etc/os-release)"
  if [ "${ID}" == "ubuntu" ]; then
    sudo apt-get install zlib1g-dev libncurses5-dev libreadline-dev
  fi
fi

dir=$(dirname $0)
cd ${dir}

osname=$(echo ${OSTYPE:0:6} | cut -d '-' -f 1)
rm -rf lib/${osname}_amd64
mkdir -p lib/${osname}_amd64

rm -rf build/*
mkdir -p build
cd build

files=(
  'https://www.lua.org/ftp/lua-5.1.5.tar.gz' \
)

targets=(
  'lua'
)

if [ "${osname}" == "linux" ]; then
  platform="linux-x86_64"
else
  platform="darwin64-x86_64-cc"
fi

compilation=(
  "case ${osname} in linux) make linux ;; darwin) make macosx ;; esac && cp src/liblua.a ../../lib/${osname}_amd64 && cp src/{lua,lualib,lauxlib,luaconf}.h ../../include/lua" \
)

count=0
for file in ${files[*]}; do
  wget ${file} -q -O source.tgz
  if [ $? -ne 0 ]; then
    echo "An error occurred while downloading the file ${file}"
    exit 1
  fi
  target=${targets[${count}]}
  mkdir -p ${target}
  tar -xzf source.tgz -C ${target} --strip-components=1
  if [ $? -ne 0 ]; then
    echo "An error occurred while unpacking the file ${file}"
    exit 1
  fi
  mkdir -p ../include/${target}
  cd ${target}
  command=${compilation[${count}]}
  eval "bash -c '${command}'"
  if [ $? -ne 0 ]; then
    echo "An error occurred while compiling ${target}"
    exit 1
  fi
  cd -
  count=$((count+1))
done

rm source.tgz
cd ..
rm -rf build

exit 0

