From: Len Brown <lenb@kernel.org>
Subject: RE: [Xen-devel] Re: Paravirtualizing bits of acpi access
Date: Fri, 27 Mar 2009 17:57:08 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903271744340.26419@localhost.localdomain>
References: <49C484B7.20100@goop.org>
 <0A882F4D99BBF6449D58E61AAFD7EDD60E5E877B@pdsmsx502.ccr.corp.intel.com>
 <49C88647.8080404@goop.org> <200903241045.19194.bjorn.helgaas@hp.com>
 <49C91832.8090300@goop.org>
 <4F65016F6CB04E49BFFA15D4F7B798D9944E2524@orsmsx506.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:14044 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145AbZC0V5f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Mar 2009 17:57:35 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH6009KNQBV7FV1@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 16:57:32 -0500 (CDT)
In-reply-to: <4F65016F6CB04E49BFFA15D4F7B798D9944E2524@orsmsx506.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Cihula, Joseph" <joseph.cihula@intel.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Brown, Len" <len.brown@intel.com>, Xen-devel <xen-devel@lists.xensource.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Wang, Shane" <shane.wang@intel.com>


> > The two changes this patch makes are, unfortunately, unavoidable:
> >
> >    1. Turn the final "enter sleep" into a hypercall, so that Xen can do
> >       all the low-level context save/restore.  The normal baremetal case
> >       is still localized in acpica/hwsleep.c, but it (may) make an
> >       excursion into arch code to see if it should do something else, and
> >    2. Directly enter the sleep state, rather than save cpu context
> >       (which Xen does)
> >
> > Though, come to think of it, perhaps there's no harm in letting the
> > kernel do its own state-saving.  I'll check.

Certainly the less different than bare metal you can be, the better.

The last thing we need is to complicate something that in Linux
has only been sort of working for 


> diff -r 855cb34ca992 drivers/acpi/acpica/hwsleep.c
> --- a/drivers/acpi/acpica/hwsleep.c     Tue Mar 17 19:53:17 2009 -0400
> +++ b/drivers/acpi/acpica/hwsleep.c     Tue Mar 24 09:37:22 2009 -0700
> @@ -45,6 +45,7 @@
>  #include <acpi/acpi.h>
>  #include "accommon.h"
>  #include "actables.h"
> +#include <asm/tboot.h>
> 
>  #define _COMPONENT          ACPI_HARDWARE
>  ACPI_MODULE_NAME("hwsleep")
> @@ -332,6 +333,39 @@ acpi_status asmlinkage acpi_enter_sleep_
> 
>         PM1Acontrol |= sleep_enable_reg_info->access_bit_mask;
>         PM1Bcontrol |= sleep_enable_reg_info->access_bit_mask;
> +
> +#ifdef CONFIG_TXT
> +#define TB_COPY_GAS(tbg, g)                 \
> +       tbg.space_id = g.space_id;          \
> +       tbg.bit_width = g.bit_width;        \
> +       tbg.bit_offset = g.bit_offset;      \
> +       tbg.access_width = g.access_width;  \
> +       tbg.address = g.address;
> +
> +       if (tboot_in_measured_env()) {
> +               TB_COPY_GAS(tboot_shared->acpi_sinfo.pm1a_cnt_blk,
> +                           acpi_gbl_FADT.xpm1a_control_block);
> +               TB_COPY_GAS(tboot_shared->acpi_sinfo.pm1b_cnt_blk,
> +                           acpi_gbl_FADT.xpm1b_control_block);

Who'd a thunk that suddently everybody would want to scribble
on acpi_enter_sleep_state()?

Note that acpica/hwsleep.c is a file from ACPICA that we share
with BSD etc.  Yes, we manage local changes in Linux, but we
try to reduce them to zero over time, else we create a big
maintenace headache.

perhaps tboot_in_measured_env() could compile in as 0
for !CONFIG_TXT and you can get rid of the #ifdefs?

Jeremy, I'm not excited about a proposed change to acpixf.h --
this is the API to ACPICA...

thanks,
-Len Brown, Intel Open Source Technology Center
