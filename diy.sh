#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy.sh
# Description: OpenWrt DIY script (After git clone)
#

set -eu

# Apply local changes to the upstream source before compiling.
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
git apply --check "$script_dir/patches/wpa3-personal-5g.patch"
git apply "$script_dir/patches/wpa3-personal-5g.patch"

# 修改Padavan登陆地址
sed -i 's/192.168.2.1"/192.168.5.1"/' trunk/user/shared/defaults.h
sed -i 's/192.168.2.100/192.168.5.50/' trunk/user/shared/defaults.h
sed -i 's/192.168.2.244/192.168.5.100/' trunk/user/shared/defaults.h
