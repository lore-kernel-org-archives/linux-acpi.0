From: "Holger W." <info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org>
Subject: RE: problems with PRT and PCI routing table
Date: Sat, 8 Mar 2003 23:47:33 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <000201c2e5c4$b6120460$0200a8c0@brutzler>
References: <000501c2e50c$d43b2790$0200a8c0@brutzler>
Reply-To: <info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <000501c2e50c$d43b2790$0200a8c0-IGm5bqYn3xw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I have to correct myself again. Let me see if I understood everything ...

First of all my PCI interrupt links are detected and I get messages like "ACPI: PCI Interrupt
Link [ALKA] (IRQs 20, disabled)". "Disabled" means in this special case that we have to
choose/enable an IRQ later.

Now "acpi_pci_irq_init" is called and we have the following calling-structure ...

acpi_irq_init {
  -> acpi_pci_link_check -> acpi_pci_link_set
  -> mp_parse_prt
  -> iosapic_parse_prt
  -> acpi_pci_irq_enable
}

"acpi_pci_link_check" will check all my devices for valid IRQs. In my special case it tries to
find an IRQ for my interrupt link ALKA. Because we don't have more than one IRQ (20) for ALKA,
we don't have a big choice. The attempt to set the IRQ for the link is done by
"acpi_pci_link_set".

Now we're here:

acpi_pci_link_set {
  -> acpi_set_current_resources
  -> acpi_bus_get_status
  -> acpi_pci_link_get_current
}

Everything works fine at this point up to "acpi_pci_link_get_current". And now we're one more
step further ...

acpi_pci_link_get_current {
  -> acpi_bus_get_status
  -> acpi_walk_resources -> acpi_pci_link_check_current
}

And after "acpi_walk_resources" ist the point where we fail. The condition "if (!irq)" is true
because "acpi_pci_link_get_current" returns with the error "pci_link-0262 [21]
acpi_pci_link_get_curr: No IRQ resource found".
That is we have an error in "acpi_pci_link_set" and we will return with this code fragment to
"acpi_pci_link_check":

result = acpi_pci_link_get_current(link);
if (result) {
	return_VALUE(result);
}

Because we failed in "acpi_pci_link_get_current" the irq variable is NULL and we get a message
like "ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 0".

Now we're back in "acpi_pci_irq_init". Another problem could be located in "mp_parse_prt":

/* We're only interested in static (non-link) entries. */
if (entry->link.handle)
	continue;

I don't understand why only non-link entries are being used !

However, all side effects I mentioned in the last posting will occur due to these errors ...
I hope I now analyzed the code properly. Would be nice if some developers could comment :-)

Thanks for your attention !!!

HOLGER W.



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
