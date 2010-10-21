From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: booting "nosmp" kernel causing ACPI errors
Date: Thu, 21 Oct 2010 16:25:03 -0700
Message-ID: <20101021162503.8511f92a.akpm@linux-foundation.org>
References: <4CB9D69D.60203@upmc.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42900 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756172Ab0JUXZI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Oct 2010 19:25:08 -0400
In-Reply-To: <4CB9D69D.60203@upmc.fr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bernard Pidoux <bernard.pidoux@upmc.fr>

On Sat, 16 Oct 2010 18:45:17 +0200
Bernard Pidoux <bernard.pidoux@upmc.fr> wrote:

> Hi,
> 
> I observed ACPI errors when booting 2.6.35.7 kernel with "nosmp" argument.
> dmesg shows a warning message starting with :
> WARNING: at mm/page_alloc.c:1981 __alloc_pages_nodemask+0x5b4/0x6d0()
> +Hardware name: MS-7519
> +Modules linked in:
> +Pid: 1, comm: swapper Not tainted 2.6.35.7 #2
> 
> This is followed by ACPI error messages and /proc/interrupts show that
> interrupts 0-15 are then handled by XT-PIC-XT
> instead of IO-APIC-edge and IO-APIC-fasteoi when runing smp kernel.
> 
> Here is lspci dump :
> 
> 00:00.0 Host bridge: Intel Corporation 4 Series Chipset DRAM Controller 
> (rev 03)
> 00:01.0 PCI bridge: Intel Corporation 4 Series Chipset PCI Express Root 
> Port (rev 03)
> 00:1a.0 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB 
> UHCI Controller #4
> 00:1a.1 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB 
> UHCI Controller #5
> 00:1a.2 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB 
> UHCI Controller #6
> 00:1a.7 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB2 
> EHCI Controller #2
> 00:1b.0 Audio device: Intel Corporation 82801JI (ICH10 Family) HD Audio 
> Controller
> 00:1c.0 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express 
> Root Port 1
> 00:1c.1 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express 
> Port 2
> 00:1c.5 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express 
> Root Port 6
> 00:1d.0 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB 
> UHCI Controller #1
> 00:1d.1 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB 
> UHCI Controller #2
> 00:1d.2 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB 
> UHCI Controller #3
> 00:1d.7 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB2 
> EHCI Controller #1
> 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 90)
> 00:1f.0 ISA bridge: Intel Corporation 82801JIB (ICH10) LPC Interface 
> Controller
> 00:1f.2 IDE interface: Intel Corporation 82801JI (ICH10 Family) 4 port 
> SATA IDE Controller #1
> 00:1f.3 SMBus: Intel Corporation 82801JI (ICH10 Family) SMBus Controller
> 00:1f.5 IDE interface: Intel Corporation 82801JI (ICH10 Family) 2 port 
> SATA IDE Controller #2
> 01:00.0 VGA compatible controller: nVidia Corporation G98 [GeForce 8400 
> GS] (rev a1)
> 02:00.0 IDE interface: JMicron Technology Corp. JMB368 IDE controller
> 04:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
> RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 02)
> 
> I observed the same issue with another machine with also an MSI 
> motherboard but using a PCI bridge VIA VT8237/VX700
> even when booting with "pci=use_crs" argument.
> 
> Attached is diff -ruN file between 2.6.35.7 kernel without and with 
> "nosmp" boot argument.
> 
> Bernard
> 
> 
