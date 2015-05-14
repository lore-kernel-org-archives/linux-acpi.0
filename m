From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	David Vrabel <david.vrabel@citrix.com>
Subject: Re: Regression due to "device property: Make it
	possible to use secondary firmware nodes" Re: Xen-unstable +
	linux 4.1-mergewindow: problems with PV guest pci
	passthrough: pcifront pci-0: pciback not responding!!!
Date: Fri, 15 May 2015 00:44:29 +0200
Message-ID: <120875582.20150515004429@eikelenboom.it>
References: <135105791.20150427174800@eikelenboom.it>
	<20150511152029.GA24379@l.oracle.com>
	<3902129.1HNpjbDdb7@vostro.rjw.lan>
	<3477983.pEhNuQXIjK@vostro.rjw.lan>
	<238309395.20150513005236@eikelenboom.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <238309395.20150513005236@eikelenboom.it>
List-Unsubscribe: <http://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <http://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Sender: xen-devel-bounces@lists.xen.org
Errors-To: xen-devel-bounces@lists.xen.org
To: Sander Eikelenboom <linux@eikelenboom.it>
Cc: linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, xen-devel <xen-devel@lists.xenproject.org>
List-Id: linux-acpi@vger.kernel.org

Hi Konrad / David,

One a big snip on this thread, got some more debug info, hopefully this will 
lead to something:

On a working kernel (with the two seemingly non related patches reverted) i get:

[    0.717796] pcifront pci-0: Allocated pdev @ 0xffff880019e11780 pdev->sh_info @ 0xffff880018f58000
[    0.717848] pcifront pci-0: ?!?!? before alloc gntref: 0
[    0.717871] pcifront pci-0: ?!?!? after alloc gntref: 8
[    0.717892] pcifront pci-0: ?!?!? before alloc evtchn: -1
[    0.717915] pcifront pci-0: ?!?!? after alloc evtchn: 17
[    0.717984] pcifront pci-0: ?!?!? bound evtchn:17 to irqhandler:-1 err:31
[    0.721640] pcifront pci-0: publishing successful!
[    0.723684] usbcore: registered new interface driver udlfb
[    0.724664] xen:xen_evtchn: Event-channel device installed
[    0.726597] pcifront pci-0: Installing PCI frontend
[    0.726853] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.727059] pcifront pci-0: Creating PCI Frontend Bus 0000:00
[    0.727363] pcifront pci-0: PCI host bridge to bus 0000:00
[    0.727391] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.727417] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffffffff]
[    0.727452] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.727475] pci_bus 0000:00: scanning bus
[    0.727503] pcifront pci-0: read dev=0000:00:00.0 - offset 0 size 4
[    0.728253] Linux agpgart interface v0.103
[    0.728387] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 seconds, margin is 60 seconds).
[    0.728474] [drm] Initialized drm 1.1.0 20060810
[    0.728551] [drm] radeon kernel modesetting enabled.
[    0.730319] pcifront pci-0: ?!?!? pciback responded !!! irq:31 irq_flags:ffff880019e100a8 ns: 1431641785551700000  ns_timeout: 1431641787541235000 evtchn:17 gnt_ref:8
[    0.730319] pcifront pci-0: ?!?!? op cmd:0 err:0 info:0 offset:0 size:4
[    0.730319] pcifront pci-0: ?!?!? active_op cmd:0 err:0 info:0 offset:0 size:4
[    0.730319] pcifront pci-0: read got back value 11113f6
[    0.738845] pcifront pci-0: read dev=0000:00:00.0 - offset e size 1
[    0.744976] brd: module loaded
[    0.745204] pcifront pci-0: ?!?!? pciback responded !!! irq:31 irq_flags:ffff880019e100a8 ns: 1431641785562852000  ns_timeout: 1431641787552580000 evtchn:17 gnt_ref:8
[    0.745204] pcifront pci-0: ?!?!? op cmd:0 err:0 info:0 offset:14 size:1
[    0.745204] pcifront pci-0: ?!?!? active_op cmd:0 err:0 info:0 offset:14 size:1
[    0.745204] pcifront pci-0: read got back value 0
[    0.749204] pcifront pci-0: read dev=0000:00:00.0 - offset 6 size 2
[    0.750155] loop: module loaded
[    0.752527] pcifront pci-0: ?!?!? pciback responded !!! irq:31 irq_flags:ffff880019e100a8 ns: 1431641785570841000  ns_timeout: 1431641787562917000 evtchn:17 gnt_ref:8
[    0.752527] pcifront pci-0: ?!?!? op cmd:0 err:0 info:0 offset:6 size:2
[    0.752527] pcifront pci-0: ?!?!? active_op cmd:0 err:0 info:0 offset:6 size:2
[    0.752527] pcifront pci-0: read got back value 210
[    0.757187] pcifront pci-0: read dev=0000:00:00.0 - offset 34 size 1


Were as in the non-working situation i get:

[    0.751244] pcifront pci-0: Allocated pdev @ 0xffff880019ec2e00 pdev->sh_info @ 0xffff88001aa51000
[    0.751295] pcifront pci-0: ?!?!? before alloc gntref: 0
[    0.751315] pcifront pci-0: ?!?!? after alloc gntref: 8
[    0.751334] pcifront pci-0: ?!?!? before alloc evtchn: -1
[    0.751355] pcifront pci-0: ?!?!? after alloc evtchn: 17
[    0.751422] pcifront pci-0: ?!?!? bound evtchn:17 to irqhandler:-1 err:31
[    0.755215] pcifront pci-0: publishing successful!
[    0.757341] usbcore: registered new interface driver udlfb
[    0.758365] xen:xen_evtchn: Event-channel device installed
[    0.760419] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.760819] pcifront pci-0: Installing PCI frontend
[    0.761518] pcifront pci-0: Creating PCI Frontend Bus 0000:00
[    0.761684] pcifront pci-0: PCI host bridge to bus 0000:00
[    0.761710] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.761733] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffffffff]
[    0.761763] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.761783] pci_bus 0000:00: scanning bus
[    0.761805] pcifront pci-0: read dev=0000:00:00.0 - offset 0 size 4
[    0.767207] Linux agpgart interface v0.103
[    0.767362] Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 seconds, margin is 60 seconds).
[    0.767439] [drm] Initialized drm 1.1.0 20060810
[    0.767515] [drm] radeon kernel modesetting enabled.
[    0.766948] pcifront pci-0: pciback not responding!!! irq:31 irq_flags:ffff880019ec0028 ns: 1431641983026498000  ns_timeout: 1431641983026497000 evtchn:0 gnt_ref:0
[    0.766948] pcifront pci-0: ?!?!? op cmd:0 err:0 info:0 offset:0 size:4
[    0.766948] pcifront pci-0: ?!?!? active_op cmd:0 err:0 info:0 offset:0 size:4
[    0.766948] pcifront pci-0: other err read got back err: ffffffff value: 0
[    2.762062] pcifront pci-0: read dev=0000:00:01.0 - offset 0 size 4
[    2.765203] pcifront pci-0: pciback not responding!!! irq:31 irq_flags:ffff880019ec0028 ns: 1431641985026742000  ns_timeout: 1431641985026741000 evtchn:0 gnt_ref:0
[    2.765203] pcifront pci-0: ?!?!? op cmd:0 err:0 info:0 offset:0 size:4
[    2.765203] pcifront pci-0: ?!?!? active_op cmd:0 err:0 info:0 offset:0 size:4
[    2.765203] pcifront pci-0: other err read got back err: ffffffff value: 0
[    4.762172] pcifront pci-0: read dev=0000:00:02.0 - offset 0 size 4
[    4.764231] brd: module loaded
[    4.765508] loop: module loaded
[    4.766748] pcifront pci-0: pciback not responding!!! irq:31 irq_flags:ffff880019ec0028 ns: 1431641987026850000  ns_timeout: 1431641987026849000 evtchn:0 gnt_ref:0
[    4.766748] pcifront pci-0: ?!?!? op cmd:0 err:0 info:0 offset:0 size:4
[    4.766748] pcifront pci-0: ?!?!? active_op cmd:0 err:0 info:0 offset:0 size:4
[    4.766748] pcifront pci-0: other err read got back err: ffffffff value: 0
[    6.762248] pcifront pci-0: read dev=0000:00:03.0 - offset 0 size 4
[    6.765545] pcifront pci-0: pciback not responding!!! irq:31 irq_flags:ffff880019ec0028 ns: 1431641989026930000  ns_timeout: 1431641989026929000 evtchn:0 gnt_ref:0
[    6.765545] pcifront pci-0: ?!?!? op cmd:0 err:0 info:0 offset:0 size:4
[    6.765545] pcifront pci-0: ?!?!? active_op cmd:0 err:0 info:0 offset:0 size:4
[    6.765545] pcifront pci-0: other err read got back err: ffffffff value: 0
[    8.762329] pcifront pci-0: read dev=0000:00:04.0 - offset 0 size 4
[    8.765626] pcifront pci-0: pciback not responding!!! irq:31 irq_flags:ffff880019ec0028 ns: 1431641991027006000  ns_timeout: 1431641991027005000 evtchn:0 gnt_ref:0
[    8.765626] pcifront pci-0: ?!?!? op cmd:0 err:0 info:0 offset:0 size:4
[    8.765626] pcifront pci-0: ?!?!? active_op cmd:0 err:0 info:0 offset:0 size:4
[    8.765626] pcifront pci-0: other err read got back err: ffffffff value: 0
[   10.762410] pcifront pci-0: read dev=0000:00:05.0 - offset 0 size 4
[   10.765701] pcifront pci-0: pciback not responding!!! irq:31 irq_flags:ffff880019ec0028 ns: 1431641993027087000  ns_timeout: 1431641993027086000 evtchn:0 gnt_ref:0
[   10.765701] pcifront pci-0: ?!?!? op cmd:0 err:0 info:0 offset:0 size:4
[   10.765701] pcifront pci-0: ?!?!? active_op cmd:0 err:0 info:0 offset:0 size:4
[   10.765701] pcifront pci-0: other err read got back err: ffffffff value: 0
[   12.762472] pcifront pci-0: read dev=0000:00:06.0 - offset 0 size 4


So somehow in the non-working situation, pdev->evtchn and pdev->gnt_ref are 0 in 
xen-pcifront.c:do_pci_op(), so no wonder it's not getting a response back ...

Question is .. why ?

--
Sander
