From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [patch 2/2] x86: Manage ENERGY_PERF_BIAS based on cpufreq
 governor
Date: Wed, 03 Mar 2010 09:52:00 -0800
Message-ID: <1267638720.16916.953.camel@localhost.localdomain>
References: <20100303000649.757684000@intel.com>
	 <20100303000849.278509000@intel.com>  <4B8DADB9.1040302@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:9234 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755185Ab0CCRwE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 3 Mar 2010 12:52:04 -0500
In-Reply-To: <4B8DADB9.1040302@xenotime.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Ingo Molnar <mingo@elte.hu>, H Peter Anvin <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>, Dave Jones <davej@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2010-03-02 at 16:30 -0800, Randy Dunlap wrote:
> On 03/02/10 16:06, venkatesh.pallipadi@intel.com wrote:
> 
> {bah, more difficult to review an attachment, so no leading '>'}

Sorry. Not sure why/how you are seeing attachment issue. I used quilt
mail to send this out (I have used this method earlier as well) and I do
see patches inline .

> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 8c666d8..4945add 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -749,6 +749,10 @@ and is between 256 and 4096 characters. It is defined in the file
>  			Default value is 0.
>  			Value can be changed at runtime via /selinux/enforce.
>  
> +	epb		[X86] Control IA32_ENERGY_PERF_BIAS setting
> +			"disable" - Kernel will not modify this MSR
> +			<0..15> - Kernel will set this MSR to i/p static value
> +
> 
> 
> Should be more like:
> 
> 	epb=		[X86] Control IA32_ENERGY_PERF_BIAS setting
> 			Format: { disable | <0...15> }

OK. Will change.

> 			"disable" - Kernel will not modify this MSR
> 			<0..15> - Kernel will set this MSR to i/p static value
> 
> 
> But what is "i/p"?  Use whatever word it should be, please.

I meant input. will change to something like "specified value"

> What do the values mean?

The way MSR is defined, the value is opaque. It can be used for
different optimizations in different CPUs.

> And what does IA32 have to do with this?  does it not apply to x86_64?

IA32_ in any MSR name is the convention that is generally followed for
all MSRs in Intel SDM. It means that the MSR is architectural (can be
detected with CPUID or some other standard way and not CPU Model
specific.

Thanks,
Venki

