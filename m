From: preeti <preeti@linux.vnet.ibm.com>
Subject: Re: Cpuidle drivers,Suspend : Fix suspend/resume hang with intel_idle
 driver
Date: Mon, 02 Jul 2012 15:51:37 +0530
Message-ID: <4FF17631.7010801@linux.vnet.ibm.com>
References: <4FEC20D2.2070501@linux.vnet.ibm.com> <4FED2AF2.4080900@linux.vnet.ibm.com> <201206300007.25255.rjw@sisk.pl> <201206301511.34269.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:47792 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932850Ab2GBKKm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Jul 2012 06:10:42 -0400
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Mon, 2 Jul 2012 10:07:15 +1000
In-Reply-To: <201206301511.34269.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Dave Hansen <dave@linux.vnet.ibm.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, linux-acpi@vger.kernel.org, "Srivatsa.S.Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>

On 06/30/2012 06:41 PM, Rafael J. Wysocki wrote:
> On Saturday, June 30, 2012, Rafael J. Wysocki wrote:
>> On Friday, June 29, 2012, preeti wrote:
>>> On 06/29/2012 12:41 AM, Rafael J. Wysocki wrote:
>>>> On Thursday, June 28, 2012, preeti wrote:
>>>>> On 06/28/2012 03:23 PM, Rafael J. Wysocki wrote:
>>>>>> On Thursday, June 28, 2012, preeti wrote:
>>>>>>>
>>>>>>> From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
>>>> [...]
>>>>> cpuidle is an architecture independent part of the kernel  code.Since 
>>>>> this patch aims at x86 architecture in specific,I considered it
>>>>> inappropriate.
>>>>>
>>>>> In addition to this,suspend happens on x86 only if ACPI is configured.
>>>>
>>>> But that is not required for intel_idle, so if it hangs with intel_idle,
>>>> then it is not dependent on ACPI after all.
>>> True intel_idle does not need ACPI to be configured,but that also means
>>> that the kernel will not provide you the means to suspend.
>>
>> Yes, it will.  You can hibernate without ACPI in theory.
>>
>>> There is no question of resume hang here at all as you cannot suspend in
>>> the first place.
>>>
>>> The issue is when ACPI is configured,and intel_idle is chosen to be the
>>> cpuidle driver.In this situation when the user suspends,cpus can enter
>>> deep sleep states as intel_idle driver does not prevent then from doing so.
>>> This is when resume hangs.
>>
>> I know that.
>>
>>>>> Therefore it seemed right to put the callback in ACPI specific code
>>>>> which deals with ACPI sleep support.
>>>>
>>>> I wonder if we can address this issue correctly.  That is, in a non-racy
>>>> way and in a better place.
>>>>
>>>> First, I really don't think it is necessary to "suspend" cpuidle (be it
>>>> ACPI or any other) when device drivers' suspend routines are being
>>>> executed (which also is racy, because the cpuidle "suspend" may be running
>>>> concurrently with cpuidle on another CPU) or earlier.  We really may want
>>>> to disable the deeper C-states when we're about to execute
>>>> suspend_ops->prepare_late(), or hibernation_ops->prepare(), i.e. after
>>>> we've run dpm_suspend_end() successfully.
>>>
>>> The commit "ACPI:disable lower idle C-states across suspend/resume"
>>> states that device_suspend() calls ACPI suspend functions which cause
>>> side effects on the lower idle C-states.
>>
>> I'd like to know the details, then.  Which ACPI suspend functions those are,
>> in particular, because I'm not aware of any in device_suspend().
>>
>> Also, please note that this commit is 5 years old and some things have changed
>> in the suspend code paths since that time.
>>
>>> This means we need to disable entry into deeper C-states even before
>>> dpm_suspend_start(),
>>
>> This most likely is wrong.
>>
>> We may need to "suspend" cpuidle before calling suspend_device_irqs(),
>> but then again that shouldn't be made via a notifier I think.  Why don't
>> we simply make suspend_device_irqs() disable lower C-states to start with?
>>
>>> but how much before?
>>>
>>> The commit answers this too.It says removing the functionality of
>>> entering deep C-states before suspend removed the side effects.Besides,
>>> the commit title says'across suspend/resume'.So I think to address the
>>> resume hang effectively,it is desirable to disable entry into deeper
>>> C-states during suspend_prepare operations.
>>>>
>>>> So, it seems, it might be a good idea to place a cpuidle driver suspend
>>>> (and/or hibernation) hook at the end of dpm_suspend_end() and make ACPI
>>>> and intel_idle drivers implement that hook.
>>>>
>>> Dont you think this patch is meant to fix a very ACPI specific problem?
>>
>> No, I don't.
>>
>>> Which is why I think the call backs or any hook meant to fix this should
>>> go into ACPI specific code.
>>> Else it will seem irrelevant to all other architectures that implement
>>> suspend.
>>
>> I don't honestly think it is irrelevant.  The fact is that similar problems
>> have not been reported on other architectures _yet_, which by no means can
>> be taken as a proof that those architectures are not affected.
>>
>> Anyway, I think that the right way to address this is through a cpuidle driver
>> callback executed from suspend_device_irqs() (and analogously for the resume
>> code path) and not through some hacky-ugly ACPI changes.
> 
> On a second thought, that may be confusing, so I'd create a cpuidle_suspend()
> routine that would be executed right before suspend_device_irqs() by
> dpm_suspend_noirq().  I'd make that routine run a suspend callback from the
> cpuidle driver (the drivers that don't need to "suspend" would not provide that
> callback).  And analogously for resume.

Why is the cpuidle_suspend() necessary? There are already operations
invoking device callbacks (i.e .suspend,.suspend_late and
.suspend_noirq) at different levels of suspend. We need to now add a few
call backs to the idle drivers depending on when during suspend we wish
to invoke them.

As per the above suggestion,we need to add a .suspend_noirq callback to
both the idle drivers which individually set the local acpi_idle_suspend
variable. Again it depends on how significant a difference it makes in
deciding which level of suspend
(i.e dpm_suspend(),dpm_suspend_late() or dpm_suspend_noirq()) executes
this callback.

If it does not make much of a difference we might as well have the
set/unset of acpi_idle_suspend in .suspend callback, as it is now for
acpi idle driver, in the intel_idle driver as well.

The same holds for resume.
> 
> Thanks,
> Rafael

Regards
Preeti
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


