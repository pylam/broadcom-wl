#!/bin/bash

#!/bin/bash

if [[ $UID -ne 0 ]]; then
  echo "$0 must be run as root"
  exit 1
fi

cat > /etc/modprobe.d/blacklist.conf <<EOF
# wireless drivers (conflict with Broadcom hybrid wireless driver 'wl')
blacklist ssb
blacklist bcma
blacklist b43
blacklist brcmsmac
EOF

rmmod b43
rmmod ssb
rmmod bcma
rmmod brcmsmac

sudo dnf -y install dkms kernel-devel
make
make install
depmod -A
modprobe wl

dkms add .
dkms status
