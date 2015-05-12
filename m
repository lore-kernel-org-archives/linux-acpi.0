From: Sander Eikelenboom <linux@eikelenboom.it>
Subject: Re: Regression due to "device property: Make it possible to use secondary firmware nodes" Re: Xen-unstable + linux 4.1-mergewindow: problems with PV guest  pci passthrough:  pcifront pci-0: pciback not responding!!!
Date: Wed, 13 May 2015 00:52:36 +0200
Message-ID: <238309395.20150513005236@eikelenboom.it>
References: <135105791.20150427174800@eikelenboom.it> <20150511152029.GA24379@l.oracle.com> <3902129.1HNpjbDdb7@vostro.rjw.lan> <3477983.pEhNuQXIjK@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vserver.eikelenboom.it ([84.200.39.61]:33278 "EHLO
	smtp.eikelenboom.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933591AbbELWwp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 May 2015 18:52:45 -0400
In-Reply-To: <3477983.pEhNuQXIjK@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org, David Vrabel <david.vrabel@citrix.com>, xen-devel <xen-devel@lists.xenproject.org>, linux-kernel@vger.kernel.org



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

Hi Rafael,

The WARN's don't trigger, so it's a red herring i suppose :-(
I also tried the msleep(100), but that didn't change anything as well. 

Konrad,

I enabled (and extended) the debugging printk's in xen-pcifront.
Why is the code actually "scanning" all those BDF's ?
Hasn't pciback written the virtual slot into xenstore already ?

 
>From pciback side i get:
[  523.502306] pciback 0000:03:06.0: resetting (FLR, D3,  bus) the device
[  523.502313] pciback 0000:03:06.0: OK
[  523.502354] pciback 0000:03:06.0: restoring config space at offset 0x4 (was 0x2100000, writing 0x2100105)
[  523.527080] pciback 0000:03:06.0: restoring config space at offset 0x4 (was 0x2100000, writing 0x2100105)
[  524.537592] pciback 0000:03:06.0: restoring config space at offset 0xc (was 0x0, writing 0x4000)
[  524.537621] pciback 0000:03:06.0: restoring config space at offset 0x4 (was 0x2100080, writing 0x2100000)
[  524.560066] xen-pciback pci-19-0: allocated pdev @ 0xffff88002f768300
[  524.561958] xen-pciback pci-19-0: getting be setup
[  524.562339] xen-pciback pci-19-0: exporting dom 0 bus 3 slot 6 func 0
[  524.562344] xen_pciback: vpci: 0000:03:06.0: assign to virtual slot 0
[  524.562607] pciback 0000:03:06.0: registering for 19
[  524.562881] xen-pciback pci-19-0: Publishing pci roots
[  524.563269] xen-pciback pci-19-0: writing root 0 at 0000:00
[  524.569003] xen-pciback pci-19-0: fe state changed 1
[  525.407945] xen-pciback pci-19-0: fe state changed 3
[  525.408370] xen-pciback pci-19-0: Reading frontend config
[  525.408674] xen-pciback pci-19-0: Attaching to frontend resources - gnt_ref=8 evtchn=10
[  525.408715] xen-pciback pci-19-0: Attached!
[  525.408717] xen-pciback pci-19-0: Connecting...
[  525.409629] xen-pciback pci-19-0: Connected? 0
[  555.416997] xen-blkback: ring-ref 9, event-channel 11, protocol 1 (x86_64-abi) persistent grants
[ 1102.845227] xen-pciback pci-19-0: fe state changed 4
[ 1102.909699] vif vif-19-0 vif19.0: Guest Rx ready


>From pcifront side:
[    0.665420] pcifront pci-0: Installing PCI frontend
[    0.665584] pcifront pci-0: Creating PCI Frontend Bus 0000:00
[    0.665631] pcifront pci-0: PCI host bridge to bus 0000:00
[    0.665638] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.665645] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffffffff]
[    0.665654] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.665659] pci_bus 0000:00: scanning bus
[    0.665666] pcifront pci-0: read dev=0000:00:00.0 - offset 0 size 4
[    0.667330] pcifront pci-0: pciback not responding!!! irq:24 irq_flags:ffff880018c00004 ns: 1431462193392053000  ns_timeout: 1431462193392052000
[    2.665795] clocksource tsc: mask: 0xffffffffffffffff max_cycles: 0x2e2108dd018, max_idle_ns: 440795268512 ns
[    2.667763] brd: module loaded
[    2.669244] loop: module loaded
[    2.669421] pcifront pci-0: read dev=0000:00:01.0 - offset 0 size 4
[    2.670009] pcifront pci-0: pciback not responding!!! irq:24 irq_flags:ffff880018c00004 ns: 1431462195395810000  ns_timeout: 1431462195395809000
[    4.669545] pcifront pci-0: read dev=0000:00:02.0 - offset 0 size 4
[    4.672797] pcifront pci-0: pciback not responding!!! irq:24 irq_flags:ffff880018c00004 ns: 1431462197395932000  ns_timeout: 1431462197395931000
[    6.669817] pcifront pci-0: read dev=0000:00:03.0 - offset 0 size 4
[    6.672908] pcifront pci-0: pciback not responding!!! irq:24 irq_flags:ffff880018c00004 ns: 1431462199396207000  ns_timeout: 1431462199396206000
[    8.669901] pcifront pci-0: read dev=0000:00:04.0 - offset 0 size 4
[    8.673182] pcifront pci-0: pciback not responding!!! irq:24 irq_flags:ffff880018c00004 ns: 1431462201396836000  ns_timeout: 1431462201396297000
[   10.670587] pcifront pci-0: read dev=0000:00:05.0 - offset 0 size 4
[   10.673829] pcifront pci-0: pciback not responding!!! irq:24 irq_flags:ffff880018c00004 ns: 1431462203396981000  ns_timeout: 1431462203396973000
[   12.670810] pcifront pci-0: read dev=0000:00:06.0 - offset 0 size 4
[   12.673995] pcifront pci-0: pciback not responding!!! irq:24 irq_flags:ffff880018c00004 ns: 1431462205397206000  ns_timeout: 1431462205397202000
[   14.670943] pcifront pci-0: read dev=0000:00:07.0 - offset 0 size 4
[   14.674205] pcifront pci-0: pciback not responding!!! irq:24 irq_flags:ffff880018c00004 ns: 1431462207397332000  ns_timeout: 1431462207397331000
[   16.671076] pcifront pci-0: read dev=0000:00:08.0 - offset 0 size 4
[   16.674331] pcifront pci-0: pciback not responding!!! irq:24 irq_flags:ffff880018c00004 ns: 1431462209397463000  ns_timeout: 1431462209397462000
[   18.671133] pcifront pci-0: read dev=0000:00:09.0 - offset 0 size 4
[   18.674438] pcifront pci-0: pciback not responding!!! irq:24 irq_flags:ffff880018c00004 ns: 1431462211397520000  ns_timeout: 1431462211397519000

<big snip>

[  560.071316] pcifront pci-0: read dev=0000:00:1e.7 - offset 0 size 4
[  560.073698] pcifront pci-0: pciback not responding!!! irq:24 irq_flags:ffff880018c00004 ns: 1431462752797707000  ns_timeout: 1431462752797706000
[  562.072326] pcifront pci-0: read dev=0000:00:1f.0 - offset 0 size 4
[  562.074707] pcifront pci-0: pciback not responding!!! irq:24 irq_flags:ffff880018c00004 ns: 1431462754798720000  ns_timeout: 1431462754798717000
[  564.074359] pcifront pci-0: read dev=0000:00:1f.1 - offset 0 size 4
[  564.076821] pcifront pci-0: pciback not responding!!! irq:24 irq_flags:ffff880018c00004 ns: 1431462756800762000  ns_timeout: 1431462756800761000
[  566.075590] pcifront pci-0: read dev=0000:00:1f.2 - offset 0 size 4
[  566.077791] pcifront pci-0: pciback not responding!!! irq:24 irq_flags:ffff880018c00004 ns: 1431462758801996000  ns_timeout: 1431462758801995000
[  568.076680] pcifront pci-0: read dev=0000:00:1f.3 - offset 0 size 4
[  568.079960] pcifront pci-0: pciback not responding!!! irq:24 irq_flags:ffff880018c00004 ns: 1431462760803264000  ns_timeout: 1431462760803084000
[  570.077939] pcifront pci-0: read dev=0000:00:1f.4 - offset 0 size 4
[  570.080267] pcifront pci-0: pciback not responding!!! irq:24 irq_flags:ffff880018c00004 ns: 1431462762804331000  ns_timeout: 1431462762804330000
[  572.078953] pcifront pci-0: read dev=0000:00:1f.5 - offset 0 size 4
[  572.081338] pcifront pci-0: pciback not responding!!! irq:24 irq_flags:ffff880018c00004 ns: 1431462764805354000  ns_timeout: 1431462764805349000
[  574.080073] pcifront pci-0: read dev=0000:00:1f.6 - offset 0 size 4
[  574.083323] pcifront pci-0: pciback not responding!!! irq:24 irq_flags:ffff880018c00004 ns: 1431462766806466000  ns_timeout: 1431462766806463000
[  576.081077] pcifront pci-0: read dev=0000:00:1f.7 - offset 0 size 4
[  576.083464] pcifront pci-0: pciback not responding!!! irq:24 irq_flags:ffff880018c00004 ns: 1431462768807992000  ns_timeout: 1431462768807468000
[  578.102629] blkfront: xvda: flush diskcache: enabled; persistent grants: enabled; indirect descriptors: enabled;

Now pcifront timed out (and pciback reports a state change to 4 which is 
"connected" .. which also seems a wrong fallthrough somewhere.

After reverting the two commits again .. i get a working pci device and this 
output from pci-front:
[    0.628804] pcifront pci-0: Installing PCI frontend
[    0.629167] pcifront pci-0: Creating PCI Frontend Bus 0000:00
[    0.629225] pcifront pci-0: PCI host bridge to bus 0000:00
[    0.629237] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.629254] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffffffff]
[    0.629269] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.629285] pci_bus 0000:00: scanning bus
[    0.629303] pcifront pci-0: read dev=0000:00:00.0 - offset 0 size 4
[    0.629344] pcifront pci-0: ?!?!? pciback responded !!! irq:24 irq_flags:ffff88001ab40004 ns: 1431470444164529000  ns_timeout: 1431470446164504000
[    0.629364] pcifront pci-0: read got back value 11113f6
[    0.629383] pcifront pci-0: read dev=0000:00:00.0 - offset e size 1
[    0.629413] pcifront pci-0: ?!?!? pciback responded !!! irq:24 irq_flags:ffff88001ab40004 ns: 1431470444164599000  ns_timeout: 1431470446164589000
[    0.629433] pcifront pci-0: read got back value 0
[    0.629452] pcifront pci-0: read dev=0000:00:00.0 - offset 6 size 2
[    0.629483] pcifront pci-0: ?!?!? pciback responded !!! irq:24 irq_flags:ffff88001ab40004 ns: 1431470444164670000  ns_timeout: 1431470446164659000
[    0.629504] pcifront pci-0: read got back value 210
[    0.629518] pcifront pci-0: read dev=0000:00:00.0 - offset 34 size 1
[    0.629547] pcifront pci-0: ?!?!? pciback responded !!! irq:24 irq_flags:ffff88001ab40004 ns: 1431470444164733000  ns_timeout: 1431470446164724000
[    0.629566] pcifront pci-0: read got back value c0
[    0.629579] pcifront pci-0: read dev=0000:00:00.0 - offset c0 size 2
[    0.629609] pcifront pci-0: ?!?!? pciback responded !!! irq:24 irq_flags:ffff88001ab40004 ns: 1431470444164796000  ns_timeout: 1431470446164786000
[    0.629632] pcifront pci-0: read got back value 1
[    0.629647] pcifront pci-0: read dev=0000:00:00.0 - offset 8 size 4
[    0.629676] pcifront pci-0: ?!?!? pciback responded !!! irq:24 irq_flags:ffff88001ab40004 ns: 1431470444164863000  ns_timeout: 1431470446164853000
[    0.629696] pcifront pci-0: read got back value 4010010
[    0.629709] pci 0000:00:00.0: [13f6:0111] type 00 class 0x040100
[    0.629720] pcifront pci-0: read dev=0000:00:00.0 - offset 6 size 2
[    0.629743] pcifront pci-0: ?!?!? pciback responded !!! irq:24 irq_flags:ffff88001ab40004 ns: 1431470444164929000  ns_timeout: 1431470446164920000
[    0.629774] pcifront pci-0: read got back value 210
[    0.629787] pcifront pci-0: read dev=0000:00:00.0 - offset 34 size 1
[    0.629828] pcifront pci-0: ?!?!? pciback responded !!! irq:24 irq_flags:ffff88001ab40004 ns: 1431470444165014000  ns_timeout: 1431470446164999000
[    0.629847] pcifront pci-0: read got back value c0
[    0.629860] pcifront pci-0: read dev=0000:00:00.0 - offset c0 size 2
[    0.629889] pcifront pci-0: ?!?!? pciback responded !!! irq:24 irq_flags:ffff88001ab40004 ns: 1431470444165076000  ns_timeout: 1431470446165067000
[    0.629919] pcifront pci-0: read got back value 1
[    0.629932] pcifront pci-0: read dev=0000:00:00.0 - offset 3d size 1
[    0.629966] pcifront pci-0: ?!?!? pciback responded !!! irq:24 irq_flags:ffff88001ab40004 ns: 1431470444165152000  ns_timeout: 1431470446165138000
[    0.630007] pcifront pci-0: ?!?!? pciback responded !!! irq:24 irq_flags:ffff88001ab40004 ns: 1431470444165194000  ns_timeout: 1431470446165138000
[    0.630020] pcifront pci-0: read got back value 1
[    0.630066] pcifront pci-0: read dev=0000:00:00.0 - offset 3c size 1
[    0.630099] pcifront pci-0: ?!?!? pciback responded !!! irq:24 irq_flags:ffff88001ab40004 ns: 1431470444165285000  ns_timeout: 1431470446165275000
[    0.630120] pcifront pci-0: read got back value 16
[    0.630140] pcifront pci-0: read dev=0000:00:00.0 - offset 4 size 2
[    0.630172] pcifront pci-0: ?!?!? pciback responded !!! irq:24 irq_flags:ffff88001ab40004 ns: 1431470444165358000  ns_timeout: 1431470446165348000
[    0.630204] pcifront pci-0: read got back value 101
[    0.630238] pcifront pci-0: ?!?!? pciback responded !!! irq:24 irq_flags:ffff88001ab40004 ns: 1431470444165421000  ns_timeout: 1431470446165414000
[    0.630265] pcifront pci-0: read dev=0000:00:00.0 - offset 10 size 4
[    0.630292] pcifront pci-0: ?!?!? pciback responded !!! irq:24 irq_flags:ffff88001ab40004 ns: 1431470444165480000  ns_timeout: 1431470446165472000
[    0.630323] pcifront pci-0: read got back value 7801
[    0.630354] pcifront pci-0: ?!?!? pciback responded !!! irq:24 irq_flags:ffff88001ab40004 ns: 1431470444165540000  ns_timeout: 1431470446165531000
[    0.630389] pcifront pci-0: read dev=0000:00:00.0 - offset 10 size 4
[    0.630425] pcifront pci-0: ?!?!? pciback responded !!! irq:24 irq_flags:ffff88001ab40004 ns: 1431470444165611000  ns_timeout: 1431470446165596000
[    0.630456] pcifront pci-0: read got back value 100
[    0.630489] pcifront pci-0: ?!?!? pciback responded !!! irq:24 irq_flags:ffff88001ab40004 ns: 1431470444165675000  ns_timeout: 1431470446165665000
[    0.630529] pcifront pci-0: ?!?!? pciback responded !!! irq:24 irq_flags:ffff88001ab40004 ns: 1431470444165715000  ns_timeout: 1431470446165703000
[    0.630571] pcifront pci-0: ?!?!? pciback responded !!! irq:24 irq_flags:ffff88001ab40004 ns: 1431470444165757000  ns_timeout: 1431470446165703000
[    0.630613] pcifront pci-0: ?!?!? pciback responded !!! irq:24 irq_flags:ffff88001ab40004 ns: 1431470444165800000  ns_timeout: 1431470446165703000
[    0.630655] pcifront pci-0: ?!?!? pciback responded !!! irq:24 irq_flags:ffff88001ab40004 ns: 1431470444165842000  ns_timeout: 1431470446165703000
[    0.630698] pcifront pci-0: ?!?!? pciback responded !!! irq:24 irq_flags:ffff88001ab40004 ns: 1431470444165884000  ns_timeout: 1431470446165703000
[    0.630733] pci 0000:00:00.0: reg 0x10: [io  0x7800-0x78ff]
[    0.803637] pcifront pci-0: read dev=0000:00:00.0 - offset 4 size 2
[    0.803701] pcifront pci-0: ?!?!? pciback responded !!! irq:24 irq_flags:ffff88001ab40004 ns: 1431470444338888000  ns_timeout: 1431470446338836000
[    0.803712] pcifront pci-0: read got back value 101
[    0.803861] pcifront pci-0: ?!?!? pciback responded !!! irq:24 irq_flags:ffff88001ab40004 ns: 1431470444339049000  ns_timeout: 1431470446338910000
[    0.803876] pcifront pci-0: read dev=0000:00:00.0 - offset 14 size 4
[    0.803920] pcifront pci-0: ?!?!? pciback responded !!! irq:24 irq_flags:ffff88001ab40004 ns: 1431470444339108000  ns_timeout: 143147044633907400

etc.

On a side note .. why is it actually "scanning" the bus and all possible BDF's ?
Shouldn't pcifront already be able to know the virtual slot pciback has written 
to xenstore were the device(s) will be ?



The only direct change involving xen-pciback and pcifront seems to be:

commit ccc9d90a9a8b5c4ad7e9708ec41f75ff9e98d61d
Author: Wei Liu <wei.liu2@citrix.com>
Date:   Fri Apr 3 14:44:59 2015 +0800

    xenbus_client: Extend interface to support multi-page ring

But my bisect didn't point that out :S

Any pointers were to add more debug code ?
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



