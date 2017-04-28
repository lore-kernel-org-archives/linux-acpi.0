From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v2 1/4] ACPICA: Tables: Fix regression introduced by a
 too early mechanism enabling
Date: Fri, 28 Apr 2017 05:30:13 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CE9A104@SHSMSX101.ccr.corp.intel.com>
References: <5361b51c7c257b3216475018a3a5cc4f8b6b21c6.1493281247.git.lv.zheng@intel.com>
 <cb4a8f21633a8369c1fb22ec165e1363c109b873.1493357044.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:8676 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163775AbdD1FaR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 28 Apr 2017 01:30:17 -0400
In-Reply-To: <cb4a8f21633a8369c1fb22ec165e1363c109b873.1493357044.git.lv.zheng@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>

The revision looks wrong.
It's actually v3 from my side.
Please drop this.
I'll re-format the series.
Sorry for the noise.

Thanks
Lv

> From: Zheng, Lv
> Sent: Friday, April 28, 2017 1:27 PM
> Subject: [PATCH v2 1/4] ACPICA: Tables: Fix regression introduced by a too early mechanism enabling
> 
> In the Linux kernel side, acpi_get_table() clones haven't been fully
> balanced by acpi_put_table() invocations. In ACPICA side, due to the design
> change, there are also unbalanced acpi_get_table_by_index() invocations
> requiring special care.
> 
> So it is not a good timing to report acpi_get_table() counting errors. The
> strict balanced validation count check should only be enabled after
> confirming that all invocations are safe and compliant to their designed
> purposes.
> 
> Thus this patch removes the fatal error along with the error report to
> fix this issue. Reported by Dan Williams, fixed by Lv Zheng.
> 
> Fixes: 174cc7187e6f ("ACPICA: Tables: Back port acpi_get_table_with_size() and
> early_acpi_os_unmap_memory() from Linux kernel")
> Cc: Dan Williams <dan.j.williams@intel.com>
> Reported-by: Anush Seetharaman <anush.seetharaman@intel.com>
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> ---
>  drivers/acpi/acpica/tbutils.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
> index 5a968a7..7abe665 100644
> --- a/drivers/acpi/acpica/tbutils.c
> +++ b/drivers/acpi/acpica/tbutils.c
> @@ -418,11 +418,7 @@ acpi_tb_get_table(struct acpi_table_desc *table_desc,
> 
>  	table_desc->validation_count++;
>  	if (table_desc->validation_count == 0) {
> -		ACPI_ERROR((AE_INFO,
> -			    "Table %p, Validation count is zero after increment\n",
> -			    table_desc));
>  		table_desc->validation_count--;
> -		return_ACPI_STATUS(AE_LIMIT);
>  	}
> 
>  	*out_table = table_desc->pointer;
> --
> 2.7.4

