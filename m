From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V9 1/2] ACPI, PCI, irq: remove interrupt count restriction
Date: Wed, 30 Dec 2015 08:23:31 -0500
Message-ID: <5683DAD3.4080006@codeaurora.org>
References: <1449677909-12432-1-git-send-email-okaya@codeaurora.org>
 <1449677909-12432-2-git-send-email-okaya@codeaurora.org>
 <CAHp75VeW7wizf_FUc=O5+PEdfibYRL1G7gqpdDxUALwXJsnBAA@mail.gmail.com>
 <56686037.70109@codeaurora.org> <56686171.5060102@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:35018 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022AbbL3NXS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2015 08:23:18 -0500
In-Reply-To: <56686171.5060102@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christopher Covington <cov@codeaurora.org>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, jcm@redhat.com, helgaas@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Bjorn, Andy;

On 12/9/2015 12:14 PM, Christopher Covington wrote:
> Hi Sinan,
> 
> On 12/09/2015 12:09 PM, Sinan Kaya wrote:
>> On 12/9/2015 11:59 AM, Andy Shevchenko wrote:
>>>> +       if (trigger != ACPI_MADT_TRIGGER_LEVEL ||
>>>>> +           polarity != ACPI_MADT_POLARITY_ACTIVE_LOW)
>>>>> +               penalty = PIRQ_PENALTY_ISA_ALWAYS;
>>>>> +       else
>>>>> +               penalty = PIRQ_PENALTY_PCI_USING;
>>>>> +
>>>>> +       acpi_irq_add_penalty(irq, penalty);
>>> Why not to change in place? I think a common sense rule is not to
>>> change something existing if it doesn't add any significant value.
>>>
>> Sorry, I didn't understand what you mean. Are you asking why we are
>> changing lines like above?
>>
>> If yes, acpi_irq_penalty used to be an array of 256 entries. Now,
>> acpi_irq_penalty doesn't exist anymore as it was replaced with a linklist.
>>
>>> -               acpi_irq_penalty[irq] += PIRQ_PENALTY_PCI_USING;
>>> +              acpi_irq_add_penalty(irq, PIRQ_PENALTY_PCI_USING);
> 
> I think Andy was suggesting that you make the change without introducing
> the penalty variable.
> 
> Christopher Covington
> 

Andy,
Is Chris' interpretation correct?

BTW, I suggest you spend some time around checkpatch for contributions. I could
have caught most of the issues you are generally concerned before submitting a patch.

Bjorn,
Is there any other question you need me to address on this patch? 


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
