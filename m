From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPICA / Interpreter: Remove redundant newline
Date: Wed, 14 Sep 2016 03:09:25 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886A1849D8@SHSMSX101.ccr.corp.intel.com>
References: <20160909161253.30952-1-bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:11176 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751091AbcINDJb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 13 Sep 2016 23:09:31 -0400
In-Reply-To: <20160909161253.30952-1-bp@alien8.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>

The newline is intentional for acpiexec.
So you should fix this issue in acpiexec, aka, in ACPICA upstream.

Thanks
Lv

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Borislav
> Petkov
> Subject: [PATCH] ACPICA / Interpreter: Remove redundant newline
> 
> From: Borislav Petkov <bp@suse.de>
> 
> acpi_info() already issues a '\n' so remove it in the call.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Robert Moore <robert.moore@intel.com>
> Cc: Lv Zheng <lv.zheng@intel.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Cc: devel@acpica.org
> ---
>  drivers/acpi/acpica/tbxfload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
> index ac71abcd32bb..e7119b7ccd79 100644
> --- a/drivers/acpi/acpica/tbxfload.c
> +++ b/drivers/acpi/acpica/tbxfload.c
> @@ -240,7 +240,7 @@ acpi_status acpi_tb_load_namespace(void)
>  	}
> 
>  	if (!tables_failed) {
> -		ACPI_INFO(("%u ACPI AML tables successfully acquired and loaded\n", tables_loaded));
> +		ACPI_INFO(("%u ACPI AML tables successfully acquired and loaded", tables_loaded));
>  	} else {
>  		ACPI_ERROR((AE_INFO,
>  			    "%u table load failures, %u successful",
> --
> 2.10.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
