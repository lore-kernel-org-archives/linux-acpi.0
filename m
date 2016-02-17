From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 0/3] PCI: Revert "Implement pcibios_alloc_irq() and pcibios_free_irq()"
Date: Wed, 17 Feb 2016 20:47:16 +0100
Message-ID: <CAJZ5v0g1TBiRhALk5Q8PbC2FOXvOCJJsfNBcTVBLFpjDFvp0ag@mail.gmail.com>
References: <20160217182718.302.10272.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:36637 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964976AbcBQTrS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Feb 2016 14:47:18 -0500
In-Reply-To: <20160217182718.302.10272.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>, =?UTF-8?B?0J7Qu9C10LPQnNC+0YDQvtC3?= <oleg.moroz@mcc.vniiem.ru>, Joerg Roedel <jroedel@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sunjin Yang <fan4326@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <jiang.liu@linux.intel.com>

On Wed, Feb 17, 2016 at 7:36 PM, Bjorn Helgaas <bhelgaas@google.com> wr=
ote:
> These are clean reverts of 991de2e59090 ("PCI, x86: Implement
> pcibios_alloc_irq() and pcibios_free_irq()") and related changes.
>
> We have two reports of drivers broken in v4.3 by Jiang's change,
> 991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq() and
> pcibios_free_irq()").
>
> It would be best to fix the problem instead of reverting 991de2e59090=
, but
> I don't have time to do that myself, and we haven't heard from Jiang,=
 so
> the only choice I have is to revert the commit.
>
> Note that reverting will likely break IOAPIC hotplug.
>
> =D0=9E=D0=BB=D0=B5=D0=B3 and Sunjin, can you please test this and see=
 whether it fixes your
> drivers?  This patch is based on v4.5-rc1.
>
> I intend to merge these for v4.5 unless I hear objections.
>
> They're on my for-linus branch, so they should appear in linux-next
> tomorrow.
>
> Changes from the v1 posting:
>   - Explicitly revert related patches instead of resolving conflicts
>     manually
> ---
>
> Bjorn Helgaas (3):
>       Revert "x86/PCI: Don't alloc pcibios-irq when MSI is enabled"
>       Revert "PCI: Add helpers to manage pci_dev->irq and pci_dev->ir=
q_managed"
>       Revert "PCI, x86: Implement pcibios_alloc_irq() and pcibios_fre=
e_irq()"

ACK for all three FWIW.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
