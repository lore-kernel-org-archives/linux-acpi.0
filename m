From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi
	list to force rsdt
Date: Mon, 16 Jun 2008 09:50:30 +0800
Message-ID: <1213581031.30416.11.camel@yakui_zhao.sh.intel.com>
References: <1210259416.6710.13.camel@hammer1.suse.de>
	 <200805081609.08810.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44569 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750851AbYFPBjt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Jun 2008 21:39:49 -0400
In-Reply-To: <200805081609.08810.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: trenn@suse.de, linux-acpi <linux-acpi@vger.kernel.org>, me@markdoughty.co.uk

On Thu, 2008-05-08 at 16:09 -0400, Len Brown wrote:
> I find it hard to believe that Windows has a DMI entry for the R40e
> to use the RSDT instead of the XSDT.
> 
> We should find out why the XSDT is disqualified on that machine
> and do the same in Linux so that the R40e and any other similar
> machines do not need DMI entries.
>From the acpidump attached by Mark Doughty, it seems that there exists
the following error:
    ACPI Error (tbfadt-0537): 32/64X address mismatch in
"Pm2ControlBlock": [00008030] [0000000000008020], using 64X [20071114]
    ACPI Error (tbfadt-0537): 32/64X address mismatch in "Gpe0Block":
[00008018] [0000000000008028], using 64X [20071114]
    In such cases maybe the ACPI PM register block address is
incorrect. 

In fact we have another similar bug:
   http://bugzilla.kernel.org/show_bug.cgi?id=8246
   
   The 32/64X address mismatch also exists on the laptop of IBM R51e.
> -Len
> 
> On Thursday 08 May 2008, Thomas Renninger wrote:
> > Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
> > 
> > Signed-off-by: Thomas Renninger <trenn@suse.de>
> > Tested-by: Mark Doughty <me@markdoughty.co.uk>
> > 
> > 
> > ---
> >  Documentation/kernel-parameters.txt |    5 +++++
> >  drivers/acpi/tables.c               |   23 +++++++++++++++++++++++
> >  2 files changed, 28 insertions(+)
> > 
> > Index: linux-acpi-2.6_video_native_vs_vendor/drivers/acpi/tables.c
> > ===================================================================
> > --- linux-acpi-2.6_video_native_vs_vendor.orig/drivers/acpi/tables.c
> > +++ linux-acpi-2.6_video_native_vs_vendor/drivers/acpi/tables.c
> > @@ -32,6 +32,7 @@
> >  #include <linux/errno.h>
> >  #include <linux/acpi.h>
> >  #include <linux/bootmem.h>
> > +#include <linux/dmi.h>
> >  
> >  #define PREFIX			"ACPI: "
> >  
> > @@ -282,6 +283,23 @@ static void __init check_multiple_madt(v
> >  	return;
> >  }
> >  
> > +static struct dmi_system_id acpi_rsdt_dmi_table[] = {
> > +	{
> > +	    .ident = "ThinkPad ",
> > +	    .matches = {
> > +		DMI_MATCH(DMI_BIOS_VENDOR, "IBM"),
> > +		DMI_MATCH(DMI_BIOS_VERSION, "1SET")},
> > +	},
> > +};
> > +
> > +static int __init acpi_force_rsdt(char *opt)
> > +{
> > +	if (!strcmp(opt, "rsdt"))
> > +		acpi_gbl_force_rsdt = 1;
> > +	return 0;
> > +}
> > +early_param("acpi_root_table", acpi_force_rsdt);
> > +
> >  /*
> >   * acpi_table_init()
> >   *
> > @@ -293,6 +311,11 @@ static void __init check_multiple_madt(v
> >  
> >  int __init acpi_table_init(void)
> >  {
> > +	if (dmi_check_system(acpi_rsdt_dmi_table))
> > +		acpi_gbl_force_rsdt = 1;
> > +	if (acpi_gbl_force_rsdt)
> > +		printk(KERN_INFO "Using RSDT as ACPI root table\n");
> > +
> >  	acpi_initialize_tables(initial_tables, ACPI_MAX_TABLES, 0);
> >  	check_multiple_madt();
> >  	return 0;
> > Index: linux-acpi-2.6_video_native_vs_vendor/Documentation/kernel-parameters.txt
> > ===================================================================
> > --- linux-acpi-2.6_video_native_vs_vendor.orig/Documentation/kernel-parameters.txt
> > +++ linux-acpi-2.6_video_native_vs_vendor/Documentation/kernel-parameters.txt
> > @@ -230,6 +230,11 @@ and is between 256 and 4096 characters.
> >  			to assume that this machine's pmtimer latches its value
> >  			and always returns good values.
> >  
> > +	acpi_root_table=	[X86,ACPI]
> > +			{ rsdt }
> > +			rsdt: If RSDP contains a non-NULL RSDT address, take it
> > +			      for fetching ACPI tables (instead of XSDT)
> > +
> >  	agp=		[AGP]
> >  			{ off | try_unsupported }
> >  			off: disable AGP support
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 

