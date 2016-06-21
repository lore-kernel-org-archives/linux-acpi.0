From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: kernel-4.7 bug in Intel sound and/or ACPI
Date: Tue, 21 Jun 2016 09:40:10 -0400
Message-ID: <576943BA.1000001@codeaurora.org>
References: <20160620003530.GA19571@djo.tudelft.nl>
 <2999417.fp4mqtxYS2@vostro.rjw.lan> <20160620212507.GA24086@localhost>
 <57686D67.8010201@codeaurora.org> <20160621124715.GB3528@djo.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33300 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbcFUNkP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Jun 2016 09:40:15 -0400
In-Reply-To: <20160621124715.GB3528@djo.tudelft.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: wim@djo.tudelft.nl
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, perex@perex.cz, linux-pci@vger.kernel.org, Takashi Iwai <tiwai@suse.com>

On 6/21/2016 8:47 AM, Wim Osterholt wrote:
>> Can you try the following and see if it makes any difference?
>>
>>
>> --- a/drivers/acpi/pci_link.c
>> +++ b/drivers/acpi/pci_link.c
>> @@ -500,7 +500,7 @@ static int acpi_irq_get_penalty(int irq)
>>         int penalty = 0;
>>
>>         if (irq < ACPI_MAX_ISA_IRQS)
>> -               penalty += acpi_isa_irq_penalty[irq];
>> +               return acpi_isa_irq_penalty[irq];
>>
>>         /*
>>         * Penalize IRQ used by ACPI SCI. If ACPI SCI pin attributes conflict
>> @@ -586,6 +586,10 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
>>                             acpi_device_bid(link->device));
>>                 return -ENODEV;
>>         } else {
>> +               if (irq < ACPI_MAX_ISA_IRQS)
>> +                       acpi_isa_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
>> +                                                       PIRQ_PENALTY_PCI_USING;
>> +
>>
>>
>>
>>> Bjorn
> 
> 
> I tried this on kernel 4.7.0-rc4, but that didn't help. It still tried to
> grab irq7.
> 
> 

Thanks, It was a guess with no proof.

Let's undo the change above and start adding some print statements to collect
data from your system.

Can you add this to the end of acpi_irq_get_penalty function and then send
the output?

	pr_info("%s:%d irq = %d penalty = %d\n", __func__, __LINE__, irq,
		penalty);
 


> Regards, Wim.
> 
> 
> ----- wim@djo.tudelft.nl -----
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
