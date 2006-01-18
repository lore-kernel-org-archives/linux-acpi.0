From: Hanno Mueller <sockpuppet@hanno.de>
Subject: How to get /proc/acpi/alarm to work
Date: Wed, 18 Jan 2006 02:42:54 +0100
Message-ID: <43CD9D1E.6010205@hanno.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from p-dns.epublica.de ([213.238.59.9]:12235 "EHLO
	kermit.epublica.de") by vger.kernel.org with ESMTP id S1751288AbWARBm7
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jan 2006 20:42:59 -0500
Received: from p548e9abd.dip0.t-ipconnect.de ([84.142.154.189] helo=[192.168.178.20])
	by kermit.epublica.de with esmtp (Exim 3.36 #2 (Debian))
	id 1Ez2Le-0000ri-00
	for <linux-acpi@vger.kernel.org>; Wed, 18 Jan 2006 02:42:54 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,


Linux: 2.6.15.1 vanilla
Mainboard: ASRock P4V88+, revision 1.00
BIOS: Updated to 1.6 (latest release from manufacturer's site)


My mainboard's BIOS allows to set an RTC wakeup time and day (not month
or year) in its ACPI settings.

This will wakeup the system from the S5 state.


Problem: It is not possible to set this value through /proc/acpi/alarm.


It's possible to write valid value to /proc/acpi/alarm and to retrieve
it [1]:

# echo "2006-01-18 03:00:00" > /proc/acpi/alarm
# cat /proc/acpi/alarm
2006-01-18 03:00:00

After a reboot the stored value is broken [2]:

# cat /proc/acpi/alarm
2006-00-00 03:00:00

The alarm time does not wake up the system. It doesn't wake up at
03:00:00 BIOS time, not today, not tomorrow, not on 2006-01-18.

Also, the alarm time does not show up in the BIOS's ACPI settings.
There, one can still find the old values that where entered several
boots ago.


Since the mainboard explicitely lists this function in its ACPI
settings, I guess that the Linux kernel somehow doesn't handle my
mainboard right.

I'm aware that there are many broken ACPI implementations on mainboards
out there. Is there any way I can find out how to fix this issue? Is
there a debugging guide for this? [3]


Thanks,

Hanno



[1] Yes, when I tried this, it was a date and time in the future. I read
somewhere that a past or invalid date will turn off the alarm time setting.

[2] I read in a forum that calling /sbin/hwclock can mess with the alarm
value. When I tried the things above, I removed the /sbin/hwclock calls
from my system's init.d-scripts, but that didn't help.

[3] The same mainboard does not work with nvram-wakeup, which is a
popular older program used by many Linux vdr/pvr setups. nvram-wakeup
uses /dev/nvram to store the wakeup time directly in the NVRAM section.
Ugly, but it works with two other (older) mainboards I tried. On my
current mainboard, however, the alarm timer bytes do not appear to be
accessible through NVRAM.
