From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 04/15] ACPICA: iasl: Add SMMUv3 device ID mapping index
 support
Date: Mon, 27 Nov 2017 14:31:22 +0000
Message-ID: <20171127143122.GA1858@red-moon>
References: <erik.schmauss@intel.com>
 <20171117234230.913-1-erik.schmauss@intel.com>
 <20171117234230.913-5-erik.schmauss@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38396 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752238AbdK0Oa5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Nov 2017 09:30:57 -0500
Content-Disposition: inline
In-Reply-To: <20171117234230.913-5-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Erik Schmauss <erik.schmauss@intel.com>
Cc: linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Bob Moore <robert.moore@intel.com>, rjw@rjwysocki.net

Hi Erik, all,

On Fri, Nov 17, 2017 at 03:42:19PM -0800, Erik Schmauss wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> ACPICA commit 5c371879e035122c5807752f42247fd091d107d6

Just a request - I would really like to see this series in v4.16 please,
so I kindly ask Rafael if it is possible to plan to pull this series for
the next kernel cycle - there are patches that provide ARM functionality
(ie the one I am replying to) that we need upstream and were queued for
a while.

Thank you,
Lorenzo

> SMMUv3 device ID mapping index is used for SMMUv3
> MSI which is introduced in IORT spec revision c,
> add its support for iasl.
> 
> Tested with iasl -t IORT then get the right SMMUv3
> node in iort.asl.
> 
> Link: https://github.com/acpica/acpica/commit/5c371879
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
> ---
>  include/acpi/actbl2.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 2623f9d72e46..0d60d5df14f8 100644
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
> 2.13.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
