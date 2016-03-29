From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPICA: Remove unnecessary "\n" from an ACPI_INFO boot
 message
Date: Tue, 29 Mar 2016 19:09:57 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37E455538@ORSMSX110.amr.corp.intel.com>
References: <74bc15316c48bb33c0954d94c0595720ee0955bd.1459187689.git.bristot@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:63439 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753403AbcC2TKI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Mar 2016 15:10:08 -0400
In-Reply-To: <74bc15316c48bb33c0954d94c0595720ee0955bd.1459187689.git.bristot@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Bristot de Oliveira <bristot@redhat.com>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Actually, I did in fact put that there to break up the output after the tables are loaded. Is this a problem?


> -----Original Message-----
> From: Daniel Bristot de Oliveira [mailto:bristot@redhat.com]
> Sent: Monday, March 28, 2016 10:59 AM
> To: Moore, Robert; Zheng, Lv; Wysocki, Rafael J; Len Brown
> Cc: linux-acpi@vger.kernel.org; devel@acpica.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] ACPICA: Remove unnecessary "\n" from an ACPI_INFO boot
> message
> 
> A "\n" at the end of bellow ACPI_INFO message is causing a blank line in
> the kernel log:
> 
>   ACPI_INFO(("%u ACPI AML tables successfully acquired and loaded\n",
> tables_loaded));
> 
> This patch removes the "\n".
> 
> Kernel log before this patch:
> 	ACPI: Core revision 20160108
> 	ACPI: 2 ACPI AML tables successfully acquired and loaded
> 
> 	Security Framework initialized
> 
> Kernel log after this patch:
> 	ACPI: Core revision 20160108
> 	ACPI: 2 ACPI AML tables successfully acquired and loaded
> 	Security Framework initialized
> 
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> 
> diff --git a/drivers/acpi/acpica/tbxfload.c
> b/drivers/acpi/acpica/tbxfload.c index 3151968..e435b84 100644
> --- a/drivers/acpi/acpica/tbxfload.c
> +++ b/drivers/acpi/acpica/tbxfload.c
> @@ -240,7 +240,8 @@ acpi_status acpi_tb_load_namespace(void)
>  	}
> 
>  	if (!tables_failed) {
> -		ACPI_INFO(("%u ACPI AML tables successfully acquired and
> loaded\n", tables_loaded));
> +		ACPI_INFO(("%u ACPI AML tables successfully acquired and
> loaded",
> +			   tables_loaded));
>  	} else {
>  		ACPI_ERROR((AE_INFO,
>  			    "%u table load failures, %u successful",
> --
> 2.5.0

