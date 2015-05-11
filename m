From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Regression due to "device property: Make it possible to use
 secondary firmware nodes" Re: Xen-unstable + linux 4.1-mergewindow: problems
 with PV guest  pci passthrough:  pcifront pci-0: pciback not responding!!!
Date: Mon, 11 May 2015 11:20:29 -0400
Message-ID: <20150511152029.GA24379@l.oracle.com>
References: <135105791.20150427174800@eikelenboom.it>
 <16510049578.20150505001849@eikelenboom.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:26420 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbbEKPUj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 May 2015 11:20:39 -0400
Content-Disposition: inline
In-Reply-To: <16510049578.20150505001849@eikelenboom.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sander Eikelenboom <linux@eikelenboom.it>, rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org
Cc: David Vrabel <david.vrabel@citrix.com>, xen-devel <xen-devel@lists.xenproject.org>, linux-kernel@vger.kernel.org

On Tue, May 05, 2015 at 12:18:49AM +0200, Sander Eikelenboom wrote:
> Hello Sander,
> 
> Monday, April 27, 2015, 5:48:00 PM, you wrote:
> 
> > Hi David / Konrad,
> 
> > Here the other problem i found, which is introduced somewhere in the 
> > 4.1 mergewindow:
> 
> > on 4.1.0-rc1 (with the one revert to get things booting) i get this in
> > the PV Guest console:
> 
> > [    0.517392] crc32c_combine: 8373 self tests passed
> > [    0.517608] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> > [    0.517655] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
> > [    0.517677] cpcihp_generic: Generic port I/O CompactPCI Hot Plug Driver version: 0.1
> > [    0.517684] cpcihp_generic: not configured, disabling.
> > [    0.517700] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> > [    0.517713] acpiphp_ibm: ibm_acpiphp_init: acpi_walk_namespace failed
> > [    0.519849] usbcore: registered new interface driver udlfb
> > [    0.613289] xen:xen_evtchn: Event-channel device installed
> > [    0.613436] pcifront pci-0: Installing PCI frontend
> > [    0.613578] pcifront pci-0: Creating PCI Frontend Bus 0000:00
> > [    0.613616] pcifront pci-0: PCI host bridge to bus 0000:00
> > [    0.613624] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> > [    0.613631] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffffffff]
> > [    0.613638] pci_bus 0000:00: root bus resource [bus 00-ff]
> > [    0.616672] pcifront pci-0: pciback not responding!!!
> > [    2.613762] clocksource tsc: mask: 0xffffffffffffffff max_cycles: 0x2e20fd6f2ba, max_idle_ns: 440795302556 ns
> > [    2.614275] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> > [    2.614682] Linux agpgart interface v0.103
> > [    2.614731] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 seconds, margin is 60 seconds).
> > [    2.614762] [drm] Initialized drm 1.1.0 20060810
> > [    2.614789] [drm] radeon kernel modesetting enabled.
> > [    2.616529] brd: module loaded
> > [    2.617844] loop: module loaded
> > [    2.620008] pcifront pci-0: pciback not responding!!!
> > [    4.621490] pcifront pci-0: pciback not responding!!!
> > [    6.621866] pcifront pci-0: pciback not responding!!!
> > [    8.622421] pcifront pci-0: pciback not responding!!!
> > etc. etc. etc.
> 
> 
> > Where on 4.0.0 it get:
> 
> > [    0.442554] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> > [    0.442583] acpiphp_ibm: ibm_acpiphp_init: acpi_walk_namespace failed
> > [    0.443293] pcifront pci-0: Allocated pdev @ 0xffff88001ab23c00 pdev->sh_info @ 0xffff88001937f000
> > [    0.444885] pcifront pci-0: publishing successful!
> > [    0.445302] usbcore: registered new interface driver udlfb
> > [    0.445829] xen:xen_evtchn: Event-channel device installed
> > [    0.446499] pcifront pci-0: Installing PCI frontend
> > [    0.446715] pcifront pci-0: Creating PCI Frontend Bus 0000:00
> > [    0.446951] pcifront pci-0: PCI host bridge to bus 0000:00
> > [    0.446960] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> > [    0.446968] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffffffff]
> > [    0.446988] pci_bus 0000:00: root bus resource [bus 00-ff]
> > [    0.447002] pci_bus 0000:00: scanning bus
> > [    0.447140] pci 0000:00:00.0: [13f6:0111] type 00 class 0x040100
> > [    0.447520] pci 0000:00:00.0: reg 0x10: [io  0x7800-0x78ff]
> > [    0.449148] pci 0000:00:00.0: supports D1 D2
> > [    0.449791] pci_bus 0000:00: fixups for bus
> > [    0.449794] pci_bus 0000:00: bus scan returning with max=00
> > [    0.450604] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> > [    0.451991] Linux agpgart interface v0.103
> > [    0.452160] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 seconds, margin is 60 seconds).
> > [    0.452222] [drm] Initialized drm 1.1.0 20060810
> > [    0.452300] [drm] radeon kernel modesetting enabled.
> > [    0.462384] pcifront pci-0: claiming resource 0000:00:00.0/0
> 
> > But i thought the patches that would change pci bus scanning were destined for 
> > 4.2 though ...
> 
> > --
> > Sander
> 
> Hi David / Konrad,
> 
> I have bisected this one .. it leads to:
> 
> commit 97badf873ab60e841243b66133ff9eff2a46ef29
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Date:   Fri Apr 3 23:23:37 2015 +0200
> 
> device property: Make it possible to use secondary firmware nodes
> 
> Since i didn't see it directly related to pci-front, i double checked by 
> reverting this commit(and 9b73262ccbf2fb0060303f047863214269e64f9a since it 
> build depends on the other) on 4.1-rc2.
> 
> Reverting in the guest kernel indeed makes pci-front work correct again.

That is quite odd. And sadly I am due for vacation at the end of this week
so own't be able to look at this (and prepare an debug patch for the MSI
addendum debug patch either).


Rafael,

Were there any other bug reports about this particular commit?

Thank you!

> 
> --
> Sander
> 
