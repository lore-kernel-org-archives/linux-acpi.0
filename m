From: Gary Hade <garyhade@us.ibm.com>
Subject: Re: [PATCH 0/4, v3] Physical PCI slot objects
Date: Mon, 19 Nov 2007 15:32:25 -0800
Message-ID: <20071119233225.GA6931@us.ibm.com>
References: <20071117182954.GA25003@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:48916 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbXKSXcb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Nov 2007 18:32:31 -0500
Content-Disposition: inline
In-Reply-To: <20071117182954.GA25003@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>, Gary Hade <garyhade@us.ibm.com>, Matthew Wilcox <matthew@wil.cx>, gregkh@suse.de, kristen.c.accardi@intel.com, lenb@kernel.org, rick.jones2@hp.com, linux

On Sat, Nov 17, 2007 at 11:29:54AM -0700, Alex Chiang wrote:
> Hi all,
> 
> This is v3 of the pci_slot patch series.
> 
> The major change is making the ACPI-PCI slot driver a Kconfig
> option, as per the recommendations of others (Gary, Kenji-san).

Alex, What I was trying to suggest is a boot-time kernel option, 
not a kernel configuration option.  The basic idea is to give
the user (with a single binary kernel) the ability to include
your ACPI-PCI slot driver feature changes only when they are
really needed.  In addition to reducing the number of
system/PCI hotplug driver combinations where your changes
would need to be validated, I believe would also help 
alleviate other worries (e.g. Andi Kleen's memory consumption
concern).  I believe this goal could also be achieved with the
kernel config option by making the pci_slot module runtime
loadable with the PCI hotplug drivers only visiting your new
code when the pci_slot driver is loaded, although I think this
would be more difficult to implement.

Also, I notice that even with your current CONFIG_ACPI_PCI_SLOT
implementation your numerous PCI hotplug driver changes (except
for only two places in pci_hotplug_core.c where there is 
`#ifndef CONFIG_ACPI_PCI_SLOT` and `#ifdef CONFIG_ACPI_PCI_SLOT`)
are _always_ exposed.  So, even with CONFIG_ACPI_PCI_SLOT disabled
there is IMO a need for testing of the affected PCI hotplug drivers
on more than a small number of isolated systems.

The good news is that I was able to test your v3 changes
(w/2.6.24-rc3 source) on our x3850 today with 'acpiphp'
and, except for the above mentioned inability to run-time
include/exclude them, they seemed to work fine.  The previous
boot-time ACPI error messages are gone and I was able to
successfully hot-remove and hot-add both PCI-X and PCIe
adapters.

Thanks,
Gary

-- 
Gary Hade
System x Enablement
IBM Linux Technology Center
503-578-4503  IBM T/L: 775-4503
garyhade@us.ibm.com
http://www.ibm.com/linux/ltc


