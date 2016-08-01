From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH -next] ACPI / EC: Add missing destroy_workqueue() on
 error in acpi_ec_init()
Date: Mon, 1 Aug 2016 00:39:10 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BC082BE@SHSMSX101.ccr.corp.intel.com>
References: <1469807604-32204-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:23521 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168AbcHAAja convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 31 Jul 2016 20:39:30 -0400
In-Reply-To: <1469807604-32204-1-git-send-email-weiyj.lk@gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi, Yongjun

Thanks for the report.

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Wei Yongjun
> Subject: [PATCH -next] ACPI / EC: Add missing destroy_workqueue() on
> error in acpi_ec_init()
> 
> Add the missing destroy_workqueue() before return from
> acpi_ec_init() in the error handling case.
> 
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
> ---
>  drivers/acpi/ec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 9267554..853a55d 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -1676,8 +1676,10 @@ int __init acpi_ec_init(void)
> 
>  	/* Now register the driver for the EC */
>  	result = acpi_bus_register_driver(&acpi_ec_driver);
> -	if (result < 0)
> +	if (result < 0) {
> +		destroy_workqueue(ec_query_wq);
[Lv Zheng] 
I think we should also set ec_query_wq = NULL.

>  		return -ENODEV;
> +	}
> 
[Lv Zheng] 
And probably could collect all cleanup code here before returning.

Thanks
Lv

>  	return result;
>  }
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
