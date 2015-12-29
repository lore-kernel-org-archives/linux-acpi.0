From: Matt Fleming <mfleming@suse.com>
Subject: Re: [PATCH] ACPI/APEI: correct/extend pgprot_t retrieval to map GHES
 memory
Date: Tue, 29 Dec 2015 12:28:36 +0000
Message-ID: <20151229122836.GA2328@codeblueprint.co.uk>
References: <56797F6502000078000C2525@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58500 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752957AbbL2M2k (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Dec 2015 07:28:40 -0500
Content-Disposition: inline
In-Reply-To: <56797F6502000078000C2525@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Beulich <JBeulich@suse.com>
Cc: linux-acpi@vger.kernel.org, zjzhang@codeaurora.org, Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Borislav Petkov <bp@alien8.de>

On Tue, 22 Dec, at 03:50:45PM, Jan Beulich wrote:
> Commit 8ece249a81 ("acpi/apei: Use appropriate pgprot_t to map GHES
> memory") adjusted ghes_ioremap_pfn_irq() but left ghes_ioremap_pfn_nmi()
> alone, and while doing the adjustment it introduced an at least latent
> truncation issue on ix86 (using "unsigned long" for a physical address).
 
Good catch, but I don't think this is the correct fix. 'paddr' should
be u64 because that's the data type used in ghes_copy_tofrom_phys(),
and because the value is read from ACPI. The firmware dictates the
data types.

> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Cc: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
> Cc: Matt Fleming <mfleming@suse.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> ---
>  drivers/acpi/apei/ghes.c |   12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> --- 4.4-rc6/drivers/acpi/apei/ghes.c
> +++ 4.4-rc6-ACPI-GHES-ioremap/drivers/acpi/apei/ghes.c
> @@ -147,17 +147,23 @@ static void ghes_ioremap_exit(void)
>  static void __iomem *ghes_ioremap_pfn_nmi(u64 pfn)
>  {
>  	unsigned long vaddr;
> +	phys_addr_t paddr;
> +	pgprot_t prot;
>  
>  	vaddr = (unsigned long)GHES_IOREMAP_NMI_PAGE(ghes_ioremap_area->addr);
> -	ioremap_page_range(vaddr, vaddr + PAGE_SIZE,
> -			   pfn << PAGE_SHIFT, PAGE_KERNEL);
> +
> +	paddr = pfn << PAGE_SHIFT;
> +	prot = arch_apei_get_mem_attribute(paddr);
> +
> +	ioremap_page_range(vaddr, vaddr + PAGE_SIZE, paddr, prot);
>  
>  	return (void __iomem *)vaddr;
>  }
  
Did you test this change? I didn't suggest fixing this function up
originally because it isn't used on arm64.
