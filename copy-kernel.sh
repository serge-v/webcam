set -x
set -e

kernel=`find ~/obj -name kernel`
mods=`find ~/obj -name if_urtwn.ko -o -name wlan_ccmp.ko -o -name wlan_tkip.ko -o -name wlan_wep.ko -o -name firmware.ko -o -name wlan.ko -o -name urtwn*.ko`
files="$HOME/dist/etc/devd.conf $HOME/dist/etc/pccard_ether"

for f in "$kernel $mods $files" ; do
	rsync -vz $f freebsd@192.168.1.14:
done

