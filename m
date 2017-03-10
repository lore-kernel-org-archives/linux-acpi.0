From: Stefan Assmann <sassmann@kpanic.de>
Subject: Re: [PATCH] ACPI: skip boot interrupt rerouting when index is zero
Date: Fri, 10 Mar 2017 14:47:06 +0100
Message-ID: <60c50f6c-bfc8-3f74-80aa-150558d6b703@kpanic.de>
References: <20170210114517.14812-1-sassmann@kpanic.de>
 <20170308223410.GA12086@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:49202 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933840AbdCJNrg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Mar 2017 08:47:36 -0500
In-Reply-To: <20170308223410.GA12086@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, rjw@rjwysocki.net

On 08.03.2017 23:34, Bjorn Helgaas wrote:
> Hi Stefan,

Hi Bjorn,

> On Fri, Feb 10, 2017 at 12:45:17PM +0100, Stefan Assmann wrote:
>> When checking for boot interrupts and PRT index is zero avoid doing
>> any interrupt rerouting since the code currently does not handle
>> determining the IRQ via _CRS method.
> 
> I don't understand this at all.  Can you educate me a little?

Sure, I'll try to explain my chain of thoughts.

> This bug occurs on the M2N-LR system.  I think that board contains an
> Intel 6702PXH PCIe-to-PCI-X bridge to support its PCI-X slots.  A
> PCI-X 3ware 9550SX is plugged in below the 6702PXH, and the problem is
> with the wired INTx interrupts from the 9550SX.
> 
> Can we tell where those PCI-X INTx wires are connected?  There's an
> IOAPIC in the 6702PXH; if they're connected there, the Intel 6700PXH
> 64-bit PCI Hub datasheet [1], sec 2.15.2, says it should generate
> upstream PCIe INTx messages ("boot interrupts") if the PCI-X INTx
> interrupt is masked in the APIC.

Correct, if you take a look at bridge_has_boot_interrupt_variant() we
actually walk up all the bridges to the root bridge and check for the
6702PXH via irq_reroute_variant, which gets set via PCI quirks in
quirk_reroute_to_boot_interrupts_intel().

> If the PCI-X INTx wires are connected elsewhere, e.g., to some other
> IOAPIC, the 6702PXH should never see its IOAPIC inputs wiggle and it
> should never generate a boot interrupt.
> 
> The fact that the 6702PXH IOAPIC doesn't appear in the lspci output
> and that "pci=noioapicquirk" is a workaround makes me think that we
> aren't using the 6702PXH IOAPIC and therefore we don't see boot
> interrupts on this system.

Oh, I did not notice that dmesg only reports 1 IO-APIC. Though walking
the bridges reports the 6702PXH IO-APIC being involved, otherwise the
quirk wouldn't hit.

> So my guess is that we should not use the IRQ reroute feature on this
> system, and I think that's what your patch accomplishes.  But I don't
> understand the way you figure it out.  Looking for "entry->index == 0"
> doesn't seem like an obvious connection.

The ACPI spec [1], sec 6.2.12, says
"There are two ways that _PRT can be used. [...]
In the second model, the PCI interrupts are hardwired to specific
interrupt inputs on the interrupt controller and are not configurable.
In this case, the Source field in _PRT does not reference a device, but
instead contains the value zero, and the Source Index field contains the
global system interrupt to which the PCI interrupt is hardwired."

This has been the case on all systems we encountered boot interrupts on
back then and thus what the quirk is based upon.

Reminder of how the _PRT entry looked like on the M2N-LR.
3w-9xxx 0000:03:00.0: PRT pin=1 link=ffff8802140621b8 index=0
Compared to a _PRT entry from the only system I could dig up which has
a 6702PXH.
megaraid 0000:03:01.0: PRT pin=1 link=          (null) index=24
megaraid 0000:03:01.0: PCI IRQ 24 -> rerouted to legacy IRQ 16

I remembered having read that there are buggy BIOSes out there which do
not set Source to a zero value but still put the IRQ in Index, though I
have no prove for that, I decided not to rely on it. If entry->index is
zero the quirk is destined to fail anyway, imho.
We could extend the condition to (entry->link && entry->index == 0) if
you think that is better.

Appreciate your thoughtful analysis!

  Stefan

[1] http://www.acpi.info/DOWNLOADS/ACPIspec50.pdf


> 
> [1] http://www.intel.com/content/dam/doc/datasheet/6700pxh-64-bit-pci-hub-datasheet.pdf
> 
>> Fixes:
>> https://bugzilla.kernel.org/show_bug.cgi?id=43074
>>
>> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
>> ---
>>  drivers/acpi/pci_irq.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
>> index c576a6f..6ecbde0 100644
>> --- a/drivers/acpi/pci_irq.c
>> +++ b/drivers/acpi/pci_irq.c
>> @@ -280,7 +280,7 @@ static int bridge_has_boot_interrupt_variant(struct pci_bus *bus)
>>  static int acpi_reroute_boot_interrupt(struct pci_dev *dev,
>>  				       struct acpi_prt_entry *entry)
>>  {
>> -	if (noioapicquirk || noioapicreroute) {
>> +	if (noioapicquirk || noioapicreroute || entry->index == 0) {
>>  		return 0;
>>  	} else {
>>  		switch (bridge_has_boot_interrupt_variant(dev->bus)) {
>> -- 
>> 2.9.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

