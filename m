From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPICA / Interpreter: Remove redundant newline
Date: Wed, 14 Sep 2016 03:11:29 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886A1849EF@SHSMSX101.ccr.corp.intel.com>
References: <20160909161253.30952-1-bp@alien8.de>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E4F34B4@ORSMSX110.amr.corp.intel.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37E4F34E9@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:40764 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754835AbcINDLk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 13 Sep 2016 23:11:40 -0400
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37E4F34E9@ORSMSX110.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>"Moore, Robert" <robert.moore@intel.com>, Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Box, David E" <david.e.box@intel.com>

Hi,

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Moore,
> Robert
> David E <david.e.box@intel.com>
> Subject: RE: [PATCH] ACPICA / Interpreter: Remove redundant newline
> 
> Well, I never thought I would write a couple lines of code like this, but here is a solution that
> should make everyone happy.
> 
> diff --git a/source/components/tables/tbxfload.c b/source/components/tables/tbxfload.c
> index 6a937b1..73ee1a2 100644
> --- a/source/components/tables/tbxfload.c
> +++ b/source/components/tables/tbxfload.c
> @@ -334,7 +334,7 @@ AcpiTbLoadNamespace (
>      if (!TablesFailed)
>      {
>          ACPI_INFO ((
> -            "%u ACPI AML tables successfully acquired and loaded\n",
> +            "%u ACPI AML tables successfully acquired and loaded",
>              TablesLoaded));
>      }
>      else
> @@ -348,6 +348,11 @@ AcpiTbLoadNamespace (
>          Status = AE_CTRL_TERMINATE;
>      }
> 
> +#ifdef ACPI_APPLICATION
> +    ACPI_DEBUG_PRINT_RAW ((ACPI_DB_INIT, "\n"));
> +#endif
> +
> +

IMO, these lines should be in ACPICA upstream, in a file under tools/acpiexec.

Thanks
Lv

>  UnlockAndExit:
>      (void) AcpiUtReleaseMutex (ACPI_MTX_TABLES);
>      return_ACPI_STATUS (Status);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
