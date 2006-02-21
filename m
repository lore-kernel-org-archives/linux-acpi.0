From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/1] EFI iounpam fix for acpi_os_unmap_memory
Date: 21 Feb 2006 15:15:21 +0100
Message-ID: <p73ek1w4x3a.fsf@verdi.suse.de>
References: <43FA5293.4070807@ed-soft.at>
	<20060220220219.6d82366a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161223AbWBUOPg@vger.kernel.org>
In-Reply-To: <20060220220219.6d82366a.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Domsch <Matt_Domsch@dell.com>, hostmaster@ed-soft.at
List-Id: linux-acpi@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

>  
>  void acpi_os_unmap_memory(void __iomem * virt, acpi_size size)
>  {
> +	/* Don't unmap memory which was not mapped by acpi_os_map_memory */
> +	if (efi_enabled &&
> +	    (efi_mem_attributes(virt_to_phys(virt)) & EFI_MEMORY_WB))
> +		return;


The patch is wrong because if the address came from ioremap 
virt_to_phys doesn't give the real physical address. Also looking
at acpi_os_map_memory it doesn't quite match the logic there.

One working way to check for ioremap memory is 
virt >= VMALLOC_START  && virt < VMALLOC_END

-Andi
