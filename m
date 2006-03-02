From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: acpi_os_map_memory()/acpi_os_unmap_memory()
Date: Thu, 2 Mar 2006 09:26:02 -0700
Message-ID: <200603020926.02151.bjorn.helgaas@hp.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B30063BFB23@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:45776 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1751588AbWCBQ0E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Mar 2006 11:26:04 -0500
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30063BFB23@hdsmsx401.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: "Grover, Andrew" <andrew.grover@intel.com>, linux-acpi@vger.kernel.org, Andi Kleen <ak@suse.de>

On Wednesday 01 March 2006 20:10, Brown, Len wrote:
> Andy,
> Do you recall the history of how this pair of routines got this way?
> 
> First problem is something mapped with efi_enabled may not use ioremap,
> but the then un-map on the same region uses iounmap().

I think we added the efi_enabled check in acpi_os_map_memory() for
the ia64 port, because some HP ia64 boxes don't support UC access to
main memory.

The fact that acpi_os_unmap_memory() doesn't work the same way is
just an oversight on our part.  On ia64, iounmap() is a no-op, so
it didn't matter.

> Second issue is that it isn't clear that ioremap() is the right way
> to go for a general purpose memory mapper.  acpi_os_map_memory()
> is used by the core to map the tables and also to support
> AML operation region reads and writes which can be memory
> or memory mapped registers.

Andi Kleen suggested making ioremap() smart enough to deal with
either regular memory or MMIO.  I think that's much better than
having the efi_enabled gunk in acpi_os_map_memory(), but if you
have an even better idea, that'd be great.

> 2002/03/14 agrover            | acpi_status
> 2005/08/05 len.brown          | acpi_os_map_memory(acpi_physical_address
> phys, acpi_size size,
> 2005/08/05 len.brown          | 		   void __iomem ** virt)
> 2002/03/14 agrover            | {
> 2003/12/29 akpm               | 	if (efi_enabled) {
> 2003/12/29 akpm               | 		if (EFI_MEMORY_WB &
> efi_mem_attributes(phys)) {
> 2005/08/05 len.brown          | 			*virt = (void
> __iomem *)phys_to_virt(phys);
> 2003/12/29 akpm               | 		} else {
> 2003/12/29 akpm               | 			*virt =
> ioremap(phys, size);
> 2003/12/29 akpm               | 		}
> 2002/10/01 agrover            | 	} else {
> 2003/12/29 akpm               | 		if (phys > ULONG_MAX) {
> 2003/12/29 akpm               | 			printk(KERN_ERR
> PREFIX "Cannot map memory that high\n");
> 2003/12/29 akpm               | 			return
> AE_BAD_PARAMETER;
> 2003/12/29 akpm               | 		}
> 2003/12/29 akpm               | 		/*
> 2005/08/05 len.brown          | 		 * ioremap checks to
> ensure this is in reserved space
> 2005/08/05 len.brown          | 		 */
> 2005/08/05 len.brown          | 		*virt =
> ioremap((unsigned long)phys, size);
> 2002/03/14 agrover            | 	}
> 2002/05/29 agrover            | 
> 2002/03/14 agrover            | 	if (!*virt)
> 2002/03/14 agrover            | 		return AE_NO_MEMORY;
> 2002/03/14 agrover            | 
> 2002/03/14 agrover            | 	return AE_OK;
> 2002/03/14 agrover            | }
> 2006/01/08 kjhall             | EXPORT_SYMBOL_GPL(acpi_os_map_memory);
> 2002/03/14 agrover            | 
> 2005/08/05 len.brown          | void acpi_os_unmap_memory(void __iomem *
> virt, acpi_size size)
> 2002/03/14 agrover            | {
> 2002/03/14 agrover            | 	iounmap(virt);
