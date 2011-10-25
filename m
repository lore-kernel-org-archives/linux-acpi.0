From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH] Convert width in bits to bytes in __acpi_ioremap_fast()
Date: Tue, 25 Oct 2011 10:48:54 +0800
Message-ID: <4EA62396.2070002@intel.com>
References: <4ea1e75f5296b6c6b@agluck-desktop.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:51485 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753859Ab1JYCs4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Oct 2011 22:48:56 -0400
In-Reply-To: <4ea1e75f5296b6c6b@agluck-desktop.sc.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Sorry for late.

On 10/22/2011 05:42 AM, Luck, Tony wrote:
> Callers to __acpi_ioremap_fast() pass the bit_width that they found in the
> acpi_generic_address structure. Convert from bits to bytes when passing to
> __acpi_find_iomap() - as it wants to see bytes, not bits.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/acpi/atomicio.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/atomicio.c b/drivers/acpi/atomicio.c
> index 252888f..70ffb71 100644
> --- a/drivers/acpi/atomicio.c
> +++ b/drivers/acpi/atomicio.c
> @@ -78,7 +78,7 @@ static void __iomem *__acpi_ioremap_fast(phys_addr_t paddr,
>  {
>  	struct acpi_iomap *map;
>  
> -	map = __acpi_find_iomap(paddr, size);
> +	map = __acpi_find_iomap(paddr, size/8);
>  	if (map)
>  		return map->vaddr + (paddr - map->paddr);
>  	else

Good catch! Thanks.

Or change the caller acpi_atomic_read_mem/write_mem?

Best Regards,
Huang Ying
