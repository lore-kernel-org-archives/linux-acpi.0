From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 2/2] arch_timer: acpi: add hisi timer erratum data
Date: Tue, 24 Jan 2017 21:22:41 +0800
Message-ID: <58875521.2000002@linaro.org>
References: <1485254391-51551-1-git-send-email-guohanjun@huawei.com> <1485254391-51551-3-git-send-email-guohanjun@huawei.com> <20170124105717.GB6277@leverpostej> <a2ac2a70-09fb-5cec-c090-b8ebde90e24f@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33327 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbdAXNXA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jan 2017 08:23:00 -0500
Received: by mail-pg0-f44.google.com with SMTP id 204so55255299pge.0
        for <linux-acpi@vger.kernel.org>; Tue, 24 Jan 2017 05:22:59 -0800 (PST)
In-Reply-To: <a2ac2a70-09fb-5cec-c090-b8ebde90e24f@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Hanjun Guo <guohanjun@huawei.com>
Cc: Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Fu Wei <fu.wei@linaro.org>, Ding Tianhong <dingtianhong@huawei.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com

On 01/24/2017 07:32 PM, Marc Zyngier wrote:
> On 24/01/17 10:57, Mark Rutland wrote:
>> On Tue, Jan 24, 2017 at 06:39:51PM +0800, Hanjun Guo wrote:
>>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>>
>>> Add hisilicon timer specific erratum fixes.
>>>
>>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>>> ---
>>>   drivers/clocksource/arm_arch_timer.c | 22 ++++++++++++++++++++++
>>>   1 file changed, 22 insertions(+)
>>>
>>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>>> index 80d6f76..3e62a09 100644
>>> --- a/drivers/clocksource/arm_arch_timer.c
>>> +++ b/drivers/clocksource/arm_arch_timer.c
>>> @@ -1156,10 +1156,32 @@ struct gtdt_arch_timer_fixup {
>>>   	void *context;
>>>   };
>>>
>>> +#ifdef CONFIG_HISILICON_ERRATUM_161010101
>>> +static void __init hisi_erratum_workaroud_enable(void *context)
>>> +{
>>> +	int i;
>>> +
>>> +	for (i = 0; i < ARRAY_SIZE(ool_workarounds); i++) {
>>> +		if (!strcmp(context, ool_workarounds[i].id)) {
>>> +			timer_unstable_counter_workaround = &ool_workarounds[i];
>>> +			static_branch_enable(&arch_timer_read_ool_enabled);
>>> +			pr_info("arch_timer: Enabling workaround for %s\n",
>>> +				timer_unstable_counter_workaround->id);
>>> +			break;
>>> +		}
>>> +	}
>>> +}
>>> +#endif
>>> +
>>>   /* note: this needs to be updated according to the doc of OEM ID
>>>    * and TABLE ID for different board.
>>>    */
>>>   static struct gtdt_arch_timer_fixup arch_timer_quirks[] __initdata = {
>>> +#ifdef CONFIG_HISILICON_ERRATUM_161010101
>>> +	{"HISI  ", "HIP05   ", 0, &hisi_erratum_workaroud_enable, "hisilicon,erratum-161010101"},
>>> +	{"HISI  ", "HIP06   ", 0, &hisi_erratum_workaroud_enable, "hisilicon,erratum-161010101"},
>>> +	{"HISI  ", "HIP07   ", 0, &hisi_erratum_workaroud_enable, "hisilicon,erratum-161010101"},
>>> +#endif
>>>   };
>>
>> NAK. This duplicates logic unnecessarily (for enabling the workaround),
>> and (ab)uses the id, which was intended to be specific to DT (since it
>> is a DT property name).
>
> Agreed, that's properly revolting.

I had a bad feeling about duplicating using of DT based ID string
in ACPI world and it's confirmed :)

>
>> We should split the matching from the particular workaround (and
>> enabling thereof), so that we can go straight from ACPI match to
>> workaround (without having to use the DT id in this manner), and don't
>> have to duplicate the logic to enable the workaround.
>>
>> I believe Marc is looking at some rework in this area which may enable
>> this, so please wait for that to appear.
>
> Yeah, I'm implementing a semi-flexible way to add new quirk types, and
> the last thing I want to see is two (or more) tables describing the same
> thing.

Thank you for doing this, I will wait for your patches.

Hanjun
