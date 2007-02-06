From: Peter Clifton <pcjc2@cam.ac.uk>
Subject: Re: Fan speeds on HP nc6400 and nc8430
Date: Tue, 06 Feb 2007 15:04:56 +0000
Message-ID: <1170774296.5785.6.camel@localhost>
References: <C3FA62B1A90D7440B9B6C7C31895994F0366363A@zadbn02100.vodacom.corp>
	 <3877989d0701232019g45af8feaxabdcf6ba77170a5d@mail.gmail.com>
	 <200701232138.54758.bjorn.helgaas@hp.com>
	 <200701240954.32742.bjorn.helgaas@hp.com>
	 <1170701940.25027.422.camel@d36.suse.de>
	 <3877989d0702060358w101d809ar3b8c8900a8dba7c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:37190 "EHLO
	ppsw-0.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbXBFPHX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Feb 2007 10:07:23 -0500
In-Reply-To: <3877989d0702060358w101d809ar3b8c8900a8dba7c9@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luming Yu <luming.yu@gmail.com>
Cc: trenn@suse.de, Bjorn Helgaas <bjorn.helgaas@hp.com>, emisca <emisca.ml@gmail.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Pieter De Wit <Pieter.DeWit@vodacom.co.za>, linux-acpi@vger.kernel.org, dtor@mail.ru

On Tue, 2007-02-06 at 19:58 +0800, Luming Yu wrote:
> I managed to get a HP NX 6330 laptop to test HP laptop related issues
> discussed here.
> But the bug http://bugzilla.kernel.org/show_bug.cgi?id=7813 seems to
> be NOT reproducible on my NX6330. This fact prompt if there are any
> essential difference between NX6330 and NC6400. The BIOS of my NX6330
> even declares itself is NC6330.

I'm not clear on HP's numbering scheme. It doesn't make any obvious
sense to me!

Mine is a nc6320 which exhibits the above bug. The DSDT lists as nc6340
though. That is an Intel Core Duo, with the following lspci output:

00:00.0 Host bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and
945GT Express Memory Controller Hub (rev 03)
00:02.0 VGA compatible controller: Intel Corporation Mobile
945GM/GMS/940GML Express Integrated Graphics Controller (rev 03)
00:02.1 Display controller: Intel Corporation Mobile 945GM/GMS/940GML
Express Integrated Graphics Controller (rev 03)
00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller (rev 01)
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 1 (rev 01)
00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 3 (rev 01)
00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 4 (rev 01)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
#1 (rev 01)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
#2 (rev 01)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
#3 (rev 01)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
#4 (rev 01)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI
Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e1)
00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface
Bridge (rev 01)
00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE
Controller (rev 01)
00:1f.2 SATA controller: Intel Corporation 82801GBM/GHM (ICH7 Family)
Serial ATA Storage Controller AHCI (rev 01)
02:06.0 CardBus bridge: Texas Instruments Unknown device 8039
02:06.1 FireWire (IEEE 1394): Texas Instruments Unknown device 803a
02:06.2 Mass storage controller: Texas Instruments Unknown device 803b
02:06.3 Class 0805: Texas Instruments Unknown device 803c
02:0e.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5788
Gigabit Ethernet (rev 03)
08:00.0 Network controller: Intel Corporation PRO/Wireless 3945ABG
Network Connection (rev 02)


Peter Clifton


