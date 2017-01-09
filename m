From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
Subject: Re: 174cc7187e6f ACPICA: Tables: Back port
 acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux
 kernel
Date: Mon, 9 Jan 2017 11:52:26 +0100
Message-ID: <20170109105226.GR17255@8bytes.org>
References: <20170107204227.bwdb5yzrjpiggkmo@pd.tnic>
 <4034dde8-ffc1-18e2-f40c-00cf37471793@intel.com>
 <20170108000702.wrov5ajeou2y3tuy@pd.tnic>
 <CAJZ5v0jtGo207YmBGDw55uCV+3sp-QX2Gx7cup-4e8ESjnHhrQ@mail.gmail.com>
 <20170108003730.hlcqkhdxtah65z66@pd.tnic>
 <CAJZ5v0jgdctHEEOaAUBNZZPb=ni_DLdkJtmiDkvVP4WQUYr3rA@mail.gmail.com>
 <20170108010158.b62eovaxsbmhfnkb@pd.tnic>
 <CAJZ5v0hxrz9os4ZpS=EHbdFp8rd7D+BU10bSyfBV-FE6UHQ6FA@mail.gmail.com>
 <CAJZ5v0idFBHG=OKRiBqvsYPgUrWQsqjTKYXfKxfdG023qsCbkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0idFBHG=OKRiBqvsYPgUrWQsqjTKYXfKxfdG023qsCbkw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>, lkml <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Rafael,

On Sun, Jan 08, 2017 at 03:20:20AM +0100, Rafael J. Wysocki wrote:
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

Yeah, good catch. Can you send me a patch for this and I am going to
send the fix upstream asap.


Thanks,

	Joerg
