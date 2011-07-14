From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH 09/17] ACPI, APEI, Add APEI bit support in generic _OSC
 call
Date: Thu, 14 Jul 2011 10:48:37 -0400
Message-ID: <20110714144837.GB3080@redhat.com>
References: <1310534068-30547-1-git-send-email-ying.huang@intel.com>
 <1310534068-30547-10-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:61680 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754696Ab1GNOsn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Jul 2011 10:48:43 -0400
Content-Disposition: inline
In-Reply-To: <1310534068-30547-10-git-send-email-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org

On Wed, Jul 13, 2011 at 01:14:20PM +0800, Huang Ying wrote:
> In APEI firmware first mode, hardware error is reported by hardware to
> firmware firstly, then firmware reports the error to Linux in a GHES
> error record via POLL/SCI/IRQ/NMI etc.
> 
> This may result in some issues if OS has no full APEI support.  So
> some firmware implementation will work in a back-compatible mode by
> default.  Where firmware will only notify OS in old-fashion, without
> GHES record.  For example, for a fatal hardware error, only NMI is
> signaled, no GHES record.
> 
> To gain full APEI power on these machines, APEI bit in generic _OSC
> call can be specified to tell firmware that Linux has full APEI
> support.  This patch adds the APEI bit support in generic _OSC call.

I have been testing this patch for a couple of weeks with no issues that I
have seen.  Without it (and/or the next one), APEI can't really work.

Tested-and-reviewed-by: Don Zickus <dzickus@redhat.com>

> 
> Signed-off-by: Huang Ying <ying.huang@intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Matthew Garrett <mjg@redhat.com>
> ---
>  drivers/acpi/bus.c   |   16 ++++++++++++++--
>  include/linux/acpi.h |    2 ++
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -39,6 +39,7 @@
>  #include <linux/pci.h>
>  #include <acpi/acpi_bus.h>
>  #include <acpi/acpi_drivers.h>
> +#include <acpi/apei.h>
>  #include <linux/dmi.h>
>  #include <linux/suspend.h>
>  
> @@ -519,6 +520,7 @@ out_kfree:
>  }
>  EXPORT_SYMBOL(acpi_run_osc);
>  
> +bool osc_sb_apei_support_acked;
>  static u8 sb_uuid_str[] = "0811B06E-4A27-44F9-8D60-3CBBC22E7B48";
>  static void acpi_bus_osc_support(void)
>  {
> @@ -541,11 +543,21 @@ static void acpi_bus_osc_support(void)
>  #if defined(CONFIG_ACPI_PROCESSOR) || defined(CONFIG_ACPI_PROCESSOR_MODULE)
>  	capbuf[OSC_SUPPORT_TYPE] |= OSC_SB_PPC_OST_SUPPORT;
>  #endif
> +
> +#ifdef CONFIG_ACPI_APEI_GHES
> +	if (!ghes_disable)
> +		capbuf[OSC_SUPPORT_TYPE] |= OSC_SB_APEI_SUPPORT;
> +#endif
>  	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handle)))
>  		return;
> -	if (ACPI_SUCCESS(acpi_run_osc(handle, &context)))
> +	if (ACPI_SUCCESS(acpi_run_osc(handle, &context))) {
> +		u32 *capbuf_ret = context.ret.pointer;
> +		if (context.ret.length > OSC_SUPPORT_TYPE)
> +			osc_sb_apei_support_acked =
> +				capbuf_ret[OSC_SUPPORT_TYPE] & OSC_SB_APEI_SUPPORT;
>  		kfree(context.ret.pointer);
> -	/* do we need to check the returned cap? Sounds no */
> +	}
> +	/* do we need to check other returned cap? Sounds no */
>  }
>  
>  /* --------------------------------------------------------------------------
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -280,6 +280,8 @@ acpi_status acpi_run_osc(acpi_handle han
>  #define OSC_SB_CPUHP_OST_SUPPORT	8
>  #define OSC_SB_APEI_SUPPORT		16
>  
> +extern bool osc_sb_apei_support_acked;
> +
>  /* PCI defined _OSC bits */
>  /* _OSC DW1 Definition (OS Support Fields) */
>  #define OSC_EXT_PCI_CONFIG_SUPPORT		1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
