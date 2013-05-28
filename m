From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPICA: Remove redundant macro defines for
 ACPI_DEBUG_PRINT() and ACPI_DEBUG_PRINT_RAW()
Date: Tue, 28 May 2013 17:07:55 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E36FE78E65@ORSMSX103.amr.corp.intel.com>
References: <51A08098.1090807@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25539 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934854Ab3E1RKN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 May 2013 13:10:13 -0400
In-Reply-To: <51A08098.1090807@linaro.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Jiang Liu <liuj97@gmail.com>

This was fixed some time ago in the main ACPICA source, and should have made it into Linux by now.


> -----Original Message-----
> From: Hanjun Guo [mailto:hanjun.guo@linaro.org]
> Sent: Saturday, May 25, 2013 2:13 AM
> To: Zheng, Lv
> Cc: Wysocki, Rafael J; Moore, Robert; linux-acpi@vger.kernel.org;
> patches@linaro.org; linaro-kernel@lists.linaro.org; Jiang Liu
> Subject: [PATCH] ACPICA: Remove redundant macro defines for
> ACPI_DEBUG_PRINT() and ACPI_DEBUG_PRINT_RAW()
> 
> In commit 0377b5acba2 (ACPICA: Merge all debug output macros into a single
> file, acoutput.), the patch introduces redundant macro defines for
> ACPI_DEBUG_PRINT() and ACPI_DEBUG_PRINT_RAW(), just remove it.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  include/acpi/acoutput.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h index
> 4f52ea7..e1c7474 100644
> --- a/include/acpi/acoutput.h
> +++ b/include/acpi/acoutput.h
> @@ -447,8 +447,6 @@
>  #define ACPI_DUMP_TABLES(a, b)
>  #define ACPI_DUMP_PATHNAME(a, b, c, d)
>  #define ACPI_DUMP_BUFFER(a, b)
> -#define ACPI_DEBUG_PRINT(pl)
> -#define ACPI_DEBUG_PRINT_RAW(pl)
>  #define ACPI_IS_DEBUG_ENABLED(level, component) 0
> 
>  /* Return macros must have a return statement at the minimum */
> -- 1.8.2.1
