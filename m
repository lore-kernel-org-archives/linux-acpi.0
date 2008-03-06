From: "Kostis Anagnostopoulos" <ankostis@gmail.com>
Subject: ACPI kernel logs for 2.6.24 on VESTEL
Date: Thu, 6 Mar 2008 03:42:43 +0200
Message-ID: <b02f340d0803051742s78fe56cfs2816d70b513e65ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:60754 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757670AbYCFBmn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Mar 2008 20:42:43 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1999735wah.23
        for <linux-acpi@vger.kernel.org>; Wed, 05 Mar 2008 17:42:43 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,
i've seen the advice in kernel logs to send toy the ACPI report.
I have a Laptop with problematic HID Mapper support
(and consequently i cannot use fn keys to enable bluetooth)
Herei is the kernel log:
ACPI: EC: Look up EC in DSDT
ACPI: BIOS _OSI(Linux) query ignored
ACPI: DMI System Vendor: VESTEL
ACPI: DMI Product Name: ARES
ACPI: DMI Product Version: 1
ACPI: DMI Board Name: The Sun
ACPI: DMI BIOS Vendor: VESTEL
ACPI: DMI BIOS Date: 11/10/2007
ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
And here ae some more infos:
> uname -a
Linux hostnae 2.6.24-gentoo-r2 #1 SMP PREEMPT Fri Feb 29 22:19:29 EET
2008 i686 Intel(R) Core(TM)2 Duo CPU T8300 @ 2.40GHz GenuineIntel
GNU/Linux
> lspci
00:00.0 Host bridge: Intel Corporation Mobile PM965/GM965/GL960 Memory
Controller Hub (rev 03)
00:01.0 PCI bridge: Intel Corporation Mobile PM965/GM965/GL960 PCI
Express Root Port (rev 03)
00:1a.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB
UHCI Contoller #4 (rev 03)
00:1a.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB
UHCI Controller #5 (rev 03)
00:1a.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2
EHCI Controller #2 (rev 03)
00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio
Controller (rev 03)
00:1c.0 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express
Port 1 (rev 03)
00:1c.1 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express
Port 2 (rev 03)
00:1c.5 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express
Port 6 (rev 03)
00:1d.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB
UHCI Controller #1 (rev 03)
00:1d.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB
UHCI Controller #2 (rev 03)
00:1d.2 USB Controller: Intel Corporation 82801H (ICH8 Family) USB
UHCI Controller #3 (rev 03)
00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2
EHCI Controller #1 (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev f3)
00:1f.0 ISA bridge: Intel Corporation 82801HEM (ICH8M) LPC Interface
Controller (rev 03)
00:1f.1 IDE interface: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E)
IDE Controller (rev 03)
00:1f.2 SATA controller: Intel Corporation 82801HBM/HEM
(ICH8M/ICH8M-E) SATA AHCI Controller (rev 03)
00:1f.3 SMBus: Intel Corporation 82801H (ICH8 Family) SMBus Controller (rev 03)
01:00.0 VGA compatible controller: nVidia Corporation GeForce 8600M GT (rev a1)
02:00.0 Network controller: Intel Corporation PRO/Wireless 4965 AG or
AGN Network Connection (rev 61)
04:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 02)
05:02.0 FireWire (IEEE 1394): O2 Micro, Inc. Firewire (IEEE 1394) (rev 02)
05:02.2 SD Host controller: O2 Micro, Inc. Integrated MMC/SD Controller (rev 01)
05:02.3 Mass storage controller: O2 Micro, Inc. Integrated MS/xD
Controller (rev 01)
> lsusb
Bus 004 Device 005: ID 08ff:1600 AuthenTec, Inc.
Bus 004 Device 004: ID 04b4:0202 Cypress Semiconductor Corp.
Bus 004 Device 001: ID 0000:0000
Bus 002 Device 004: ID 0a12:0001 Cambridge Silicon Radio, Ltd
Bluetooth Dongle (HCI mode)
Bus 002 Device 001: ID 0000:0000
Bus 006 Device 002: ID 0c45:62c0 Microdia
Bus 006 Device 001: ID 0000:0000
Bus 001 Device 001: ID 0000:0000
Bus 007 Device 004: ID 1164:1efc YUAN High-Tech Development Co., Ltd
Bus 007 Device 001: ID 0000:0000
Bus 005 Device 001: ID 0000:0000
Bus 003 Device 001: ID 0000:0000
I'm willing to help you debug it.
Thank you for your helpful kerel message!
Kostis
