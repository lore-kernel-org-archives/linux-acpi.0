From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [patch] ACPI: call init functions explicitly instead of using
	initcalls
Date: Thu, 30 Oct 2008 10:01:43 +0800
Message-ID: <1225332103.5189.298.camel@yakui_zhao.sh.intel.com>
References: <200810291525.58218.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12097 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752821AbYJ3BzN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Oct 2008 21:55:13 -0400
In-Reply-To: <200810291525.58218.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>

On Thu, 2008-10-30 at 05:25 +0800, Bjorn Helgaas wrote:
> Call init_acpi_device_notify(), acpi_debug_init(), acpi_scan_init(),
> and acpi_system_init() explicitly from acpi_init() instead of using
> initcalls.  This removes some link order and initcall order dependencies.
> 
> I'm uncomfortable with the fact that we can disable ACPI after
> calling init_acpi_device_notify(), which would leave platform_notify
> and platform_notify_remove set to ACPI functions even though ACPI is
> disabled.  This patch doesn't fix that, but it doesn't make it any
> worse than it was, either.
What is the advantage after the following functions are explicitly from
acpi_init instead of using initcall?

In your patch the module link order is also changed. In current kernel
some module parameters using the same ACPI prefix are defined in the
different files. For example: acpi.debug_layer && acpi.debug_level are
defined in debug.c. The acpi.acpica_version is defined in system.c.

If they are separated by files with module parameter, there exists the
following warning message. 
     >WARNING: at /linux-2.6/fs/sysfs/dir.c:463
>sysfs_add_one+0x33/0x39()
>sysfs: duplicate filename 'acpi' can not be created


> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---
>  drivers/acpi/Makefile |    9 +++++----
>  drivers/acpi/acpi.h   |   15 +++++++++++++++
>  drivers/acpi/bus.c    |   15 +++++++++++++++
>  drivers/acpi/debug.c  |   16 ++++++++--------
>  drivers/acpi/glue.c   |    8 +++-----
>  drivers/acpi/scan.c   |   10 +++-------
>  drivers/acpi/system.c |   10 ++--------
>  7 files changed, 51 insertions(+), 32 deletions(-)
>  create mode 100644 drivers/acpi/acpi.h
> 
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index d91c027..edd6f75 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -19,7 +19,7 @@ obj-y				+= tables.o
>  obj-$(CONFIG_X86)		+= blacklist.o
>  
>  #
> -# ACPI Core Subsystem (Interpreter)
> +# ACPI CA Core Subsystem (Interpreter)
>  #
>  obj-y				+= osl.o utils.o reboot.o\
>  				   dispatcher/ events/ executer/ hardware/ \
> @@ -36,8 +36,10 @@ processor-objs	+= processor_perflib.o
>  endif
>  
>  obj-y				+= sleep/
> -obj-y				+= bus.o glue.o
> -obj-y				+= scan.o
> +obj-y				+= bus.o scan.o
> +obj-y				+= glue.o
> +obj-$(CONFIG_ACPI_DEBUG)	+= debug.o
> +
>  # Keep EC driver first. Initialization of others depend on it.
>  obj-$(CONFIG_ACPI_EC)		+= ec.o
>  obj-$(CONFIG_ACPI_AC) 		+= ac.o
> @@ -53,7 +55,6 @@ obj-$(CONFIG_ACPI_CONTAINER)	+= container.o
>  obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
>  obj-$(CONFIG_ACPI_POWER)	+= power.o
>  obj-$(CONFIG_ACPI_SYSTEM)	+= system.o event.o
> -obj-$(CONFIG_ACPI_DEBUG)	+= debug.o
>  obj-$(CONFIG_ACPI_NUMA)		+= numa.o
>  obj-$(CONFIG_ACPI_WMI)		+= wmi.o
>  obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
> diff --git a/drivers/acpi/acpi.h b/drivers/acpi/acpi.h
> new file mode 100644
> index 0000000..8ef1ed5
> --- /dev/null
> +++ b/drivers/acpi/acpi.h
> @@ -0,0 +1,15 @@
> +/*
> + * (c) Copyright 2008 Hewlett-Packard Development Company, L.P.
> + *	Bjorn Helgaas <bjorn.helgaas@hp.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/* Functions internal to the ACPI core */
> +
> +int init_acpi_device_notify(void);
> +int acpi_debug_init(void);
> +int acpi_scan_init(void);
> +int acpi_system_init(void);
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index c797c64..469dcc7 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -39,6 +39,8 @@
>  #include <acpi/acpi_bus.h>
>  #include <acpi/acpi_drivers.h>
>  
> +#include "acpi.h"
> +
>  #define _COMPONENT		ACPI_BUS_COMPONENT
>  ACPI_MODULE_NAME("bus");
>  
> @@ -854,6 +856,7 @@ static int __init acpi_init(void)
>  		acpi_kobj = NULL;
>  	}
>  
> +	init_acpi_device_notify();
>  	result = acpi_bus_init();
>  
>  	if (!result) {
> @@ -868,11 +871,23 @@ static int __init acpi_init(void)
>  		}
>  	} else
>  		disable_acpi();
> +
>  	/*
>  	 * If the laptop falls into the DMI check table, the power state check
>  	 * will be disabled in the course of device power transistion.
>  	 */
>  	dmi_check_system(power_nocheck_dmi_table);
> +
> +	if (acpi_disabled)
> +		return result;
> +
> +#ifdef CONFIG_ACPI_DEBUG
> +	acpi_debug_init();
> +#endif
> +	acpi_scan_init();
> +#ifdef CONFIG_ACPI_SYSTEM
> +	acpi_system_init();
> +#endif
>  	return result;
>  }
>  
> diff --git a/drivers/acpi/debug.c b/drivers/acpi/debug.c
> index abf36b4..5f642fa 100644
> --- a/drivers/acpi/debug.c
> +++ b/drivers/acpi/debug.c
> @@ -11,6 +11,8 @@
>  #include <acpi/acpi_drivers.h>
>  #include <acpi/acglobal.h>
>  
> +#include "acpi.h"
> +
>  #define _COMPONENT		ACPI_SYSTEM_COMPONENT
>  ACPI_MODULE_NAME("debug");
>  
> @@ -283,17 +285,15 @@ acpi_system_write_debug(struct file *file,
>  
>  	return count;
>  }
> +#endif
>  
> -static int __init acpi_debug_init(void)
> +int __init acpi_debug_init(void)
>  {
> +#ifdef CONFIG_ACPI_PROCFS
>  	struct proc_dir_entry *entry;
>  	int error = 0;
>  	char *name;
>  
> -
> -	if (acpi_disabled)
> -		return 0;
> -
>  	/* 'debug_layer' [R/W] */
>  	name = ACPI_SYSTEM_FILE_DEBUG_LAYER;
>  	entry =
> @@ -324,7 +324,7 @@ static int __init acpi_debug_init(void)
>  	remove_proc_entry(ACPI_SYSTEM_FILE_DEBUG_LAYER, acpi_root_dir);
>  	error = -ENODEV;
>  	goto Done;
> -}
> -
> -subsys_initcall(acpi_debug_init);
> +#else
> +	return 0;
>  #endif
> +}
> diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
> index 24649ad..6f2dcdf 100644
> --- a/drivers/acpi/glue.c
> +++ b/drivers/acpi/glue.c
> @@ -12,6 +12,8 @@
>  #include <linux/rwsem.h>
>  #include <linux/acpi.h>
>  
> +#include "acpi.h"
> +
>  #define ACPI_GLUE_DEBUG	0
>  #if ACPI_GLUE_DEBUG
>  #define DBG(x...) printk(PREFIX x)
> @@ -246,10 +248,8 @@ static int acpi_platform_notify_remove(struct device *dev)
>  	return 0;
>  }
>  
> -static int __init init_acpi_device_notify(void)
> +int init_acpi_device_notify(void)
>  {
> -	if (acpi_disabled)
> -		return 0;
>  	if (platform_notify || platform_notify_remove) {
>  		printk(KERN_ERR PREFIX "Can't use platform_notify\n");
>  		return 0;
> @@ -258,5 +258,3 @@ static int __init init_acpi_device_notify(void)
>  	platform_notify_remove = acpi_platform_notify_remove;
>  	return 0;
>  }
> -
> -arch_initcall(init_acpi_device_notify);
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index a9dda8e..1f605dd 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -12,6 +12,8 @@
>  #include <acpi/acpi_drivers.h>
>  #include <acpi/acinterp.h>	/* for acpi_ex_eisa_id_to_string() */
>  
> +#include "acpi.h"
> +
>  #define _COMPONENT		ACPI_BUS_COMPONENT
>  ACPI_MODULE_NAME("scan");
>  #define STRUCT_TO_INT(s)	(*((int*)&s))
> @@ -1566,15 +1568,11 @@ static int acpi_bus_scan_fixed(struct acpi_device *root)
>  }
>  
> 
> -static int __init acpi_scan_init(void)
> +int __init acpi_scan_init(void)
>  {
>  	int result;
>  	struct acpi_bus_ops ops;
>  
> -
> -	if (acpi_disabled)
> -		return 0;
> -
>  	memset(&ops, 0, sizeof(ops));
>  	ops.acpi_op_add = 1;
>  	ops.acpi_op_start = 1;
> @@ -1607,5 +1605,3 @@ static int __init acpi_scan_init(void)
>        Done:
>  	return result;
>  }
> -
> -subsys_initcall(acpi_scan_init);
> diff --git a/drivers/acpi/system.c b/drivers/acpi/system.c
> index 1d74171..8ade31c 100644
> --- a/drivers/acpi/system.c
> +++ b/drivers/acpi/system.c
> @@ -626,20 +626,14 @@ static int acpi_system_procfs_init(void)
>  }
>  #endif
>  
> -static int __init acpi_system_init(void)
> +int __init acpi_system_init(void)
>  {
> -	int result = 0;
> -
> -	if (acpi_disabled)
> -		return 0;
> +	int result;
>  
>  	result = acpi_system_procfs_init();
>  	if (result)
>  		return result;
>  
>  	result = acpi_system_sysfs_init();
> -
>  	return result;
>  }
> -
> -subsys_initcall(acpi_system_init);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

