From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 2/3] ACPI: table upgrade: move early_initrd_acpi_init()
 to header file
Date: Wed, 18 May 2016 01:08:06 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BBA2DBF@SHSMSX101.ccr.corp.intel.com>
References: <1463486765-31827-1-git-send-email-aleksey.makarov@linaro.org>
 <1463486765-31827-3-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:22782 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751842AbcERBIW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 May 2016 21:08:22 -0400
In-Reply-To: <1463486765-31827-3-git-send-email-aleksey.makarov@linaro.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>, Russell King <linux@arm.linux.org.uk>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Graeme Gregory <graeme.gregory@linaro.org>, Jon Masters <jcm@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>

Hi,

> From: Aleksey Makarov [mailto:aleksey.makarov@linaro.org]
> Subject: [PATCH 2/3] ACPI: table upgrade: move early_initrd_acpi_init() to
> header file
> 
> Move early_initrd_acpi_init() to header file so that
> it can be used with architectures other than X86
[Lv Zheng] 
The patch looks OK to me.
Except 2 possible improvements.
You can feel free to add Acked-by: Lv Zheng <lv.zheng@intel.com>

> 
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
> ---
>  arch/x86/kernel/setup.c | 7 -------
>  drivers/acpi/tables.c   | 7 +++++--
>  include/linux/acpi.h    | 4 ++--
>  3 files changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index c4e7b39..5ddbbfd 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -399,10 +399,6 @@ static void __init reserve_initrd(void)
>  	memblock_free(ramdisk_image, ramdisk_end - ramdisk_image);
>  }
> 
> -static void __init early_initrd_acpi_init(void)
> -{
> -	early_acpi_table_init((void *)initrd_start, initrd_end - initrd_start);
> -}
>  #else
>  static void __init early_reserve_initrd(void)
>  {
> @@ -410,9 +406,6 @@ static void __init early_reserve_initrd(void)
>  static void __init reserve_initrd(void)
>  {
>  }
> -static void __init early_initrd_acpi_init(void)
> -{
> -}
>  #endif /* CONFIG_BLK_DEV_INITRD */
> 
>  static void __init parse_setup_data(void)
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 449a649..82be84a 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -34,6 +34,7 @@
>  #include <linux/bootmem.h>
>  #include <linux/earlycpio.h>
>  #include <linux/memblock.h>
> +#include <linux/initrd.h>
>  #include "internal.h"
> 
>  #ifdef CONFIG_ACPI_CUSTOM_DSDT
> @@ -742,9 +743,11 @@ acpi_os_table_override(struct acpi_table_header
> *existing_table,
>  	return AE_OK;
>  }
> 
> -void __init early_acpi_table_init(void *data, size_t size)
> +void __init early_initrd_acpi_init(void)
>  {
> -	acpi_table_initrd_init(data, size);
> +#ifdef CONFIG_BLK_DEV_INITRD
> +	acpi_table_initrd_init((void *)initrd_start, initrd_end - initrd_start);
> +#endif
>  }
[Lv Zheng] 
Please avoid to make #ifdef appearing in a function body.
You may consider a way to maintain #ifdef CONFIG_xxx at function boundary.
The point is:
#ifdef should be maintained at the function boundary, this is an implicit (maybe explicit in Documentation) programming rule in Linux.
This helps to split the "functionality" and the "dependency" to make the code cleaner and easier to follow.

For this case, you may:
#ifdef CONFIG_BLK_DEV_INTRD
#define ACPI_TABLE_INITRD_DATA	(initrd_start)
#define ACPI_TABLE_INITRD_SIZE	(initrd_end - initrd_start)
#else
#define ACPI_TABLE_INITRD_DATA	NULL
#define ACPI_TABLE_INITRD_SIZE	0
#endif

Or you can:
Use initrd_start, inird_end directly in acpi_table_initrd_init, and delete its arguments.
By doing so, you are able to achieve in-function #ifdef elimination by providing a stub for acpi_table_initrd_init().

> 
>  /*
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 288fac5..cb700c1 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -208,7 +208,7 @@ void acpi_boot_table_init (void);
>  int acpi_mps_check (void);
>  int acpi_numa_init (void);
> 
> -void early_acpi_table_init(void *data, size_t size);
> +void early_initrd_acpi_init(void);
>  int acpi_table_init (void);
>  int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
>  int __init acpi_parse_entries(char *id, unsigned long table_size,
> @@ -588,7 +588,7 @@ static inline const char *acpi_dev_name(struct
> acpi_device *adev)
>  	return NULL;
>  }
> 
> -static inline void early_acpi_table_init(void *data, size_t size) { }
> +static inline void early_initrd_acpi_init(void) { }
>  static inline void acpi_early_init(void) { }
>  static inline void acpi_subsystem_init(void) { }
> 
[Lv Zheng] 
You can rename early_initrd_acpi_init to early_acpi_table_init.
We'd prefer not to export "initrd" awareness from acpi.h.

Thanks and best regards
-Lv

> --
> 2.8.2

