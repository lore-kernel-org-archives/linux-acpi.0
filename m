From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Convert width in bits to bytes in __acpi_ioremap_fast()
Date: Fri, 28 Oct 2011 02:17:27 +0200
Message-ID: <201110280217.27681.trenn@suse.de>
References: <4ea1e75f5296b6c6b@agluck-desktop.sc.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60471 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708Ab1J1ARH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Oct 2011 20:17:07 -0400
In-Reply-To: <4ea1e75f5296b6c6b@agluck-desktop.sc.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Huang Ying <ying.huang@intel.com>

On Friday 21 October 2011 23:42:55 Luck, Tony wrote:
> Callers to __acpi_ioremap_fast() pass the bit_width that they found in the
> acpi_generic_address structure. Convert from bits to bytes when passing to
> __acpi_find_iomap() - as it wants to see bytes, not bits.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
This one should get:
CC: stable@kernel.org
added.

   Thomas
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
> -- 
> 1.7.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

