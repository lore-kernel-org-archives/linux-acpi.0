From: Borislav Petkov <bp@alien8.de>
Subject: Re: 174cc7187e6f ACPICA: Tables: Back port
 acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux
 kernel
Date: Mon, 9 Jan 2017 23:57:56 +0100
Message-ID: <20170109225756.xv5pdmrnydkcd7l4@pd.tnic>
References: <20170107204227.bwdb5yzrjpiggkmo@pd.tnic>
 <CAJZ5v0idFBHG=OKRiBqvsYPgUrWQsqjTKYXfKxfdG023qsCbkw@mail.gmail.com>
 <20170109105226.GR17255@8bytes.org>
 <1607437.S0DYC9F2YO@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:59724 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1764272AbdAIW6A (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 9 Jan 2017 17:58:00 -0500
Content-Disposition: inline
In-Reply-To: <1607437.S0DYC9F2YO@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>, lkml <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Mon, Jan 09, 2017 at 11:41:15PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] IOMMU / AMD: Fix error code path in early_amd_iommu_init()
> 
> Prevent early_amd_iommu_init() from leaking memory mapped via
> acpi_get_table() if check_ivrs_checksum() returns an error.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/iommu/amd_iommu_init.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/iommu/amd_iommu_init.c
> ===================================================================
> --- linux-pm.orig/drivers/iommu/amd_iommu_init.c
> +++ linux-pm/drivers/iommu/amd_iommu_init.c
> @@ -2230,7 +2230,7 @@ static int __init early_amd_iommu_init(v
>  	 */
>  	ret = check_ivrs_checksum(ivrs_base);
>  	if (ret)
> -		return ret;
> +		goto out;
>  
>  	amd_iommu_target_ivhd_type = get_highest_supported_ivhd_type(ivrs_base);
>  	DUMP_printk("Using IVHD type %#x\n", amd_iommu_target_ivhd_type);

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
