From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [PATCH] acpi: simplify module_param namespace
Date: Mon, 09 Mar 2009 10:20:44 +0800
Message-ID: <1236565244.7060.7.camel@localhost.localdomain>
References: <200903071328.28113.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22235 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751749AbZCICTm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 8 Mar 2009 22:19:42 -0400
In-Reply-To: <200903071328.28113.rusty@rustcorp.com.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sat, 2009-03-07 at 10:58 +0800, Rusty Russell wrote:
> (I've been holding this for a while: if you really hate it I'll delete it)
> 
> Rather than overriding MODULE_PARAM_PREFIX, build via acpi.o so
> KBUILD_MODNAME is set to "acpi".
> 
> This is the logical way to do it, even though acpi cannot be a module
> due to these config options being bool.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> ---
>  drivers/acpi/Makefile |   10 ++++++----
>  drivers/acpi/debug.c  |    5 -----
>  drivers/acpi/power.c  |    4 ----
>  drivers/acpi/system.c |    4 ----
>  4 files changed, 6 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -14,8 +14,13 @@ obj-$(CONFIG_X86)		+= blacklist.o
>  #
>  # ACPI Core Subsystem (Interpreter)
>  #
> -obj-y				+= osl.o utils.o reboot.o\
> +obj-y				+= acpi.o \
>  					acpica/

If so, it can't be guaranteed that the EC driver is initialized before
the power resource driver.

> +
> +# "acpi." module_param namespace.
> +acpi-y				+= osl.o utils.o reboot.o power.o \
> +					system.o event.o
> +acpi-$(CONFIG_ACPI_DEBUG)	+= debug.o
>  
>  # sleep related files
>  obj-y				+= wakeup.o
> @@ -51,9 +56,6 @@ obj-$(CONFIG_ACPI_PROCESSOR)	+= processo
>  obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
>  obj-$(CONFIG_ACPI_CONTAINER)	+= container.o
>  obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
> -obj-y				+= power.o
> -obj-y				+= system.o event.o
> -obj-$(CONFIG_ACPI_DEBUG)	+= debug.o
>  obj-$(CONFIG_ACPI_NUMA)		+= numa.o
>  obj-$(CONFIG_ACPI_HOTPLUG_MEMORY)	+= acpi_memhotplug.o
>  obj-$(CONFIG_ACPI_PROCFS_POWER)	+= cm_sbs.o
> diff --git a/drivers/acpi/debug.c b/drivers/acpi/debug.c
> --- a/drivers/acpi/debug.c
> +++ b/drivers/acpi/debug.c
> @@ -12,11 +12,6 @@
>  
>  #define _COMPONENT		ACPI_SYSTEM_COMPONENT
>  ACPI_MODULE_NAME("debug");
> -
> -#ifdef MODULE_PARAM_PREFIX
> -#undef MODULE_PARAM_PREFIX
> -#endif
> -#define MODULE_PARAM_PREFIX "acpi."
>  
>  struct acpi_dlayer {
>  	const char *name;
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -54,10 +54,6 @@ ACPI_MODULE_NAME("power");
>  #define ACPI_POWER_RESOURCE_STATE_ON	0x01
>  #define ACPI_POWER_RESOURCE_STATE_UNKNOWN 0xFF
>  
> -#ifdef MODULE_PARAM_PREFIX
> -#undef MODULE_PARAM_PREFIX
> -#endif
> -#define MODULE_PARAM_PREFIX "acpi."
>  int acpi_power_nocheck;
>  module_param_named(power_nocheck, acpi_power_nocheck, bool, 000);
>  
> diff --git a/drivers/acpi/system.c b/drivers/acpi/system.c
> --- a/drivers/acpi/system.c
> +++ b/drivers/acpi/system.c
> @@ -33,10 +33,6 @@
>  
>  #define _COMPONENT		ACPI_SYSTEM_COMPONENT
>  ACPI_MODULE_NAME("system");
> -#ifdef MODULE_PARAM_PREFIX
> -#undef MODULE_PARAM_PREFIX
> -#endif
> -#define MODULE_PARAM_PREFIX "acpi."
>  
>  #define ACPI_SYSTEM_CLASS		"system"
>  #define ACPI_SYSTEM_DEVICE_NAME		"System"
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

