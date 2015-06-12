From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH V3 4/4] acpi, apei: use EFI memmap to map GHES memory
Date: Fri, 12 Jun 2015 18:29:24 +0200
Message-ID: <20150612162924.GH9084@pd.tnic>
References: <1434047160-23358-1-git-send-email-zjzhang@codeaurora.org>
 <1434047160-23358-5-git-send-email-zjzhang@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1434047160-23358-5-git-send-email-zjzhang@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>
Cc: Matt Fleming <matt.fleming@intel.com>, Thomas Gleixner <tglx@linutronix.de>, fu.wei@linaro.org, al.stone@linaro.org, tony.luck@gmail.com, rjw@rjwysocki.net, lenb@kernel.org, ying.huang@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Jun 11, 2015 at 11:26:00AM -0700, Jonathan (Zhixiong) Zhang wrote:
> From: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>
> 
> With ACPI APEI firmware first handling, generic hardware error
> record is updated by firmware in GHES memory region. When firmware
> updated GHES memory region with uncached access attribute, Linux
> reads stale data from cache.
> 
> GHES memory region should be mapped with cache attributes
> according to EFI memory map when applicable. On such system, if
> firmware updates RAM directly without going through cache,
> EFI memory map has GHES memory region defined as uncached;
> If firmware updates cache, EFI memory map has GHES memory region
> defined as cached.
> 
> On EFI system, if GHES memory region has EFI_MEMORY_UC attribute
> defined, map the page with arch defined UC page protection type.
> 
> Signed-off-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
> ---
>  drivers/acpi/apei/ghes.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index e82d0976a5d0..5cfd951ebf67 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -48,6 +48,7 @@
>  #include <linux/pci.h>
>  #include <linux/aer.h>
>  #include <linux/nmi.h>
> +#include <linux/efi.h>
>  
>  #include <acpi/ghes.h>
>  #include <acpi/apei.h>
> @@ -164,8 +165,14 @@ static void __iomem *ghes_ioremap_pfn_irq(u64 pfn)
>  	unsigned long vaddr;
>  
>  	vaddr = (unsigned long)GHES_IOREMAP_IRQ_PAGE(ghes_ioremap_area->addr);
> -	ioremap_page_range(vaddr, vaddr + PAGE_SIZE,
> +
> +	if (efi_mem_attributes(pfn << PAGE_SHIFT) & EFI_MEMORY_UC) {
> +		ioremap_page_range(vaddr, vaddr + PAGE_SIZE,
> +				   pfn << PAGE_SHIFT, ARCH_APEI_PAGE_KERNEL_UC);
> +	} else {
> +		ioremap_page_range(vaddr, vaddr + PAGE_SIZE,
>  			   pfn << PAGE_SHIFT, PAGE_KERNEL);
> +	}
>  
>  	return (void __iomem *)vaddr;

This is still hacky. All of a sudden, ghes code gets to know about EFI
which looks like a mishmash to me.

Maybe it would be cleaner if you added an arch-specific

	arch_get_mem_attribute(phys_addr);

which returns a pgprot_t thing which you can use directly above, like
so:

        ioremap_page_range(vaddr,
			   vaddr + PAGE_SIZE,
                           pfn << PAGE_SHIFT,
			   arch_get_mem_attribute(pfn << PAGE_SHIFT));

Each arch can then return what it likes with arch_get_mem_attribute().

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
