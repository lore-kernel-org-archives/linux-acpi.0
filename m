From: Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] fixing wrong comment
Date: Mon, 6 Nov 2006 15:18:41 -0500
Message-ID: <200611061518.41388.len.brown@intel.com>
References: <87mz7aupmu.wl%takeuchi_satoru@jp.fujitsu.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46824 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1753328AbWKFUQI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Nov 2006 15:16:08 -0500
In-Reply-To: <87mz7aupmu.wl%takeuchi_satoru@jp.fujitsu.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

Applied.

thanks,
-Len

On Thursday 02 November 2006 05:08, Satoru Takeuchi wrote:
> Fixing wrong description for acpi_gpe_sleep_prepare().
> 
> acpi_gpe_sleep_prepare() had only used on power off and was changed
> to also used on entering some sleep state. However its description
> isn't changed yet.
> 
> Signed-off-by: Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com>
> 
> Index: linux-2.6.19-rc4/drivers/acpi/sleep/wakeup.c
> ===================================================================
> --- linux-2.6.19-rc4.orig/drivers/acpi/sleep/wakeup.c	2006-11-02 18:25:49.000000000 +0900
> +++ linux-2.6.19-rc4/drivers/acpi/sleep/wakeup.c	2006-11-02 18:30:42.000000000 +0900
> @@ -183,11 +183,11 @@ late_initcall(acpi_wakeup_device_init);
>  #endif
>  
>  /*
> - * Disable all wakeup GPEs before power off.
> - * 
> + * Disable all wakeup GPEs before entering requested sleep state.
> + *	@sleep_state:	ACPI state
>   * Since acpi_enter_sleep_state() will disable all
>   * RUNTIME GPEs, we simply mark all GPES that
> - * are not enabled for wakeup from S5 as RUNTIME.
> + * are not enabled for wakeup from requested state as RUNTIME.
>   */
>  void acpi_gpe_sleep_prepare(u32 sleep_state)
>  {
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
