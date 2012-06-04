From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [RFC PATCH V3 3/3] usb : Add sysfs files to control usb port's
 power
Date: Mon, 4 Jun 2012 11:02:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1206041040510.1555-100000@iolanthe.rowland.org>
References: <1338799665-13997-3-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1338799665-13997-3-git-send-email-tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 4 Jun 2012, Lan Tianyu wrote:

> Change since v2: add ABI descripters for new sysfs files and with some small
> modification.

Better, but it still can be improved.

> Change since v1: move sysfs files from usb hub device sysfs directory to usb
> hub interface sysfs directory.
> 
> This patch is to add two sys files for each usb hub ports to control port's power.
> Control port's power through setting or clearing PORT_POWER feature.
> 
> The new sys files is under the usb hub interface sysfs portx directory.
> ls /sys/bus/usb/devices/1-0:1.0
> bAlternateSetting  bInterfaceClass  bInterfaceNumber  bInterfaceProtocol
> bInterfaceSubClass  bNumEndpoints  driver  ep_81  modalias  power
> subsystem  supports_autosuspend  uevent port1 port2 port3 port4
> 
> ls /sys/bus/usb/devices/1-0:1.0/port1
> control state
> 
> control has three options. "auto", "on" and "off"
> "auto" - For ports with device, there is a proposal that if the device was not
> 	in the suspend at that pointer, the power would remain on but it would

s/in the suspend/suspended/ -- this change is needed throughout the 
patch.

s/pointer/point/

> 	power off when it was suspended. If the the device was in the suspend,
> 	"auto" means the device could be put into much lower state so the device
> 	need to resume and suspend again.

Get rid of "so the device...".  You don't need to resume a suspended 
port before powering it off.

> "on" - port must be power on.
> "off" - port must be power off.
> 
> state reports usb ports' power state

s/ports'/port's/

> "on" - power on
> "off" - power off
> "error" - can't get power state
> 
> Signed-off-by: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  Documentation/ABI/testing/sysfs-bus-usb |   37 +++++++
>  drivers/usb/core/hub.c                  |  172 +++++++++++++++++++++++++++++++
>  2 files changed, 209 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
> index 6df4e6f..62c396b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-usb
> +++ b/Documentation/ABI/testing/sysfs-bus-usb
> @@ -208,3 +208,40 @@ Description:
>  		such as ACPI. This file will read either "removable" or
>  		"fixed" if the information is available, and "unknown"
>  		otherwise.
> +
> +What:		/sys/bus/usb/devices/.../(hub interface)/port1, port2,...portX

Just portX, not port1, port2, ...

> +Date:		June 2012
> +Contact		Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> +Description:
> +		The /sys/bus/usb/device/.../(hub interface)/portX directory
> +		contains attributes allowing the user space to check and modify

s/the user/user/  -- here and below

> +		some usb port related properties of associated port.

Change to:	properties of the associated USB port.

> +
> +What:		/sys/bus/usb/devices/.../(hub interface)/portX/control
> +Date:		June 2012
> +Contact		Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> +Description:

Lines should not extend past column 76 or so.

> +		The /sys/bus/usb/devices/.../(hub interface)/portX/control attribue

s/attribue/attribute/  -- here and below

> +		allows the user space to control the power policy on the usb port
> +
> +		All ports have one of the following three values for portX/control
> +		"auto" - For ports with device, if the device was not in the suspend
> +			at that pointer, the power would remain on but it would power
> +			off when it was suspended. If the the device was in the suspend,
> +			"auto" means the device could be put into much lower state so
> +			the device would be resumed and suspended again.

The patch does not implement anything at all for "auto".  It should do 
_something_.

> +		"on" - port must be power on.

Change to: port power must be on.

> +		"off" - port must be power off.

Change to: port power must be off.

> +
> +What:		/sys/bus/usb/devices/.../(hub interface)/portX/state
> +Date:		June 2012
> +Contact		Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> +Description:
> +		The /sys/bus/usb/devices/.../(hub interface)/portX/state attribue
> +		allows the user space to check hub port's power state.
> +
> +		All ports have three following states
> +		"on"	  -    port power on
> +		"off"	  -    port power off
> +		"error"	  -    can't get the hub port's power state
> +
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 2ed5244..445cd6e 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -41,12 +41,22 @@
>  #endif
>  #endif
>  
> +enum port_power_policy {
> +	USB_PORT_POWER_ON = 0,
> +	USB_PORT_POWER_OFF,
> +	USB_PORT_POWER_AUTO,
> +};
> +
>  struct usb_hub_port {
>  	void			*port_owner;
>  	struct usb_device	*child;
>  #ifdef CONFIG_ACPI
>  	acpi_handle		port_acpi_handle;
>  #endif
> +	struct attribute_group	port_attr_group;

I think you don't need the attribute_group at all.  See below.

> @@ -2558,6 +2577,25 @@ static int port_is_power_on(struct usb_hub *hub, unsigned portstatus)
>  	return ret;
>  }
>  
> +static int usb_get_hub_port_power_state(struct usb_device *hdev, int port1)
> +{
> +	struct usb_hub *hub = hdev_to_hub(hdev);
> +	struct usb_port_status data;
> +	u16 portstatus;
> +	int ret;
> +
> +	ret = get_port_status(hub->hdev, port1, &data);
> +	if (ret < 4) {
> +		dev_err (hub->intfdev,

checkpatch will complain about the ' ' before the '('.  You should fix 
such problems before posting.

> @@ -4499,6 +4537,139 @@ static int hub_thread(void *__unused)
>  	return 0;
>  }
>  
> +static ssize_t show_port_power_state(struct device *dev,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct usb_device *udev = to_usb_device(dev->parent);
> +	struct usb_hub_port *hub_port = container_of(attr,
> +		struct usb_hub_port, port_state_attr);
> +	int power_state;
> +	const char *result;
> +	int port1;
> +
> +	if (sscanf(hub_port->port_attr_group.name, "port%d", &port1) != 1)
> +		return -EINVAL;

You can determine the port number without using the attribute group:

	struct usb_hub *hub = dev_get_drvdata(dev);
	int port1 = hub_port - hub->port_data + 1;

> +static void usb_hub_port_sysfs_add(struct usb_hub *hub)
> +{
> +	int i, rc;
> +	struct attribute* port_attrs[3];

s/e* p/e *p/

Make port_attr_group another local variable rather than part of 
hub->port_data[i].

> +
> +	for (i = 0; i < hub->hdev->maxchild; i++) {
> +		hub->port_data[i].port_control_attr = (struct device_attribute)
> +			__ATTR(control, S_IRUGO | S_IWUSR,
> +			show_port_power_control,
> +			store_port_power_control);
> +		hub->port_data[i].port_state_attr = (struct device_attribute)
> +			__ATTR(state, S_IRUGO, show_port_power_state, NULL);
> +
> +		port_attrs[0] = &hub->port_data[i].port_control_attr.attr;
> +		port_attrs[1] = &hub->port_data[i].port_state_attr.attr;
> +		port_attrs[2] = NULL;
> +		hub->port_data[i].port_attr_group = (struct attribute_group) {
> +			.name = port_name[i],
> +			.attrs = port_attrs
> +		};
> +
> +		rc = sysfs_create_group(&hub->intfdev->kobj,
> +			&hub->port_data[i].port_attr_group);
> +		if (rc < 0)
> +			dev_err(hub->intfdev, "can't create sys " \
> +				"files for port%d\n", i + 1);
> +	}
> +}

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
