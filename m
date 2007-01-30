From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/3] [-mm]: ACPI: add a Kconfig option for ACPI  procfs interface
Date: Tue, 30 Jan 2007 02:47:31 -0500
Message-ID: <200701300247.31640.lenb@kernel.org>
References: <1170039750.6907.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39336 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965143AbXA3Hsv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Jan 2007 02:48:51 -0500
In-Reply-To: <1170039750.6907.9.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>

applied 1-3 to acpi-test

thanks,
-Len

On Sunday 28 January 2007 22:02, Zhang Rui wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> 
> Add a kconfig option CONFIG_ACPI_PROCFS to make procfs interface
> a configurable attribute of ACPI.
> 
> No procfs interface is actually deprecated,
> and no sysfs interface is added in this patch.
> 
> CONGI_ACPI_PROCFS is used to mark procfs interface as deprecated
> once the same function is duplicated in sysfs.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  Documentation/feature-removal-schedule.txt |    9 +++++++++
>  drivers/acpi/Kconfig                       |   10 ++++++++++
>  2 files changed, 19 insertions(+)
> 
> Index: linux-2.6.20-rc4-mm1/drivers/acpi/Kconfig
> ===================================================================
> --- linux-2.6.20-rc4-mm1.orig/drivers/acpi/Kconfig	2007-01-29 09:24:14.000000000 +0800
> +++ linux-2.6.20-rc4-mm1/drivers/acpi/Kconfig	2007-01-29 09:24:17.000000000 +0800
> @@ -77,6 +77,16 @@ config ACPI_SLEEP_PROC_SLEEP
>  	  Create /proc/acpi/sleep
>  	  Deprecated by /sys/power/state
>  
> +config ACPI_PROCFS
> +	bool "Procfs interface (deprecated)"
> +	depends on ACPI
> +	default y
> +	---help---
> +	  Procfs interface for ACPI is made optional for back-compatible.
> +	  As the same functions are duplicated in sysfs interface
> +	  and this proc interface will be removed some time later,
> +	  it's marked as deprecated.
> +
>  config ACPI_AC
>  	tristate "AC Adapter"
>  	depends on X86
> Index: linux-2.6.20-rc4-mm1/Documentation/feature-removal-schedule.txt
> ===================================================================
> --- linux-2.6.20-rc4-mm1.orig/Documentation/feature-removal-schedule.txt	2007-01-29 09:24:14.000000000 +0800
> +++ linux-2.6.20-rc4-mm1/Documentation/feature-removal-schedule.txt	2007-01-29 09:27:02.000000000 +0800
> @@ -264,3 +264,12 @@ Why:   OSS drivers with ALSA replacement
>  Who:   Adrian Bunk <bunk@stusta.de>
>  
>  ---------------------------
> +
> +What:	ACPI procfs interface
> +When:	July 2007
> +Why:	After ACPI sysfs conversion, ACPI attributes will be duplicated
> +	in sysfs and the ACPI procfs interface should be removed.
> +Who:	Zhang Rui <rui.zhang@intel.com>
> +
> +---------------------------
> +
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
