From: Nikolaus Filus <nfilus-hi6Y0CQ0nG0@public.gmane.org>
Subject: Samsung P35, S3, black screen (radeon)
Date: Sat, 22 Jan 2005 14:42:05 +0100
Message-ID: <20050122134205.GA9354@wsc-gmbh.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

after having a lot trouble to reproduce the situation described by others, 
I was finally able to survive a S3 to get a working console. But I'm still
unable to get the screen on and it stays dark. I tried several permutations
off all found hints, but no success so far.

The System: 
 linux-2.6.10 + resume-finish-split + pci-resume-2.6.9 + pci-resume-old
	vesa:off radeonfb:off (fbcon:on)
 xorg-6.8.0-r3 (gentoo, radeon s3 patch included)

I tested with the appended script, with several freezes and always black
screen. MagicSysRq-Boot and PowerOff works most the time, so the kernel
responds. Another observation was, when starting the vesa X11 for the first
time, I can see rests of the Samsung Boot logo, which seems to stay
in memory (maybe a hint for incorrect POST address later by the tools?!).

Like Mathias Hentges wrote, the vesa X11 crashes after resume.
Saving VBE state after vbetool post freezes the machine.

Any hints?!


-- 
out of signatures

--YZ5djTAD1cGYuMQK
Content-Type: application/x-sh
Content-Disposition: attachment; filename="s3niko.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0A=0Aclear > /dev/tty9=0A=0Afunction mecho {=0A	if test -z "$2"=
 ; then=0A		echo "$1" >> /dev/tty9=0A		echo "[`date +"%d.%m.%y-%H:%M:%S"`]$=
1" >> /s3.log=0A	else=0A		echo $1 "$2" >> /dev/tty9=0A		echo $1 "[`date +"%=
d.%m.%y-%H:%M:%S"`]$2" >> /s3.log=0A	fi	=0A}=0A=0Amecho " * * * * * PREPARI=
NG TO SUSPEND * * * * *"=0A=0Aumount /proc/bus/usb=0Amodclean=0A=0Achvt 9 |=
| die "chvt 9 failed"=0Amecho "-> starting radeon X11 screen"=0A=0AX -confi=
g /etc/X11/mini.conf :1 &>/dev/null &=0Asleep 5=0A=0Amecho "-> starting VES=
A X11 screen"=0A=0AX -config /etc/X11/vesa.conf :2 &>/dev/null &=0Asleep 5=
=0A=0Amecho "-> changing back to VT1"=0Achvt 9 || die "chvt 9 failed"=0A=0A=
mecho "-> Syncing drives"=0Async =0A=0Amecho "* * * * * GOING DOWN * * * * =
*"=0A#echo 4 > /proc/acpi/sleep=0Aecho -n mem > /sys/power/state=0A=0Amecho=
 "* * * * * WAKING UP * * * * *"=0A=0Asleep 3=0Amecho "-> running all that =
post tools"=0A /boot-vga-bios	;	sleep 2=0A /boot-radeon ;		sleep 2=0A /vbet=
ool post ;	sleep 2=0A /vbestate restore < /vbestate.state ;	sleep 2=0A /vm8=
6_video_post ;	sleep 2=0A=0Amecho "-> running vbetool state and dpms on"=0A=
/vbetool vbestate restore </vbetool.state=0A/vbetool dpms on=0A=0Asleep 3=
=0A=0Amecho "-> changing to VT8 vesa screen"=0Achvt 8 &=0A=0Asleep 2=0A=0Am=
echo "-> changing to VT7 radeon screen"=0Achvt 7=0A=0Amecho "saving ps ax"=
=0Aps ax > /psax.log=0A=0A#saving freezes the machine :(=0A#mecho "-> savin=
g vbetool state"=0A#/vbetool vbestate save >/vbetool.after=0A#mecho "-> sav=
ing vbestate state" =0A#/vbestate save >/vbestate.after=0A=0Amecho "-> sync=
ing ..."=0Async=0A
--YZ5djTAD1cGYuMQK--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
