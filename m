From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch] ACPI: call init functions explicitly instead of using initcalls
Date: Tue, 4 Nov 2008 18:33:47 -0600
Message-ID: <200811041733.48396.bjorn.helgaas@hp.com>
References: <200810291525.58218.bjorn.helgaas@hp.com> <200810300913.32986.bjorn.helgaas@hp.com> <1225424543.3993.44.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:7571 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754090AbYKEAdv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Nov 2008 19:33:51 -0500
In-Reply-To: <1225424543.3993.44.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>

On Thursday 30 October 2008 09:42:23 pm Zhao Yakui wrote:
> On Thu, 2008-10-30 at 23:13 +0800, Bjorn Helgaas wrote:
> > On Wednesday 29 October 2008 08:01:43 pm Zhao Yakui wrote:
> > > On Thu, 2008-10-30 at 05:25 +0800, Bjorn Helgaas wrote:
> > > > Call init_acpi_device_notify(), acpi_debug_init(), acpi_scan_init(),
> > > > and acpi_system_init() explicitly from acpi_init() instead of using
> > > > initcalls.  This removes some link order and initcall order dependencies.
> > > >
> > > What is the advantage after the following functions are explicitly from
> > > acpi_init instead of using initcall?
> > 
> > The advantage of explicit calls is that you don't have to worry
> > about whether the initcall ordering is correct.  The ordering
> > is obvious from the code and doesn't depend on link order.
> Understand.     
> > > In your patch the module link order is also changed. In current kernel
> > > some module parameters using the same ACPI prefix are defined in the
> > > different files. For example: acpi.debug_layer && acpi.debug_level are
> > > defined in debug.c. The acpi.acpica_version is defined in system.c.
> > >
> > > If they are separated by files with module parameter, there exists the
> > > following warning message.
> > >      >WARNING: at /linux-2.6/fs/sysfs/dir.c:463
> > > >sysfs_add_one+0x33/0x39()
> > > >sysfs: duplicate filename 'acpi' can not be created
> > 
> > I did change the link order because acpi/debug.c and acpi/system.c
> > are not drivers in the same sense as things like ec.c, pci_root.c,
> > etc.  debug.c and system.c are really optional parts of ACPI itself,
> > not things that can be loaded in after the fact like drivers can.
> > 
> > It would certainly be bad if the /sys/module/acpi directory creation
> > relies on module link order.  I don't know enough about sysfs to
> > intuit where this problem occurs, and I don't see it in my testing
> > (see dmesg below).  Can you give any more information about this?
>    For example: In my test the acpi.power_nocheck is defined in power.c.
> The acpi.debug_level & acpi.debug_layer are defined in debug.c. And they
> are split by the thermal/processor module.(The thermal/processor module
> is also compiled as built-in kernel). So the following warning message
> will be reported in the boot phase:
>    >sysfs: duplicate filename 'acpi' can not be created
> 
>     Why this happen is caused by the generic param code related with
> sysfs. (param_sysfs_init).

I think the param_sysfs_init() dependency on module link order was
removed by this recent commit: 9b473de87209fa86eb421b23386693b461612f30

So I'll quit the sysfs_add_one() wild goose chase and move on to the
other issues.

Bjorn
