# Introduction
Makefile to create package p7zip for [LEDE](https://lede-project.org)/[OpenWrt](https://openwrt.org/).
Only `7z` `7za` and `7zr` is available.

# Usage
```bash
cd lede-sdk/
git clone https://github.com/swordv2/p7zip-lede.git package/p7zip
make menuconfig
```

Check `Ultilities`->`Compression`->`p7zip-7z`/`p7zip-7za`/`p7zip-7zr`

```bash
make -j 1 V=s
```

And you'll get the ipk file under `bin` directory.
