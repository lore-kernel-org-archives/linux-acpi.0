From: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Subject: Re: Runtime GPEs not saved over suspend/resume if type != "platform"
Date: Thu, 26 Oct 2006 17:21:43 +0400
Message-ID: <4540B667.6090707@linux.intel.com>
References: <1C601A6A3344064EB423D0C1E83B717B5C5954@pdsmsx411.ccr.corp.intel.com> <453F9252.9060404@linux.intel.com> <200610252054.32945.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:14440 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1161145AbWJZNVr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Oct 2006 09:21:47 -0400
In-Reply-To: <200610252054.32945.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>, "Brown, Len" <len.brown@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>

Both yours and mine patches suffer from the same problem -- it's not possible to write
to "/sys/power/disk" any longer, as all values other than PM_DISK_PLATFORM would be rejected :)
Still want to hear a word from subsystem maintainers on this issue... :(

Regards,
	Alex.

Rafael J. Wysocki wrote:
> On Wednesday, 25 October 2006 18:35, Alexey Starikovskiy wrote:
>> Here is a least intrusive patch by my opinion...
>> Just copy pm_disk_mode from pm_ops supplied by platform.
>> ACPI sets it to PM_DISK_PLATFORM if it has S4,
>> and it should be zero otherwise, patch does not copy it then.
> 
> Well, I think the appended patch is sufficient.
> 
> If "platform" is unavailable it has no effect and works like "shutdown".
> 
> Greetings,
> Rafael
> 
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  kernel/power/disk.c |    8 +++++---
>  kernel/power/main.c |    2 +-
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> Index: linux-2.6.19-rc2-mm2/kernel/power/main.c
> ===================================================================
> --- linux-2.6.19-rc2-mm2.orig/kernel/power/main.c
> +++ linux-2.6.19-rc2-mm2/kernel/power/main.c
> @@ -28,7 +28,7 @@
>  DECLARE_MUTEX(pm_sem);
>  
>  struct pm_ops *pm_ops;
> -suspend_disk_method_t pm_disk_mode = PM_DISK_SHUTDOWN;
> +suspend_disk_method_t pm_disk_mode = PM_DISK_PLATFORM;
>  
>  /**
>   *	pm_set_ops - Set the global power method table. 
> Index: linux-2.6.19-rc2-mm2/kernel/power/disk.c
> ===================================================================
> --- linux-2.6.19-rc2-mm2.orig/kernel/power/disk.c
> +++ linux-2.6.19-rc2-mm2/kernel/power/disk.c
> @@ -61,9 +61,11 @@ static void power_down(suspend_disk_meth
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
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
