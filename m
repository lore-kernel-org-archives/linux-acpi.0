From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 3/3] x86/platform/intel-mid: Add special handling of
 ACPI HW reduced platforms
Date: Wed, 17 Jan 2018 19:43:52 +0200
Message-ID: <1516211032.7000.1049.camel@linux.intel.com>
References: <20180117173409.88136-1-andriy.shevchenko@linux.intel.com>
         <20180117173409.88136-3-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:12987 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754123AbeAQRn4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 Jan 2018 12:43:56 -0500
In-Reply-To: <20180117173409.88136-3-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2018-01-17 at 19:34 +0200, Andy Shevchenko wrote:
> When switching to ACPI HW reduced platforms we still want to
> initialize timers.
> Override acpi_reduced_hw_init() to achieve that.

Just realized, that it may annihilate the other acpi_reduced_hw_init()
on non-MID platforms...

Open to suggestions how would be better to deal with this (I really
don't like the idea to spread MID quirks all over the code).

P.S. Patch 2 from the series still makes sense per se.

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/platform/intel-mid/intel-mid.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/x86/platform/intel-mid/intel-mid.c
> b/arch/x86/platform/intel-mid/intel-mid.c
> index 2c67bae6bb53..51bf2f6c9e97 100644
> --- a/arch/x86/platform/intel-mid/intel-mid.c
> +++ b/arch/x86/platform/intel-mid/intel-mid.c
> @@ -13,6 +13,7 @@
>  
>  #define pr_fmt(fmt) "intel_mid: " fmt
>  
> +#include <linux/acpi.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/interrupt.h>
> @@ -172,6 +173,14 @@ static unsigned char
> intel_mid_get_nmi_reason(void)
>  	return 0;
>  }
>  
> +void __init acpi_reduced_hw_init(void)
> +{
> +	/*
> +	 * Do nothing for now as everything needed done in
> +	 * x86_intel_mid_early_setup() below.
> +	 */
> +}
> +
>  /*
>   * Moorestown specific x86_init function overrides and early setup
>   * calls.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
