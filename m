From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] acpi: add support for extended IRQ to PCI link
Date: Thu, 12 Nov 2015 10:04:03 -0500
Message-ID: <5644AA63.2070205@codeaurora.org>
References: <1447308882-29634-1-git-send-email-okaya@codeaurora.org>
 <1447308882-29634-2-git-send-email-okaya@codeaurora.org>
 <CAHp75VfHi=p_QTFr-AG06f=7HSH11bPBVvSSHfEnEHqoEvDG5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51581 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbbKLPEI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2015 10:04:08 -0500
In-Reply-To: <CAHp75VfHi=p_QTFr-AG06f=7HSH11bPBVvSSHfEnEHqoEvDG5w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, cov@codeaurora.org, jcm@redhat.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 11/12/2015 4:56 AM, Andy Shevchenko wrote:
> On Thu, Nov 12, 2015 at 8:14 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> The ACPI compiler uses the extended format when used
>> interrupt numbers are greater than 256. The PCI link code
>> currently only supports simple interrupt format. The IRQ
>> numbers are represented using 32 bits when extended IRQ
>> syntax. This patch changes the interrupt number type to
>> 32 bits and places an upper limit of 1020 as possible
>> interrupt id.
>>
>> 1020 is the maximum interrupt ID that can be assigned to
>> an ARM SPI interrupt according to ARM architecture.
> 
> I think it worth to put these lines in the code as well.
> 

ok

>>
>> Additional checks have been placed to prevent out of bounds
>> writes.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>  drivers/acpi/pci_link.c | 28 +++++++++++++++++-----------
>>  1 file changed, 17 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
>> index 7c8408b..a2becab 100644
>> --- a/drivers/acpi/pci_link.c
>> +++ b/drivers/acpi/pci_link.c
>> @@ -1,6 +1,7 @@
>>  /*
>>   *  pci_link.c - ACPI PCI Interrupt Link Device Driver ($Revision: 34 $)
>>   *
>> + *  Copyright (c) 2015, The Linux Foundation. All rights reserved.
>>   *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
>>   *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
>>   *  Copyright (C) 2002       Dominik Brodowski <devel@brodo.de>
>> @@ -67,12 +68,12 @@ static struct acpi_scan_handler pci_link_handler = {
>>   * later even the link is disable. Instead, we just repick the active irq
>>   */
>>  struct acpi_pci_link_irq {
>> -       u8 active;              /* Current IRQ */
>> +       u32 active;             /* Current IRQ */
>>         u8 triggering;          /* All IRQs */
>>         u8 polarity;            /* All IRQs */
>>         u8 resource_type;
>>         u8 possible_count;
>> -       u8 possible[ACPI_PCI_LINK_MAX_POSSIBLE];
>> +       u32 possible[ACPI_PCI_LINK_MAX_POSSIBLE];
>>         u8 initialized:1;
>>         u8 reserved:7;
>>  };
>> @@ -437,7 +438,7 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
>>   * enabled system.
>>   */
>>
>> -#define ACPI_MAX_IRQS          256
>> +#define ACPI_MAX_IRQS          1020
>>  #define ACPI_MAX_ISA_IRQ       16
>>
>>  #define PIRQ_PENALTY_PCI_AVAILABLE     (0)
>> @@ -493,7 +494,8 @@ int __init acpi_irq_penalty_init(void)
>>                                             penalty;
>>                         }
>>
>> -               } else if (link->irq.active) {
>> +               } else if (link->irq.active &&
>> +                       (link->irq.active < ACPI_MAX_IRQS)) {
>>                         acpi_irq_penalty[link->irq.active] +=
>>                             PIRQ_PENALTY_PCI_POSSIBLE;
>>                 }
>> @@ -541,14 +543,16 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
>>         else
>>                 irq = link->irq.possible[link->irq.possible_count - 1];
>>
>> -       if (acpi_irq_balance || !link->irq.active) {
>> +       if ((acpi_irq_balance || !link->irq.active) && (irq < ACPI_MAX_IRQS)) {
>>                 /*
> 
>> -                * Select the best IRQ.  This is done in reverse to promote
>> -                * the use of IRQs 9, 10, 11, and >15.
>> +                * Select the best IRQ.  This is done in reverse to
>> +                * promote the use of IRQs 9, 10, 11, and >15.
> 
> What was changed here?

See your comments here.
https://lkml.org/lkml/2015/11/8/231

> 
>>                  */
>> -               for (i = (link->irq.possible_count - 1); i >= 0; i--) {
>> -                       if (acpi_irq_penalty[irq] >
>> -                           acpi_irq_penalty[link->irq.possible[i]])
>> +               i = link->irq.possible_count;
>> +               while (--i) {
>> +                       if ((link->irq.possible[i] < ACPI_MAX_IRQS) &&
>> +                           (acpi_irq_penalty[irq] >
>> +                           acpi_irq_penalty[link->irq.possible[i]]))
>>                                 irq = link->irq.possible[i];
>>                 }
>>         }
>> @@ -568,7 +572,9 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
>>                             acpi_device_bid(link->device));
>>                 return -ENODEV;
>>         } else {
>> -               acpi_irq_penalty[link->irq.active] += PIRQ_PENALTY_PCI_USING;
>> +               if (link->irq.active < ACPI_MAX_IRQS)
>> +                       acpi_irq_penalty[link->irq.active] +=
>> +                               PIRQ_PENALTY_PCI_USING;
>>                 printk(KERN_WARNING PREFIX "%s [%s] enabled at IRQ %d\n",
>>                        acpi_device_name(link->device),
>>                        acpi_device_bid(link->device), link->irq.active);
> 
> 


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
