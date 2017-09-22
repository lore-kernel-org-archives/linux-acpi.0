From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH v2 1/4] ACPICA: Add SMMUv3 device ID mapping index
 support
Date: Fri, 22 Sep 2017 12:25:08 +0100
Message-ID: <20170922112508.GB3475@red-moon>
References: <1505999838-52530-1-git-send-email-guohanjun@huawei.com>
 <1505999838-52530-2-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56420 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752105AbdIVLWg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Sep 2017 07:22:36 -0400
Content-Disposition: inline
In-Reply-To: <1505999838-52530-2-git-send-email-guohanjun@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, Hanjun Guo <hanjun.guo@linaro.org>

On Thu, Sep 21, 2017 at 09:17:15PM +0800, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> SMMUv3 device ID mapping index is used for SMMUv3
> MSIs, update the IORT to support that.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  include/acpi/actbl2.h | 1 +
>  1 file changed, 1 insertion(+)

Have you sent the related git pull ACPICA upstream ?

Lorenzo

> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 686b6f8..d90277e 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -810,6 +810,7 @@ struct acpi_iort_smmu_v3 {
>  	u8 pxm;
>  	u8 reserved1;
>  	u16 reserved2;
> +	u32 id_mapping_index;
>  };
>  
>  /* Values for Model field above */
> -- 
> 1.7.12.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
