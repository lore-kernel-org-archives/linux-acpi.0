From: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>
Subject: Re: bluetooth button is dead
Date: Tue, 21 Dec 2004 20:37:54 +0100
Message-ID: <m2d5x3l9wt.fsf@phoenix.squirrel.nl>
References: <20041221150316.14A5D9DA3B@phoenix.squirrel.nl>
	<200412211628.47370.sanskryt@op.pl>
	<m2hdmflbhe.fsf@phoenix.squirrel.nl>
	<200412212014.36223.sanskryt@op.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200412212014.36223.sanskryt-FWhLrETftxM@public.gmane.org>
 =?iso-8859-2?q?=28Zdzis=B3aw?= A. Kaleta's message of "Tue, 21 Dec 2004 20:14:35 +0100")
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: sanskryt-FWhLrETftxM@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable

"Zdzis=B3aw A. Kaleta" <sanskryt-FWhLrETftxM@public.gmane.org> writes:

> I think the answer is yes. Just try.
> Please for security cc it to my priv ;-)

Okay. Attached is "acer_keys", a script to run at boot time to map all
unmapped Acer specific keys to keycodes.
Note that the key code set is different from the one received by X,
but that seems to be a known problem.
Also attached is ".xbindkeysrc", a bindkeys configuration to intercept
some of these keys and do something.
xbindkeys is probably on your computer already, if not, use Google.
xosd is a small script (attached) that uses osd-cat (Google) to show
on-screen message.

Have phun!


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=acer_keys
Content-Description: acer key settings

#!/bin/bash
#
# chkconfig: 2345 55 25
# description: Acer TravelMate 4001 Key codes
#
# source function library
. /etc/rc.d/init.d/functions

RETVAL=0

start()
{
	
	echo -n $"Setting Acer TravelMate key codes: "
# Set valid keycodes for all additional keys of the Acer TravelMate 4001.
# WARNING: The key code set is not always the one returned by X event!

# Euro-key near the cursor block
setkeycodes e033 89 # X: 211
# $-key near the cursor block
setkeycodes e034 90 # X: 128
# WiFi/RF [front of the latptop]
setkeycodes e055 88 # on, X: 96
setkeycodes e056 91 # off, X: 127
# Bluetooth [front of the laptop]
setkeycodes e058 92 # X: 129

# "p" key [near power button]
setkeycodes e073 93 # X: 208
# "e" key [near power button]
setkeycodes e074 94 # X: 131
# "Planet" key [near power button]
# keycode 178
# "Mail" key [near power button]
# keycode 236

# Fn F1 [?]
setkeycodes e025 140 # X: 161
# Fn F2 [ ]
setkeycodes e026 141 # X: 108
# Fn F3 [ ]
setkeycodes e027 142 # X: 109
# Fn F4 [Zz]
# ACPI button/sleep SLPB event
# Fn F5 [Video Aux]
setkeycodes e029 143 # X: 227
# Fn F6 [Display Backlight]
# -- no key/event --
# Fn F7 [Touchpad on]
setkeycodes e071 144 # X: 198
# Fn F7 [Touchpad off]
setkeycodes e072 145 # X: 199
# Fn F8 [Mute]
# keycode 160

# Fn Up [Vol incr]
# keycode 176
# Fn Left [Display darker]
# keycode 239
# Fn Down [Vol decr]
# keycode 174
# Fn Right [Display brighter]
setkeycodes e06e 238 # X: 243

# Panel close
# ACPI button/lib LID event
	success
	echo
}

case "$1" in
	start)
		start
		;;
	stop)
		;;
	restart)
		start
		;;
	reload)
		reload
		;;
	*)
		echo $"Usage: $0 {start|stop}"
		RETVAL=1
esac
exit $RETVAL

--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=.xbindkeysrc-eithne
Content-Description: .xbindkeysrc

# For the benefit of emacs users: -*- shell-script -*-

"xbk_aumix incr"
  c:176

"xbk_aumix decr"
  c:174

"xbk_aumix mute"
  c:160

"echo Touchpad Off | xosd -- -"
  c:199

"echo Touchpad On | xosd -- -"
  c:198

"echo Display: Darker | xosd -- -"
  c:239

"echo Display: Brighter | xosd -- -"
  c:243

"echo WiFi Off | xosd -- -"
  c:127

"echo WiFi On | xosd -- -"
  c:96

"echo BlueTooth | xosd -- -"
  c:129

"xbk_sysinfo info"
  c:161

--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=xosd
Content-Description: xosd

#!/bin/sh

exec /usr/bin/osd_cat \
    --font='-b&h-lucidasans-bold-r-normal-sans-0-480-0-0-p-0-iso8859-1' \
    --font='-b&h-luxi sans-bold-r-normal--0-480-0-0-p-0-iso8859-1' \
    --shadow=1 \
    --color=green \
    --pos=middle \
    --align=center \
    --delay=2 \
    ${1+"$@"}

--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=xbk_aumix
Content-Description: xbk_aumix

#!/bin/sh

cd $HOME

action=$1; shift
killall -q osd_cat > /dev/null 2>&1

get_volume() {
    volume=`aumix -q | sed -ne 's/^vol \([^,]*\).*/\1/p'`
}

show_volume() {
    xosd --text Volume:\ $1 --barmode=percentage --percentage=$1
}

case "$action" in

incr)
    delta=${1:-5}
    rm -f .mutevol
    aumix -v +$delta
    get_volume
    show_volume $volume
    ;;

decr)
    delta=${1:-5}
    rm -f .mutevol
    aumix -v -$delta
    get_volume
    show_volume $volume
    ;;

mute)
    if [ -s .mutevol ]
    then
	vol=`cat .mutevol`
	rm -f .mutevol
	aumix -v $vol
	# echo "Volume: $vol" | xosd -- -
	show_volume $vol
    else
	get_volume
	[ $volume != 0 ] && echo $volume > .mutevol
	aumix -v 0
	echo "Volume: muted" | xosd -- -
    fi
    ;;
esac


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=xbk_sysinfo
Content-Description: xbk_sysinfo

#!/bin/sh

cd $HOME

action=$1; shift
killall -q osd_cat > /dev/null 2>&1

case "$action" in

info)
    thrm=/proc/acpi/thermal_zone/THRM
    fan=/proc/acpi/fan
    power=/proc/acpi/processor
    (
	sed -ne 's/^active state: *\(.*\)/CPU state: \1/p' $power/CPU*/power
	sed -e 's/  */ /g' $thrm/temperature
	sed -e 's/  */ /g' $thrm/state
	sed -e 's/	/ /g' $thrm/cooling_mode
	sed -e 's/status: */fan: /' $fan/FAN*/state
    )| xosd --lines=6 --delay=3 -- -
    ;;

esac


--=-=-=--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
