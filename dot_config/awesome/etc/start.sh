sudo pacman -S picom
mkdir /etc/X11/xorg.conf.d

sudo cat >> 20-intel.conf << EOF
Section "Device"
  Identifier "Intel Graphics"
  Driver "intel"
  Option "TearFree" "true"
EndSection
EOF

