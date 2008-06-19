From: Alok Kataria <akataria@vmware.com>
Subject: [PCI_ACPI] Modify PCI gap calculation
Date: Thu, 19 Jun 2008 15:56:49 -0700
Message-ID: <1213916210.27983.32.camel@promb-2n-dhcp368.eng.vmware.com>
Reply-To: akataria@vmware.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-outbound-1.vmware.com ([65.113.40.141]:37822 "EHLO
	smtp-outbound-1.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752711AbYFSW4w (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jun 2008 18:56:52 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

Today, we calculate a gap in the low 32bit address space for PCI devices
to assign MMIO resources for hotplug or unconfigured devices,
(pci_mem_start). 
This gap calculation is done by walking the e820 memory space, this
calculation ignores the SRAT for any possible reservations that the
BIOS might have done for memory hotplug. In some cases the
PCI device resources (f.e. Expansion ROMS) end up sharing the address
space with memory hotplug capable regions. 

As a result, when we try to hotadd memory to a system which has less
than 4GB memory to start with, we see resource clashes and the hotadd
requests fail. 

The solution here is to find a PCI gap in the PCI reserved regions as
exported by the ACPI table. We read the _CRS object under PCI0 for
possible producer regions and search for a big enough unclaimed gap
within these producer regions.

There are 2 patches 
1. cleanup of the e820_search_gap function
2. code which walks ACPI resources searching for gap within producer
regions.

I have kept the original e820_find_gap function since in systems with
ACPI disabled we still may need to calculate the gap.

Please have a look. 

Thanks,
Alok

