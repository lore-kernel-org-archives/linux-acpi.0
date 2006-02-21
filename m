From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/1] EFI iounpam fix for acpi_os_unmap_memory
Date: Tue, 21 Feb 2006 12:59:19 -0800
Message-ID: <20060221125919.5085de5f.akpm@osdl.org>
References: <43FA5293.4070807@ed-soft.at>
	<20060220220219.6d82366a.akpm@osdl.org>
	<p73ek1w4x3a.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932649AbWBUVBO@vger.kernel.org>
In-Reply-To: <p73ek1w4x3a.fsf@verdi.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Matt_Domsch@dell.com, hostmaster@ed-soft.at
List-Id: linux-acpi@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
> >  
> >  void acpi_os_unmap_memory(void __iomem * virt, acpi_size size)
> >  {
> > +	/* Don't unmap memory which was not mapped by acpi_os_map_memory */
> > +	if (efi_enabled &&
> > +	    (efi_mem_attributes(virt_to_phys(virt)) & EFI_MEMORY_WB))
> > +		return;
> 
> 
> The patch is wrong because if the address came from ioremap 
> virt_to_phys doesn't give the real physical address. Also looking
> at acpi_os_map_memory it doesn't quite match the logic there.
> 
> One working way to check for ioremap memory is 
> virt >= VMALLOC_START  && virt < VMALLOC_END
> 

OK, thanks.  I don't think we actually know who is trying to unmap some
memory which acpi didn't map.

Edgar, can you please describe the bug which you're trying to fix?
