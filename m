From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v4 04/14] x86/rtc: replace paravirt rtc check with
 platform legacy quirk
Date: Fri, 8 Apr 2016 07:18:07 +0200
Message-ID: <57073F0F.400@suse.com>
References: <1459987594-5434-1-git-send-email-mcgrof@kernel.org>
 <1459987594-5434-5-git-send-email-mcgrof@kernel.org>
 <570658DA.7060509@oracle.com> <20160408003207.GN1990@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59271 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751043AbcDHFSN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Apr 2016 01:18:13 -0400
In-Reply-To: <20160408003207.GN1990@wotan.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, rusty@rustcorp.com.au, x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, david.vrabel@citrix.com, konrad.wilk@oracle.com, xen-devel@lists.xensource.com, lguest@lists.ozlabs.org, andriy.shevchenko@linux.intel.com, jlee@suse.com, glin@suse.com, matt@codeblueprint.co.uk, andrew.cooper3@citrix.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, toshi.kani@hp.com, linux-acpi@vger.kernel.org, kozerkov@parallels.com, josh@joshtriplett.org, Joerg Roedel <joro@8bytes.org>

On 08/04/16 02:32, Luis R. Rodriguez wrote:
> On Thu, Apr 07, 2016 at 08:55:54AM -0400, Boris Ostrovsky wrote:
>> On 04/06/2016 08:06 PM, Luis R. Rodriguez wrote:
>>> We have 4 types of x86 platforms that disable RTC:
>>>
>>>   * Intel MID
>>>   * Lguest - uses paravirt
>>>   * Xen dom-U - uses paravirt
>>>   * x86 on legacy systems annotated with an ACPI legacy flag
>>>
>>> We can consolidate all of these into a platform specific legacy
>>> quirk set early in boot through i386_start_kernel() and through
>>> x86_64_start_reservations(). This deals with the RTC quirks which
>>> we can rely on through the hardware subarch, the ACPI check can
>>> be dealt with separately.
>>>
>>> v2: split the subarch check from the ACPI check, clarify
>>>     on the ACPI change commit log why ordering works
>>>
>>> Suggested-by: Ingo Molnar <mingo@kernel.org>
>>> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> 
> <-- snip -->
> 
>>> diff --git a/arch/x86/kernel/platform-quirks.c b/arch/x86/kernel/platform-quirks.c
>>> new file mode 100644
>>> index 000000000000..1b114ac5996f
>>> --- /dev/null
>>> +++ b/arch/x86/kernel/platform-quirks.c
>>> @@ -0,0 +1,18 @@
>>> +#include <linux/kernel.h>
>>> +#include <linux/init.h>
>>> +
>>> +#include <asm/setup.h>
>>> +#include <asm/bios_ebda.h>
>>> +
>>> +void __init x86_early_init_platform_quirks(void)
>>> +{
>>> +	x86_platform.legacy.rtc = 1;
>>> +
>>> +	switch (boot_params.hdr.hardware_subarch) {
>>> +	case X86_SUBARCH_XEN:
>>> +	case X86_SUBARCH_LGUEST:
>>> +	case X86_SUBARCH_INTEL_MID:
>>> +		x86_platform.legacy.rtc = 0;
>>> +		break;
>>> +	}
>>> +}
>>
>> What about Xen dom0 (aka initial domain)?
> 
> Indeed, thanks for catching this, the hunk below removes the re-enablement of
> the the RTC for dom0:
> 
>>> --- a/arch/x86/xen/enlighten.c
>>> +++ b/arch/x86/xen/enlighten.c
>>> @@ -1192,7 +1192,6 @@ static const struct pv_info xen_info __initconst = {
>>>  #ifdef CONFIG_X86_64
>>>  	.extra_user_64bit_cs = FLAT_USER_CS64,
>>>  #endif
>>> -	.features = 0,
>>>  	.name = "Xen",
>>>  };
>>> @@ -1525,8 +1524,6 @@ asmlinkage __visible void __init xen_start_kernel(void)
>>>  	/* Install Xen paravirt ops */
>>>  	pv_info = xen_info;
>>> -	if (xen_initial_domain())
>>> -		pv_info.features |= PV_SUPPORTED_RTC;
>>>  	pv_init_ops = xen_init_ops;
>>>  	if (!xen_pvh_domain()) {
>>>  		pv_cpu_ops = xen_cpu_ops;
> 
> This should then break dom0 unless of course you have the respective next
> patch applied and that disabled the RTC due to an ACPI setting on your
> platform. Juergen, can you check to see if that was the case for your
> testing platform on dom0 ?

Are you sure it would break? Wouldn't it just fall back to another
clock source, e.g. hpet?

I looked into my test system: seems as if add_rtc_cmos() is returning
before the .legacy.rtc test.

> This highlights a semantic gap issue. From a quick cursory review, I think
> we can address this temporarily by just using a check:
> 
> void __init x86_early_init_platform_quirks(void)
> {
> 	x86_platform.legacy.rtc = 1;
> 
> 	switch (boot_params.hdr.hardware_subarch) {
> 	case X86_SUBARCH_XEN:
> 	case X86_SUBARCH_LGUEST:
> 	case X86_SUBARCH_INTEL_MID:
> -		x86_platform.legacy.rtc = 0;
> +		if (x86_init.mpparse.get_smp_config != x86_init_uint_noop)
> +			x86_platform.legacy.rtc = 0;

No! Why don't you just use the explicit test xen_initial_domain() ?


Juergen

