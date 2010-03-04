From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: [patch 2/2] x86: Manage ENERGY_PERF_BIAS based on cpufreq
 governor - v2
Date: Thu, 4 Mar 2010 15:34:33 -0800
Message-ID: <7C53B33EE871F14797C999838AA8B5A914A8317F@orsmsx505.amr.corp.intel.com>
References: <20100304231454.247805000@intel.com>
 <20100304231547.798303000@intel.com> <20100304232756.GA13895@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:64938 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756578Ab0CDXeK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Mar 2010 18:34:10 -0500
In-Reply-To: <20100304232756.GA13895@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, H Peter Anvin <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Venkatesh Pallipadi <venkatesh.pallipadi@gmail.com>

 

>-----Original Message-----
>From: Dave Jones [mailto:davej@redhat.com] 
>Sent: Thursday, March 04, 2010 3:28 PM
>To: Pallipadi, Venkatesh
>Cc: Ingo Molnar; H Peter Anvin; Thomas Gleixner; Len Brown; 
>linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org; 
>Venkatesh Pallipadi
>Subject: Re: [patch 2/2] x86: Manage ENERGY_PERF_BIAS based on 
>cpufreq governor - v2
>
>On Thu, Mar 04, 2010 at 03:14:56PM -0800, Venki Pallipadi wrote:
> 
> > +	if (!strncmp(gov->name, "performance", strlen("performance")))
> > +		epb_val = ENERGY_PERF_BIAS_PERF;
> > +	else if (!strncmp(gov->name, "powersave", strlen("powersave")))
> > +		epb_val = ENERGY_PERF_BIAS_POWER;
> > +	else
> > +		epb_val = ENERGY_PERF_BIAS_ONDEMAND;
> > +
> > +	set_epb_on_cpu(epb_val, cpu);
> > +	return 0;
>
>hardcoding a list of cpufreq governors is kinda icky, but I don't have
>a better solution.  We'll just have to be mindful of it if we ever
>get around to finally making performance/powersave personalities
>of ondemand as was discussed years ago.

Yes. In that case we will have to find some other way to tie this to
user preference.

>
>What if the governor is set to 'userspace' ?
>powernowd/cpufreqd are sort of ondemand-done-in-userspace, but there
>may also be other userspace governors we don't know about.
>I suppose it's not catastrophic..
>

Userspace/ondemand/conservative can all be at middle ground here as
they are mostly used where user expects adaptive kind of behaviour.

I did think about exporting this as a new tunable in /sys and let
userspace deal with it. But, that doesn't help with having sane default
values and users (background apps) may shoot themselves in the foot
with it.

Thanks,
Venki