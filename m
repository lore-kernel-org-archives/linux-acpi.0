From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH -mm] ACPI: use more understandable bus_id for ACPI devices
Date: Fri, 5 Jan 2007 23:38:19 -0500
Message-ID: <200701052338.19204.lenb@kernel.org>
References: <1167894198.5725.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41261 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751171AbXAFEiy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 5 Jan 2007 23:38:54 -0500
In-Reply-To: <1167894198.5725.8.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org

applied to sysfs branch.

thanks,
-Len

On Thursday 04 January 2007 02:03, Zhang Rui wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> 
> Some of the ACPI devices use the internal fake hids which are exposed to userspace as devces' bus_id after sysfs conversion.
> To make it more friendly, we convert them to more understandable strings.
> 
> For those devices w/o PNPids, we use "device:instance_no" as the bus_id
> instead of "PNPIDNON:instance_no".
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/scan.c         |    6 +++---
>  include/acpi/acpi_bus.h     |    2 +-
>  include/acpi/acpi_drivers.h |   16 ++++++++--------
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> Index: linux-2.6.20-rc2-mm1/drivers/acpi/scan.c
> ===================================================================
> --- linux-2.6.20-rc2-mm1.orig/drivers/acpi/scan.c	2006-12-29 14:12:08.000000000 +0800
> +++ linux-2.6.20-rc2-mm1/drivers/acpi/scan.c	2006-12-29 16:05:36.000000000 +0800
> @@ -26,7 +26,7 @@ DEFINE_SPINLOCK(acpi_device_lock);
>  LIST_HEAD(acpi_wakeup_device_list);
>  
>  struct acpi_device_bus_id{
> -	char bus_id[9];
> +	char bus_id[15];
>  	unsigned int instance_no;
>  	struct list_head node;
>  };
> @@ -342,7 +342,7 @@ static int acpi_device_register(struct a
>  	 * If failed, create one and link it into acpi_bus_id_list
>  	 */
>  	list_for_each_entry(acpi_device_bus_id, &acpi_bus_id_list, node) {
> -		if(!strcmp(acpi_device_bus_id->bus_id, device->flags.hardware_id? device->pnp.hardware_id : "PNPIDNON")) {
> +		if(!strcmp(acpi_device_bus_id->bus_id, device->flags.hardware_id? device->pnp.hardware_id : "device")) {
>  			acpi_device_bus_id->instance_no ++;
>  			found = 1;
>  			kfree(new_bus_id);
> @@ -351,7 +351,7 @@ static int acpi_device_register(struct a
>  	}
>  	if(!found) {
>  		acpi_device_bus_id = new_bus_id;
> -		strcpy(acpi_device_bus_id->bus_id, device->flags.hardware_id ? device->pnp.hardware_id : "PNPIDNON");
> +		strcpy(acpi_device_bus_id->bus_id, device->flags.hardware_id ? device->pnp.hardware_id : "device");
>  		acpi_device_bus_id->instance_no = 0;
>  		list_add_tail(&acpi_device_bus_id->node, &acpi_bus_id_list);
>  	}
> Index: linux-2.6.20-rc2-mm1/include/acpi/acpi_bus.h
> ===================================================================
> --- linux-2.6.20-rc2-mm1.orig/include/acpi/acpi_bus.h	2006-12-29 14:12:10.000000000 +0800
> +++ linux-2.6.20-rc2-mm1/include/acpi/acpi_bus.h	2006-12-29 14:22:29.000000000 +0800
> @@ -184,7 +184,7 @@ struct acpi_device_dir {
>  
>  typedef char acpi_bus_id[5];
>  typedef unsigned long acpi_bus_address;
> -typedef char acpi_hardware_id[9];
> +typedef char acpi_hardware_id[15];
>  typedef char acpi_unique_id[9];
>  typedef char acpi_device_name[40];
>  typedef char acpi_device_class[20];
> Index: linux-2.6.20-rc2-mm1/include/acpi/acpi_drivers.h
> ===================================================================
> --- linux-2.6.20-rc2-mm1.orig/include/acpi/acpi_drivers.h	2006-12-29 14:12:10.000000000 +0800
> +++ linux-2.6.20-rc2-mm1/include/acpi/acpi_drivers.h	2006-12-29 14:29:25.000000000 +0800
> @@ -36,15 +36,15 @@
>  
>  /* _HID definitions */
>  
> -#define ACPI_POWER_HID			"ACPI_PWR"
> -#define ACPI_PROCESSOR_HID		"ACPI_CPU"
> -#define ACPI_SYSTEM_HID			"ACPI_SYS"
> -#define ACPI_THERMAL_HID		"ACPI_THM"
> -#define ACPI_BUTTON_HID_POWERF		"ACPI_FPB"
> -#define ACPI_BUTTON_HID_SLEEPF		"ACPI_FSB"
> +#define ACPI_POWER_HID			"power_resource"
> +#define ACPI_PROCESSOR_HID		"processor"
> +#define ACPI_SYSTEM_HID			"acpi_system"
> +#define ACPI_THERMAL_HID		"thermal"
> +#define ACPI_BUTTON_HID_POWERF		"button_power"
> +#define ACPI_BUTTON_HID_SLEEPF		"button_sleep"
>  
> -#define ACPI_VIDEO_HID			"ACPI_VID"
> -#define ACPI_BAY_HID			"ACPI_BAY"
> +#define ACPI_VIDEO_HID			"video"
> +#define ACPI_BAY_HID			"bay"
>  /* --------------------------------------------------------------------------
>                                         PCI
>     -------------------------------------------------------------------------- */
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
