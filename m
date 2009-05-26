From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH] PCI/ACPI: fix wrong ref count handling in
	acpi_pci_bind()
Date: Tue, 26 May 2009 17:41:48 -0600
Message-ID: <20090526234148.GA12468@ldl.fc.hp.com>
References: <4A1B32E3.7060801@jp.fujitsu.com> <200905260946.02184.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:38519 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754840AbZEZXls (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 May 2009 19:41:48 -0400
Content-Disposition: inline
In-Reply-To: <200905260946.02184.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux acpi <linux-acpi@vger.kernel.org>, lenb@kernel.org

Adding Len because this should probably go through his tree, not
Jesse's.

Len, we're discussing a patch that I feel should go into 2.6.30,
because it fixes an oops that I introduced in the beginning of
the merge window, and that we've been working on since. We just
now have a patch to fix it, along with another patch that I
wrote:

	http://patchwork.kernel.org/patch/25296/

This current patch is here:

	http://patchwork.kernel.org/patch/25895/

Discussion follows.

* Bjorn Helgaas <bjorn.helgaas@hp.com>:
> On Monday 25 May 2009 06:08:03 pm Kenji Kaneshige wrote:
> > Fix wrong struct pci_dev reference counter handling in acpi_pci_bind().
> > 
> > The 'dev' field of struct acpi_pci_data is having a pointer to struct
> > pci_dev without incrementing the reference counter. Because of this, I
> > got the following kernel oops when I was doing some pci hotplug
> > operations. This patch fixes this bug by replacing wrong hand-made
> > pci_find_slot() with pci_get_slot() in acpi_pci_bind().
> 
> I don't like this ACPI/PCI bind thing in general because having the
> extra .bind and .unbind methods is ugly and somewhat non-obvious, and
> I'm nervous about object lifetime issues like this one.
> 
> But I don't have a better alternative to offer, and there's definitely
> a problem here, so thanks for fixing and testing it.  I do have one
> question below about whether the comment in the existing code, which
> seems to be an excuse for doing the hand-made pci_find_slot(), is
> still relevant, or should just be removed.

I reviewed and successfully tested this patch on our ia64 machine.

Reviewed-by: Alex Chiang <achiang@hp.com>
Tested-by: Alex Chiang <achiang@hp.com>

> > @@ -180,16 +177,8 @@ int acpi_pci_bind(struct acpi_device *de
> >  	 * PCI devices are added to the global pci list when the root
> >  	 * bridge start ops are run, which may not have happened yet.
> 
> Please update or remove this comment, which claims that "we cannot
> simply search the global pci device list."  I don't know whether the
> comment (a) explains why we can't use pci_get_slot(), (b) explains
> why we can't use pci_find_slot() or some other interface, (c) refers
> to an ordering problem that doesn't exist on your system, or (d) is
> just no longer applicable at all.

I think the comment is simply no longer applicable.

During boot, we exercise this path in acpi_pci_root_add():

acpi_pci_root_add
	pci_acpi_scan_root
	acpi_pci_bind_root
	acpi_pci_bridge_scan
		acpi_pci_bind

pci_acpi_scan_root will create the PCI namespace for us before we
attempt to bind the devices, so we know we will find the pci_dev
on the pci_bus->devices list.

During hotplug, we exercise this path:

acpiphp_enable_slot
	enable_device
		pci_scan_slot
		pci_scan_bridge
		acpiphp_bus_add
			acpi_bus_add
				acpi_add_single_object
					acpi_pci_bind

pci_scan_slot() will put the new pci_devs onto pci_bus->devices,
so by the time we get to acpi_pci_bind, the call to pci_get_slot
will be successful.

There is the case where we hotplug a bridge device:

handle_hotplug_event_bridge
	handle_bridge_insertion
		acpi_bus_add
			acpi_add_single_object
				acpi_pci_bind

And this does confuse me a little bit, because I'm not seeing how
the bridge device gets added to the parent pci_bus->devices list
before we get to acpi_pci_bind, but...

Kenji's patch isn't changing the semantics on _how_ we find a
device:

-       bus = pci_find_bus(data->id.segment, data->id.bus);
-       if (bus) {
-               list_for_each_entry(dev, &bus->devices, bus_list) {
-                       if (dev->devfn == PCI_DEVFN(data->id.device,
-                                                   data->id.function)) {
-                               data->dev = dev;
-                               break;
-                       }
-               }
-       }
+       data->dev = pci_get_slot(pdata->bus,
+                               PCI_DEVFN(data->id.device, data->id.function));
        if (!data->dev) {
                ACPI_DEBUG_PRINT((ACPI_DB_INFO,
                                  "Device %04x:%02x:%02x.%d not present in PCI namespace\n",

pci_get_slot() iterates across bus->devices too (except that it
correctly grabs the pci_bus_sem first) in addition to the obvious
refcount on the pci_dev.

Given the above, I feel pretty comfortable with Kenji-san's
change, and I'd recommend that he just get rid of that confusing
comment entirely.

The only other suggestion I have is that he could trim down the
oops output a bit to just get the stack trace:

BUG: unable to handle kernel NULL pointer dereference at 00000000000000e8
 IP: [<ffffffff803f0e9b>] acpi_pci_unbind+0xb1/0xdd
 Call Trace:
  [<ffffffff803ecee4>] acpi_bus_remove+0x54/0x68
  [<ffffffff803ecf6d>] acpi_bus_trim+0x75/0xe3
  [<ffffffffa0345ddd>] acpiphp_disable_slot+0x16d/0x1e0 [acpiphp]
  [<ffffffffa03441f0>] disable_slot+0x20/0x60 [acpiphp]
  [<ffffffff803cfc18>] power_write_file+0xc8/0x110
  [<ffffffff803c6a54>] pci_slot_attr_store+0x24/0x30
  [<ffffffff803469ce>] sysfs_write_file+0xce/0x140
  [<ffffffff802e94e7>] vfs_write+0xc7/0x170
  [<ffffffff802e9aa0>] sys_write+0x50/0x90
  [<ffffffff8020bd6b>] system_call_fastpath+0x16/0x1b

Thanks.

/ac

