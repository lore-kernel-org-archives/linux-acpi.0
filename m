From: Len Brown <lenb@kernel.org>
Subject: Re: [patch] ACPI: Remove duplicate definitions for _STA bits
Date: Wed, 25 Apr 2007 14:16:14 -0400
Message-ID: <200704251416.14655.lenb@kernel.org>
References: <200704201056.48764.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52471 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423366AbXDYSRe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Apr 2007 14:17:34 -0400
In-Reply-To: <200704201056.48764.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Naveen B S <naveen.b.s@intel.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>

Applied.

thanks,
-Len

On Friday 20 April 2007 12:56, Bjorn Helgaas wrote:
> No need to duplicate the existing definitions in include/acpi/actypes.h.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> Index: w/drivers/acpi/acpi_memhotplug.c
> ===================================================================
> --- w.orig/drivers/acpi/acpi_memhotplug.c	2007-04-19 21:14:41.000000000 -0600
> +++ w/drivers/acpi/acpi_memhotplug.c	2007-04-19 21:25:33.000000000 -0600
> @@ -44,11 +44,6 @@
>  MODULE_DESCRIPTION("Hotplug Mem Driver");
>  MODULE_LICENSE("GPL");
>  
> -/* ACPI _STA method values */
> -#define ACPI_MEMORY_STA_PRESENT		(0x00000001UL)
> -#define ACPI_MEMORY_STA_ENABLED		(0x00000002UL)
> -#define ACPI_MEMORY_STA_FUNCTIONAL	(0x00000008UL)
> -
>  /* Memory Device States */
>  #define MEMORY_INVALID_STATE	0
>  #define MEMORY_POWER_ON_STATE	1
> @@ -204,9 +199,9 @@
>  	 * Check for device status. Device should be
>  	 * present/enabled/functioning.
>  	 */
> -	if (!((current_status & ACPI_MEMORY_STA_PRESENT)
> -	      && (current_status & ACPI_MEMORY_STA_ENABLED)
> -	      && (current_status & ACPI_MEMORY_STA_FUNCTIONAL)))
> +	if (!((current_status & ACPI_STA_DEVICE_PRESENT)
> +	      && (current_status & ACPI_STA_DEVICE_ENABLED)
> +	      && (current_status & ACPI_STA_DEVICE_FUNCTIONING)))
>  		return -ENODEV;
>  
>  	return 0;
> @@ -286,7 +281,7 @@
>  		return -ENODEV;
>  
>  	/* Check for device status.  Device should be disabled */
> -	if (current_status & ACPI_MEMORY_STA_ENABLED)
> +	if (current_status & ACPI_STA_DEVICE_ENABLED)
>  		return -EINVAL;
>  
>  	return 0;
> Index: w/drivers/acpi/container.c
> ===================================================================
> --- w.orig/drivers/acpi/container.c	2007-04-19 21:14:41.000000000 -0600
> +++ w/drivers/acpi/container.c	2007-04-19 21:14:44.000000000 -0600
> @@ -49,8 +49,6 @@
>  MODULE_DESCRIPTION("ACPI container driver");
>  MODULE_LICENSE("GPL");
>  
> -#define ACPI_STA_PRESENT		(0x00000001)
> -
>  static int acpi_container_add(struct acpi_device *device);
>  static int acpi_container_remove(struct acpi_device *device, int type);
>  
> @@ -75,13 +73,13 @@
>  
>  	status = acpi_get_handle(handle, "_STA", &temp);
>  	if (ACPI_FAILURE(status))
> -		return 1;	/* _STA not found, assmue device present */
> +		return 1;	/* _STA not found, assume device present */
>  
>  	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
>  	if (ACPI_FAILURE(status))
>  		return 0;	/* Firmware error */
>  
> -	return ((sta & ACPI_STA_PRESENT) == ACPI_STA_PRESENT);
> +	return ((sta & ACPI_STA_DEVICE_PRESENT) == ACPI_STA_DEVICE_PRESENT);
>  }
>  
>  /*******************************************************************/
> Index: w/drivers/acpi/processor_core.c
> ===================================================================
> --- w.orig/drivers/acpi/processor_core.c	2007-04-19 21:14:41.000000000 -0600
> +++ w/drivers/acpi/processor_core.c	2007-04-19 21:14:44.000000000 -0600
> @@ -71,8 +71,6 @@
>  #define ACPI_PROCESSOR_LIMIT_USER	0
>  #define ACPI_PROCESSOR_LIMIT_THERMAL	1
>  
> -#define ACPI_STA_PRESENT 0x00000001
> -
>  #define _COMPONENT		ACPI_PROCESSOR_COMPONENT
>  ACPI_MODULE_NAME("processor_core");
>  
> @@ -780,7 +778,7 @@
>  
>  
>  	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
> -	if (ACPI_FAILURE(status) || !(sta & ACPI_STA_PRESENT)) {
> +	if (ACPI_FAILURE(status) || !(sta & ACPI_STA_DEVICE_PRESENT)) {
>  		ACPI_EXCEPTION((AE_INFO, status, "Processor Device is not present"));
>  		return 0;
>  	}
> 
