From: Stefan Bader <stefan.bader@canonical.com>
Subject: Re: Regression in 3.1 causes Xen to use wrong idle routine
Date: Wed, 26 Oct 2011 15:36:50 +0200
Message-ID: <4EA80CF2.5040309@canonical.com>
References: <4EA7DFD1.9060608@canonical.com> <20111026133003.GA6654@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:47355 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932742Ab1JZNgz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Oct 2011 09:36:55 -0400
In-Reply-To: <20111026133003.GA6654@phenom.dumpdata.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: len.brown@intel.com, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 26.10.2011 15:30, Konrad Rzeszutek Wilk wrote:
> On Wed, Oct 26, 2011 at 12:24:17PM +0200, Stefan Bader wrote:
>> The following commit changes calls to pm_idle into first trying
>> cpuidle_call_idle() and if that returns non-zero to fall back to
>> call pm_idle().
>>
>> commit a0bfa1373859e9d11dc92561a8667588803e42d8
>> Author: Len Brown <len.brown@intel.com>
>> Date:   Fri Apr 1 19:34:59 2011 -0400
>>
>>     cpuidle: stop depending on pm_idle
>>
>> However cpuidle_call_idle() will return -ENODEV if it is supposed to be disabled
>> by cpuidle.off. Which then causes pm_idle() to be called.
>>
>> This has some bad interaction with the following change that tries to
>> make use of disabling cpuidle in Xen to fall back to hlt.
>>
>> commit d91ee5863b71e8c90eaf6035bff3078a85e2e7b5
>> Author: Len Brown <len.brown@intel.com>
>> Date:   Fri Apr 1 18:28:35 2011 -0400
>>
>>     cpuidle: replace xen access to x86 pm_idle and default_idle
>>
>> The problem I see is that select_idle_routine() is called from
>> arch/x86/kernel/cpu/common.c and since Xen setup does not set pm_idle
>> anymore, it can cause mwait_idle or amd_e400_idle functions to be selected.
> 
> Right, b/c that is what d91ee5863b71e8c90eaf6035bff3078a85e2e7b5 was suppose
> to do - " xen scribble on pm_idle and access default_idle,
>     have it simply disable_cpuidle() so acpi_idle will not load and
>     architecture default HLT will be used."
> 
> But it seems that select_idle_routine() was not thought off.
> 
>> In testing it seem amd_e400_idle in PVM domU at least does not immediately cause
>> problems, but mwait_idle just causes crashes. From the reports I have
>> this may be related to older hypervisors (3.1 and older) not clearing the mwait
>> capability. But overall there seems something wrong in the interaction.
>>
>> I am not really sure whether the logic of calling pm_idle() on all errors from
>> cpuidle_call_idle() is already flawed or the assumption in the Xen patch about
>> being able to prevent the wrong idle function by turning cpuidle off is incorrect.
>> One quick fix could be to add some Xen case into select_idle_routine() which
>> picks default_idle...
> 
> What about using the cpuidle_disabled() functionality and adhere to that?
> As so:
> 
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index e7e3b01..1f7f8c8 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -14,6 +14,7 @@
>  #include <linux/utsname.h>
>  #include <trace/events/power.h>
>  #include <linux/hw_breakpoint.h>
> +#include <linux/cpuidle.h>
>  #include <asm/cpu.h>
>  #include <asm/system.h>
>  #include <asm/apic.h>
> @@ -587,6 +588,10 @@ void __cpuinit select_idle_routine(const struct cpuinfo_x86 *c)
>  	if (pm_idle)
>  		return;
>  
> +	if (cpuidle_disabled()) {
> +		pm_idle = default_idle;
> +		return;
> +	}
>  	if (cpu_has(c, X86_FEATURE_MWAIT) && mwait_usable(c)) {
>  		/*
>  		 * One CPU supports mwait => All CPUs supports mwait
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index b51629e..123fe9e 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -122,6 +122,7 @@ struct cpuidle_driver {
>  };
>  
>  #ifdef CONFIG_CPU_IDLE
> +extern int cpuidle_disabled(void);
>  extern void disable_cpuidle(void);
>  extern int cpuidle_idle_call(void);
>  
> @@ -137,6 +138,7 @@ extern int cpuidle_enable_device(struct cpuidle_device *dev);
>  extern void cpuidle_disable_device(struct cpuidle_device *dev);
>  
>  #else
> +static inline int cpuidle_disabled(void) { return 1; }
>  static inline void disable_cpuidle(void) { }
>  static inline int cpuidle_idle_call(void) { return -ENODEV; }
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

>From reading over it, this should work. Though I would be interested to hear
from the linux-acpi folks. Also to double check that calling pm_idle when
cpuidle.off was specified really is what is intended.

-Stefan
