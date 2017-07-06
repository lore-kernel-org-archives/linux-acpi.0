From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: lpss_iosf_enter_d3_state breaks PWM on Baytrail
Date: Thu, 6 Jul 2017 21:14:17 +0200
Message-ID: <d0a9c3d6-d989-f3ff-0b3f-78fb7e11b67c@redhat.com>
References: <f28e3a7a-1ea7-5f2d-4cfa-ab2cb85bdb45@redhat.com>
 <1498570163.22624.188.camel@linux.intel.com>
 <3da5964a-d80b-d622-0217-c8c415cfe70f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751874AbdGFTOV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 6 Jul 2017 15:14:21 -0400
In-Reply-To: <3da5964a-d80b-d622-0217-c8c415cfe70f@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Mikkola, Jarkko" <jarkko.mikkola@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

Hi,

On 27-06-17 15:54, Hans de Goede wrote:
> Hi,
> 
> On 06/27/2017 03:29 PM, Andy Shevchenko wrote:
>> On Mon, 2017-06-26 at 11:31 +0200, Hans de Goede wrote:
>>> Hi Andy, et al.,
>>>
>>> I've spend quite some time this weekend debugging an issue
>>> an a Bay Trail laptop with a Crystal Cove PMIC which uses
>>> the LPSS PWM for backlight control rather then the PMIC's
>>> PWM.
>>>
>>> The problem is lpss_iosf_enter_d3_state. Specifically when
>>> called when the PWM runtime-suspends during i915 driver load,
>>> during which the i915 driver disables then re-enables the PWM.
>>>
>>> This is the only time (including normal suspend(to-idle)
>>> and resume) when this check:
>>>
>>>           pmc_status = (~(d3_sts_0 | func_dis)) & pmc_mask;
>>>           if (pmc_status)
>>>                   goto exit;
>>>
>>> Does not hit the goto exit path
>>
>> ...meaning all LPSS devices (except maybe DMA) are in D3hot.
> 
> Correct AFAICT.
>>>   and lpss_iosf_enter_d3_state
>>> actually executes these 3 statements:
>>>
>>>           iosf_mbi_modify(LPSS_IOSF_UNIT_LPIO1, MBI_CFG_WRITE,
>>>                           LPSS_IOSF_PMCSR, value2, mask2);
>>>
>>>           iosf_mbi_modify(LPSS_IOSF_UNIT_LPIO2, MBI_CFG_WRITE,
>>>                           LPSS_IOSF_PMCSR, value2, mask2);
>>>
>>>           iosf_mbi_modify(LPSS_IOSF_UNIT_LPIOEP, MBI_CR_WRITE,
>>>                           LPSS_IOSF_GPIODEF0, value1, mask1);
>>>
>>> If I comment out these 3 statements then everything works fine,
>>> with these 3 statements in place though, then the PWM controller
>>> gets stuck when the i915 driver tries to re-enable it (and it
>>> runtime-resumes). After these 3 statements have been run once
>>> then any subsequent reads from the PWM's control register
>>> always return 0x00010000 and writes seem to be ignored.
>>
>> Sounds like powered off LPSS power island.
> 
> Right, but this is after runtime resume and after lpss_iosf_exit_d3_state
> has been called, I've added debug printk calls to verify that
> lpss_iosf_exit_d3_state is called for the register reads which
> only return 0x00010000
> 
>>
>>> Given the past troubles with the LPSS DMA controller suspend,
>>> see all the links in this commit message (which introduces
>>> the current fix) :
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com
>>> mit/?id=eebb3e8d8aaf2
>>>
>>> I'm tempted to just rip out lpss_iosf_enter_d3_state,
>>> especially since it does not seem to do anything other
>>> then during early boot when not all drivers are loaded yet.
>>
>> Interesting...
>>
>> You are telling that there is guaranteed that at least one LPSS device
>> (except DMA) will be on at any time?
> 
> In my testing, yes that seems to be the case, a pr_err in
> lpss_iosf_enter_d3_state after the if (...) goto ... only
> triggers once during i915 driver load and never again. Not
> even if I switch to a text console, then blank the
> screen and wait a while.
> 
> Note that the enter / exit d3 state calls are only done on
> runtime suspend / resume, so this also does not trigger on
> normal suspend / resume.
> 
>>> Note that on Bay Trail devices with an AXP288 PMIC (most new
>>> Bay Trail devices) and on any Cherry Trail device the LPSS I2C
>>> controller connected to the PMIC will never suspend because
>>> some DSTDs make ACPI OpRegion calls during late suspend /
>>> early resume and as such we need to keep the I2C bus alive
>>> the whole time. This means that the check in
>>> lpss_iosf_enter_d3_state will always hit the goto exit path
>>> on these devices,
>>
>> Looks like an answer to the previous question.
> 
> Right, except for Bay Trail devices with Crystal Cove PMIC,
> there the I2C controller for the PMIC is not kept alive
> (which we may need to change if we ever find late_suspend /
> early_resume PMIC OpRegion use on these devices, but sofar
> they don't seem to do this)
> 
>>>   leaving just (older) Bay Trail + non AXP288
>>> PMIC devices as potentially hitting the code path where
>>> lpss_iosf_enter_d3_state actually does something and these are
>>> exactly the devices with which people are having a lot of
>>> problems with freezes / hangs.
>>>
>>> So I believe that the best approach would be to simply remove
>>> lpss_iosf_enter_d3_state. Which leaves me wondering what it
>>> actually does. It would be nice for the future if undocumented
>>> (not publicly documented) registers are used that some comments
>>> are added describing what each register write actually does.
>>
>> Do the commit messages describe this enough along with several comments
>> inside acpi_lpss.c?
> 
> Nope, they give a hint what is going on, but don't make it
> really clear what the individual register writes do, hence
> my questions in this email.
> 
>>> These seem to simply put the DMA controller into D3:
>>>
>>>           u32 value2 = LPSS_PMCSR_D3hot;
>>>           u32 mask2 = LPSS_PMCSR_Dx_MASK;
>>>
>>>           iosf_mbi_modify(LPSS_IOSF_UNIT_LPIO1, MBI_CFG_WRITE,
>>>                           LPSS_IOSF_PMCSR, value2, mask2);
>>>
>>>           iosf_mbi_modify(LPSS_IOSF_UNIT_LPIO2, MBI_CFG_WRITE,
>>>                           LPSS_IOSF_PMCSR, value2, mask2);
>>
>> It overrides the lines which propagate clock and reset signals to the
>> entire LPSS islands.
> 
> Overrides sounds weird if we set it to D0 / D3, I would expect there
> to be 1 bit to say "override auto pm stuff" and another bit or bits
> to select the value we are forcing when the override is active.
> 
>> DMA just happened to be a function 0 (in terms of PCI), so, if it is off
>> the rest of the functions can not be on.
> 
> Ok.
> 
>>> But what does this one do?   :
>>>
>>>           u32 value1 = 0;
>>>           u32 mask1 = LPSS_GPIODEF0_DMA_D3_MASK |
>>
>>> LPSS_GPIODEF0_DMA_LLP;
>>
>> (this one is a chicken bit to enable hardware linked list transfers on
>> DMA)
> 
> Yes I noticed that was added in a separate commit. If we are
> just setting that to enable a feature then why are not doing that
> once on probe. That would seem more logical then toggling it
> on / off with the power-state.
> 
>>
>>>
>>>           iosf_mbi_modify(LPSS_IOSF_UNIT_LPIOEP, MBI_CR_WRITE,
>>>                           LPSS_IOSF_GPIODEF0, value1, mask1);
>>>
>>> I guess this turns on(?) the automatically down powering of the
>>> DMA controllers ? If so then why not just do only that ?
>>
>> No, automatic power gating is a *hardware* (PMC firmware? I do not
>> remember details now) feature which is overridden by the code above.
> 
> Then wat do the LPSS_GPIODEF0_DMA_D3_MASK bits do ?

So any news on this? Any ideas how to fix this with a smaller hammer ?

Regards,

Hans
