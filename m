From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH]: ACPI: Disable Fixed_RTC event when installing RTC handler
Date: Wed, 14 May 2008 00:33:05 -0400
Message-ID: <200805140033.05877.lenb@kernel.org>
References: <1191814518.3830.2.camel@yakui_zhao.sh.intel.com> <200710092343.40843.lenb@kernel.org> <1210735979.7932.14.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36349 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192AbYENEdP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 May 2008 00:33:15 -0400
In-Reply-To: <1210735979.7932.14.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org

Applied.

thanks,
-Len

On Tuesday 13 May 2008, Zhao Yakui wrote:
> Subject:ACPI: Disable Fixed_RTC event when installing RTC handler
> >From : Zhao Yakui <yakui.zhao@intel.com>
> 
> The Fixed_RTC event should be disabled when installing RTC handler.
> Only when RTC alarm is set will it be enabled again. If it is not 
> disabled, maybe some machines will be powered on automatically after 
> the system is shutdown even when the RTC alarm is not set.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=10010
> 
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> 
> ---
>  drivers/acpi/glue.c       |    6 ++++++
>  drivers/acpi/sleep/proc.c |    6 ++++++
>  2 files changed, 12 insertions(+)
> 
> Index: linux-2.6/drivers/acpi/glue.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/glue.c
> +++ linux-2.6/drivers/acpi/glue.c
> @@ -272,6 +272,12 @@ static u32 rtc_handler(void *context)
>  static inline void rtc_wake_setup(void)
>  {
>  	acpi_install_fixed_event_handler(ACPI_EVENT_RTC, rtc_handler, NULL);
> +	/*
> +	 * After the RTC handler is installed, the Fixed_RTC event should
> +	 * be disabled. Only when the RTC alarm is set will it be enabled.
> +	 */
> +	acpi_clear_event(ACPI_EVENT_RTC);
> +	acpi_disable_event(ACPI_EVENT_RTC, 0);
>  }
>  
>  static void rtc_wake_on(struct device *dev)
> Index: linux-2.6/drivers/acpi/sleep/proc.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/sleep/proc.c
> +++ linux-2.6/drivers/acpi/sleep/proc.c
> @@ -495,6 +495,12 @@ static int __init acpi_sleep_proc_init(v
>  		    acpi_root_dir, &acpi_system_alarm_fops);
>  
>  	acpi_install_fixed_event_handler(ACPI_EVENT_RTC, rtc_handler, NULL);
> +	/*
> +	 * Disable the RTC event after installing RTC handler.
> +	 * Only when RTC alarm is set will it be enabled.
> +	 */
> +	acpi_clear_event(ACPI_EVENT_RTC);
> +	acpi_disable_event(ACPI_EVENT_RTC, 0);
>  #endif				/* HAVE_ACPI_LEGACY_ALARM */
>  
>  	/* 'wakeup device' [R/W] */
> 
> 


