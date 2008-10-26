From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH 3/4] x86 hibernate: Mark ACPI NVS memory region at startup
Date: Sun, 26 Oct 2008 13:29:15 +0100
Message-ID: <200810261329.16260.rjw@sisk.pl>
References: <200810222249.20629.rjw@sisk.pl> <200810222253.16264.rjw@sisk.pl> <20081026121404.GC1607@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:53973 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752672AbYJZMY2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 26 Oct 2008 08:24:28 -0400
In-Reply-To: <20081026121404.GC1607@ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Zhang Rui <rui.zhang@intel.com>

On Sunday, 26 of October 2008, Pavel Machek wrote:
> On Wed 2008-10-22 22:53:15, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > x86 hibernate: Mark ACPI NVS memory region at startup
> > 
> > Introduce new initcall for marking the ACPI NVS memory at startup, so
> > that it can be saved/restore during hibernation/resume.
> > 
> > Based on a patch by Zhang Rui.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  arch/x86/kernel/e820.c |   25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > Index: linux-2.6/arch/x86/kernel/e820.c
> > ===================================================================
> > --- linux-2.6.orig/arch/x86/kernel/e820.c
> > +++ linux-2.6/arch/x86/kernel/e820.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/pfn.h>
> >  #include <linux/suspend.h>
> >  #include <linux/firmware-map.h>
> > +#include <linux/efi.h>
> >  
> >  #include <asm/pgtable.h>
> >  #include <asm/page.h>
> 
> Unrelated chunk?
> 
> > @@ -665,6 +666,30 @@ void __init e820_mark_nosave_regions(uns
> >  }
> >  #endif
> >  
> > +#ifdef CONFIG_HIBERNATION
> > +/**
> > + * Mark ACPI NVS memory region, so that we can save/restore it during
> > + * hibernation and the subsequent resume.
> > + */
> > +static int __init e820_mark_nvs_memory(void)
> > +{
> > +	int i;
> > +
> > +	if (efi_enabled)
> > +		return 0;
> 
> Aha, not unrelated... why is that? EFI does not use acpi? 

With EFI we are not supposed to do that.  Rui knows the details.  Rui?

> > +	for (i = 0; i < e820.nr_map; i++) {
> > +		struct e820entry *ei = &e820.map[i];
> > +
> > +		if (ei->type == E820_NVS)
> > +			hibernate_nvs_register(ei->addr, ei->size);
> 
> can nvs_register fail? (OOM?)

It can, in which case it will do the cleanup.

Thanks,
Rafael
