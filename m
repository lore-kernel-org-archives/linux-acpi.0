From: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH] x86_64: enable SWIOTLB if system has SRAT memory
 regions above MAX_DMA32_PFN
Date: Fri, 4 Dec 2015 12:08:56 +0100
Message-ID: <20151204120856.5cbd06c8@nial.brq.redhat.com>
References: <1448904938-92922-1-git-send-email-imammedo@redhat.com>
	<20151204082049.GA27096@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50896 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817AbbLDLJC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Dec 2015 06:09:02 -0500
In-Reply-To: <20151204082049.GA27096@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, konrad.wilk@oracle.com, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, akataria@vmware.com, fujita.tomonori@lab.ntt.co.jp, revers@redhat.com

On Fri, 4 Dec 2015 09:20:50 +0100
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
> > index 94c18eb..53d7951 100644
> > --- a/arch/x86/include/asm/acpi.h
> > +++ b/arch/x86/include/asm/acpi.h
> > @@ -147,6 +147,7 @@ static inline void disable_acpi(void) { }
> >  #ifdef CONFIG_ACPI_NUMA
> >  extern int acpi_numa;
> >  extern int x86_acpi_numa_init(void);
> > +unsigned long acpi_get_max_possible_pfn(void);
> >  #endif /* CONFIG_ACPI_NUMA */
> >  
> >  #define acpi_unlazy_tlb(x)	leave_mm(x)
> > @@ -170,4 +171,8 @@ static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
> >  }
> >  #endif
> >  
> > +#ifdef CONFIG_ACPI_HOTPLUG_MEMORY
> > +extern bool acpi_no_memhotplug;
> > +#endif /* CONFIG_ACPI_HOTPLUG_MEMORY */
> > +
> >  #endif /* _ASM_X86_ACPI_H */
> > diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
> > index adf0392..61d5ba5 100644
> > --- a/arch/x86/kernel/pci-swiotlb.c
> > +++ b/arch/x86/kernel/pci-swiotlb.c
> > @@ -88,7 +88,11 @@ int __init pci_swiotlb_detect_4gb(void)
> >  {
> >  	/* don't initialize swiotlb if iommu=off (no_iommu=1) */
> >  #ifdef CONFIG_X86_64
> > +#ifdef CONFIG_ACPI_NUMA
> > +	if (!no_iommu && acpi_get_max_possible_pfn() > MAX_DMA32_PFN)
> > +#else
> >  	if (!no_iommu && max_pfn > MAX_DMA32_PFN)
> > +#endif
> >  		swiotlb = 1;
> >  #endif
> >  	return swiotlb;
> > diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
> > index c2aea63..21b33f0 100644
> > --- a/arch/x86/mm/srat.c
> > +++ b/arch/x86/mm/srat.c
> > @@ -153,10 +153,20 @@ acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
> >  
> >  #ifdef CONFIG_MEMORY_HOTPLUG
> >  static inline int save_add_info(void) {return 1;}
> > +static unsigned long max_possible_pfn __initdata;
> >  #else
> >  static inline int save_add_info(void) {return 0;}
> >  #endif
> >  
> > +unsigned long __init acpi_get_max_possible_pfn(void)
> > +{
> > +#ifdef CONFIG_ACPI_HOTPLUG_MEMORY
> > +	if (!acpi_no_memhotplug)
> > +		return max_possible_pfn;
> > +#endif
> > +	return max_pfn;
> > +}
> > +
> >  /* Callback for parsing of the Proximity Domain <-> Memory Area mappings */
> >  int __init
> >  acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
> > @@ -203,6 +213,11 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
> >  		pr_warn("SRAT: Failed to mark hotplug range [mem %#010Lx-%#010Lx] in memblock\n",
> >  			(unsigned long long)start, (unsigned long long)end - 1);
> >  
> > +#ifdef CONFIG_MEMORY_HOTPLUG
> > +	if (max_possible_pfn < PFN_UP(end - 1))
> > +		max_possible_pfn = PFN_UP(end - 1);
> > +#endif
> > +
> >  	return 0;
> >  out_err_bad_srat:
> >  	bad_srat();
> > diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> > index 6b0d3ef..ae38f57 100644
> > --- a/drivers/acpi/acpi_memhotplug.c
> > +++ b/drivers/acpi/acpi_memhotplug.c
> > @@ -357,7 +357,7 @@ static void acpi_memory_device_remove(struct acpi_device *device)
> >  	acpi_memory_device_free(mem_device);
> >  }
> >  
> > -static bool __initdata acpi_no_memhotplug;
> > +bool __initdata acpi_no_memhotplug;
> >  
> >  void __init acpi_memory_hotplug_init(void)
> >  {
> 
> So I don't disagree with the fix in principle, but the implementation here is 
> rather ugly - it spreads new non-obvious #ifdefs across various critical parts of 
> the kernel.
> 
> For example this:
> 
> >  #ifdef CONFIG_X86_64
> > +#ifdef CONFIG_ACPI_NUMA
> > +	if (!no_iommu && acpi_get_max_possible_pfn() > MAX_DMA32_PFN)
> > +#else
> >  	if (!no_iommu && max_pfn > MAX_DMA32_PFN)
> > +#endif
> >  		swiotlb = 1;
> >  #endif
> 
> could be cleaned up by introducing a proper max_possible_pfn variable, and setting 
> it from the ACPI code - instead of exporting acpi_get_max_possible_pfn().
Thanks for review,
I'll try to drop #ifdefs as suggested and split it
in several patches.

> 
> Another pattern is:
> 
> > +#ifdef CONFIG_ACPI_HOTPLUG_MEMORY
> > +	if (!acpi_no_memhotplug)
on the second thought,
we don't need need this knob to force disabling
SWIOTLB initialization since there is an existing
"no_iommu" option to do it, so I'll drop this check.


> > +		return max_possible_pfn;
> > +#endif
> 
> this should be driven from the acpi_no_memhotplug knob, instead of spreading 
> acpi_no_memhotplug uses to other callsites.
> 
> Furthermore, please split these various steps up into multiple steps (and first do 
> the preparatory changes, then fix the bug in the end) - to make it easier to 
> bisect and analyze if we regress existing functionality somewhere.
> 
> Thanks,
> 
> 	Ingo

