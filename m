From: Nils Faerber <nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Subject: Re: [ACPI] RE: ACPI kernel crash with 2.4.22-pre7 on ASUS L3800C
Date: Thu, 04 Sep 2003 11:25:56 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1062667556.13465.37.camel@idoru.kc.de>
References: <BF1FE1855350A0479097B3A0D2A80EE009FCFB@hdsmsx402.hd.intel.com>
	 <20030904085315.GA29773@hell.org.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Ga7ah+o3jiFhdSyXU3oS"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030904085315.GA29773-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Martin Mokrejs <mmokrejs-V2lp6ZUObelkZyP8+xg2CQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-Ga7ah+o3jiFhdSyXU3oS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Am Do, 2003-09-04 um 10.53 schrieb Karol Kozimor:
> Thus wrote Brown, Len:
> > Martin,
> > Does this still happen with 2.4.22?
> > If yes, can I trouble you to drop the info into bugzilla so we can put
> > it in the queue?
> FYI, I just had it *after* boot, i.e. some 30 seconds after the swsusp 
> resume (trace below), and _again_ _after_ I warm-rebooted the machine using
> SysRq+B. The subsequent warm-reboot went OK.
> 
> Linux 2.4.21 + ACPI 20030619
[...]

Just FYI...
I have kernel 2.4.22 + swsusp 1.1-rc7 running without problems on the
very same machine (Asus L3800C, BIOS 121a).
I fiddled a little with a home grown suspend script until I got swsusp
reliably working with older versions (0.9-pre and before) and it still
works perfectly for me; the suspend script from the swsusp project was
too generic and complicated for me ;) I have attached my version in case
someone's interested in it.

One point that proofs to be a good idea is to remove any unnecessary
drivers before suspending, like USB, Firewire and ethernet and to
re-insert them afterwards. The attached script does this.

> Best regards,
CU
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--

--=-Ga7ah+o3jiFhdSyXU3oS
Content-Disposition: attachment; filename=suspend
Content-Type: text/x-sh; name=suspend; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

#!/bin/sh

#
# swsusp suspend helper script
# for Asus L3800C and maybe other notebooks
# by Nils Faerber <nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
#
# Comments and suggestions welcome!
#
# It assumes that XFree is running on VT7 and that VT12 is more
# or less unallocated for debugging output.
# It will remove safe-to-remove drivers before suspend and re-insert them
# afterwards (USB, Firewire, Ethernet, etc.) as well as ejecting a built-in
# WLAN card (mini-PCI).
#

# Prepare for suspend
chvt 12
ifdown eth0 > /dev/tty12 2>&1
ifdown eth1 > /dev/tty12 2>&1
cardctl eject 2 > /dev/tty12 2>&1
rmmod 8139too > /dev/tty12 2>&1

#rmmod usb-uhci > /dev/tty12 2>&1
#rmmod usbmouse > /dev/tty12 2>&1
#rmmod usbnet > /dev/tty12 2>&1
#rmmod usb-storage > /dev/tty12 2>&1
/etc/hotplug/usb.rc stop
rmmod ohci1394 > /dev/tty12 2>&1

# Do it
rmmod -a
sync
rmmod -a
sync
echo "waiting a second..." > /dev/tty12 2>&1
sleep 1
#echo "1 0 2" > /proc/sys/kernel/swsusp
#echo "4" > /proc/acpi/sleep
echo > /proc/swsusp/activate

# Come back
sync
echo "waiting a second..." > /dev/tty12 2>&1
sleep 1

#modprobe usb-uhci > /dev/tty12 2>&1
/etc/hotplug/usb.rc start
modprobe 8139too > /dev/tty12 2>&1
hwclock --hctosys
ifup eth0 > /dev/tty12 2>&1

cardctl insert 2 > /dev/tty12 2>&1

chvt 7 > /dev/tty12 2>&1
modprobe ohci1394 > /dev/tty12 2>&1

--=-Ga7ah+o3jiFhdSyXU3oS--
