From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/1] EFI iounpam fix for acpi_os_unmap_memory
Date: Tue, 21 Feb 2006 22:09:06 +0100
Message-ID: <200602212209.07586.ak@suse.de>
References: <43FA5293.4070807@ed-soft.at> <p73ek1w4x3a.fsf@verdi.suse.de> <20060221125919.5085de5f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:15279 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932776AbWBUVJZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Feb 2006 16:09:25 -0500
In-Reply-To: <20060221125919.5085de5f.akpm@osdl.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Matt_Domsch@dell.com, hostmaster@ed-soft.at, Bjorn Helgaas <bjorn.helgaas@hp.com>

On Tuesday 21 February 2006 21:59, Andrew Morton wrote:
> Andi Kleen <ak@suse.de> wrote:
> >
> > Andrew Morton <akpm@osdl.org> writes:
> > 
> > >  
> > >  void acpi_os_unmap_memory(void __iomem * virt, acpi_size size)
> > >  {
> > > +	/* Don't unmap memory which was not mapped by acpi_os_map_memory */
> > > +	if (efi_enabled &&
> > > +	    (efi_mem_attributes(virt_to_phys(virt)) & EFI_MEMORY_WB))
> > > +		return;
> > 
> > 
> > The patch is wrong because if the address came from ioremap 
> > virt_to_phys doesn't give the real physical address. Also looking
> > at acpi_os_map_memory it doesn't quite match the logic there.
> > 
> > One working way to check for ioremap memory is 
> > virt >= VMALLOC_START  && virt < VMALLOC_END
> > 
> 
> OK, thanks.  I don't think we actually know who is trying to unmap some
> memory which acpi didn't map.
> 
> Edgar, can you please describe the bug which you're trying to fix?

I think the bug is clear - the logic in acpi_os_unmap_memory needs to match 
what acpi_os_map_memory() does for EFI. In particular this means not calling
iounmap.

He probably has a EFI system where this caused troubles.

But think even acpi_os_miap_memory is broken - I doubt the efi_mem_attributes
thing guarantees that  the memory is mapped. I guess this was added for
IA64 because ioremap used to return uncached memory there and IA64 doesn't
like this for memory accesses or something like that.

But Bjorn afaik recently fixed this by making ioremap handle it. So the right 
fix probably would be to just drop all the efi_enabled gunk in acpi_os_map_memory 
and just always use ioremap()

Also removed this ptr > ULONG_MAX check. Obvious it can never trigger.

<untested patch follows>

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/drivers/acpi/osl.c
===================================================================
--- linux.orig/drivers/acpi/osl.c
+++ linux/drivers/acpi/osl.c
@@ -182,23 +182,10 @@ acpi_status
 acpi_os_map_memory(acpi_physical_address phys, acpi_size size,
 		   void __iomem ** virt)
 {
-	if (efi_enabled) {
-		if (EFI_MEMORY_WB & efi_mem_attributes(phys)) {
-			*virt = (void __iomem *)phys_to_virt(phys);
-		} else {
-			*virt = ioremap(phys, size);
-		}
-	} else {
-		if (phys > ULONG_MAX) {
-			printk(KERN_ERR PREFIX "Cannot map memory that high\n");
-			return AE_BAD_PARAMETER;
-		}
-		/*
-		 * ioremap checks to ensure this is in reserved space
-		 */
-		*virt = ioremap((unsigned long)phys, size);
-	}
-
+	/*
+	 * ioremap checks to ensure this is in reserved space
+	 */
+	*virt = ioremap((unsigned long)phys, size);
 	if (!*virt)
 		return AE_NO_MEMORY;
 






> 
