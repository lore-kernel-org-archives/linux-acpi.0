From: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: [patch 17/26] acpi: ia64: wake on LAN fix
Date: Fri, 31 Mar 2006 23:26:33 +0200
Message-ID: <20060331212633.GC30044@electric-eye.fr.zoreil.com>
References: <200603282203.k2SM3nUC027701@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:42129 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1751412AbWCaV2s
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 31 Mar 2006 16:28:48 -0500
Content-Disposition: inline
In-Reply-To: <200603282203.k2SM3nUC027701@shell0.pdx.osdl.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, takeuchi_satoru@jp.fujitsu.com, tony.luck@intel.com

akpm@osdl.org <akpm@osdl.org> :
> 
> From: Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com>
> 
> Currently wakeup capability is available if and only if
> CONFIG_ACPI_SLEEP=y.  But S5 is not a sleep state.  This patch makes ACPI
> subsystem to be able to wakeup from S5 state even if sleep mode is not
> supported.
[...]
> diff -puN drivers/acpi/sleep/Makefile~acpi-ia64-wake-on-lan-fix drivers/acpi/sleep/Makefile
> --- devel/drivers/acpi/sleep/Makefile~acpi-ia64-wake-on-lan-fix	2006-03-28 14:03:06.000000000 -0800
> +++ devel-akpm/drivers/acpi/sleep/Makefile	2006-03-28 14:03:06.000000000 -0800
> @@ -1,5 +1,4 @@
> -obj-y					:= poweroff.o wakeup.o
> +obj-y					:= poweroff.o wakeup.o proc.o
>  obj-$(CONFIG_ACPI_SLEEP)		+= main.o
> -obj-$(CONFIG_ACPI_SLEEP_PROC_FS)	+= proc.o

$ less drivers/acpi/Kconfig
[...]
config ACPI_SLEEP_PROC_SLEEP
        bool "/proc/acpi/sleep (deprecated)"
        depends on ACPI_SLEEP_PROC_FS

The current patch would always build in a deprecated feature, right ?

-- 
Ueimor
