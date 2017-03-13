From: Stefan Assmann <sassmann@kpanic.de>
Subject: Re: [PATCH] ACPI: skip boot interrupt rerouting when index is zero
Date: Mon, 13 Mar 2017 09:19:02 +0100
Message-ID: <d62a4124-5ae6-bfa0-2267-bbf667e6a9fd@kpanic.de>
References: <20170210114517.14812-1-sassmann@kpanic.de>
 <20170313022040.GB8232@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:58281 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbdCMITK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Mar 2017 04:19:10 -0400
In-Reply-To: <20170313022040.GB8232@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, rjw@rjwysocki.net

On 13.03.2017 03:20, Bjorn Helgaas wrote:
> On Fri, Feb 10, 2017 at 12:45:17PM +0100, Stefan Assmann wrote:
>> When checking for boot interrupts and PRT index is zero avoid doing
>> any interrupt rerouting since the code currently does not handle
>> determining the IRQ via _CRS method.
>>
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
> 
> I don't understand acpi_reroute_boot_interrupt() in general.
> 
> I think I understand the chipset functionality, i.e., the Intel
> 6700PXH contains two IOAPICs, each with 16 interrupt inputs, and if an
> interrupt is asserted while that input is masked in the IOAPIC, the
> 6700PXH generates an INTx ASSERT message on the PCIe bus.
> 
> What I don't understand is what the "correct" way of handling this is.
> I assume the intent was *not* that the OS should have device-specific
> code to deal with this.

Boot interrupts are a mechanism to forward IRQs to the primary PIC/APIC,
this is done via the INTx messages. The idea is to provide support for
legacy OSes that do not support APICs. It probably was meant to be a
firmware only thing, but the problem at hand is this:
The condition for generating boot interrupts is, the input being masked
while an interrupt is asserted (on a non-primary IO-APIC). As you
already stated.
If this happens _and_ the interrupt line, the INTx messages get forwarded
to, already has an IRQ handler registered then there's no handler to
take care of those forwarded IRQs and eventually the kernel may
falsely shutdown that interrupt line. Because of too many lost
interrupts.
Sidenote, if there's no IRQ handler registered on that interrupt line,
the input is already masked and the boot interrupt silently disappears.

> Is it a case of the BIOS doing something wrong?  Is ACPI just not
> expressive enough to describe this hardware behavior?  

To be honest I'm not sure. The simplest of solutions would have been to
implement an on/off switch for boot interrupts in the chipset, but
unfortunately we did not find such a thing. So the solution we worked
out was to move the interrupt handler to the legacy interrupt line.

This has been a working solution for most systems affected so far. All
systems I've seen containing 6700PXH are about 10 years old by now and I
haven't notice the problem resurface.

  Stefan
