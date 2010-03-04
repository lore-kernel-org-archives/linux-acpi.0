From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [patch 2/2] x86: Manage ENERGY_PERF_BIAS based on cpufreq
 governor
Date: Wed, 03 Mar 2010 16:27:49 -0800
Message-ID: <1267662469.16916.1020.camel@localhost.localdomain>
References: <20100303000649.757684000@intel.com>
	 <20100303000849.278509000@intel.com> <4B8DADB9.1040302@xenotime.net>
	 <20100303215453.GG2579@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32090 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752331Ab0CDA15 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 3 Mar 2010 19:27:57 -0500
In-Reply-To: <20100303215453.GG2579@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Ingo Molnar <mingo@elte.hu>, H Peter Anvin <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, Dave Jones <davej@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, 2010-03-03 at 13:57 -0800, Pavel Machek wrote:
> Hi!
> 
> > index 8c666d8..4945add 100644
> > --- a/Documentation/kernel-parameters.txt
> > +++ b/Documentation/kernel-parameters.txt
> > @@ -749,6 +749,10 @@ and is between 256 and 4096 characters. It is defined in the file
> >  			Default value is 0.
> >  			Value can be changed at runtime via /selinux/enforce.
> >  
> > +	epb		[X86] Control IA32_ENERGY_PERF_BIAS setting
> > +			"disable" - Kernel will not modify this MSR
> > +			<0..15> - Kernel will set this MSR to i/p static value
> > +
> > 
> > 
> > Should be more like:
> > 
> > 	epb=		[X86] Control IA32_ENERGY_PERF_BIAS setting
> > 			Format: { disable | <0...15> }
> > 			"disable" - Kernel will not modify this MSR
> > 			<0..15> - Kernel will set this MSR to i/p static value
> > 
> > 
> > But what is "i/p"?  Use whatever word it should be, please.
> > What do the values mean?
> > And what does IA32 have to do with this?  does it not apply to x86_64?
> 
> Exactly. This is end user documentation, it should not even talk about
> MSRs. Tell us what the setting does...

The not so good part of this feature is that the setting here is opaque.
Software can set this based on its preference, for example 0 for
performance 15 for power and 7 for balanced. Different CPUs can use this
information to do different optimizations or power-performance tradeoffs
in the hardware. The only thing that user knows here is that there is
this dial with 16 possible values. I can remove the MSR name here. But,
I think that will end up confusing the end user on what this thing is
and how it is related to all the other tunables we have in the kernel.
Having the MSR name gives a hint.

Also, the expectation here is that kernel will do the right thing by
default. The option here is to the user who_knows_what_he_is_doing to
override the kernel default.

> 
> Also... does it make change to tweak the setting during runtime? Maybe
> different settings for AC and battery power?

Yes. Matthew mentioned in other response aboue setting this based on
freq. For the CPUs that support this feature currently, we don't see
advantage in setting this feature at run time.

Thanks,
Venki



