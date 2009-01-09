From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] : ACPI : Use RSDT instead of XSDT by adding boot option of "acpi=rsdt"
Date: Fri, 9 Jan 2009 11:54:42 +0100
Message-ID: <200901091154.43606.trenn@suse.de>
References: <20081031184233.8588.42241.stgit@thinkpad> <1229504118.3991.63.camel@yakui_zhao.sh.intel.com> <alpine.LFD.2.00.0901090135300.4091@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41807 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472AbZAIKyr (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Fri, 9 Jan 2009 05:54:47 -0500
In-Reply-To: <alpine.LFD.2.00.0901090135300.4091@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Zhao Yakui <yakui.zhao@intel.com>, "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>, me@markdoughty.co.uk, ibm-acpi-devel@lists.sourceforge.net

On Friday 09 January 2009 07:35:33 Len Brown wrote:
> applied
>
> --
> Len Brown, Intel Open Source Technology Center
>
> On Wed, 17 Dec 2008, Zhao Yakui wrote:
> > From: Zhao Yakui <yakui.zhao@intel.com>
> >
> > On some boxes there exist both RSDT and XSDT table. But unfortunately
> > sometimes there exists the following error when XSDT table is used:
> >    a. 32/64X address mismatch
> >    b. The 32/64X FACS address mismatch
> >
> >    In such case the boot option of "acpi=rsdt" is provided so that
> > RSDT is tried instead of XSDT table when the system can't work well.

Great, now we still need a dmi blacklist with machines which are known
broken. Then we are at the patchset I posted about a year ago -> scnr.

I am going to post the missing two patches to make R40e and R50e work.

Thanks,

      Thomas
> >
> > http://bugzilla.kernel.org/show_bug.cgi?id=8246
> >
> > Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> > cc:Thomas Renninger <trenn@suse.de>
> > ---
> >  Documentation/kernel-parameters.txt |    2 ++
> >  arch/ia64/kernel/acpi.c             |    1 +
> >  arch/x86/kernel/acpi/boot.c         |    6 +++++-
> >  drivers/acpi/tables/tbutils.c       |    3 ++-
> >  include/acpi/acpixf.h               |    1 +
> >  5 files changed, 11 insertions(+), 2 deletions(-)
> >
> > Index: linux-2.6/arch/x86/kernel/acpi/boot.c
> > ===================================================================
> > --- linux-2.6.orig/arch/x86/kernel/acpi/boot.c
> > +++ linux-2.6/arch/x86/kernel/acpi/boot.c
> > @@ -47,7 +47,7 @@
> >  #endif
> >
> >  static int __initdata acpi_force = 0;
> > -
> > +u32 acpi_rsdt_forced;
> >  #ifdef	CONFIG_ACPI
> >  int acpi_disabled = 0;
> >  #else
> > @@ -1783,6 +1783,10 @@ static int __init parse_acpi(char *arg)
> >  			disable_acpi();
> >  		acpi_ht = 1;
> >  	}
> > +	/* acpi=rsdt use RSDT instead of XSDT */
> > +	else if (strcmp(arg, "rsdt") == 0) {
> > +		acpi_rsdt_forced = 1;
> > +	}
> >  	/* "acpi=noirq" disables ACPI interrupt routing */
> >  	else if (strcmp(arg, "noirq") == 0) {
> >  		acpi_noirq_set();
> > Index: linux-2.6/include/acpi/acpixf.h
> > ===================================================================
> > --- linux-2.6.orig/include/acpi/acpixf.h
> > +++ linux-2.6/include/acpi/acpixf.h
> > @@ -48,6 +48,7 @@
> >  #include "actypes.h"
> >  #include "actbl.h"
> >
> > +extern u32 acpi_rsdt_forced;
> >  /*
> >   * Global interfaces
> >   */
> > Index: linux-2.6/drivers/acpi/tables/tbutils.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/acpi/tables/tbutils.c
> > +++ linux-2.6/drivers/acpi/tables/tbutils.c
> > @@ -420,7 +420,8 @@ acpi_tb_parse_root_table(acpi_physical_a
> >
> >  	/* Differentiate between RSDT and XSDT root tables */
> >
> > -	if (rsdp->revision > 1 && rsdp->xsdt_physical_address) {
> > +	if (rsdp->revision > 1 && rsdp->xsdt_physical_address
> > +			&& !acpi_rsdt_forced) {
> >  		/*
> >  		 * Root table is an XSDT (64-bit physical addresses). We must use the
> >  		 * XSDT if the revision is > 1 and the XSDT pointer is present, as per
> > Index: linux-2.6/arch/ia64/kernel/acpi.c
> > ===================================================================
> > --- linux-2.6.orig/arch/ia64/kernel/acpi.c
> > +++ linux-2.6/arch/ia64/kernel/acpi.c
> > @@ -65,6 +65,7 @@ EXPORT_SYMBOL(pm_idle);
> >  void (*pm_power_off) (void);
> >  EXPORT_SYMBOL(pm_power_off);
> >
> > +u32 acpi_rsdt_forced;
> >  unsigned int acpi_cpei_override;
> >  unsigned int acpi_cpei_phys_cpuid;
> >
> > Index: linux-2.6/Documentation/kernel-parameters.txt
> > ===================================================================
> > --- linux-2.6.orig/Documentation/kernel-parameters.txt
> > +++ linux-2.6/Documentation/kernel-parameters.txt
> > @@ -139,6 +139,8 @@ and is between 256 and 4096 characters.
> >  			ht -- run only enough ACPI to enable Hyper Threading
> >  			strict -- Be less tolerant of platforms that are not
> >  				strictly ACPI specification compliant.
> > +			rsdt -- RSDT is used instead of XSDT table when both
> > +				exits.
> >
> >  			See also Documentation/power/pm.txt, pci=noacpi
> >
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html


