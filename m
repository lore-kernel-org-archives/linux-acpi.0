From: Stefan Assmann <sassmann@redhat.com>
Subject: Re: drivers/pci/quirks.c: irq_reroute_variant is dead code?
Date: Mon, 07 Sep 2009 18:09:59 +0200
Message-ID: <4AA53057.1060602__39838.7037138038$1252347029$gmane$org@redhat.com>
References: <4A6F5670.4010405@goop.org> <20090807103318.06ed3ecd@jbarnes-g45> <20090808144520.GB25931@elte.hu> <20090810093228.54406cab@jbarnes-g45> <4A8121FD.1050307@redhat.com> <20090811080622.GA23226@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:28268 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752014AbZIGQNF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Sep 2009 12:13:05 -0400
In-Reply-To: <20090811080622.GA23226@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Len Brown <lenb@kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, Olaf Dabrunz <Olaf.Dabrunz@gmx.net>, linux-acpi@vger.kernel.org

On 11.08.2009 10:06, Ingo Molnar wrote:
[snip]
>>>>> On Tue, 28 Jul 2009 12:50:08 -0700
>>>>> Jeremy Fitzhardinge<jeremy@goop.org>  wrote:
>>>>>
>>>>>> quirk_reroute_to_boot_interrupts_intel() goes to some effort to
>>>>>> scan for a bunch of Intel devices and set
>>>>>> dev->irq_reroute_variant = INTEL_IRQ_REROUTE_VARIANT.  However,
>>>>>> as far as I can see that's the only reference to
>>>>>> dev->irq_reroute_variant and INTEL_IRQ_REROUTE_VARIANT, so the
>>>>>> whole thing appears to have no effect.
>>>>>>
>>>>>> Is it all dead code?  Is there something else which should be
>>>>>> there missing?
>>>>> Hm my quick look couldn't find a user either.  The initial patch
>>>>> to add that stuff (e1d3a90846b40ad3160bf4b648d36c6badad39ac) had
>>>>> an ACPI component, but it looks like that may have vanished
>>>>> somehow (maybe some of the IOAPIC code got shuffled around and
>>>>> this bit was missed?).
>>>>>
>>>>> Stefan or Ingo?
>>>> I dont remember ioapic interactions. Stefan?
>>>>
>>>> 	Ingo
>>>>
>>
>> Actually the ACPI part of the commit got trashed by some major 
>> ACPI rewrite. [...]
> 
> Yeah, i remember some larger reject resolved by Len i think, about 
> two cycles ago, in this area. So we probably lost those bits there - 
> i've Cc:-ed Len.
> 
> There's no urgency in terms of v2.6.31 (since we never really 
> exposed this new functionality in a new release), but it would be 
> nice to get to the bottom of this.

sorry it took me a while to come up with a patch. Here's some first
attempt of how we could turn CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS
into something useful again.

Ccing linux-acpi@vger.kernel.org as this changes ACPI code.

I'm not really sure if the ACPI GSI is always matches the final IRQ
number. From looking at the code it looks like it is but there might
be exceptions. So please let me know of any troubles that this patch
might cause.

I've tested this patch on a machine with 6700PXH PCI Express-to-PCI
Bridge and the machine booted fine. With the patch enabled and
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y set the NICs IRQ was
successfully moved from IRQ
  48:          0          0      16163        195   IO-APIC-fasteoi   eth0
to
  16:          0          0       4715        237   IO-APIC-fasteoi   uhci_hcd:usb2, uhci_hcd:usb5, eth0

Len, I know that you weren't that pleased by this whole "altering ACPI
information" approach the last time. Please consider it anyway.

  Stefan
---
 drivers/acpi/pci_irq.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -301,6 +301,61 @@ void acpi_pci_irq_del_prt(struct pci_bus
 /* --------------------------------------------------------------------------
                           PCI Interrupt Routing Support
    -------------------------------------------------------------------------- */
+#ifdef CONFIG_X86_IO_APIC
+extern int noioapicquirk;
+extern int noioapicreroute;
+
+static int bridge_has_boot_interrupt_variant(struct pci_bus *bus)
+{
+	struct pci_bus *bus_it;
+
+	for (bus_it = bus ; bus_it ; bus_it = bus_it->parent) {
+		if (!bus_it->self)
+			return 0;
+		if (bus_it->self->irq_reroute_variant)
+			return bus_it->self->irq_reroute_variant;
+	}
+	return 0;
+}
+
+/*
+ * Some chipsets (e.g. Intel 6700PXH) generate a legacy INTx when the IRQ
+ * entry in the chipset's IO-APIC is masked (as, e.g. the RT kernel does
+ * during interrupt handling). When this INTx generation cannot be disabled,
+ * we reroute these interrupts to their legacy equivalent to get rid of
+ * spurious interrupts.
+ */
+static int acpi_reroute_boot_interrupt(struct pci_dev *dev,
+				       struct acpi_prt_entry *entry)
+{
+	if (noioapicquirk || noioapicreroute) {
+		return 0;
+	} else {
+		switch (bridge_has_boot_interrupt_variant(dev->bus)) {
+		case 0:
+			/* no rerouting necessary */
+			return 0;
+		case INTEL_IRQ_REROUTE_VARIANT:
+			/*
+			 * Remap according to INTx routing table in 6700PXH
+			 * specs, intel order number 302628-002, section
+			 * 2.15.2. Other chipsets (80332, ...) have the same
+			 * mapping and are handled here as well.
+			 */
+			dev_info(&dev->dev, "PCI IRQ %d -> rerouted to legacy "
+				 "IRQ %d\n", entry->index,
+				 (entry->index % 4) + 16);
+			entry->index = (entry->index % 4) + 16;
+			return 1;
+		default:
+			dev_warn(&dev->dev, "Cannot reroute IRQ %d to legacy "
+				 "IRQ: unknown mapping\n", entry->index);
+			return -1;
+		}
+	}
+}
+#endif /* CONFIG_X86_IO_APIC */
+
 static struct acpi_prt_entry *acpi_pci_irq_lookup(struct pci_dev *dev, int pin)
 {
 	struct acpi_prt_entry *entry;
@@ -309,6 +364,9 @@ static struct acpi_prt_entry *acpi_pci_i

 	entry = acpi_pci_irq_find_prt_entry(dev, pin);
 	if (entry) {
+#ifdef CONFIG_X86_IO_APIC
+		acpi_reroute_boot_interrupt(dev, entry);
+#endif /* CONFIG_X86_IO_APIC */
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %s[%c] _PRT entry\n",
 				  pci_name(dev), pin_name(pin)));
 		return entry;

--
Stefan Assmann         | Red Hat GmbH
Software Engineer      | Otto-Hahn-Strasse 20, 85609 Dornach
                       | HR: Amtsgericht Muenchen HRB 153243
                       | GF: Brendan Lane, Charlie Peters,
sassmann at redhat.com |     Michael Cunningham, Charles Cachera
