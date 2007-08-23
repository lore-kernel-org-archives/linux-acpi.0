From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: don't send netlink events for those that go into input layer
Date: Thu, 23 Aug 2007 14:30:16 -0400
Message-ID: <200708231430.16887.lenb@kernel.org>
References: <1187803471.27227.7.camel@acpi-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55482 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765002AbXHWSa1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Aug 2007 14:30:27 -0400
In-Reply-To: <1187803471.27227.7.camel@acpi-hp.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, astarikovskiy@suse.de

I like it, Rui.

I think that upon this patch, we can start to deprecate acpi_bus_generate_event,
as every user of it is now handled by the input layer or netlink.

applied.

thanks,
-Len

On Wednesday 22 August 2007 13:24, Zhang Rui wrote:
> As a replacement of /prco/acpi/event, all ACPI events are exported to user
> space either via netlink or via input layer.
> Events that go into input layer should not be sent to netlink at the same time.
> 
> This patch introduces a new interface acpi_bus_generate_netlink_event which is
> called by devices that want to export events via netlink rather than input layer.
> 
> events that are sent via netlink:
> 	ac/battery/sbs events
> 	thermal events
> 	processor events
> 	thinkpad_acpi dock/bay events
> 
> events that are sent via input layer:
> 	video hotkey events
> 	thinkpad_acpi hotkey events
> 	button events
> 	asus_acpi/asus-laptop hotkey events
> 	sonypi/sonylaptop events
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/ac.c                 |    3 +++
>  drivers/acpi/battery.c            |    3 +++
>  drivers/acpi/bus.c                |    4 ----
>  drivers/acpi/event.c              |   13 +++++++++----
>  drivers/acpi/processor_core.c     |    7 +++++++
>  drivers/acpi/sbs.c                |    1 +
>  drivers/acpi/thermal.c            |   12 ++++++++++++
>  drivers/misc/thinkpad_acpi.c      |   20 ++++++++++++++------
>  drivers/pci/hotplug/acpiphp_ibm.c |    3 +++
>  include/acpi/acpi_bus.h           |    3 +--
>  10 files changed, 53 insertions(+), 16 deletions(-)
> 
> Index: linux-2.6.23-rc3/drivers/acpi/bus.c
> ===================================================================
> --- linux-2.6.23-rc3.orig/drivers/acpi/bus.c
> +++ linux-2.6.23-rc3/drivers/acpi/bus.c
> @@ -292,10 +292,6 @@ int acpi_bus_generate_event(struct acpi_
>  	if (!device)
>  		return -EINVAL;
>  
> -	if (acpi_bus_generate_genetlink_event(device, type, data))
> -		printk(KERN_WARNING PREFIX
> -			"Failed to generate an ACPI event via genetlink!\n");
> -
>  	/* drop event on the floor if no one's listening */
>  	if (!event_is_open)
>  		return 0;
> Index: linux-2.6.23-rc3/drivers/acpi/event.c
> ===================================================================
> --- linux-2.6.23-rc3.orig/drivers/acpi/event.c
> +++ linux-2.6.23-rc3/drivers/acpi/event.c
> @@ -147,7 +147,8 @@ static struct genl_multicast_group acpi_
>  	.name = ACPI_GENL_MCAST_GROUP_NAME,
>  };
>  
> -int acpi_bus_generate_genetlink_event(struct acpi_device *device,
> +int acpi_bus_generate_netlink_event(const char *device_class,
> +				      const char *bus_id,
>  				      u8 type, int data)
>  {
>  	struct sk_buff *skb;
> @@ -191,8 +192,8 @@ int acpi_bus_generate_genetlink_event(st
>  
>  	memset(event, 0, sizeof(struct acpi_genl_event));
>  
> -	strcpy(event->device_class, device->pnp.device_class);
> -	strcpy(event->bus_id, device->dev.bus_id);
> +	strcpy(event->device_class, device_class);
> +	strcpy(event->bus_id, bus_id);
>  	event->type = type;
>  	event->data = data;
>  
> @@ -211,6 +212,8 @@ int acpi_bus_generate_genetlink_event(st
>  	return 0;
>  }
>  
> +EXPORT_SYMBOL(acpi_bus_generate_netlink_event);
> +
>  static int acpi_event_genetlink_init(void)
>  {
>  	int result;
> @@ -228,12 +231,14 @@ static int acpi_event_genetlink_init(voi
>  }
>  
>  #else
> -int acpi_bus_generate_genetlink_event(struct acpi_device *device, u8 type,
> +int acpi_bus_generate_netlink_event(struct acpi_device *device, u8 type,
>  				      int data)
>  {
>  	return 0;
>  }
>  
> +EXPORT_SYMBOL(acpi_generate_netlink_event);
> +
>  static int acpi_event_genetlink_init(void)
>  {
>  	return -ENODEV;
> Index: linux-2.6.23-rc3/drivers/acpi/ac.c
> ===================================================================
> --- linux-2.6.23-rc3.orig/drivers/acpi/ac.c
> +++ linux-2.6.23-rc3/drivers/acpi/ac.c
> @@ -205,6 +205,9 @@ static void acpi_ac_notify(acpi_handle h
>  	case ACPI_NOTIFY_DEVICE_CHECK:
>  		acpi_ac_get_state(ac);
>  		acpi_bus_generate_event(device, event, (u32) ac->state);
> +		acpi_bus_generate_netlink_event(device->pnp.device_class,
> +						  device->dev.bus_id, event,
> +						  (u32) ac->state);
>  		break;
>  	default:
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> Index: linux-2.6.23-rc3/include/acpi/acpi_bus.h
> ===================================================================
> --- linux-2.6.23-rc3.orig/include/acpi/acpi_bus.h
> +++ linux-2.6.23-rc3/include/acpi/acpi_bus.h
> @@ -321,8 +321,7 @@ struct acpi_bus_event {
>  };
>  
>  extern struct kset acpi_subsys;
> -extern int acpi_bus_generate_genetlink_event(struct acpi_device *device,
> -						u8 type, int data);
> +extern int acpi_bus_generate_netlink_event(const char*, const char*, u8, int);
>  /*
>   * External Functions
>   */
> Index: linux-2.6.23-rc3/drivers/acpi/battery.c
> ===================================================================
> --- linux-2.6.23-rc3.orig/drivers/acpi/battery.c
> +++ linux-2.6.23-rc3/drivers/acpi/battery.c
> @@ -869,6 +869,9 @@ static void acpi_battery_notify(acpi_han
>  		acpi_battery_notify_update(battery);
>  		acpi_bus_generate_event(device, event,
>  					acpi_battery_present(battery));
> +		acpi_bus_generate_netlink_event(device->pnp.device_class,
> +						  device->dev.bus_id, event,
> +						  acpi_battery_present(battery));
>  		break;
>  	default:
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> Index: linux-2.6.23-rc3/drivers/acpi/processor_core.c
> ===================================================================
> --- linux-2.6.23-rc3.orig/drivers/acpi/processor_core.c
> +++ linux-2.6.23-rc3/drivers/acpi/processor_core.c
> @@ -700,14 +700,21 @@ static void acpi_processor_notify(acpi_h
>  		acpi_processor_ppc_has_changed(pr);
>  		acpi_bus_generate_event(device, event,
>  					pr->performance_platform_limit);
> +		acpi_bus_generate_netlink_event(device->pnp.device_class,
> +						  device->dev.bus_id, event,
> +						  pr->performance_platform_limit);
>  		break;
>  	case ACPI_PROCESSOR_NOTIFY_POWER:
>  		acpi_processor_cst_has_changed(pr);
>  		acpi_bus_generate_event(device, event, 0);
> +		acpi_bus_generate_netlink_event(device->pnp.device_class,
> +						  device->dev.bus_id, event, 0);
>  		break;
>  	case ACPI_PROCESSOR_NOTIFY_THROTTLING:
>  		acpi_processor_tstate_has_changed(pr);
>  		acpi_bus_generate_event(device, event, 0);
> +		acpi_bus_generate_netlink_event(device->pnp.device_class,
> +						  device->dev.bus_id, event, 0);
>  	default:
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  				  "Unsupported event [0x%x]\n", event));
> Index: linux-2.6.23-rc3/drivers/acpi/thermal.c
> ===================================================================
> --- linux-2.6.23-rc3.orig/drivers/acpi/thermal.c
> +++ linux-2.6.23-rc3/drivers/acpi/thermal.c
> @@ -487,6 +487,10 @@ static int acpi_thermal_critical(struct 
>  	       KELVIN_TO_CELSIUS(tz->temperature));
>  	acpi_bus_generate_event(tz->device, ACPI_THERMAL_NOTIFY_CRITICAL,
>  				tz->trips.critical.flags.enabled);
> +	acpi_bus_generate_netlink_event(tz->device->pnp.device_class,
> +					  tz->device->dev.bus_id,
> +					  ACPI_THERMAL_NOTIFY_CRITICAL,
> +					  tz->trips.critical.flags.enabled);
>  
>  	orderly_poweroff(true);
>  
> @@ -506,6 +510,10 @@ static int acpi_thermal_hot(struct acpi_
>  
>  	acpi_bus_generate_event(tz->device, ACPI_THERMAL_NOTIFY_HOT,
>  				tz->trips.hot.flags.enabled);
> +	acpi_bus_generate_netlink_event(tz->device->pnp.device_class,
> +					  tz->device->dev.bus_id,
> +					  ACPI_THERMAL_NOTIFY_HOT,
> +					  tz->trips.hot.flags.enabled);
>  
>  	/* TBD: Call user-mode "sleep(S4)" function */
>  
> @@ -1150,11 +1158,15 @@ static void acpi_thermal_notify(acpi_han
>  		acpi_thermal_get_trip_points(tz);
>  		acpi_thermal_check(tz);
>  		acpi_bus_generate_event(device, event, 0);
> +		acpi_bus_generate_netlink_event(device->pnp.device_class,
> +						  device->dev.bus_id, event, 0);
>  		break;
>  	case ACPI_THERMAL_NOTIFY_DEVICES:
>  		if (tz->flags.devices)
>  			acpi_thermal_get_devices(tz);
>  		acpi_bus_generate_event(device, event, 0);
> +		acpi_bus_generate_netlink_event(device->pnp.device_class,
> +						  device->dev.bus_id, event, 0);
>  		break;
>  	default:
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> Index: linux-2.6.23-rc3/drivers/misc/thinkpad_acpi.c
> ===================================================================
> --- linux-2.6.23-rc3.orig/drivers/misc/thinkpad_acpi.c
> +++ linux-2.6.23-rc3/drivers/misc/thinkpad_acpi.c
> @@ -2162,22 +2162,27 @@ static void dock_notify(struct ibm_struc
>  	int docked = dock_docked();
>  	int pci = ibm->acpi->hid && ibm->acpi->device &&
>  		acpi_match_device_ids(ibm->acpi->device, ibm_pci_device_ids);
> +	int data;
>  
>  	if (event == 1 && !pci)	/* 570 */
> -		acpi_bus_generate_event(ibm->acpi->device, event, 1);	/* button */
> +		data = 1;	/* button */
>  	else if (event == 1 && pci)	/* 570 */
> -		acpi_bus_generate_event(ibm->acpi->device, event, 3);	/* dock */
> +		data = 3;	/* dock */
>  	else if (event == 3 && docked)
> -		acpi_bus_generate_event(ibm->acpi->device, event, 1);	/* button */
> +		data = 1;	/* button */
>  	else if (event == 3 && !docked)
> -		acpi_bus_generate_event(ibm->acpi->device, event, 2);	/* undock */
> +		data = 2;	/* undock */
>  	else if (event == 0 && docked)
> -		acpi_bus_generate_event(ibm->acpi->device, event, 3);	/* dock */
> +		data = 3;	/* dock */
>  	else {
>  		printk(IBM_ERR "unknown dock event %d, status %d\n",
>  		       event, _sta(dock_handle));
> -		acpi_bus_generate_event(ibm->acpi->device, event, 0);	/* unknown */
> +		data = 0;	/* unknown */
>  	}
> +	acpi_bus_generate_event(ibm->acpi->device, event, data);
> +	acpi_bus_generate_netlink_event(ibm->acpi->device->pnp.device_class,
> +					  ibm->acpi->device->dev.bus_id,
> +					  event, data);
>  }
>  
>  static int dock_read(char *p)
> @@ -2276,6 +2281,9 @@ static int __init bay_init(struct ibm_in
>  static void bay_notify(struct ibm_struct *ibm, u32 event)
>  {
>  	acpi_bus_generate_event(ibm->acpi->device, event, 0);
> +	acpi_bus_generate_netlink_event(ibm->acpi->device->pnp.device_class,
> +					  ibm->acpi->device->dev.bus_id,
> +					  event, 0);
>  }
>  
>  #define bay_occupied(b) (_sta(b##_handle) & 1)
> Index: linux-2.6.23-rc3/drivers/pci/hotplug/acpiphp_ibm.c
> ===================================================================
> --- linux-2.6.23-rc3.orig/drivers/pci/hotplug/acpiphp_ibm.c
> +++ linux-2.6.23-rc3/drivers/pci/hotplug/acpiphp_ibm.c
> @@ -268,6 +268,9 @@ static void ibm_handle_events(acpi_handl
>  	if (subevent == 0x80) {
>  		dbg("%s: generationg bus event\n", __FUNCTION__);
>  		acpi_bus_generate_event(note->device, note->event, detail);
> +		acpi_bus_generate_netlink_event(note->device->pnp.device_class,
> +						  note->device->dev.bus_id,
> +						  note->event, detail);
>  	} else
>  		note->event = event;
>  }
> Index: linux-2.6.23-rc3/drivers/acpi/sbs.c
> ===================================================================
> --- linux-2.6.23-rc3.orig/drivers/acpi/sbs.c
> +++ linux-2.6.23-rc3/drivers/acpi/sbs.c
> @@ -445,6 +445,7 @@ static int acpi_sbs_generate_event(struc
>  	strcpy(acpi_device_bid(device), bid_saved);
>  	strcpy(acpi_device_class(device), class_saved);
>  
> +	acpi_bus_generate_netlink_event(class, bid, event, state);
>  	return result;
>  }
>  
> 
