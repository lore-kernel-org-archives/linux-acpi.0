From: "Langsdorf, Mark" <mark.langsdorf@amd.com>
Subject: RE: [PATCH] powernow-k8: don't load powernow-k8 driver whenacpi=off
Date: Tue, 28 Jul 2009 09:47:42 -0500
Message-ID: <6453C3CB8E2B3646B0D020C112613273036209FC@sausexmb4.amd.com>
References: <1248315070.2670.16.camel@rzhang-dt> <200907231209.13343.trenn@suse.de> <1248758657.2670.137.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-dub.frontbridge.com ([213.199.154.16]:13555 "EHLO
	IE1EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbZG1Orx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jul 2009 10:47:53 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1248758657.2670.137.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Thomas Renninger <trenn@suse.de>
Cc: davej@redhat.com, linux-acpi <linux-acpi@vger.kernel.org>, cpufreq@vger.kernel.org, Len Brown <lenb@kernel.org>, howl.nsp@gmail.com

 

> -----Original Message-----
> From: Zhang Rui [mailto:rui.zhang@intel.com] 
> Sent: Tuesday, July 28, 2009 12:24 AM
> To: Thomas Renninger
> Cc: davej@redhat.com; linux-acpi; cpufreq@vger.kernel.org; 
> Len Brown; howl.nsp@gmail.com; Langsdorf, Mark
> Subject: Re: [PATCH] powernow-k8: don't load powernow-k8 
> driver whenacpi=off
> 
> On Thu, 2009-07-23 at 18:09 +0800, Thomas Renninger wrote:
> > On Thursday 23 July 2009 04:11:10 Zhang Rui wrote:
> > > when acpi=off, powernow-k8 driver is still loaded, and fails with
> > > a firmware bug warning message.
> > > http://bugzilla.kernel.org/show_bug.cgi?id=13695#c5
> > > 
> > > this is misleading,
> > > we should not load powernow-k8 driver when acpi=off.
> > > http://bugzilla.kernel.org/show_bug.cgi?id=13695
> > 
> > Maybe this one is better:
> >   - It allows these special, deprecated PSB BIOS structure
> >     use in acpi=off case
> >   - It complains that powernow-k8 won't work without ACPI, instead
> >     of complaining about the BIOS missing _PSS ACPI structures
> >     (in acpi=off case).
> > 
> > Compile tested on latest 2.6.31-rc2.
> > 
> >    Thomas
> > 
> > ----
> > CPUFREQ: Avoid powernow-k8 BIOS complains when acpi=off
> > 
> >   - It still allows these special, deprecated PSB BIOS structure
> >     use in acpi=off case
> >   - It complains that powernow-k8 won't work without ACPI, instead
> >     of complaining about the BIOS missing _PSS ACPI structures
> >     (in acpi=off case).
> > 
> > Signed-off-by: Thomas Renninger <trenn@suse.de>
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Signed-off-by: Mark Langsdorf <mark.langsdorf@amd.com>

> > ---
> >  arch/x86/kernel/cpu/cpufreq/powernow-k8.c |    6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > Index: 
> cpufreq_governor_cleanups/arch/x86/kernel/cpu/cpufreq/powernow-k8.c
> > ===================================================================
> > --- 
> cpufreq_governor_cleanups.orig/arch/x86/kernel/cpu/cpufreq/pow
> ernow-k8.c
> > +++ 
> cpufreq_governor_cleanups/arch/x86/kernel/cpu/cpufreq/powernow-k8.c
> > @@ -1286,7 +1286,11 @@ static int __cpuinit powernowk8_cpu_init
> >  		 * an UP version, and is deprecated by AMD.
> >  		 */
> >  		if (num_online_cpus() != 1) {
> > -			printk_once(ACPI_PSS_BIOS_BUG_MSG);
> > +			if (acpi_disabled)
> > +				printk_once(KERN_WARN PFX
> > +					    "ACPI disabled, exiting\n");
> > +			else
> > +				printk_once(ACPI_PSS_BIOS_BUG_MSG);
> >  			goto err_out;
> >  		}
> >  		if (pol->cpu != 0) {
> > 
> 
> 
> 

