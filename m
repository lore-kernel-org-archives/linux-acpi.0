From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPICA / Interpreter: Remove redundant newline
Date: Fri, 9 Sep 2016 18:26:17 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E4F34B4@ORSMSX110.amr.corp.intel.com>
References: <20160909161253.30952-1-bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160909161253.30952-1-bp@alien8.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>
List-Id: linux-acpi@vger.kernel.org

Is this a big deal?

We do this on purpose for AcpiExec, to make the screen output more readable.


> -----Original Message-----
> From: Borislav Petkov [mailto:bp@alien8.de]
> Sent: Friday, September 9, 2016 9:13 AM
> To: LKML <linux-kernel@vger.kernel.org>
> Cc: Moore, Robert <robert.moore@intel.com>; Zheng, Lv
> <lv.zheng@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>;
> Len Brown <lenb@kernel.org>; linux-acpi@vger.kernel.org;
> devel@acpica.org
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
> diff --git a/drivers/acpi/acpica/tbxfload.c
> b/drivers/acpi/acpica/tbxfload.c index ac71abcd32bb..e7119b7ccd79 100644
> --- a/drivers/acpi/acpica/tbxfload.c
> +++ b/drivers/acpi/acpica/tbxfload.c
> @@ -240,7 +240,7 @@ acpi_status acpi_tb_load_namespace(void)
>  	}
> 
>  	if (!tables_failed) {
> -		ACPI_INFO(("%u ACPI AML tables successfully acquired and
> loaded\n", tables_loaded));
> +		ACPI_INFO(("%u ACPI AML tables successfully acquired and
> loaded",
> +tables_loaded));
>  	} else {
>  		ACPI_ERROR((AE_INFO,
>  			    "%u table load failures, %u successful",
> --
> 2.10.0
