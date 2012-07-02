From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: Cpuidle drivers,Suspend : Fix suspend/resume hang with intel_idle
 driver
Date: Mon, 02 Jul 2012 11:03:14 +0530
Message-ID: <4FF1329A.7000502@linux.vnet.ibm.com>
References: <4FEC20D2.2070501@linux.vnet.ibm.com> <201206282111.03992.rjw@sisk.pl> <4FED2AF2.4080900@linux.vnet.ibm.com> <201206300007.25255.rjw@sisk.pl> <4FF1336D.10808@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7]:47516 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932066Ab2GBFel (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Jul 2012 01:34:41 -0400
Received: from /spool/local
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Mon, 2 Jul 2012 11:04:31 +0530
In-Reply-To: <4FF1336D.10808@linux.vnet.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: preeti <preeti@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Dave Hansen <dave@linux.vnet.ibm.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, linux-acpi@vger.kernel.org, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>

On 07/02/2012 11:06 AM, preeti wrote:
> On 06/30/2012 03:37 AM, Rafael J. Wysocki wrote:
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
> 
> True.You can suspend to disk without ACPI,but can suspend to RAM only
> with ACPI.
> This also highlights the fact that my patch has not taken care of
> hibernate notifiers,which I should have done.This goes to say that the
> callbacks during suspend better not be in ACPI specific code.I will look
> into correcting the placement of the callbacks.
> 
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
> 
> I agree.My view on this,as I have mentioned in one of my previous mails
> is, in the patch with the acpi_idle_suspend workaround,we have not taken
> precautions to check if there are cpus that have already entered deep
> C-states before the suspend routine has begun.
> 
> We take care of disabling entry into deep C-states only during suspend.
> so if deep C-states are posing problems during suspend,then why dont
> these cpus that have entered idle states before suspend cause a resume hang?
>

Because cpu hotplug kicks the cpu out of any idle state it was in, in order
to execute the CPU_DYING_FROZEN callbacks. (See my other mail about this).
 
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
> I agree with having a cpuidle driver callback as even hibernate
> callbacks need to be taken care of which have nothing to do with ACPI.
> 
> But on what basis is the placement of the call back suggested at
> suspend_device_irqs()? What is the assurance that this placement  will
> not cause a resume hang considering we dont know what precisely is
> causing this problem?
> 

Any place before CPU hotplug should do, I think.

Regards,
Srivatsa S. Bhat

