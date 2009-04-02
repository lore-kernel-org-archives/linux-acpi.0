From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 01/10] ACPI: support acpi_device_ops .notify methods
Date: Thu, 2 Apr 2009 15:56:28 +0200
Message-ID: <200904021556.32810.trenn@suse.de>
References: <20090330174646.20905.18465.stgit@bob.kio> <20090330174813.20905.76536.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:48209 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754245AbZDBN4j (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Apr 2009 09:56:39 -0400
In-Reply-To: <20090330174813.20905.76536.stgit@bob.kio>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>, kamezawa.hiroyu@jp.fujitsu.com, y-goto@jp.fujitsu.com
Cc: Len Brown <lenb@kernel.org>, Tony Vroon <tony@linx.net>, Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org, Carlos Corbacho <carlos@strangeworlds.co.uk>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Zhao Yakui <yakui.zhao@intel.com>, Mattia Dongili <malattia@linux.it>, Harald Welte <laforge@gnumonks.org>, Venki Pallipadi <venkatesh.pallipadi@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <mjg@redhat.com>

Hi Bjorn,

On Monday 30 March 2009 19:48:13 Bjorn Helgaas wrote:
> This patch adds support for ACPI device driver .notify() methods.  If
> such a method is present, Linux/ACPI installs a handler for device
> notifications (but not for system notifications such as Bus Check,
> Device Check, etc).  When a device notification occurs, Linux/ACPI
> passes it on to the driver's .notify() method.
I sent more or less the same some years ago.
Thanks a lot for finally cleaning this up!

> In most cases, this removes the need for drivers to install their own
> handlers for device-specific notifications.
> 
> For fixed hardware devices like some power and sleep buttons, there's
> no notification value because there's no control method to execute a
> Notify opcode.  When a fixed hardware device generates an event, we
> handle it the same as a regular device notification, except we send
> a ACPI_FIXED_HARDWARE_EVENT value.  This is outside the normal 0x0-0xff
> range used by Notify opcodes.
> 
> Several drivers install their own handlers for system Bus Check and
> Device Check notifications so they can support hot-plug.  This patch
> doesn't affect that usage.
Getting rid of these will be the tricky part.
When I looked at it start/stop already was defined, but nobody used it.
IMO start/stop is not needed and hotplug capable device drivers can
handle things themselves in the relevant notify case.
Most risky part probably will be to register devices which are not present
(to get rid of the own system bus handlers).
I could imagine it will just work. The device drivers have to be able to
handle it. E.g. check in add() or notify() whether _STA is present and if not,
don't touch the device's functions. This should mostly be done for hotplug
capable drivers and not necessary for others (additional sanity checking for
_STA being not present is a good idea, though).

I remember these two guys helped me testing on memory hotplug.
They only had a simulator, but might want to give the latest kernel a try if
you come to clean up acpi_memhotplug.c:
kamezawa.hiroyu@jp.fujitsu.com
Yasunori Goto <y-goto@jp.fujitsu.com>

AFAIK, we also have memory hotplug capable machines somewhere, tell
me if I shall test something.

Thanks a lot,

    Thomas

> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Reviewed-by: Alex Chiang <achiang@hp.com>
> ---
>  drivers/acpi/scan.c         |   71 +++++++++++++++++++++++++++++++++++++++++++
>  include/acpi/acpi_bus.h     |    2 +
>  include/acpi/acpi_drivers.h |   10 ++++++
>  3 files changed, 83 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index b7308ef..20c23c0 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -359,6 +359,61 @@ static int acpi_device_uevent(struct device *dev, struct kobj_uevent_env *env)
>  	return 0;
>  }
>  
> +static void acpi_device_notify(acpi_handle handle, u32 event, void *data)
> +{
> +	struct acpi_device *device = data;
> +
> +	device->driver->ops.notify(device, event);
> +}
> +
> +static acpi_status acpi_device_notify_fixed(void *data)
> +{
> +	struct acpi_device *device = data;
> +
> +	acpi_device_notify(device->handle, ACPI_FIXED_HARDWARE_EVENT, device);
> +	return AE_OK;
> +}
> +
> +static int acpi_device_install_notify_handler(struct acpi_device *device)
> +{
> +	acpi_status status;
> +	char *hid;
> +
> +	hid = acpi_device_hid(device);
> +	if (!strcmp(hid, ACPI_BUTTON_HID_POWERF))
> +		status =
> +		    acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
> +						     acpi_device_notify_fixed,
> +						     device);
> +	else if (!strcmp(hid, ACPI_BUTTON_HID_SLEEPF))
> +		status =
> +		    acpi_install_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
> +						     acpi_device_notify_fixed,
> +						     device);
> +	else
> +		status = acpi_install_notify_handler(device->handle,
> +						     ACPI_DEVICE_NOTIFY,
> +						     acpi_device_notify,
> +						     device);
> +
> +	if (ACPI_FAILURE(status))
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +static void acpi_device_remove_notify_handler(struct acpi_device *device)
> +{
> +	if (!strcmp(acpi_device_hid(device), ACPI_BUTTON_HID_POWERF))
> +		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
> +						acpi_device_notify_fixed);
> +	else if (!strcmp(acpi_device_hid(device), ACPI_BUTTON_HID_SLEEPF))
> +		acpi_remove_fixed_event_handler(ACPI_EVENT_SLEEP_BUTTON,
> +						acpi_device_notify_fixed);
> +	else
> +		acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
> +					   acpi_device_notify);
> +}
> +
>  static int acpi_bus_driver_init(struct acpi_device *, struct acpi_driver *);
>  static int acpi_start_single_object(struct acpi_device *);
>  static int acpi_device_probe(struct device * dev)
> @@ -371,6 +426,20 @@ static int acpi_device_probe(struct device * dev)
>  	if (!ret) {
>  		if (acpi_dev->bus_ops.acpi_op_start)
>  			acpi_start_single_object(acpi_dev);
> +
> +		if (acpi_drv->ops.notify) {
> +			ret = acpi_device_install_notify_handler(acpi_dev);
> +			if (ret) {
> +				if (acpi_drv->ops.stop)
> +					acpi_drv->ops.stop(acpi_dev,
> +						   acpi_dev->removal_type);
> +				if (acpi_drv->ops.remove)
> +					acpi_drv->ops.remove(acpi_dev,
> +						     acpi_dev->removal_type);
> +				return ret;
> +			}
> +		}
> +
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  			"Found driver [%s] for device [%s]\n",
>  			acpi_drv->name, acpi_dev->pnp.bus_id));
> @@ -385,6 +454,8 @@ static int acpi_device_remove(struct device * dev)
>  	struct acpi_driver *acpi_drv = acpi_dev->driver;
>  
>  	if (acpi_drv) {
> +		if (acpi_drv->ops.notify)
> +			acpi_device_remove_notify_handler(acpi_dev);
>  		if (acpi_drv->ops.stop)
>  			acpi_drv->ops.stop(acpi_dev, acpi_dev->removal_type);
>  		if (acpi_drv->ops.remove)
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 08ec60c..a222851 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -95,6 +95,7 @@ typedef int (*acpi_op_suspend) (struct acpi_device * device,
>  typedef int (*acpi_op_resume) (struct acpi_device * device);
>  typedef int (*acpi_op_bind) (struct acpi_device * device);
>  typedef int (*acpi_op_unbind) (struct acpi_device * device);
> +typedef void (*acpi_op_notify) (struct acpi_device * device, u32 event);
>  
>  struct acpi_bus_ops {
>  	u32 acpi_op_add:1;
> @@ -110,6 +111,7 @@ struct acpi_device_ops {
>  	acpi_op_resume resume;
>  	acpi_op_bind bind;
>  	acpi_op_unbind unbind;
> +	acpi_op_notify notify;
>  };
>  
>  struct acpi_driver {
> diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
> index 241d227..0352c8f 100644
> --- a/include/acpi/acpi_drivers.h
> +++ b/include/acpi/acpi_drivers.h
> @@ -67,6 +67,16 @@
>  #define ACPI_BAY_HID			"LNXIOBAY"
>  #define ACPI_DOCK_HID			"LNXDOCK"
>  
> +/*
> + * For fixed hardware buttons, we fabricate acpi_devices with HID
> + * ACPI_BUTTON_HID_POWERF or ACPI_BUTTON_HID_SLEEPF.  Fixed hardware
> + * signals only an event; it doesn't supply a notification value.
> + * To allow drivers to treat notifications from fixed hardware the
> + * same as those from real devices, we turn the events into this
> + * notification value.
> + */
> +#define ACPI_FIXED_HARDWARE_EVENT	0x100
> +
>  /* --------------------------------------------------------------------------
>                                         PCI
>     -------------------------------------------------------------------------- */
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


