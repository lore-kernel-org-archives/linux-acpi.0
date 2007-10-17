From: Maik Broemme <mbroemme@plusserver.de>
Subject: Re: [PATCH 2/2] Recent Lenovo ThinkPads define a dummy grahpics
	device, find it and ignore it
Date: Wed, 17 Oct 2007 12:12:52 +0200
Message-ID: <20071017101252.GA2934@bart.intergenia.de>
References: <1192465995.9847.587.camel@queen.suse.de> <20071016175053.GB17671@netswarm.net> <20071016180919.GH7262@bart.intergenia.de> <1192609537.9847.630.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from isis45.plusserver.de ([217.172.174.164]:41138 "EHLO
	isis45.plusserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233AbXJQKNe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Oct 2007 06:13:34 -0400
Content-Disposition: inline
In-Reply-To: <1192609537.9847.630.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Christian Birchinger <joker@netswarm.net>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>, ibm-acpi-devel <ibm-acpi-devel@lists.sourceforge.net>

Hi,

Thomas Renninger <trenn@suse.de> wrote:
> On Tue, 2007-10-16 at 20:09 +0200, Maik Broemme wrote:
> > Hi,
> > 
> > Christian Birchinger <joker@netswarm.net> wrote:
> > > On Mon, Oct 15, 2007 at 06:33:15PM +0200, Thomas Renninger wrote:
> > > > Recent Lenovo ThinkPads define a dummy grahpics device, find it and ignore it
> > > 
> > > I think it's ok. dmesg says:
> > > 
> > > ACPI: Video device VID not physically connected, ignoring
> > > input: Video Bus as /devices/virtual/input/input11
> > > ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
> > > 
> > 
> > No i think thats not enough because not everyone is using the ACPI video
> > extension at this moment and at least for my ThinkPad X61 i got:
> > 
> > babyface@bart:~$ ls /proc/acpi/video/VID
> > CRT0  DOS  DVI0  LCD0  POST  POST_info  ROM  info
> > babyface@bart:~$ ls /proc/acpi/video/VID1
> > CRT0  DOS  DVI0  LCD0  POST  POST_info  ROM  info
> > 
> > input: Video Bus as /devices/virtual/input/input3
> > ACPI: Video Device [VID] (multi-head: yes rom: no  post: no)
> > input: Video Bus as /devices/virtual/input/input4
> > ACPI: Video Device [VID1] (multi-head: yes rom: no  post: no)
> > 
> > Anyway, also tools like lspci should show you the fake vga device and
> > the X.org will complaint about it like:
> > 
> > (WW) intel: No matching Device section for instance (BusID PCI:0:2:1) found
> > 
> > And if you add this section (just for people who want to fix those
> > warnings) your X server will no longer start. :) Can someone correct me if
> > i am wrong?
> Can you send lspci output and check your BIOS version (dmidecode |less,
> there should be a string like KEWWT456 and a version, not sure, AFAIK
> 2.01 should be about the latest...).
> 

First sorry Thomas, it was my fault with ACPI video, i habe at this
moemnt to many different modules of that for testing and used the wrong
one at time of writing the e-mail yesterday. :) It is correct now and
looks like:

babyface@bart:~$ dmesg | grep video -i
Boot video device is 0000:00:02.0
input: Video Bus as /devices/virtual/input/input3
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
ACPI: Video device VID not physically connected, ignoring

This will fix the issue with multiple VID devices in /proc but the rest
will still occur, of course this is no fault of ACPI video. X.org will
still show:

(II) Primary Device is: PCI 00:02:0
(WW) intel: No matching Device section for instance (BusID PCI:0:2:1) found
(--) Chipset 965GM found

babyface@bart:~$ lspci 
00:00.0 Host bridge: Intel Corporation Mobile PM965/GM965/GL960 Memory Controller Hub (rev 0c)
00:02.0 VGA compatible controller: Intel Corporation Mobile GM965/GL960 Integrated Graphics Controller (rev 0c)
00:02.1 Display controller: Intel Corporation Mobile GM965/GL960 Integrated Graphics Controller (rev 0c)
00:19.0 Ethernet controller: Intel Corporation 82566MM Gigabit Network Connection (rev 03)
00:1a.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Contoller #4 (rev 03)
00:1a.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #5 (rev 03)
00:1a.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI Controller #2 (rev 03)
00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio Controller (rev 03)
00:1c.0 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 1 (rev 03)
00:1c.1 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 2 (rev 03)
00:1d.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #1 (rev 03)
00:1d.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI Controller #2 (rev 03)
00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI Controller #1 (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev f3)
00:1f.0 ISA bridge: Intel Corporation 82801HBM (ICH8M-E) LPC Interface Controller (rev 03)
00:1f.1 IDE interface: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E) IDE Controller (rev 03)
00:1f.2 SATA controller: Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E) SATA AHCI Controller (rev 03)
00:1f.3 SMBus: Intel Corporation 82801H (ICH8 Family) SMBus Controller (rev 03)
03:00.0 Network controller: Intel Corporation PRO/Wireless 3945ABG Network Connection (rev 02)
05:00.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev ba)
05:00.1 FireWire (IEEE 1394): Ricoh Co Ltd R5C832 IEEE 1394 Controller (rev 04)
05:00.2 Class 0805: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter (rev 21)

ThinkPad BIOS 7SET18WW (1.04)
ThinkPad EC 7RHT16WW (1.02)

Notebook is a X61 tablet and the latest bios would be 1.06, but i had not
enough time to upgrade it. With dmidecode i was not able to find a string
called KEWWT456.

> Thanks,
> 
>     Thomas

--Maik
