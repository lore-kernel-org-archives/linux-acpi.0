From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH 6/7] ACPI: Page based coalescing of I/O remappings
 optimization
Date: Fri, 22 Oct 2010 13:17:05 +0800
Message-ID: <1287724625.2862.78.camel@yhuang-dev>
References: <20101021201916.9220.5711.stgit@bob.kio>
	 <20101021202414.9220.71053.stgit@bob.kio>
	 <1287709434.2862.25.camel@yhuang-dev>  <1287717834.2564.81.camel@zim>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:48926 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752483Ab0JVFRH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Oct 2010 01:17:07 -0400
In-Reply-To: <1287717834.2564.81.camel@zim>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Myron Stowe <myron.stowe@hp.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "ak@linux.intel.com" <ak@linux.intel.com>

On Fri, 2010-10-22 at 11:23 +0800, Myron Stowe wrote:
> On Fri, 2010-10-22 at 09:03 +0800, Huang Ying wrote:
> > Hi, Myron,
> > 
> > On Fri, 2010-10-22 at 04:24 +0800, Myron Stowe wrote:
> > > This patch optimizes ACPI MMIO remappings by keeping track of the
> > > remappings on a PAGE_SIZE granularity.
> > > 
> > > When an ioremap() occurs, the underlying infrastructure works on a 'page'
> > > based granularity.  As such, an ioremap() request for 1 byte for example,
> > > will end up mapping in an entire (PAGE_SIZE) page.  Huang Ying took
> > > advantage of this in commit 15651291a2f8c11e7e6a42d8bfde7a213ff13262 by
> > > checking if subsequent ioremap() requests reside within any of the list's
> > > existing remappings still in place, and if so, incrementing a reference
> > > count on the existing mapping as opposed to performing another ioremap().
> > > 
> > > 
> > > Signed-off-by: Myron Stowe <myron.stowe@hp.com>
> > > ---
> > > 
> > >  drivers/acpi/osl.c |   62 +++++++++++++++++++++++++++++++++++++++++++---------
> > >  1 files changed, 51 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> > > index 3282689..885e222 100644
> > > --- a/drivers/acpi/osl.c
> > > +++ b/drivers/acpi/osl.c
> > > @@ -104,6 +104,7 @@ struct acpi_ioremap {
> > >  	void __iomem *virt;
> > >  	acpi_physical_address phys;
> > >  	acpi_size size;
> > > +	struct kref ref;
> > >  };
> > >  
> > >  static LIST_HEAD(acpi_ioremaps);
> > > @@ -245,15 +246,28 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
> > >  }
> > >  
> > >  /* Must be called with 'acpi_ioremap_lock' or RCU read lock held. */
> > > -static void __iomem *
> > > -acpi_map_vaddr_lookup(acpi_physical_address phys, acpi_size size)
> > > +static struct acpi_ioremap *
> > > +acpi_map_lookup(acpi_physical_address phys, acpi_size size)
> > >  {
> > >  	struct acpi_ioremap *map;
> > >  
> > >  	list_for_each_entry_rcu(map, &acpi_ioremaps, list)
> > >  		if (map->phys <= phys &&
> > >  		    phys + size <= map->phys + map->size)
> > > -			return map->virt + (phys - map->phys);
> > > +			return map;
> > > +
> > > +	return NULL;
> > > +}
> > > +
> > > +/* Must be called with 'acpi_ioremap_lock' or RCU read lock held. */
> > > +static void __iomem *
> > > +acpi_map_vaddr_lookup(acpi_physical_address phys, unsigned int size)
> > > +{
> > > +	struct acpi_ioremap *map;
> > > +
> > > +	map = acpi_map_lookup(phys, size);
> > > +	if (map)
> > > +		return map->virt + (phys - map->phys);
> > >  
> > >  	return NULL;
> > >  }
> > > @@ -265,7 +279,8 @@ acpi_map_lookup_virt(void __iomem *virt, acpi_size size)
> > >  	struct acpi_ioremap *map;
> > >  
> > >  	list_for_each_entry_rcu(map, &acpi_ioremaps, list)
> > > -		if (map->virt == virt && map->size == size)
> > > +		if (map->virt <= virt &&
> > > +		    virt + size <= map->virt + map->size)
> > >  			return map;
> > >  
> > >  	return NULL;
> > > @@ -274,9 +289,10 @@ acpi_map_lookup_virt(void __iomem *virt, acpi_size size)
> > >  void __iomem *__init_refok
> > >  acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
> > >  {
> > > -	struct acpi_ioremap *map;
> > > -	unsigned long flags;
> > > +	struct acpi_ioremap *map, *tmp_map;
> > > +	unsigned long flags, pg_sz;
> > >  	void __iomem *virt;
> > > +	phys_addr_t pg_off;
> > >  
> > >  	if (phys > ULONG_MAX) {
> > >  		printk(KERN_ERR PREFIX "Cannot map memory that high\n");
> > > @@ -290,7 +306,9 @@ acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
> > >  	if (!map)
> > >  		return NULL;
> > >  
> > > -	virt = ioremap(phys, size);
> > > +	pg_off = round_down(phys, PAGE_SIZE);
> > > +	pg_sz = round_up(phys + size, PAGE_SIZE) - pg_off;
> > > +	virt = ioremap(pg_off, pg_sz);
> > >  	if (!virt) {
> > >  		kfree(map);
> > >  		return NULL;
> > 
> > Why not check the existing map (that is, acpi_map_lookup()) before the
> > ioremap()? In APEI tables, several GAS may be in same page, so we need
> > ioremap() for the first page only.
> 
> Yes, even in other instances, several registers (GAS) may reside within
> the same page(s) of a previously, still active, ioremapping and thus
> only one ioremapping needs to be in place (with the subsequent
> mapping(s) that fall within the same page(s) of the existing, active,
> remapping then only needing to increment its reference).
> 
> 
> In the existing implementation - atomicio.c:acpi_pre_map() - there is a
> check at the beginning of the routine to see if a new mapping fits
> within the page(s) of a previous entry's page(s) that is still active:
> __acpi_try_ioremap().  Then later in the same routine, the same
> __acpi_try_ioremap() check has to be made again due to a potential mp
> race between the initial check and the insertion of a potentially new
> entry onto the list.
> 
> Since the second check *must* take place,

No. If the first check succeeds, the second check is not necessary, it
is sufficient just to increase the reference count and return the mapped
virtual address. The first check will eliminate
kmalloc/ioremap/iounmap/kfree for physical address has been mapped by
previous calling.

>  due to the possible race, I
> decided to skip the initial check in the re-factored implementation
> knowing that such a situation would ultimately still be caught by it
> (the second check) and handled correctly: a subsequent, overlapping,
> mapping is caught by the "tmp_map = acpi_map_lookup()" below, the
> reference to the initial, active, remapping incremented, and the
> overlapping mapping is "backed out".
> 
> Do you see any issues with such an approach?

Best Regards,
Huang Ying


