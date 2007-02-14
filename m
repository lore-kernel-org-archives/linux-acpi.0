From: John Keller <jpk@sgi.com>
Subject: Re: acpi_bus_register_driver() and latest acpi trees
Date: Wed, 14 Feb 2007 11:29:03 -0600 (CST)
Message-ID: <200702141729.l1EHT38M402952@fcbayern.americas.sgi.com>
References: <200702110103.22630.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from omx1-ext.sgi.com ([192.48.179.11]:41203 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750952AbXBNRaa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Feb 2007 12:30:30 -0500
In-Reply-To: <200702110103.22630.lenb@kernel.org> from "Len Brown" at Feb 11, 2007 01:03:22 AM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: John Keller <jpk@sgi.com>, Luck Tony <tony.luck@intel.com>, Zhang Rui <rui.zhang@intel.com>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, akpm@osdl.org, ayoung@sgi.com, shaohua.li@intel.com

> 
> On Friday 09 February 2007 19:27, John Keller wrote:
> > > 
> > > On Wednesday 31 January 2007 20:58, Zhang Rui wrote:
> > > > On Wed, 2007-01-31 at 10:11 -0600, John Keller wrote:
> > > > > Len,
> > > > >   When building kernels from your ACPI release or test trees,
> > > > > as well as the -mm tree, SN Altix boots are crashing in the
> > > > > kobject code when calling acpi_bus_register_driver().
> > > > > The crash is because kset->list has not been initialized yet.
> > > > > 
> > > > >  kobject_add()
> > > > >   list_add_tail(&kobj->entry,&kobj->kset->list);
> > > > > 
> > > > > 
> > > > > Is there now a restriction on how early acpi_bus_register_driver()
> > > > > can be called? If so, at what point in time can calls be made,
> > > > > and is it still possible to register a driver early enough such
> > > > > that it will be called at device discovery time vs registration time?
> > > > >
> > > > Yes, this is caused by the recent ACPI sysfs conversion changes.
> > > > Now we make ACPI use driver model.
> > > > All the ACPI drivers should register after the ACPI bus has registered,
> > > > i.e. we can not call acpi_bus_register_driver() before acpi_scan_init()
> > > > in drivers/acpi/scan.c. 
> > > 
> > > John,
> > > Below is the order of the linux driver model universe.
> > > acpi_bus_register_driver is safe to call after subsys_initcall(),
> > > ie. at device_initcall() time.  Do you need to be earlier than that,
> > > and if so, why?
> > > 
> > > thanks,
> > > -Len
> > > 
> > > 
> > > #define core_initcall(fn)               __define_initcall("1",fn,1)
> > > #define core_initcall_sync(fn)          __define_initcall("1s",fn,1s)
> > > #define postcore_initcall(fn)           __define_initcall("2",fn,2)
> > > #define postcore_initcall_sync(fn)      __define_initcall("2s",fn,2s)
> > > #define arch_initcall(fn)               __define_initcall("3",fn,3)
> > > #define arch_initcall_sync(fn)          __define_initcall("3s",fn,3s)
> > > #define subsys_initcall(fn)             __define_initcall("4",fn,4)
> > > #define subsys_initcall_sync(fn)        __define_initcall("4s",fn,4s)
> > > #define fs_initcall(fn)                 __define_initcall("5",fn,5)
> > > #define fs_initcall_sync(fn)            __define_initcall("5s",fn,5s)
> > > #define rootfs_initcall(fn)             __define_initcall("rootfs",fn,rootfs)
> > > #define device_initcall(fn)             __define_initcall("6",fn,6)
> > > #define device_initcall_sync(fn)        __define_initcall("6s",fn,6s)
> > > #define late_initcall(fn)               __define_initcall("7",fn,7)
> > > #define late_initcall_sync(fn)          __define_initcall("7s",fn,7s)
> > > 
> > 
> > 
> > Len,
> >  We're registering a driver for our IO hubs. Within the hubs are our
> > PCI root buses/bridges. Our code currently expects the hub infrastructure
> > for a particular bus to be initialized prior to bus scanning and the
> > invocation of our platform specific bus fixup code.
> > 
> > We've been able to make this happen by registering our driver prior to
> > acpi_bus_scan(), so that when our hub devices are discovered, the driver
> > can execute before the acpi_pci_root_driver.
> > 
> > With the latest ACPI changes it appears that this is no longer possible?
> 
> Yep, that's right.
> Any chance the early hub infrastructure init can be split out to
> happen before driver registration?

Our driver's main purpose is to do the hub infrastructure init.
It does the init based on the PROM supplied info in the vendor resource
for each hub device.

I suspect we could move this code earlier, but then we'd have to manually
walk the namespace to find our hub devices and the vendor resources.
Registering as a driver, and being called with the acpi_device for each of
our hub devices works very slick today.


Or am I missing something?

John


> 
> -Len
> 

