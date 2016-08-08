From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPICA: Remove unnecessary '\n' in the end of ACPI_INFO
 output
Date: Mon, 8 Aug 2016 00:55:54 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BC0AEDE@SHSMSX101.ccr.corp.intel.com>
References: <20160806172749.6315-1-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56984 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751955AbcHHAz6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Aug 2016 20:55:58 -0400
In-Reply-To: <20160806172749.6315-1-kuleshovmail@gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>, "Moore, Robert" <robert.moore@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

> From: Alexander Kuleshov [mailto:kuleshovmail@gmail.com]
> Subject: [PATCH] ACPICA: Remove unnecessary '\n' in the end of
> ACPI_INFO output
> 
> as the ACPI_INFO already prints `\n` in the end itself.
[Lv Zheng] 
Looks good.
Acked-by: Lv Zheng <lv.zheng@intel.com>
However this patch should go through ACPICA upstream.

Thanks
-Lv

> 
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
>  drivers/acpi/acpica/tbxfload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
> index ac71abc..e7119b7 100644
> --- a/drivers/acpi/acpica/tbxfload.c
> +++ b/drivers/acpi/acpica/tbxfload.c
> @@ -240,7 +240,7 @@ acpi_status acpi_tb_load_namespace(void)
>  	}
> 
>  	if (!tables_failed) {
> -		ACPI_INFO(("%u ACPI AML tables successfully acquired and
> loaded\n", tables_loaded));
> +		ACPI_INFO(("%u ACPI AML tables successfully acquired and
> loaded", tables_loaded));
>  	} else {
>  		ACPI_ERROR((AE_INFO,
>  			    "%u table load failures, %u successful",
> --
> 2.8.0.rc3.1353.gea9bdc0

