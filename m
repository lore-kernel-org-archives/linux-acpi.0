From: Len Brown <lenb@kernel.org>
Subject: Re: acpi_bus_register_driver() and latest acpi trees
Date: Wed, 7 Feb 2007 21:29:39 -0500
Message-ID: <200702072129.40098.lenb@kernel.org>
References: <200701311611.l0VGBCwY395506@fcbayern.americas.sgi.com> <1170295115.24637.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50471 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422918AbXBHCbE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Feb 2007 21:31:04 -0500
In-Reply-To: <1170295115.24637.5.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: John Keller <jpk@sgi.com>, len.brown@intel.com, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, akpm@osdl.org, ayoung@sgi.com, shaohua.li@intel.com

On Wednesday 31 January 2007 20:58, Zhang Rui wrote:
> On Wed, 2007-01-31 at 10:11 -0600, John Keller wrote:
> > Len,
> >   When building kernels from your ACPI release or test trees,
> > as well as the -mm tree, SN Altix boots are crashing in the
> > kobject code when calling acpi_bus_register_driver().
> > The crash is because kset->list has not been initialized yet.
> > 
> >  kobject_add()
> >   list_add_tail(&kobj->entry,&kobj->kset->list);
> > 
> > 
> > Is there now a restriction on how early acpi_bus_register_driver()
> > can be called? If so, at what point in time can calls be made,
> > and is it still possible to register a driver early enough such
> > that it will be called at device discovery time vs registration time?
> >
> Yes, this is caused by the recent ACPI sysfs conversion changes.
> Now we make ACPI use driver model.
> All the ACPI drivers should register after the ACPI bus has registered,
> i.e. we can not call acpi_bus_register_driver() before acpi_scan_init()
> in drivers/acpi/scan.c. 

John,
Below is the order of the linux driver model universe.
acpi_bus_register_driver is safe to call after subsys_initcall(),
ie. at device_initcall() time.  Do you need to be earlier than that,
and if so, why?

thanks,
-Len


#define core_initcall(fn)               __define_initcall("1",fn,1)
#define core_initcall_sync(fn)          __define_initcall("1s",fn,1s)
#define postcore_initcall(fn)           __define_initcall("2",fn,2)
#define postcore_initcall_sync(fn)      __define_initcall("2s",fn,2s)
#define arch_initcall(fn)               __define_initcall("3",fn,3)
#define arch_initcall_sync(fn)          __define_initcall("3s",fn,3s)
#define subsys_initcall(fn)             __define_initcall("4",fn,4)
#define subsys_initcall_sync(fn)        __define_initcall("4s",fn,4s)
#define fs_initcall(fn)                 __define_initcall("5",fn,5)
#define fs_initcall_sync(fn)            __define_initcall("5s",fn,5s)
#define rootfs_initcall(fn)             __define_initcall("rootfs",fn,rootfs)
#define device_initcall(fn)             __define_initcall("6",fn,6)
#define device_initcall_sync(fn)        __define_initcall("6s",fn,6s)
#define late_initcall(fn)               __define_initcall("7",fn,7)
#define late_initcall_sync(fn)          __define_initcall("7s",fn,7s)
