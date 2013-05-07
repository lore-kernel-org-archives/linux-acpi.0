From: Max Asbock <masbock@linux.vnet.ibm.com>
Subject: Re: [Patch] MCE, APEI: Don't enable CMCI when Firmware First mode
 is set in HEST for corrected machine checks
Date: Mon, 06 May 2013 20:32:46 -0700
Message-ID: <1367897566.4518.83.camel@oc3432500282.ibm.com>
References: <1367881102.4518.68.camel@oc3432500282.ibm.com>
	 <20130506232537.GF22041@pd.tnic>
Reply-To: masbock@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:55582 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758091Ab3EGDcy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 May 2013 23:32:54 -0400
Received: from /spool/local
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <masbock@linux.vnet.ibm.com>;
	Mon, 6 May 2013 21:32:54 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 0FE481FF001D
	for <linux-acpi@vger.kernel.org>; Mon,  6 May 2013 21:27:44 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r473Wnvt123576
	for <linux-acpi@vger.kernel.org>; Mon, 6 May 2013 21:32:49 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r473Wm0M011621
	for <linux-acpi@vger.kernel.org>; Mon, 6 May 2013 21:32:49 -0600
In-Reply-To: <20130506232537.GF22041@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, linux-acpi@vger.kernel.org, ying.huang@intel.com, naveen.n.rao@in.ibm.com, ananth@in.ibm.com, lcm@linux.vnet.ibm.com

On Tue, 2013-05-07 at 01:25 +0200, Borislav Petkov wrote:
> On Mon, May 06, 2013 at 03:58:22PM -0700, Max Asbock wrote:
> > This patch adds code to the machine check handler to parse the 
> > APEI Hardware Error Source Table (HEST) and check if Firmware First mode
> > is set for the Correct Machine Check structure in HEST.
> > If Firmware First mode is set, the corrected machine checks are expected
> > to be reported through a Generic Hardware Error Source (GHES). Therefore in this
> > case CMCI will not be enabled to avoid interference with the firmware's
> > error reporting.
> > 
> > Signed-off-by: Max Asbock <masbock@linux.vnet.ibm.com>
> > ---
> >  include/asm/mce.h                |    2 +
> >  kernel/cpu/mcheck/mce-apei.c     |   70 +++++++++++++++++++++++++++++++++++++++
> >  kernel/cpu/mcheck/mce-internal.h |    5 ++
> >  kernel/cpu/mcheck/mce_intel.c    |    6 ++-
> >  4 files changed, 81 insertions(+), 2 deletions(-)
> > 
> > 
> > diff -burpN linux-3.9/arch/x86/include/asm/mce.h linux-3.9.ff/arch/x86/include/asm/mce.h
> > --- linux-3.9/arch/x86/include/asm/mce.h	2013-05-02 09:38:16.000000000 -0700
> > +++ linux-3.9.ff/arch/x86/include/asm/mce.h	2013-05-03 13:20:36.000000000 -0700
> > @@ -144,12 +144,14 @@ DECLARE_PER_CPU(struct device *, mce_dev
> >  
> >  #ifdef CONFIG_X86_MCE_INTEL
> >  void mce_intel_feature_init(struct cpuinfo_x86 *c);
> > +void mce_intel_init_cmci(void);
> >  void cmci_clear(void);
> >  void cmci_reenable(void);
> >  void cmci_rediscover(void);
> >  void cmci_recheck(void);
> >  #else
> >  static inline void mce_intel_feature_init(struct cpuinfo_x86 *c) { }
> > +static inline void mce_intel_init_cmci(void) {}
> >  static inline void cmci_clear(void) {}
> >  static inline void cmci_reenable(void) {}
> >  static inline void cmci_rediscover(void) {}
> > diff -burpN linux-3.9/arch/x86/kernel/cpu/mcheck/mce-apei.c linux-3.9.ff/arch/x86/kernel/cpu/mcheck/mce-apei.c
> > --- linux-3.9/arch/x86/kernel/cpu/mcheck/mce-apei.c	2013-05-02 09:38:16.000000000 -0700
> > +++ linux-3.9.ff/arch/x86/kernel/cpu/mcheck/mce-apei.c	2013-05-06 14:25:48.000000000 -0700
> > @@ -32,6 +32,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/acpi.h>
> >  #include <linux/cper.h>
> > +#include <linux/init.h>
> >  #include <acpi/apei.h>
> >  #include <asm/mce.h>
> >  
> > @@ -148,3 +149,72 @@ int apei_clear_mce(u64 record_id)
> >  {
> >  	return erst_clear(record_id);
> >  }
> > +
> > +
> > +/* Support for Firmware First (FF) mode for Corrected Machine Checks
> > + * as defined by APEI in the Hardware Error Source Table (HEST).
> > + * (see section 18.3.2.2 in the ACPI spec, version 5.0)
> > + *
> > + * When Firmware First mode is specified in HEST for Corrected Machine Checks,
> > + * these errors are expected to be reported by the firmware through a
> > + * Generic Harware Event Source (GHES). In this case error reporting
> > + * through CMCI should not be enabled so it won't interfere with the firmware.
> > + *
> > + * In the boot sequence HEST parsing is initialized after
> > + * CPUs, therefore initially we don't know if Firmware First is set.
> > + * We just assume yes, and enable CMCI in a late init call if FF is not set.
> 
> I'm very sceptical about that assumption - I don't think that the
> majority of boxes out there *now* have APEI and FF enabled (and those
> working properly :)).
> 
> Besides, there's a bigger problem with this - in the window between
> mce_intel_feature_init() and honor_cmc_firmware_first() you don't handle
> any correctable errors, AFAICT.

You bring up good points here. Most systems probably don't support APEI
and FF right now. Therefore a patch should not affect the behavior of
the majority of systems. And this current patch does leave a window
where CMCI is not enabled for all systems.

I actually have a different version of this patch where CMCI is always
enabled first and subsequently disabled if a HEST and FF is found, more
similar to what you suggest below. 

> 
> > + */
> > +static bool cmc_firmware_first;
> > +static bool cmc_firmware_first_checked;
> > +
> > +bool apei_cmc_firmware_first(void)
> > +{
> > +	if (!cmc_firmware_first_checked)
> > +		return true;
> > +	return cmc_firmware_first;
> > +}
> > +
> > +static int check_cmc_firmware_first(struct acpi_hest_header *hest_hdr, void *d)
> > +{
> > +	if (hest_hdr->type == ACPI_HEST_TYPE_IA32_CORRECTED_CHECK) {
> > +		struct acpi_hest_ia_corrected *cmc;
> > +
> > +		cmc = (struct acpi_hest_ia_corrected *)hest_hdr;
> > +
> > +		if (cmc->flags & ACPI_HEST_FIRMWARE_FIRST) {
> > +			cmc_firmware_first = true;
> > +			return 1;
> > +		}
> > +	}
> > +	return 0;
> > +}
> > +
> > +static void intel_late_init_cmci(void *data)
> > +{
> > +	if (!mce_available(__this_cpu_ptr(&cpu_info)))
> > +		return;
> > +
> > +	mce_intel_init_cmci();
> > +}
> > +
> > +static __init int honor_cmc_firmware_first(void)
> > +{
> > +	struct cpuinfo_x86 *c = __this_cpu_ptr(&cpu_info);
> > +
> > +	if (c->x86_vendor != X86_VENDOR_INTEL)
> > +		return 0;
> > +
> > +	apei_hest_parse(check_cmc_firmware_first, NULL);
> > +	cmc_firmware_first_checked = true;
> > +
> > +	if (cmc_firmware_first)
> > +		mca_cfg.cmci_disabled = true;
> > +
> > +	if (mca_cfg.cmci_disabled || mca_cfg.ignore_ce)
> > +		return 0;
> > +
> > +	on_each_cpu(intel_late_init_cmci, NULL, 1);
> > +	return 0;
> > +}
> > +
> > +late_initcall(honor_cmc_firmware_first);
> 
> This glue code should go to drivers/acpi/apei/ where the rest of the
> APEI gunk lives.

But this is glue code between MCE and APEI, therefore I thought a file
named mce-apei.c would be a good place. If we put it into apei then we
might have to export some of the MCE interfaces, whereas
apei_hest_parse() is already exported.

> 
> > diff -burpN linux-3.9/arch/x86/kernel/cpu/mcheck/mce_intel.c linux-3.9.ff/arch/x86/kernel/cpu/mcheck/mce_intel.c
> > --- linux-3.9/arch/x86/kernel/cpu/mcheck/mce_intel.c	2013-05-02 09:38:16.000000000 -0700
> > +++ linux-3.9.ff/arch/x86/kernel/cpu/mcheck/mce_intel.c	2013-05-03 13:21:53.000000000 -0700
> > @@ -315,7 +315,7 @@ void cmci_reenable(void)
> >  		cmci_discover(banks);
> >  }
> >  
> > -static void intel_init_cmci(void)
> > +void mce_intel_init_cmci(void)
> >  {
> >  	int banks;
> >  
> > @@ -337,5 +337,7 @@ static void intel_init_cmci(void)
> >  void mce_intel_feature_init(struct cpuinfo_x86 *c)
> >  {
> >  	intel_init_thermal(c);
> > -	intel_init_cmci();
> > +
> > +	if (!apei_cmc_firmware_first())
> > +		mce_intel_init_cmci();
> 
> Right, so I think the right approach should be to let CMCI get
> initialized, then when apei gets to run, it calls cmci_clear() to turn
> it off and continue its own FF handling. And this should be doable
> without touching any MCA internals like mca_cfg and such. Simply
> exporting the CMCI interfaces should be much cleaner.

I can post another version of this patch where CMCI gets initialized
first. 

> 
> Btw, we should keep the possibility open to be able to fall back to CMCI
> at any point when, for some reason, it has been determined that APEI
> functionality is out of order but we still want to have CMCI polling,
> independent from the BIOS.

Agreed, it would be good to be able to override FF.

thanks,
Max



