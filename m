From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPI: change acpi_sleep_proc_init() to return void.
Date: Mon, 14 Sep 2015 03:32:36 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E8832D1FF55@SHSMSX101.ccr.corp.intel.com>
References: <1441982962-7299-1-git-send-email-ramirose@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:34397 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752890AbbINDde convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 13 Sep 2015 23:33:34 -0400
In-Reply-To: <1441982962-7299-1-git-send-email-ramirose@gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rami Rosen <ramirose@gmail.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi,

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Rami Rosen
> Sent: Friday, September 11, 2015 10:49 PM
> 
> This patch changes the type of the return value of the acpi_sleep_proc_init()
> method to be void, as this method never fails and its return value is never
> used.
> 
> Signed-off-by: Rami Rosen <ramirose@gmail.com>
> ---
>  drivers/acpi/internal.h | 4 ++--
>  drivers/acpi/proc.c     | 4 +---
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 9e42621..685bcb6 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -179,13 +179,13 @@ static inline int acpi_sleep_init(void) { return -ENXIO; }
>  #endif
> 
>  #ifdef CONFIG_ACPI_SLEEP
> -int acpi_sleep_proc_init(void);
> +void acpi_sleep_proc_init(void);
>  int suspend_nvs_alloc(void);
>  void suspend_nvs_free(void);
>  int suspend_nvs_save(void);
>  void suspend_nvs_restore(void);
>  #else
> -static inline int acpi_sleep_proc_init(void) { return 0; }
> +static inline void acpi_sleep_proc_init(void) { return 0; }

Has this line been tested?

Thanks
-Lv

>  static inline int suspend_nvs_alloc(void) { return 0; }
>  static inline void suspend_nvs_free(void) {}
>  static inline int suspend_nvs_save(void) { return 0; }
> diff --git a/drivers/acpi/proc.c b/drivers/acpi/proc.c
> index 75c28ea..2a35815 100644
> --- a/drivers/acpi/proc.c
> +++ b/drivers/acpi/proc.c
> @@ -144,11 +144,9 @@ static const struct file_operations acpi_system_wakeup_device_fops = {
>  	.release = single_release,
>  };
> 
> -int __init acpi_sleep_proc_init(void)
> +void __init acpi_sleep_proc_init(void)
>  {
>  	/* 'wakeup device' [R/W] */
>  	proc_create("wakeup", S_IFREG | S_IRUGO | S_IWUSR,
>  		    acpi_root_dir, &acpi_system_wakeup_device_fops);
> -
> -	return 0;
>  }
> --
> 2.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
