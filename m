From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: problems with PRT and PCI routing table
Date: Thu, 13 Mar 2003 16:51:49 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A1F6@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Holger W. [mailto:info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org] 
> I have to correct myself again. Let me see if I understood 
> everything ...
> 
> First of all my PCI interrupt links are detected and I get 
> messages like "ACPI: PCI Interrupt
> Link [ALKA] (IRQs 20, disabled)". "Disabled" means in this 
> special case that we have to
> choose/enable an IRQ later.

Yes.

[code walkthru deleted]

> result = acpi_pci_link_get_current(link);
> if (result) {
> 	return_VALUE(result);
> }
> 
> Because we failed in "acpi_pci_link_get_current" the irq 
> variable is NULL and we get a message
> like "ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 0".

Why did pci_link_get_current() fail? The ASL should report back 20 in
the extended irq structure, we should read that, and then that should be
that. I've heard a report that Windows does not use _CRS like we do, so
this ASL code path may be untested, and therefore that could be the
problem. Have you disassembled your ASL? What does this link device's
_CRS method look like?

> Now we're back in "acpi_pci_irq_init". Another problem could 
> be located in "mp_parse_prt":
> 
> /* We're only interested in static (non-link) entries. */
> if (entry->link.handle)
> 	continue;

My understanding (not 100%) is that in that particular section of the
code we are just dealing with the static _PRT entries, because the
dynamic ones are enumerated as link devices and handled through the code
paths you detailed in your message.

Regards -- Andy

The current PCI IRQ routing code was hashed out more than a year ago and
I think may be due for a rework. Persistent IRQ routing problems are
still occurring.

The current code:

1) Sees if there is a current IRQ for the link device, and uses that,
even if it is not in the range of IRQs listed in _PRS
2) For disabled link devices, it picks one according to a weighting
system and sets it.

Later on, a device driver will load and try to enable its irq. If we can
derive the irq, then great, but if we can't is when things start falling
apart.

Regards -- Andy


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
