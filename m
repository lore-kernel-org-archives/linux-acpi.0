From: "Li, Shaohua" <shaohua.li@intel.com>
Subject: RE: How to get /proc/acpi/alarm to work
Date: Wed, 18 Jan 2006 10:47:34 +0800
Message-ID: <59D45D057E9702469E5775CBB56411F101682685@pdsmsx406>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:19368 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S964863AbWARCrf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2006 21:47:35 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanno Mueller <sockpuppet@hanno.de>
Cc: linux-acpi@vger.kernel.org

Hi,
>Linux: 2.6.15.1 vanilla
>Mainboard: ASRock P4V88+, revision 1.00
>BIOS: Updated to 1.6 (latest release from manufacturer's site)
>
>
>My mainboard's BIOS allows to set an RTC wakeup time and day (not month
>or year) in its ACPI settings.
>
>This will wakeup the system from the S5 state.
>
>
>Problem: It is not possible to set this value through /proc/acpi/alarm.
>
>
>It's possible to write valid value to /proc/acpi/alarm and to retrieve
>it [1]:
>
># echo "2006-01-18 03:00:00" > /proc/acpi/alarm
># cat /proc/acpi/alarm
>2006-01-18 03:00:00
>
>After a reboot the stored value is broken [2]:
>
># cat /proc/acpi/alarm
>2006-00-00 03:00:00
>
>The alarm time does not wake up the system. It doesn't wake up at
>03:00:00 BIOS time, not today, not tomorrow, not on 2006-01-18.
>
>Also, the alarm time does not show up in the BIOS's ACPI settings.
>There, one can still find the old values that where entered several
>boots ago.
>
>
>Since the mainboard explicitely lists this function in its ACPI
>settings, I guess that the Linux kernel somehow doesn't handle my
>mainboard right.
>
>I'm aware that there are many broken ACPI implementations on mainboards
>out there. Is there any way I can find out how to fix this issue? Is
>there a debugging guide for this? [3]
Is it possible you could try the patch at 
http://bugzilla.kernel.org/show_bug.cgi?id=5833?
Christian Lupien's patch made a lot of improvements on alarm.

Thanks,
Shaohua
