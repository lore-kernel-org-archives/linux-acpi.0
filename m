From: Joerg Platte <jplatte@naasa.net>
Subject: Re: [2.6.30] Kernel bug with dock driver
Date: Mon, 15 Jun 2009 09:36:39 +0200
Message-ID: <200906150936.41983.jplatte@naasa.net>
References: <200906142100.48621.jplatte@naasa.net> <20090615020226.GA30720@khazad-dum.debian.net>
Reply-To: jplatte@naasa.net
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rosi.naasa.net ([212.8.0.13]:43699 "EHLO rosi.naasa.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796AbZFOHgn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Jun 2009 03:36:43 -0400
In-Reply-To: <20090615020226.GA30720@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Am Monday, 15. June 2009 schrieb Henrique de Moraes Holschuh:
> Do it in single user mode with udev helpers *killed*, but just releas=
e

Today I tried to reproduce the bug in runlevel 2 (Debian based system) =
without=20
success, even after a suspend to disk. In the past this was one method =
to=20
trigger bugs with the bay.

> the lever, _don't_ pull the drive off the bay, unless you do verify t=
hat
> the bay LED went off.
>
> ***NEVER*** remove an Ultrabay device with the Ultrabay LED still lit=
,
> especially if it is a PATA device.

I did this accidentally some times before and the bay is still working.=
 But=20
I'll try to not to do it again :)

> If the bug cannot be reproduced in that condition, it is happening
> because userspace is trapping the lever release event (as it should),
> and doing something the kernel doesn't like with it (which is a bug
> in the kernel in any case).  That might help you track down a better
> way to reproduce the issue.

Userspace scripts are written by me (based on some information from=20
thinkwiki).=20
The udev rule looks like this:
ATTR{type}=3D=3D"ata_bay", ATTR{docked}=3D=3D"1", KERNEL=3D=3D"dock.*",=
 ACTION=3D=3D"change",=20
SUBSYSTEM=3D=3D"platform", RUN+=3D"/usr/local/sbin/ultrabay_open"

and ultrabay_open contains the following lines of shell code:
#!/bin/bash
ULTRABAY_SYSDIR=3D'/sys/class/scsi_device/1:0:0:0/device'
shopt -s nullglob

if [ -d $ULTRABAY_SYSDIR ]; then
        sync
        echo 1 > $ULTRABAY_SYSDIR/delete
        logger "removed $ULTRABAY_SYSDIR"
fi
sync
# Turn off power to the UltraBay:
if [ -f /sys/devices/platform/dock.2/undock ]; then
        echo 1 > /sys/devices/platform/dock.2/undock
        logger "/sys/devices/platform/dock.2/undock"
else
        echo eject > /proc/acpi/ibm/bay
fi
# Tell the user we're OK
logger "/proc/acpi/ibm/beep"
echo 12 > /proc/acpi/ibm/beep

What I discovered today after modifying ultrabay_open was that in some =
cases=20
the script is called again directly after inserting a drive to the bay.=
 But=20
only, if the execution of this script takes some more time (I added a s=
leep 2=20
after the second sync to be able to see which command might trigger the=
 bug).

So maybe yesterday this script was called twice and the kernel does not=
 like=20
to undock a device while it is in the process of being undocked? How sh=
ould I=20
modify the udev rule to prevent another execution each time a drive is=20
inserted into the bay?

regards,
J=F6rg

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
