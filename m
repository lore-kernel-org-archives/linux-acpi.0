From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC] [PATCH] ACPI: use unique ACPI device names in procfs
Date: Wed, 15 Aug 2007 23:26:09 -0400
Message-ID: <200708152326.09901.lenb@kernel.org>
References: <1185923082.3993.7.camel@rzhang-asus.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54887 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756640AbXHPD0T (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Aug 2007 23:26:19 -0400
In-Reply-To: <1185923082.3993.7.camel@rzhang-asus.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org

NAK.

Lets leave /proc/acpi as alone as we can,
and focus on getting the video driver properly supported in sysfs.

thanks,
-Len

On Tuesday 31 July 2007 19:04, Zhang Rui wrote:
> Use unique device names in procfs.
> 
> Device name is not unique in /proc/acpi.
> http://bugzilla.kernel.org/show_bug.cgi?id=8798
> 
> Use acpi_device->dev.bus_id instead of
> acpi_device->pnp.bus_id, like what we've done in sysfs.
> 
> ACPI proc I/F will change a lot with this patch applied.
> But as /proc/acpi/... won't be removed in a short time,
> I still think it's worth doing.
> 
> Does this patch miss something?
> Or are there any better ideas to make the ACPI device name
> unique in procfs?
> 
> Any comments are appreciated. Thanks.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/bus.c        |   29 +++++++++++++++--------------
>  drivers/acpi/power.c      |   10 +++++-----
>  drivers/acpi/sbs.c        |    2 +-
>  drivers/acpi/scan.c       |    2 +-
>  drivers/acpi/sleep/proc.c |   19 ++++++++++---------
>  drivers/acpi/thermal.c    |    6 +++---
>  include/acpi/acpi_bus.h   |    4 ++--
>  7 files changed, 37 insertions(+), 35 deletions(-)
> 
> Index: linux-2.6.23-rc1/drivers/acpi/thermal.c
> ===================================================================
> --- linux-2.6.23-rc1.orig/drivers/acpi/thermal.c
> +++ linux-2.6.23-rc1/drivers/acpi/thermal.c
> @@ -834,7 +834,7 @@ static int acpi_thermal_trip_seq_show(st
>  		for (j = 0; j < tz->trips.passive.devices.count; j++) {
>  			status = acpi_bus_get_device(tz->trips.passive.devices.
>  						     handles[j], &device);
> -			seq_printf(seq, "%4.4s ", status ? "" :
> +			seq_printf(seq, "%s ", status ? "" :
>  				   acpi_device_bid(device));
>  		}
>  		seq_puts(seq, "\n");
> @@ -850,7 +850,7 @@ static int acpi_thermal_trip_seq_show(st
>  			status = acpi_bus_get_device(tz->trips.active[i].
>  						     devices.handles[j],
>  						     &device);
> -			seq_printf(seq, "%4.4s ", status ? "" :
> +			seq_printf(seq, "%s", status ? "" :
>  				   acpi_device_bid(device));
>  		}
>  		seq_puts(seq, "\n");
> @@ -1163,7 +1163,7 @@ static int acpi_thermal_add(struct acpi_
>  		return -ENOMEM;
>  
>  	tz->device = device;
> -	strcpy(tz->name, device->pnp.bus_id);
> +	strcpy(tz->name, acpi_device_bid(device));
>  	strcpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
>  	strcpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
>  	acpi_driver_data(device) = tz;
> Index: linux-2.6.23-rc1/include/acpi/acpi_bus.h
> ===================================================================
> --- linux-2.6.23-rc1.orig/include/acpi/acpi_bus.h
> +++ linux-2.6.23-rc1/include/acpi/acpi_bus.h
> @@ -182,7 +182,7 @@ struct acpi_device_dir {
>  
>  /* Plug and Play */
>  
> -typedef char acpi_bus_id[5];
> +typedef char acpi_bus_id[BUS_ID_SIZE];
>  typedef unsigned long acpi_bus_address;
>  typedef char acpi_hardware_id[15];
>  typedef char acpi_unique_id[9];
> @@ -199,7 +199,7 @@ struct acpi_device_pnp {
>  	acpi_device_class device_class;	/*        "          */
>  };
>  
> -#define acpi_device_bid(d)	((d)->pnp.bus_id)
> +#define acpi_device_bid(d)	((d)->dev.bus_id)
>  #define acpi_device_adr(d)	((d)->pnp.bus_address)
>  #define acpi_device_hid(d)	((d)->pnp.hardware_id)
>  #define acpi_device_uid(d)	((d)->pnp.unique_id)
> Index: linux-2.6.23-rc1/drivers/acpi/sbs.c
> ===================================================================
> --- linux-2.6.23-rc1.orig/drivers/acpi/sbs.c
> +++ linux-2.6.23-rc1/drivers/acpi/sbs.c
> @@ -424,7 +424,7 @@ static int acpi_check_update_proc(struct
>  static int acpi_sbs_generate_event(struct acpi_device *device,
>  				   int event, int state, char *bid, char *class)
>  {
> -	char bid_saved[5];
> +	char bid_saved[BUS_ID_SIZE];
>  	char class_saved[20];
>  	int result = 0;
>  
> Index: linux-2.6.23-rc1/drivers/acpi/bus.c
> ===================================================================
> --- linux-2.6.23-rc1.orig/drivers/acpi/bus.c
> +++ linux-2.6.23-rc1/drivers/acpi/bus.c
> @@ -110,12 +110,13 @@ int acpi_bus_get_status(struct acpi_devi
>  	if (device->status.functional && !device->status.present) {
>  		printk(KERN_WARNING PREFIX "Device [%s] status [%08x]: "
>  		       "functional but not present; setting present\n",
> -		       device->pnp.bus_id, (u32) STRUCT_TO_INT(device->status));
> +		       acpi_device_bid(device),
> +		       (u32) STRUCT_TO_INT(device->status));
>  		device->status.present = 1;
>  	}
>  
>  	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device [%s] status [%08x]\n",
> -			  device->pnp.bus_id,
> +			  acpi_device_bid(device),
>  			  (u32) STRUCT_TO_INT(device->status)));
>  
>  	return 0;
> @@ -168,7 +169,7 @@ int acpi_bus_get_power(acpi_handle handl
>  	}
>  
>  	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device [%s] power state is D%d\n",
> -			  device->pnp.bus_id, device->power.state));
> +			 acpi_device_bid(device), device->power.state));
>  
>  	return 0;
>  }
> @@ -261,11 +262,11 @@ int acpi_bus_set_power(acpi_handle handl
>  	if (result)
>  		printk(KERN_WARNING PREFIX
>  			      "Transitioning device [%s] to D%d\n",
> -			      device->pnp.bus_id, state);
> +			      acpi_device_bid(device), state);
>  	else
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  				  "Device [%s] transitioned to D%d\n",
> -				  device->pnp.bus_id, state));
> +				  acpi_device_bid(device), state));
>  
>  	return result;
>  }
> @@ -306,7 +307,7 @@ int acpi_bus_generate_event(struct acpi_
>  		return -ENOMEM;
>  
>  	strcpy(event->device_class, device->pnp.device_class);
> -	strcpy(event->bus_id, device->pnp.bus_id);
> +	strcpy(event->bus_id, acpi_device_bid(device));
>  	event->type = type;
>  	event->data = data;
>  
> @@ -466,7 +467,7 @@ static void acpi_bus_notify(acpi_handle 
>  	case ACPI_NOTIFY_BUS_CHECK:
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  				  "Received BUS CHECK notification for device [%s]\n",
> -				  device->pnp.bus_id));
> +				  acpi_device_bid(device)));
>  		result = acpi_bus_check_scope(device);
>  		/*
>  		 * TBD: We'll need to outsource certain events to non-ACPI
> @@ -477,7 +478,7 @@ static void acpi_bus_notify(acpi_handle 
>  	case ACPI_NOTIFY_DEVICE_CHECK:
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  				  "Received DEVICE CHECK notification for device [%s]\n",
> -				  device->pnp.bus_id));
> +				  acpi_device_bid(device)));
>  		result = acpi_bus_check_device(device, NULL);
>  		/*
>  		 * TBD: We'll need to outsource certain events to non-ACPI
> @@ -488,42 +489,42 @@ static void acpi_bus_notify(acpi_handle 
>  	case ACPI_NOTIFY_DEVICE_WAKE:
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  				  "Received DEVICE WAKE notification for device [%s]\n",
> -				  device->pnp.bus_id));
> +				  acpi_device_bid(device)));
>  		/* TBD */
>  		break;
>  
>  	case ACPI_NOTIFY_EJECT_REQUEST:
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  				  "Received EJECT REQUEST notification for device [%s]\n",
> -				  device->pnp.bus_id));
> +				  acpi_device_bid(device)));
>  		/* TBD */
>  		break;
>  
>  	case ACPI_NOTIFY_DEVICE_CHECK_LIGHT:
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  				  "Received DEVICE CHECK LIGHT notification for device [%s]\n",
> -				  device->pnp.bus_id));
> +				  acpi_device_bid(device)));
>  		/* TBD: Exactly what does 'light' mean? */
>  		break;
>  
>  	case ACPI_NOTIFY_FREQUENCY_MISMATCH:
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  				  "Received FREQUENCY MISMATCH notification for device [%s]\n",
> -				  device->pnp.bus_id));
> +				  acpi_device_bid(device)));
>  		/* TBD */
>  		break;
>  
>  	case ACPI_NOTIFY_BUS_MODE_MISMATCH:
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  				  "Received BUS MODE MISMATCH notification for device [%s]\n",
> -				  device->pnp.bus_id));
> +				  acpi_device_bid(device)));
>  		/* TBD */
>  		break;
>  
>  	case ACPI_NOTIFY_POWER_FAULT:
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  				  "Received POWER FAULT notification for device [%s]\n",
> -				  device->pnp.bus_id));
> +				  acpi_device_bid(device)));
>  		/* TBD */
>  		break;
>  
> Index: linux-2.6.23-rc1/drivers/acpi/scan.c
> ===================================================================
> --- linux-2.6.23-rc1.orig/drivers/acpi/scan.c
> +++ linux-2.6.23-rc1/drivers/acpi/scan.c
> @@ -267,7 +267,7 @@ static int acpi_device_probe(struct devi
>  			acpi_start_single_object(acpi_dev);
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  			"Found driver [%s] for device [%s]\n",
> -			acpi_drv->name, acpi_dev->pnp.bus_id));
> +			acpi_drv->name, acpi_device_bid(acpi_dev)));
>  		get_device(dev);
>  	}
>  	return ret;
> Index: linux-2.6.23-rc1/drivers/acpi/power.c
> ===================================================================
> --- linux-2.6.23-rc1.orig/drivers/acpi/power.c
> +++ linux-2.6.23-rc1/drivers/acpi/power.c
> @@ -197,7 +197,7 @@ static int acpi_power_on(acpi_handle han
>  		ref = container_of(node, struct acpi_power_reference, node);
>  		if (dev->handle == ref->device->handle) {
>  			ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device [%s] already referenced by resource [%s]\n",
> -				  dev->pnp.bus_id, resource->name));
> +				  acpi_device_bid(dev), resource->name));
>  			found = 1;
>  			break;
>  		}
> @@ -214,7 +214,7 @@ static int acpi_power_on(acpi_handle han
>  		list_add_tail(&ref->node, &resource->reference);
>  		ref->device = dev;
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device [%s] added to resource [%s] references\n",
> -			  dev->pnp.bus_id, resource->name));
> +			  acpi_device_bid(dev), resource->name));
>  	}
>  	mutex_unlock(&resource->resource_lock);
>  
> @@ -262,7 +262,7 @@ static int acpi_power_off_device(acpi_ha
>  			list_del(&ref->node);
>  			kfree(ref);
>  			ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Device [%s] removed from resource [%s] references\n",
> -			    dev->pnp.bus_id, resource->name));
> +			    acpi_device_bid(dev), resource->name));
>  			break;
>  		}
>  	}
> @@ -470,7 +470,7 @@ int acpi_power_transition(struct acpi_de
>  	if (result) {
>  		device->power.state = ACPI_STATE_UNKNOWN;
>  		printk(KERN_WARNING PREFIX "Transitioning device [%s] to D%d\n",
> -			      device->pnp.bus_id, state);
> +			      acpi_device_bid(device), state);
>  	} else {
>  	/* We shouldn't change the state till all above operations succeed */
>  		device->power.state = state;
> @@ -602,7 +602,7 @@ static int acpi_power_add(struct acpi_de
>  	resource->device = device;
>  	mutex_init(&resource->resource_lock);
>  	INIT_LIST_HEAD(&resource->reference);
> -	strcpy(resource->name, device->pnp.bus_id);
> +	strcpy(resource->name, acpi_device_bid(device));
>  	strcpy(acpi_device_name(device), ACPI_POWER_DEVICE_NAME);
>  	strcpy(acpi_device_class(device), ACPI_POWER_CLASS);
>  	acpi_driver_data(device) = resource;
> Index: linux-2.6.23-rc1/drivers/acpi/sleep/proc.c
> ===================================================================
> --- linux-2.6.23-rc1.orig/drivers/acpi/sleep/proc.c
> +++ linux-2.6.23-rc1/drivers/acpi/sleep/proc.c
> @@ -359,7 +359,7 @@ acpi_system_wakeup_device_seq_show(struc
>  {
>  	struct list_head *node, *next;
>  
> -	seq_printf(seq, "Device\tS-state\t  Status   Sysfs node\n");
> +	seq_printf(seq, "Device        \tName\tS-state\t  Status   Sysfs node\n");
>  
>  	spin_lock(&acpi_device_lock);
>  	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
> @@ -372,8 +372,8 @@ acpi_system_wakeup_device_seq_show(struc
>  		spin_unlock(&acpi_device_lock);
>  
>  		ldev = acpi_get_physical_device(dev->handle);
> -		seq_printf(seq, "%s\t  S%d\t%c%-8s  ",
> -			   dev->pnp.bus_id,
> +		seq_printf(seq, "%.15s\t%4s\t  S%d\t%c%-8s  ",
> +			   acpi_device_bid(dev), dev->pnp.bus_id,
>  			   (u32) dev->wakeup.sleep_state,
>  			   dev->wakeup.flags.run_wake ? '*' : ' ',
>  			   dev->wakeup.state.enabled ? "enabled" : "disabled");
> @@ -396,13 +396,13 @@ acpi_system_write_wakeup_device(struct f
>  				size_t count, loff_t * ppos)
>  {
>  	struct list_head *node, *next;
> -	char strbuf[5];
> -	char str[5] = "";
> +	char strbuf[BUS_ID_SIZE];
> +	char str[BUS_ID_SIZE] = "";
>  	int len = count;
>  	struct acpi_device *found_dev = NULL;
>  
> -	if (len > 4)
> -		len = 4;
> +	if (len > BUS_ID_SIZE)
> +		len = BUS_ID_SIZE;
>  
>  	if (copy_from_user(strbuf, buffer, len))
>  		return -EFAULT;
> @@ -416,7 +416,7 @@ acpi_system_write_wakeup_device(struct f
>  		if (!dev->wakeup.flags.valid)
>  			continue;
>  
> -		if (!strncmp(dev->pnp.bus_id, str, 4)) {
> +		if (!strncmp(acpi_device_bid(dev), str, BUS_ID_SIZE)) {
>  			dev->wakeup.state.enabled =
>  			    dev->wakeup.state.enabled ? 0 : 1;
>  			found_dev = dev;
> @@ -438,7 +438,8 @@ acpi_system_write_wakeup_device(struct f
>  				printk(KERN_WARNING
>  				       "ACPI: '%s' and '%s' have the same GPE, "
>  				       "can't disable/enable one seperately\n",
> -				       dev->pnp.bus_id, found_dev->pnp.bus_id);
> +				       acpi_device_bid(dev),
> +				       acpi_device_bid(found_dev));
>  				dev->wakeup.state.enabled =
>  				    found_dev->wakeup.state.enabled;
>  			}
> 
