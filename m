From: Sander Eikelenboom <linux@eikelenboom.it>
Subject: Re: Regression due to "device property: Make it possible to use secondary firmware nodes" Re: Xen-unstable + linux 4.1-mergewindow: problems with PV guest  pci passthrough:  pcifront pci-0: pciback not responding!!!
Date: Tue, 12 May 2015 17:24:33 +0200
Message-ID: <1802429902.20150512172433@eikelenboom.it>
References: <135105791.20150427174800@eikelenboom.it> <20150511152029.GA24379@l.oracle.com> <3902129.1HNpjbDdb7@vostro.rjw.lan> <3477983.pEhNuQXIjK@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3477983.pEhNuQXIjK@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org, David Vrabel <david.vrabel@citrix.com>, xen-devel <xen-devel@lists.xenproject.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


Tuesday, May 12, 2015, 5:45:06 PM, you wrote:

> On Tuesday, May 12, 2015 02:59:57 AM Rafael J. Wysocki wrote:
>> On Monday, May 11, 2015 11:20:29 AM Konrad Rzeszutek Wilk wrote:
>> > On Tue, May 05, 2015 at 12:18:49AM +0200, Sander Eikelenboom wrote:
>> > > Hello Sander,
>> > > 
>> > > Monday, April 27, 2015, 5:48:00 PM, you wrote:
>> > > 
>> > > > Hi David / Konrad,
>> > > 
>> > > > Here the other problem i found, which is introduced somewhere in the 
>> > > > 4.1 mergewindow:
>> > > 
>> > > > on 4.1.0-rc1 (with the one revert to get things booting) i get this in
>> > > > the PV Guest console:
>> > > 
>> > > > [    0.517392] crc32c_combine: 8373 self tests passed
>> > > > [    0.517608] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
>> > > > [    0.517655] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
>> > > > [    0.517677] cpcihp_generic: Generic port I/O CompactPCI Hot Plug Driver version: 0.1
>> > > > [    0.517684] cpcihp_generic: not configured, disabling.
>> > > > [    0.517700] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
>> > > > [    0.517713] acpiphp_ibm: ibm_acpiphp_init: acpi_walk_namespace failed
>> > > > [    0.519849] usbcore: registered new interface driver udlfb
>> > > > [    0.613289] xen:xen_evtchn: Event-channel device installed
>> > > > [    0.613436] pcifront pci-0: Installing PCI frontend
>> > > > [    0.613578] pcifront pci-0: Creating PCI Frontend Bus 0000:00
>> > > > [    0.613616] pcifront pci-0: PCI host bridge to bus 0000:00
>> > > > [    0.613624] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
>> > > > [    0.613631] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffffffff]
>> > > > [    0.613638] pci_bus 0000:00: root bus resource [bus 00-ff]
>> > > > [    0.616672] pcifront pci-0: pciback not responding!!!
>> > > > [    2.613762] clocksource tsc: mask: 0xffffffffffffffff max_cycles: 0x2e20fd6f2ba, max_idle_ns: 440795302556 ns
>> > > > [    2.614275] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
>> > > > [    2.614682] Linux agpgart interface v0.103
>> > > > [    2.614731] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 seconds, margin is 60 seconds).
>> > > > [    2.614762] [drm] Initialized drm 1.1.0 20060810
>> > > > [    2.614789] [drm] radeon kernel modesetting enabled.
>> > > > [    2.616529] brd: module loaded
>> > > > [    2.617844] loop: module loaded
>> > > > [    2.620008] pcifront pci-0: pciback not responding!!!
>> > > > [    4.621490] pcifront pci-0: pciback not responding!!!
>> > > > [    6.621866] pcifront pci-0: pciback not responding!!!
>> > > > [    8.622421] pcifront pci-0: pciback not responding!!!
>> > > > etc. etc. etc.
>> > > 
>> > > 
>> > > > Where on 4.0.0 it get:
>> > > 
>> > > > [    0.442554] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
>> > > > [    0.442583] acpiphp_ibm: ibm_acpiphp_init: acpi_walk_namespace failed
>> > > > [    0.443293] pcifront pci-0: Allocated pdev @ 0xffff88001ab23c00 pdev->sh_info @ 0xffff88001937f000
>> > > > [    0.444885] pcifront pci-0: publishing successful!
>> > > > [    0.445302] usbcore: registered new interface driver udlfb
>> > > > [    0.445829] xen:xen_evtchn: Event-channel device installed
>> > > > [    0.446499] pcifront pci-0: Installing PCI frontend
>> > > > [    0.446715] pcifront pci-0: Creating PCI Frontend Bus 0000:00
>> > > > [    0.446951] pcifront pci-0: PCI host bridge to bus 0000:00
>> > > > [    0.446960] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
>> > > > [    0.446968] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffffffff]
>> > > > [    0.446988] pci_bus 0000:00: root bus resource [bus 00-ff]
>> > > > [    0.447002] pci_bus 0000:00: scanning bus
>> > > > [    0.447140] pci 0000:00:00.0: [13f6:0111] type 00 class 0x040100
>> > > > [    0.447520] pci 0000:00:00.0: reg 0x10: [io  0x7800-0x78ff]
>> > > > [    0.449148] pci 0000:00:00.0: supports D1 D2
>> > > > [    0.449791] pci_bus 0000:00: fixups for bus
>> > > > [    0.449794] pci_bus 0000:00: bus scan returning with max=00
>> > > > [    0.450604] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
>> > > > [    0.451991] Linux agpgart interface v0.103
>> > > > [    0.452160] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 seconds, margin is 60 seconds).
>> > > > [    0.452222] [drm] Initialized drm 1.1.0 20060810
>> > > > [    0.452300] [drm] radeon kernel modesetting enabled.
>> > > > [    0.462384] pcifront pci-0: claiming resource 0000:00:00.0/0
>> > > 
>> > > > But i thought the patches that would change pci bus scanning were destined for 
>> > > > 4.2 though ...
>> > > 
>> > > > --
>> > > > Sander
>> > > 
>> > > Hi David / Konrad,
>> > > 
>> > > I have bisected this one .. it leads to:
>> > > 
>> > > commit 97badf873ab60e841243b66133ff9eff2a46ef29
>> > > Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> > > Date:   Fri Apr 3 23:23:37 2015 +0200
>> > > 
>> > > device property: Make it possible to use secondary firmware nodes
>> > > 
>> > > Since i didn't see it directly related to pci-front, i double checked by 
>> > > reverting this commit(and 9b73262ccbf2fb0060303f047863214269e64f9a since it 
>> > > build depends on the other) on 4.1-rc2.
>> > > 
>> > > Reverting in the guest kernel indeed makes pci-front work correct again.
>> > 
>> > That is quite odd.
>> 
>> Yes, that's weird.
>> 
>> > And sadly I am due for vacation at the end of this week
>> > so own't be able to look at this (and prepare an debug patch for the MSI
>> > addendum debug patch either).
>> > 
>> > 
>> > Rafael,
>> > 
>> > Were there any other bug reports about this particular commit?
>> 
>> Not that I'm aware of.
>> 
>> I'll look at that tomorrow when I'm a bit less tired.

> So since device_add_property_set() is not currently used, the commit it's
> been bisected to should not have any functional effects on anything, but
> nevertheless please apply the appended debug patch and see if you get any
> extra output from it.

> That said, the commit might make a difference for Xen if there's an already
> existing initialization ordering issue, because it slows down the ACPI/PCI
> initialization a bit (due to the new checks in set_primary_fwnode()) and
> something already racy with respect to it may be able to win the race now.

> So I'm wondering, for example, if adding something like msleep(100); at the
> beginning of pcifront_init() (right after the initial checks) will make any
> difference.

Thanks for looking into it, it will give this patch and your suggestion a shot 
and see if i can get some more details.

Thanks,

--
Sander



> ---
>  drivers/base/core.c |    4 ++++
>  1 file changed, 4 insertions(+)

> Index: linux-pm/drivers/base/core.c
> ===================================================================
> --- linux-pm.orig/drivers/base/core.c
> +++ linux-pm/drivers/base/core.c
> @@ -2167,11 +2167,15 @@ void set_primary_fwnode(struct device *d
>                 if (fwnode_is_primary(fn))
>                         fn = fn->secondary;
>  
> +               WARN_ON_ONCE(fn);
> +
>                 fwnode->secondary = fn;
>                 dev->fwnode = fwnode;
>         } else {
>                 dev->fwnode = fwnode_is_primary(dev->fwnode) ?
>                         dev->fwnode->secondary : NULL;
> +
> +               WARN_ON_ONCE(dev->fwnode);
>         }
>  }
>  EXPORT_SYMBOL_GPL(set_primary_fwnode);
