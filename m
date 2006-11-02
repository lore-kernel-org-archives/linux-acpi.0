From: Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] swsusp: Use platform mode by default
Date: Wed, 1 Nov 2006 22:40:12 -0500
Message-ID: <200611012240.13412.len.brown@intel.com>
References: <200611011323.14830.rjw@sisk.pl>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:64676 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1752625AbWKBDiK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Nov 2006 22:38:10 -0500
In-Reply-To: <200611011323.14830.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-acpi@vger.kernel.org, Stefan Seyfried <seife@suse.de>

Applied.

thanks,
-Len

On Wednesday 01 November 2006 07:23, Rafael J. Wysocki wrote:
> It has been reported that on some systems the functionality after a resume
> from disk is limited if the system is simply powered off during the suspend
> instead of using the ACPI S4 suspend (aka platform mode).
> 
> Unfortunately the default is currently to power off the system during the
> suspend so the users of these systems experience problems after the resume
> if they don't switch to the platform mode explicitly.  This patch makes swsusp
> use the platform mode by default to avoid such situations.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  kernel/power/disk.c |    8 +++++---
>  kernel/power/main.c |    2 +-
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> Index: linux-2.6.19-rc4-mm1/kernel/power/main.c
> ===================================================================
> --- linux-2.6.19-rc4-mm1.orig/kernel/power/main.c
> +++ linux-2.6.19-rc4-mm1/kernel/power/main.c
> @@ -29,7 +29,7 @@
>  DECLARE_MUTEX(pm_sem);
>  
>  struct pm_ops *pm_ops;
> -suspend_disk_method_t pm_disk_mode = PM_DISK_SHUTDOWN;
> +suspend_disk_method_t pm_disk_mode = PM_DISK_PLATFORM;
>  
>  /**
>   *	pm_set_ops - Set the global power method table. 
> Index: linux-2.6.19-rc4-mm1/kernel/power/disk.c
> ===================================================================
> --- linux-2.6.19-rc4-mm1.orig/kernel/power/disk.c
> +++ linux-2.6.19-rc4-mm1/kernel/power/disk.c
> @@ -62,9 +62,11 @@ static void power_down(suspend_disk_meth
>  
>  	switch(mode) {
>  	case PM_DISK_PLATFORM:
> -		kernel_shutdown_prepare(SYSTEM_SUSPEND_DISK);
> -		error = pm_ops->enter(PM_SUSPEND_DISK);
> -		break;
> +		if (pm_ops && pm_ops->enter) {
> +			kernel_shutdown_prepare(SYSTEM_SUSPEND_DISK);
> +			error = pm_ops->enter(PM_SUSPEND_DISK);
> +			break;
> +		}
>  	case PM_DISK_SHUTDOWN:
>  		kernel_power_off();
>  		break;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
