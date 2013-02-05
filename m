From: Dag Wieers <dag@wieers.com>
Subject: ACPI capabilities on AppleTV (1st gen)
Date: Tue, 5 Feb 2013 13:06:30 +0100 (CET)
Message-ID: <alpine.LRH.2.02.1302051247260.2736@pikachu.3ti.be>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pikachu.3ti.be ([188.40.111.73]:48476 "EHLO pikachu.3ti.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751437Ab3BEMQS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Feb 2013 07:16:18 -0500
Received: from localhost (localhost [127.0.0.1])
	by pikachu.3ti.be (Postfix) with ESMTP id 4A9992118F
	for <linux-acpi@vger.kernel.org>; Tue,  5 Feb 2013 13:06:31 +0100 (CET)
Received: from pikachu.3ti.be ([127.0.0.1])
	by localhost (pikachu.3ti.be [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id FjsWM7+H7Y9w for <linux-acpi@vger.kernel.org>;
	Tue,  5 Feb 2013 13:06:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by pikachu.3ti.be (Postfix) with ESMTP id 8CD8E2118F
	for <linux-acpi@vger.kernel.org>; Tue,  5 Feb 2013 13:06:30 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

For the OpenELEC project I am looking into what exact ACPI capabilities 
the AppleTV (1st gen) hardware has that we can take advantage of. I am 
specifically looking for ways to:

  - make the device consume less power and produce less heat
  - allow it to suspend/resume (maybe triggered by WOL or IR)

The 1st generation AppleTV device is using a stripped down Intel 
architecture with the following devices:

----
root ~ # lspci
00:00.0 Host bridge: Intel Corporation Mobile 945GM/PM/GMS, 943/940GML and 945GT Express Memory Controller Hub (rev 03)
00:01.0 PCI bridge: Intel Corporation Mobile 945GM/PM/GMS, 943/940GML and 945GT Express PCI Express Root Port (rev 03)
00:07.0 Performance counters: Intel Corporation Device 27a3 (rev 03)
00:1b.0 Audio device: Intel Corporation N10/ICH 7 Family High Definition Audio Controller (rev 02)
00:1c.0 PCI bridge: Intel Corporation N10/ICH 7 Family PCI Express Port 1 (rev 02)
00:1d.0 USB controller: Intel Corporation N10/ICH 7 Family USB UHCI Controller #1 (rev 02)
00:1d.7 USB controller: Intel Corporation N10/ICH 7 Family USB2 EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2)
00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface Bridge (rev 02)
00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller (rev 02)
00:1f.3 SMBus: Intel Corporation N10/ICH 7 Family SMBus Controller (rev 02)
01:00.0 VGA compatible controller: NVIDIA Corporation G72M [Quadro NVS 110M/GeForce Go 7300] (rev a1)
02:00.0 Multimedia controller: Broadcom Corporation BCM70015 Video Decoder [Crystal HD]
03:03.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
----

It has a custom BIOS (which requires a special bootloader, atv-bootloader). 
The device has no buttons whatsoever and comes with an IR remote control.

It appears that the device cannot be powered off through normal 
instructions (which somehow makes sense as there is power button) however 
if it would have WOL capabilities (uncertain) this would be useful.
I noticed that the device does provide a LNXPWRBN:00 entry though.

Having a way to properly power it off could be useful so that an external 
(remote) powerswitch can be used for powering it back on.

There are rumours that the device also does not have proper ACPI 
capabilities to suspend/resume. I do find this for waking up the system:

root ~ # cat /proc/acpi/wakeup
Device  S-state   Status   Sysfs node
PXS1      S4    *disabled  pci:0000:02:00.0
USB1      S3    *enabled   pci:0000:00:1d.0
USB7      S3    *enabled   pci:0000:00:1d.7

Since I am not very knowledgeable about ACPI, I am looking for someone who 
can help me with understanding the capabilities of the device (and/or 
improving the support).

The Linux kernel boot output is available from:

     http://sprunge.us/GIOX

I added pmtools and ACPICA tools in order to disassemble the ACPI tables, 
and can provide you with those if needed. The DSDT table is already 
available from:

     http://sprunge.us/JPff

Any help is appreciated,
-- 
-- dag wieers, dag@wieers.com, http://dag.wieers.com/
-- dagit linux solutions, info@dagit.net, http://dagit.net/

[Any errors in spelling, tact or fact are transmission errors]
