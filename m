From: Thomas Renninger <trenn@suse.de>
Subject: Re: Patch[1/1]:Adding_Netlink_Support_to_ThermalFramework
Date: Wed, 2 Feb 2011 00:07:11 +0100
Message-ID: <201102020007.12396.trenn@suse.de>
References: <D6D887BA8C9DFF48B5233887EF046541094494D951@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:33428 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183Ab1BAXGt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Feb 2011 18:06:49 -0500
In-Reply-To: <D6D887BA8C9DFF48B5233887EF046541094494D951@bgsmsx502.gar.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi,

some quick comments:

> +The framework includes a simple notification mechanism, in the form of a
> +netlink event. Netlink socket initialization is done during the _init_
> +of the framework. Drivers which intend to use the notification mechanism
> +must register with the thermal framework. Once registered, they will be
> +assigned an unique id. They can call thermal_netlink_event() to send
> +netlink events.
> +
> +This thermal_netlink_event function takes two arguments:
> +	1.Originator id
My idea was: pass the thermal_zone_device id, compare with:
include/linux/thermal.h:
struct thermal_zone_device {
        int id;
I expect it's used to create the sysfs directory:
/sys/devices/virtual/thermal/thermal_zone0
-> zero in the end should be the id (I did not verify this).

> +
> +enum thermal_devices {
> +	/* For multi-core CPUs */
> +	THERMAL_CPU_CORE0 = 0,
is this a placeholder for 32 cores? That's not much and not
generic enough. CPU should be enough. There also should
be THERMAL_DEVICE_UNKNOWN.
> +	THERMAL_GPU = 32,
> +	THERMAL_BATTERY,
> +	/* Add other devices, if any */
> +};
> +
> +struct thermal_genl_event {
> +	enum thermal_devices device;
> +	enum thermal_events event;
> +};
> +
> +/* attributes of thermal_genl_family */
> +enum {
> +	THERMAL_GENL_ATTR_UNSPEC,
> +	THERMAL_GENL_ATTR_EVENT,
> +	__THERMAL_GENL_ATTR_MAX,
> +};
> +#define THERMAL_GENL_ATTR_MAX (__THERMAL_GENL_ATTR_MAX - 1)
> +
> +/* commands supported by the thermal_genl_family */
> +enum {
> +	THERMAL_GENL_CMD_UNSPEC,
> +	THERMAL_GENL_CMD_EVENT,
> +	__THERMAL_GENL_CMD_MAX,
> +};
> +#define THERMAL_GENL_CMD_MAX (__THERMAL_GENL_CMD_MAX - 1)
> +
> +int thermal_netlink_event(enum thermal_devices, enum thermal_events);
not sure what is best, an int or even better request:
struct thermal_zone_device* and then pass the ->id (additionally?)
to userspace. I see that there might be drivers which cannot register as a
thermal driver (e.g. getting an emergency notification from BIOS and no temperature
or thermal trip points at all) and that there might be exceptions needed for the
future, they could pass NULL or a specific value so that userspace knows it
cannot read up further info from /sys/devices/virtual/thermal/thermal_zone-1.

Just some thoughts, I somehow like the idea of userspace being
able to look up the thermal device in sysfs which has thrown the event.

I try to find some time to read into the user definable trip points
(THERMAL_CT_AUX1,..) and might be able to give more feedback then.

About the userspace tool that should pick up these events,
is this integrated into an existing project, is there
code already you could point to?

Thanks,

          Thomas
