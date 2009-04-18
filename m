From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 3/8] acpi-cpufreq: First multiply then divide to avoid zero
 results
Date: Sat, 18 Apr 2009 01:37:24 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904180134120.30751@localhost.localdomain>
References: <1239978132-6261-1-git-send-email-trenn@suse.de>
 <1239978132-6261-4-git-send-email-trenn@suse.de>
 <1239988227.4529.8641.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:53243 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbZDRFh2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 18 Apr 2009 01:37:28 -0400
In-reply-to: <1239988227.4529.8641.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Thomas Renninger <trenn@suse.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>


> Why is this needed? Normal C precedence rules should take care of this.

Correct, * and / are the same precedence
and they associate (are evaluated) left to right.

so this change is a functional no-op.

But my brain parsed this line better w/ this style change,
so i applied it:-)

thanks,
-Len Brown, Intel Open Source Technology Center

> On Fri, 2009-04-17 at 07:22 -0700, Thomas Renninger wrote:
> > Signed-off-by: Thomas Renninger <trenn@suse.de>
> > Cc: <linux-acpi@vger.kernel.org>
> > Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
> > Cc: <cpufreq@vger.kernel.org>
> > ---
> >  arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
> > index 4475523..7948d88 100644
> > --- a/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
> > +++ b/arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c
> > @@ -340,7 +340,7 @@ static unsigned int get_measured_perf(struct cpufreq_policy *policy,
> >  
> >  #endif
> >  
> > -	retval = per_cpu(drv_data, policy->cpu)->max_freq * perf_percent / 100;
> > +	retval = (per_cpu(drv_data, policy->cpu)->max_freq * perf_percent) / 100;
> >  
> >  	return retval;
> >  }
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
