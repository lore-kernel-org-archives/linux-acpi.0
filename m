From: Maciej Kotlinski <mkotl@ibb.waw.pl>
Subject: Suspend to ram 2.6.20-rc4
Date: Wed, 10 Jan 2007 19:40:54 +0100
Message-ID: <45A53336.7010201@ibb.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from poczta.ibb.waw.pl ([212.87.28.201]:46481 "EHLO ibb.waw.pl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965023AbXAJSlG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Jan 2007 13:41:06 -0500
Received: from hieracium.ibb.waw.pl ([212.87.28.96]:51430)
	by ibb.waw.pl with esmtp (Exim 4.52)
	id 1H4iQZ-0006gx-6i
	for linux-acpi@vger.kernel.org; Wed, 10 Jan 2007 19:44:04 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I have problem with suspending my laptop (Toshiba Tecra M5-384 -
Core2Duo, Nvidia Quadro NVS110, Intel SATA HDD controler on pIIx SATA
driver).
Problem occurs in kernel 2.6.19, 2.6.19.1 and 2.6.20 all versions
including rc4. I haven't tested any older kernels.

When I try to suspend to RAM (echo mem > /sys/power/state) system start
suspend
process. I can see on the console that second CPU is down and some messages
saying that USB ports are also stopped. Then screen becomes black (off)
but CPU
fan is working and power LED is green (should blink). I can't connect to the
computer from network and SysRq keys don't work.
I try to suspend from runlevel 1 or 2 witch no modules loaded.

Entering s3_sleep=bios as kernel parameter doesn't help

I tried to turn pm_trace on. It shows this in dmesg:

ACPI: (supports S0 S3 S4 S5)
  Magic number: 7:0:150
  hash matches device ttyp4

I don't know if it has any sens. In documentation they say that pm_trace 
is for debugging resume after suspend, but it show sth.

My lspci:
0000:00:00.0 Host bridge: Intel Corporation Mobile Memory Controller Hub
(rev 03)
0000:00:01.0 PCI bridge: Intel Corporation Mobile PCI Express Graphics
Port (rev 03)
0000:00:1b.0 0403: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller (rev 02)
0000:00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI
Express Port 1 (rev 02)
0000:00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI
Express Port 2 (rev 02)
0000:00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI
Express Port 3 (rev 02)
0000:00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #1 (rev 02)
0000:00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #2 (rev 02)
0000:00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #3 (rev 02)
0000:00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #4 (rev 02)
0000:00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2
EHCI Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2)
0000:00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC
Interface Bridge (rev 02)
0000:00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family)
Serial ATA Storage Controllers cc=IDE (rev 02)
0000:01:00.0 VGA compatible controller: nVidia Corporation: Unknown
device 01da (rev a1)
0000:02:00.0 Ethernet controller: Intel Corporation 82573L Gigabit
Ethernet Controller
0000:05:00.0 Network controller: Intel Corporation: Unknown device 4222
(rev 02)
0000:06:0b.0 CardBus bridge: Texas Instruments: Unknown device 8039
0000:06:0b.1 FireWire (IEEE 1394): Texas Instruments: Unknown device 803a
0000:06:0b.3 0805: Texas Instruments: Unknown device 803c



