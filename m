From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V8] ACPI, PCI, irq: support IRQ numbers greater than 256
Date: Wed, 9 Dec 2015 10:34:52 -0500
Message-ID: <56684A1C.2010301@codeaurora.org>
References: <1449169135-28448-1-git-send-email-okaya@codeaurora.org>
 <20151208201516.GA31930@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:46002 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbbLIPe4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2015 10:34:56 -0500
In-Reply-To: <20151208201516.GA31930@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org

On 12/8/2015 3:15 PM, Bjorn Helgaas wrote:
> On Thu, Dec 03, 2015 at 01:58:55PM -0500, Sinan Kaya wrote:
>> The ACPI compiler uses the extended format when used interrupt numbers
>> are greater than 15. The extended IRQ is 32 bits according to the ACPI
>> spec. The code supports parsing the extended interrupt numbers. However,
>> due to used data structure type; the code silently truncates interrupt
>> numbers greater than 256.
>>
>> First, this patch changes the interrupt number type to 32 bits. Next, the
>> penalty array has been limited to 16 for ISA IRQs. Finally, a new penalty
>> linklist has been added for all other interrupts greater than 16. If an IRQ
>> is not found in the link list, an IRQ info structure will be dynamically
>> allocated on the first access and will be placed on the list for further
>> reuse. The list will grow by the number of supported interrupts in the
>> ACPI table rather than having a 256 hard limitation.
> 
> Can you split this into two patches?  One to replace the penalty
> storage scheme, and a second to change the interrupt number types
> from u8 to u32?

I'll post a patch soon

> 
> Generally looks good to me.  Tracking all the penalty information
> still seems clunky, but I don't have any great ideas of better ways.
> I have a few minor comments below; when you address them, you can add
> my:
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

thanks

> 
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>  drivers/acpi/pci_link.c | 134 +++++++++++++++++++++++++++++++++++++-----------
>>  1 file changed, 104 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
>> index 7c8408b..e10661f 100644
>> --- a/drivers/acpi/pci_link.c
>> +++ b/drivers/acpi/pci_link.c
>> @@ -4,6 +4,7 @@
>>   *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
>>   *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
>>   *  Copyright (C) 2002       Dominik Brodowski <devel@brodo.de>
>> + *  Copyright (c) 2015, The Linux Foundation. All rights reserved.
>>   *
>>   * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   *
>> @@ -67,12 +68,12 @@ static struct acpi_scan_handler pci_link_handler = {
>>   * later even the link is disable. Instead, we just repick the active irq
>>   */
>>  struct acpi_pci_link_irq {
>> -	u8 active;		/* Current IRQ */
>> +	u32 active;		/* Current IRQ */
>>  	u8 triggering;		/* All IRQs */
>>  	u8 polarity;		/* All IRQs */
>>  	u8 resource_type;
>>  	u8 possible_count;
>> -	u8 possible[ACPI_PCI_LINK_MAX_POSSIBLE];
>> +	u32 possible[ACPI_PCI_LINK_MAX_POSSIBLE];
>>  	u8 initialized:1;
>>  	u8 reserved:7;
>>  };
>> @@ -437,8 +438,7 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
>>   * enabled system.
>>   */
>>  
>> -#define ACPI_MAX_IRQS		256
>> -#define ACPI_MAX_ISA_IRQ	16
>> + #define ACPI_MAX_ISA_IRQ	16
> 
> Extra leading space here.

Done.

> 
>>  #define PIRQ_PENALTY_PCI_AVAILABLE	(0)
>>  #define PIRQ_PENALTY_PCI_POSSIBLE	(16*16)
>> @@ -447,7 +447,7 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
>>  #define PIRQ_PENALTY_ISA_USED		(16*16*16*16*16)
>>  #define PIRQ_PENALTY_ISA_ALWAYS		(16*16*16*16*16*16)
>>  
>> -static int acpi_irq_penalty[ACPI_MAX_IRQS] = {
>> +static int acpi_irq_isa_penalty[ACPI_MAX_ISA_IRQ] = {
>>  	PIRQ_PENALTY_ISA_ALWAYS,	/* IRQ0 timer */
>>  	PIRQ_PENALTY_ISA_ALWAYS,	/* IRQ1 keyboard */
>>  	PIRQ_PENALTY_ISA_ALWAYS,	/* IRQ2 cascade */
>> @@ -464,9 +464,61 @@ static int acpi_irq_penalty[ACPI_MAX_IRQS] = {
>>  	PIRQ_PENALTY_ISA_USED,		/* IRQ13 fpe, sometimes */
>>  	PIRQ_PENALTY_ISA_USED,		/* IRQ14 ide0 */
>>  	PIRQ_PENALTY_ISA_USED,		/* IRQ15 ide1 */
>> -	/* >IRQ15 */
>>  };
>>  
>> +struct irq_penalty_info {
>> +	unsigned int irq;
>> +	int penalty;
>> +	struct list_head node;
>> +};
>> +
>> +LIST_HEAD(acpi_irq_penalty_list);
> 
> Should be static.

OK

> 
>> +static int acpi_irq_get_penalty(int irq)
>> +{
>> +	struct irq_penalty_info *irq_info;
>> +
>> +	if (irq < ACPI_MAX_ISA_IRQ)
>> +		return acpi_irq_isa_penalty[irq];
>> +
>> +	list_for_each_entry(irq_info, &acpi_irq_penalty_list, node) {
>> +		if (irq_info->irq == irq)
>> +			return irq_info->penalty;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int acpi_irq_set_penalty(int irq, unsigned int new_penalty)
> 
> "int new_penalty" to match irq_info->penalty and acpi_irq_get_penalty()
> return type.

Done

> 
>> +{
>> +	struct irq_penalty_info *irq_info;
>> +
>> +	/* see if this is a ISA IRQ */
>> +	if (irq < ACPI_MAX_ISA_IRQ) {
>> +		acpi_irq_isa_penalty[irq] = new_penalty;
>> +		return 0;
>> +	}
>> +
>> +	/* next, try to locate from the dynamic list */
>> +	list_for_each_entry(irq_info, &acpi_irq_penalty_list, node) {
>> +		if (irq_info->irq == irq) {
>> +			irq_info->penalty  = new_penalty;
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	/* nope, let's allocate a slot for this IRQ */
>> +	irq_info = kzalloc(sizeof(*irq_info), GFP_KERNEL);
>> +	if (!irq_info)
>> +		return -ENOMEM;
>> +
>> +	irq_info->irq = irq;
>> +	irq_info->penalty = new_penalty;
>> +	list_add_tail(&irq_info->node, &acpi_irq_penalty_list);
>> +
>> +	return 0;
>> +}
> 
> An "acpi_irq_add_penalty(int irq, int penalty)" here would simplify
> most of the calls below:
> 
>   static void acpi_irq_add_penalty(int irq, int penalty)
>   {
>     int current = acpi_irq_get_penalty(irq);
> 
>     acpi_irq_set_penalty(irq, current + penalty);
>   }
> 

Good idea.

>> +
>>  int __init acpi_irq_penalty_init(void)
>>  {
>>  	struct acpi_pci_link *link;
>> @@ -487,15 +539,22 @@ int __init acpi_irq_penalty_init(void)
>>  			    link->irq.possible_count;
>>  
>>  			for (i = 0; i < link->irq.possible_count; i++) {
>> -				if (link->irq.possible[i] < ACPI_MAX_ISA_IRQ)
>> -					acpi_irq_penalty[link->irq.
>> -							 possible[i]] +=
>> -					    penalty;
>> +				if (link->irq.possible[i] < ACPI_MAX_ISA_IRQ) {
>> +					int irqpos = link->irq.possible[i];
>> +					int curpen;
>> +
>> +					curpen = acpi_irq_get_penalty(irqpos);
>> +					curpen += penalty;
>> +					acpi_irq_set_penalty(irqpos, curpen);
> 
> 	acpi_irq_add_penalty(link->irq.possible[i], penalty);
> 
>> +				}
>>  			}
>>  
>>  		} else if (link->irq.active) {
> 
> You didn't change this, but the "else" here looks wrong to me: if we
> got any IRQs from _PRS, we never add PIRQ_PENALTY_PCI_POSSIBLE to the
> active IRQ.
> 
> It also seems wrong that we loop through everything on acpi_link_list.
> It would be better if we could do this for each link as it is
> enumerated in acpi_pci_link_add(), so any hot-added links would be
> handled the same way.
> 
> These are both pre-existing issues/questions, so I don't think you're
> obligated to address them.

I'll leave them alone for now.

> 
>> -			acpi_irq_penalty[link->irq.active] +=
>> -			    PIRQ_PENALTY_PCI_POSSIBLE;
>> +			int curpen;
>> +
>> +			curpen = acpi_irq_get_penalty(link->irq.active);
>> +			curpen += PIRQ_PENALTY_PCI_POSSIBLE;
>> +			acpi_irq_set_penalty(link->irq.active, curpen);
>>  		}
>>  	}
>>  
>> @@ -547,12 +606,12 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
>>  		 * the use of IRQs 9, 10, 11, and >15.
>>  		 */
>>  		for (i = (link->irq.possible_count - 1); i >= 0; i--) {
>> -			if (acpi_irq_penalty[irq] >
>> -			    acpi_irq_penalty[link->irq.possible[i]])
>> +			if (acpi_irq_get_penalty(irq) >
>> +			    acpi_irq_get_penalty(link->irq.possible[i]))
>>  				irq = link->irq.possible[i];
>>  		}
>>  	}
>> -	if (acpi_irq_penalty[irq] >= PIRQ_PENALTY_ISA_ALWAYS) {
>> +	if (acpi_irq_get_penalty(irq) >= PIRQ_PENALTY_ISA_ALWAYS) {
>>  		printk(KERN_ERR PREFIX "No IRQ available for %s [%s]. "
>>  			    "Try pci=noacpi or acpi=off\n",
>>  			    acpi_device_name(link->device),
>> @@ -568,7 +627,12 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
>>  			    acpi_device_bid(link->device));
>>  		return -ENODEV;
>>  	} else {
>> -		acpi_irq_penalty[link->irq.active] += PIRQ_PENALTY_PCI_USING;
>> +		int curpen;
>> +
>> +		curpen = acpi_irq_get_penalty(link->irq.active);
>> +		curpen += PIRQ_PENALTY_PCI_USING;
>> +		acpi_irq_set_penalty(link->irq.active, curpen);
>> +
>>  		printk(KERN_WARNING PREFIX "%s [%s] enabled at IRQ %d\n",
>>  		       acpi_device_name(link->device),
>>  		       acpi_device_bid(link->device), link->irq.active);
>> @@ -778,7 +842,7 @@ static void acpi_pci_link_remove(struct acpi_device *device)
>>  }
>>  
>>  /*
>> - * modify acpi_irq_penalty[] from cmdline
>> + * modify penalty from cmdline
>>   */
>>  static int __init acpi_irq_penalty_update(char *str, int used)
>>  {
>> @@ -796,13 +860,15 @@ static int __init acpi_irq_penalty_update(char *str, int used)
>>  		if (irq < 0)
>>  			continue;
>>  
>> -		if (irq >= ARRAY_SIZE(acpi_irq_penalty))
>> -			continue;
>> +		if (used) {
>> +			int curpen;
>>  
>> -		if (used)
>> -			acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_USED;
>> +			curpen = acpi_irq_get_penalty(irq);
>> +			curpen += PIRQ_PENALTY_ISA_USED;
>> +			acpi_irq_set_penalty(irq, curpen);
>> +		}
>>  		else
>> -			acpi_irq_penalty[irq] = PIRQ_PENALTY_PCI_AVAILABLE;
>> +			acpi_irq_set_penalty(irq, PIRQ_PENALTY_PCI_AVAILABLE);
>>  
>>  		if (retval != 2)	/* no next number */
>>  			break;
>> @@ -819,18 +885,22 @@ static int __init acpi_irq_penalty_update(char *str, int used)
>>   */
>>  void acpi_penalize_isa_irq(int irq, int active)
>>  {
>> -	if (irq >= 0 && irq < ARRAY_SIZE(acpi_irq_penalty)) {
>> +	if (irq >= 0) {
> 
> I would structure this as:
> 
>   if (irq < 0)
>     return;
> 
>   if (active)
>     acpi_irq_add_penalty(irq, PIRQ_PENALTY_ISA_USED);
>   else
>     acpi_irq_add_penalty(irq, PIRQ_PENALTY_PCI_USING);
> 
> But that might be just my personal preference.  Similarly in
> acpi_penalize_sci_irq() below.

OK, cleaner.

> 
>> +		int curpen;
>> +
>> +		curpen = acpi_irq_get_penalty(irq);
>>  		if (active)
>> -			acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_USED;
>> +			curpen += PIRQ_PENALTY_ISA_USED;
>>  		else
>> -			acpi_irq_penalty[irq] += PIRQ_PENALTY_PCI_USING;
>> +			curpen += PIRQ_PENALTY_PCI_USING;
>> +		acpi_irq_set_penalty(irq, curpen);
>>  	}
>>  }
>>  
>>  bool acpi_isa_irq_available(int irq)
>>  {
>> -	return irq >= 0 && (irq >= ARRAY_SIZE(acpi_irq_penalty) ||
>> -			    acpi_irq_penalty[irq] < PIRQ_PENALTY_ISA_ALWAYS);
>> +	return irq >= 0 &&
>> +		(acpi_irq_get_penalty(irq) < PIRQ_PENALTY_ISA_ALWAYS);
>>  }
>>  
>>  /*
>> @@ -840,12 +910,16 @@ bool acpi_isa_irq_available(int irq)
>>   */
>>  void acpi_penalize_sci_irq(int irq, int trigger, int polarity)
>>  {
>> -	if (irq >= 0 && irq < ARRAY_SIZE(acpi_irq_penalty)) {
>> +	if (irq >= 0) {
>> +		int curpen;
>> +
>> +		curpen = acpi_irq_get_penalty(irq);
>>  		if (trigger != ACPI_MADT_TRIGGER_LEVEL ||
>>  		    polarity != ACPI_MADT_POLARITY_ACTIVE_LOW)
>> -			acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_ALWAYS;
>> +			curpen += PIRQ_PENALTY_ISA_ALWAYS;
>>  		else
>> -			acpi_irq_penalty[irq] += PIRQ_PENALTY_PCI_USING;
>> +			curpen += PIRQ_PENALTY_PCI_USING;
>> +		acpi_irq_set_penalty(irq, curpen);
>>  	}
>>  }
>>  
>> -- 
>> Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
