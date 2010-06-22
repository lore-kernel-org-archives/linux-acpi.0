From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 4/4 V2] ACPI: introduce module parameter acpi.aml_debug
Date: Mon, 21 Jun 2010 23:09:14 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1006212307400.26824@localhost.localdomain>
References: <1276328790.19052.17845.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:64157 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab0FVDJY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jun 2010 23:09:24 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L4E00A4TBFHTEB0@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 21 Jun 2010 22:09:18 -0500 (CDT)
In-reply-to: <1276328790.19052.17845.camel@rzhang1-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

On Sat, 12 Jun 2010, Zhang Rui wrote:

> 
> 
> Introduce module parameter acpi.aml_debug.
> 
> With acpi.aml_debug set, we can get AML debug object output
> (Store (AAA, Debug)), even with CONFIG_ACPI_DEBUG cleared.
> 
> Together with the runtime custom method mechanism,
> we can debug AML code problems without rebuilding the kernel.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  Documentation/acpi/method-customizing.txt |    2 ++
>  drivers/acpi/debugfs.c                    |   21 +++++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> Index: linux-2.6/drivers/acpi/debugfs.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/debugfs.c
> +++ linux-2.6/drivers/acpi/debugfs.c
> @@ -9,6 +9,27 @@
>  #define _COMPONENT		ACPI_SYSTEM_COMPONENT
>  ACPI_MODULE_NAME("debugfs");
>  
> +static int param_set_aml_debug(const char *val, struct kernel_param *kp)
> +{
> +	if (!strncmp(val, "1\n", 2))
> +		acpi_gbl_enable_aml_debug_object = 1;
> +	else if (!strncmp(val, "0\n", 2))
> +		acpi_gbl_enable_aml_debug_object = 0;
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int param_get_aml_debug(char *buffer, struct kernel_param *kp)
> +{
> +	if (acpi_gbl_enable_aml_debug_object)
> +		return sprintf(buffer, "1");
> +	else
> +		return sprintf(buffer, "0");
> +}
> +
> +module_param_call(aml_debug, param_set_aml_debug, param_get_aml_debug, NULL, 0644);

lets do this with a simple module_param instead.
We can change the type of acpi_gbl_enable_aml_debug_object from u8
if we need to diverge from acpica.  Maybe we can use a #define
in aclinux.h to change it to a more friendly modparam,
such as aml_debug_object?

thanks,
-Len Brown, Intel Open Source Technology Center

>  /* --------------------------------------------------------------------------
>  				DebugFS Interface
>     -------------------------------------------------------------------------- */
> Index: linux-2.6/Documentation/acpi/method-customizing.txt
> ===================================================================
> --- linux-2.6.orig/Documentation/acpi/method-customizing.txt
> +++ linux-2.6/Documentation/acpi/method-customizing.txt
> @@ -19,6 +19,8 @@ Note: Only ACPI METHOD can be overridden
>        "Device", "OperationRegion", are not recognized.
>  Note: The same ACPI control method can be overridden for many times,
>        and it's always the latest one that used by Linux/kernel.
> +Note: To get the ACPI debug object output (Store (AAAA, Debug)),
> +      please run "echo 1 > /sys/module/acpi/parameters/aml_debug".
>  
>  1. override an existing method
>     a) get the ACPI table via ACPI sysfs I/F. e.g. to get the DSDT,
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
