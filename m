From: agustinv@codeaurora.org
Subject: Re: [PATCH V6 2/3] ACPI: Add support for ResourceSource/IRQ domain
 mapping
Date: Fri, 11 Nov 2016 22:01:03 -0500
Message-ID: <713f102418c0fffacf67acb16dbdeec2@codeaurora.org>
References: <1477687696-1509-1-git-send-email-agustinv@codeaurora.org>
 <1477687696-1509-3-git-send-email-agustinv@codeaurora.org>
 <42ff0a81-7836-11f6-58e0-979bd1d0be20@linaro.org>
 <60c1d53146c0aebd3a05095823229224@codeaurora.org>
 <20161110175814.GA12446@red-moon> <5825C8A2.3040302@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42668 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934854AbcKLDBF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Nov 2016 22:01:05 -0500
In-Reply-To: <5825C8A2.3040302@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net, lenb@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, timur@codeaurora.org, cov@codeaurora.org, agross@codeaurora.org, harba@codeaurora.org, jcm@redhat.com, msalter@redhat.com, mlangsdo@redhat.com, ahs3@redhat.com, astone@redhat.com, graeme.gregory@linaro.org, guohanjun@huawei.com, charles.garcia-tobin@arm.com, Gabriele Paoloni <gabriele.paoloni@huawei.com>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>

Hey Lorenzo, Hanjun,

On 2016-11-11 08:33, Hanjun Guo wrote:
> Hi Lorenzo,
> 
> On 11/11/2016 01:58 AM, Lorenzo Pieralisi wrote:
>> On Thu, Nov 10, 2016 at 10:02:35AM -0500, agustinv@codeaurora.org 
>> wrote:
>>> Hey Hanjun,
>>> 
>>> On 2016-11-09 21:36, Hanjun Guo wrote:
>>>> Hi Marc, Rafael, Lorenzo,
>>>> 
>>>> Since we agreed to add a probe deferral if we failed to get irq
>>>> resources which mirroring the DT does (patch 1 in this patch set),
>>>> I think the last blocker to make things work both for Agustin and
>>>> me [1] is this patch, which makes the interrupt producer and 
>>>> consumer
>>>> work in ACPI, we have two different solution for one thing, we'd 
>>>> happy
>>>> to work together for one solution, could you give some suggestions
>>>> please?
>>>> 
>>>> [1]: 
>>>> https://mail-archive.com/linux-kernel@vger.kernel.org/msg1257419.html
>>>> 
>>>> Agustin, I have some comments below.
>>>> 
>>>> On 2016/10/29 4:48, Agustin Vega-Frias wrote:
>>>>> This allows irqchip drivers to associate an ACPI DSDT device to
>>>>> an IRQ domain and provides support for using the ResourceSource
>>>>> in Extended IRQ Resources to find the domain and map the IRQs
>>>>> specified on that domain.
>>>>> 
>>>>> Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
>>>>> ---
>>>>> drivers/acpi/Makefile    |   1 +
>>>>> drivers/acpi/irqdomain.c | 119
>>>>> +++++++++++++++++++++++++++++++++++++++++++++++
>>>> 
>>>> Could we just reuse the gsi.c and not introduce a new
>>>> file, probably we can change the gsi.c to irqdomain.c
>>>> or something similar, then reuse the code in gsi.c.
>>> 
>>> I was thinking just that after we chatted off-list.
>> 
>> Yes, that's a fair point.
>> 
>>> I might revisit and see what I come up with given that we already 
>>> have
>>> a device argument and we could pass the IRQ source there.
>> 
>> I agree with the approach taken by this patch, I do not like much
>> passing around struct acpi_resource_source *source (in particular
>> the dummy struct) I do not think it is needed, I will comment on
>> the code.
> 
> thanks for your time to have a look:)
> 
>> 
>> Hopefully there is not any buggy FW out there that does use the
>> resource source inappropriately otherwise we will notice on x86/ia64
>> (ie you can't blame FW if it breaks the kernel) but I suspect the
>> only way to find out is by trying, the patch has to go through 
>> Rafael's
>> review anyway before getting there so it is fine.
> 
> I think we can avoid that by not touching the logic that x86/ia64
> already used, but only adding interrupt producer/consumer function.

I looked at this more today and implemented a new patch that I plan to
test over the weekend, but I wanted to let you know the approach I am
pursuing.

On the new patch use of ResourceSource when parsing ACPI Extended IRQ
Resources is conditional on CONFIG_ACPI_GENERIC_GSI. The reason for this
is two fold:

1. Since we wanted to reduce duplication and place the new APIs on the
    same source file as acpi_register_gsi, which is already under that
    config flag.
2. So the patch does not have effect on platforms not using the generic
    GSI support, including x86/ia64.

If support for this is needed outside platforms using the generic GSI
implementation, we can move these APIs out to their own source file
and eliminate the CONFIG_ACPI_GENERIC_GSI conditionality.

I'll send the new patch, hopefully some time tomorrow, but please let
me know if you have concerns with this approach.

Thanks,
Agustin

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux Foundation Collaborative Project.
