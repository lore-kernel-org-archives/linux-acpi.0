From: Al Stone <al.stone@linaro.org>
Subject: Re: [PATCH 04/12] ACPI: HW reduced mode does not allow use of the
 FADT sci_interrupt field
Date: Thu, 21 Nov 2013 12:36:35 -0700
Message-ID: <528E60C3.7080706@linaro.org>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org> <6357288.C9cEqtMB8J@vostro.rjw.lan> <528D288D.9060902@linaro.org> <6632063.kaWI72d4Ef@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:50356 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116Ab3KUTgi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Nov 2013 14:36:38 -0500
Received: by mail-ie0-f179.google.com with SMTP id x13so385508ief.38
        for <linux-acpi@vger.kernel.org>; Thu, 21 Nov 2013 11:36:37 -0800 (PST)
In-Reply-To: <6632063.kaWI72d4Ef@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>

On 11/20/2013 05:27 PM, Rafael J. Wysocki wrote:
> On Wednesday, November 20, 2013 02:24:29 PM Al Stone wrote:
>> On 11/17/2013 03:06 PM, Rafael J. Wysocki wrote:
>>> On Saturday, November 09, 2013 06:36:14 PM al.stone@linaro.org wrote:
>>>> From: Al Stone <ahs3@redhat.com>
>>>
>>> -ENOCHANGELOG
>>
>> Yup.  Will be added.
>>
>>>> Signed-off-by: Al Stone <al.stone@linaro.org>
>>>> ---
>>>>    drivers/acpi/bus.c      |  3 ++-
>>>>    drivers/acpi/osl.c      | 10 ++++++----
>>>>    drivers/acpi/pci_link.c | 14 ++++++++------
>>>>    3 files changed, 16 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>>>> index b587ec8..6a54dd5 100644
>>>> --- a/drivers/acpi/bus.c
>>>> +++ b/drivers/acpi/bus.c
>>>> @@ -540,7 +540,8 @@ void __init acpi_early_init(void)
>>>>    		goto error0;
>>>>    	}
>>>>
>>>> -#ifdef CONFIG_X86
>>>> +#if (!CONFIG_ACPI_REDUCED_HARDWARE)
>>>
>>> Why don't you use #ifndef here?
>>
>> No particular reason; I'll change it.
>>
>>>> +	/* NB: in HW reduced mode, FADT sci_interrupt has no meaning */
>>>
>>> I'm not sure what the "NB" stands for, but it looks like that's what "NOTE:" is
>>> used for elsewhere.
>>
>> Ah.  Whups.  "NB" == "Nota Bene" -- Latin for "note well" and a
>> personal habit when writing.  Yes, it should be "NOTE:".
>>
>>>>    	if (!acpi_ioapic) {
>>>>    		/* compatible (0) means level (3) */
>>>>    		if (!(acpi_sci_flags & ACPI_MADT_TRIGGER_MASK)) {
>>>> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
>>>> index 54a20ff..017b85c 100644
>>>> --- a/drivers/acpi/osl.c
>>>> +++ b/drivers/acpi/osl.c
>>>> @@ -84,6 +84,7 @@ static int (*__acpi_os_prepare_extended_sleep)(u8 sleep_state, u32 val_a,
>>>>
>>>>    static acpi_osd_handler acpi_irq_handler;
>>>>    static void *acpi_irq_context;
>>>> +static u32 acpi_irq_number;
>>>>    static struct workqueue_struct *kacpid_wq;
>>>>    static struct workqueue_struct *kacpi_notify_wq;
>>>>    static struct workqueue_struct *kacpi_hotplug_wq;
>>>> @@ -797,9 +798,9 @@ acpi_os_install_interrupt_handler(u32 gsi, acpi_osd_handler handler,
>>>>
>>>>    	/*
>>>>    	 * ACPI interrupts different from the SCI in our copy of the FADT are
>>>> -	 * not supported.
>>>> +	 * not supported, except in HW reduced mode.
>>>>    	 */
>>>> -	if (gsi != acpi_gbl_FADT.sci_interrupt)
>>>> +	if (!acpi_gbl_reduced_hardware && (gsi != acpi_gbl_FADT.sci_interrupt))
>>>
>>> The inner parens are not necessary.
>>
>> Ack.
>>
>>> Also it seems that we may need to support gsi != acpi_gbl_FADT.sci_interrupt
>>> generically, because there may be GPE device objects with interrupts different
>>> from the SCI.
>>
>> In reduced HW mode, there are no GPE blocks defined; all
>> interrupts of that nature are required to use GPIO interrupts
>> instead, afaict.
>
> Well, I'm not sure about that.  The GPE0/1 blocks in FADT are not supposed to
> be present, but does that apply to GPE block devices (Section 9.10 of ACPI 5.0)?
>
>> The spec unfortunately has this info scattered
>> through out -- the earlier parts of the spec discussing the
>> reduced HW mode and the discussion around the FADT go into
>> some of the details.
>
> Any more precise pointers?
>
> Anyway, the point was that we may need to support interrupts different from
> acpi_gbl_FADT.sci_interrupt even if the HW reduced mode is *not* used, so
> making that depend on acpi_gbl_reduced_hardware doesn't seem quite right.

Yeah, sorry, I should have included the pointers earlier.  I'm basing
my thinking on my understanding of these sections:

    -- Section 4.1 which defines HW reduced ACPI, and specifically
       on 4.1.1, Hardware-Reduced Events.

    -- Section 5.2.9 defining the FADT and the HW reduced restrictions

    -- Section 5.6.5, GPIO-signaled ACPI events

    -- Section 9.10, GPE block device

The way I read 9.10 in particular is why I'm thinking that any use of
acpi_gbl_FADT.sci_interrupt needs to go away in HW reduced mode.  The
first sentence says:

    The GPE Block device is an optional device that allows a system
    designer to describe GPE blocks beyond the two that are described
    in the FADT.

The way I am interpreting that is that a GPE block device only makes
sense as an extension of the GPE0/1 blocks, not as an independent
device.  Since using the GPE0/1 blocks is not allowed in reduced HW
mode (see 5.2.9), we cannot extend them with a GPE block device.

That being said, I agree we should be able to install interrupt
handlers other than acpi_gbl_FADT.sci_interrupt regardless of whether
we are in legacy or reduced HW mode.  So, I'm thinking that this
block:

	if (gsi != acpi_gbl_FADT.sci_interrupt)
		return AE_BAD_PARAMETER;

should just be removed from acpi_os_install_interrupt_handler().

Does that make sense?

>>>>    		return AE_BAD_PARAMETER;
>>>>
>>>>    	if (acpi_irq_handler)
>>>> @@ -818,13 +819,14 @@ acpi_os_install_interrupt_handler(u32 gsi, acpi_osd_handler handler,
>>>>    		acpi_irq_handler = NULL;
>>>>    		return AE_NOT_ACQUIRED;
>>>>    	}
>>>> +	acpi_irq_number = irq;
>>>>
>>>>    	return AE_OK;
>>>>    }
>>>>
>>>>    acpi_status acpi_os_remove_interrupt_handler(u32 irq, acpi_osd_handler handler)
>>>>    {
>>>> -	if (irq != acpi_gbl_FADT.sci_interrupt)
>>>> +	if (!acpi_gbl_reduced_hardware && (irq != acpi_gbl_FADT.sci_interrupt))
>>>
>>> The inner parens are not necessary.
>>
>> Ack.
>>
>>>>    		return AE_BAD_PARAMETER;
>>>>
>>>>    	free_irq(irq, acpi_irq);
>>>> @@ -1806,7 +1808,7 @@ acpi_status __init acpi_os_initialize1(void)
>>>>    acpi_status acpi_os_terminate(void)
>>>>    {
>>>>    	if (acpi_irq_handler) {
>>>> -		acpi_os_remove_interrupt_handler(acpi_gbl_FADT.sci_interrupt,
>>>> +		acpi_os_remove_interrupt_handler(acpi_irq_number,
>>>>    						 acpi_irq_handler);
>>>
>>> It looks like this could be one line now?
>>
>> Yup.  Will fix.
>>
>>>>    	}
>>>>
>>>> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
>>>> index 2652a61..c0ab28a 100644
>>>> --- a/drivers/acpi/pci_link.c
>>>> +++ b/drivers/acpi/pci_link.c
>>>
>>> I'm not sure how the comment changes below belong to this patch.
>>
>> Sigh.  They don't.  Will omit.
>>
>>>> @@ -23,7 +23,7 @@
>>>>     *
>>>>     * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>     *
>>>> - * TBD:
>>>> + * TBD:
>>>>     *      1. Support more than one IRQ resource entry per link device (index).
>>>>     *	2. Implement start/stop mechanism and use ACPI Bus Driver facilities
>>>>     *	   for IRQ management (e.g. start()->_SRS).
>>>> @@ -268,8 +268,8 @@ static int acpi_pci_link_get_current(struct acpi_pci_link *link)
>>>>    		}
>>>>    	}
>>>>
>>>> -	/*
>>>> -	 * Query and parse _CRS to get the current IRQ assignment.
>>>> +	/*
>>>> +	 * Query and parse _CRS to get the current IRQ assignment.
>>>>    	 */
>>>>
>>>>    	status = acpi_walk_resources(link->device->handle, METHOD_NAME__CRS,
>>>> @@ -415,7 +415,7 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
>>>>    /*
>>>>     * "acpi_irq_balance" (default in APIC mode) enables ACPI to use PIC Interrupt
>>>>     * Link Devices to move the PIRQs around to minimize sharing.
>>>> - *
>>>> + *
>>>>     * "acpi_irq_nobalance" (default in PIC mode) tells ACPI not to move any PIC IRQs
>>>>     * that the BIOS has already set to active.  This is necessary because
>>>>     * ACPI has no automatic means of knowing what ISA IRQs are used.  Note that
>>>> @@ -433,7 +433,7 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
>>>>     *
>>>>     * Note that PCI IRQ routers have a list of possible IRQs,
>>>>     * which may not include the IRQs this table says are available.
>>>> - *
>>>> + *
>>>>     * Since this heuristic can't tell the difference between a link
>>>>     * that no device will attach to, vs. a link which may be shared
>>>>     * by multiple active devices -- it is not optimal.
>>>> @@ -505,7 +505,9 @@ int __init acpi_irq_penalty_init(void)
>>>>    		}
>>>>    	}
>>>
>>> Why don't you simply put
>>>
>>> 	if (acpi_gbl_reduced_hardware)
>>> 		return 0;
>>>
>>> here?
>>
>> Aha.  Much more obvious.  Thanks.  Will fix.
>>
>>>>    	/* Add a penalty for the SCI */
>>>> -	acpi_irq_penalty[acpi_gbl_FADT.sci_interrupt] += PIRQ_PENALTY_PCI_USING;
>>>> +	if (!acpi_gbl_reduced_hardware)
>>>> +		acpi_irq_penalty[acpi_gbl_FADT.sci_interrupt] +=
>>>> +			PIRQ_PENALTY_PCI_USING;
>>>>    	return 0;
>>>>    }
>>>>
>>>>
>>
>>
>>


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone@linaro.org
-----------------------------------
