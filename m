From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: Patch[1/1]:Adding_Netlink_Support_to_ThermalFramework
Date: Wed, 2 Feb 2011 12:09:58 +0530
Message-ID: <D6D887BA8C9DFF48B5233887EF046541094494DF6F@bgsmsx502.gar.corp.intel.com>
References: <D6D887BA8C9DFF48B5233887EF046541094494D951@bgsmsx502.gar.corp.intel.com>
 <201102020007.12396.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:20466 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421Ab1BBGkL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Feb 2011 01:40:11 -0500
In-Reply-To: <201102020007.12396.trenn@suse.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi Thomas,

> some quick comments:
> 
> > +The framework includes a simple notification mechanism, in the form of a
> > +netlink event. Netlink socket initialization is done during the _init_
> > +of the framework. Drivers which intend to use the notification mechanism
> > +must register with the thermal framework. Once registered, they will be
> > +assigned an unique id. They can call thermal_netlink_event() to send
> > +netlink events.
> > +
> > +This thermal_netlink_event function takes two arguments:
> > +	1.Originator id
> My idea was: pass the thermal_zone_device id, compare with:
> include/linux/thermal.h:
> struct thermal_zone_device {
>         int id;
> I expect it's used to create the sysfs directory:
> /sys/devices/virtual/thermal/thermal_zone0
> -> zero in the end should be the id (I did not verify this).

I completely agree with this idea. I was waiting to see Jean's reply
On the other list, about making it register as a thermal driver.

> > +
> > +enum thermal_devices {
> > +	/* For multi-core CPUs */
> > +	THERMAL_CPU_CORE0 = 0,
> is this a placeholder for 32 cores? That's not much and not
> generic enough. CPU should be enough. There also should
> be THERMAL_DEVICE_UNKNOWN.

Ok. Shall change.

> > +	THERMAL_GPU = 32,
> > +	THERMAL_BATTERY,
> > +	/* Add other devices, if any */
> > +};
> > +
> > +struct thermal_genl_event {
> > +	enum thermal_devices device;
> > +	enum thermal_events event;
> > +};
> > +
> > +/* attributes of thermal_genl_family */
> > +enum {
> > +	THERMAL_GENL_ATTR_UNSPEC,
> > +	THERMAL_GENL_ATTR_EVENT,
> > +	__THERMAL_GENL_ATTR_MAX,
> > +};
> > +#define THERMAL_GENL_ATTR_MAX (__THERMAL_GENL_ATTR_MAX - 1)
> > +
> > +/* commands supported by the thermal_genl_family */
> > +enum {
> > +	THERMAL_GENL_CMD_UNSPEC,
> > +	THERMAL_GENL_CMD_EVENT,
> > +	__THERMAL_GENL_CMD_MAX,
> > +};
> > +#define THERMAL_GENL_CMD_MAX (__THERMAL_GENL_CMD_MAX - 1)
> > +
> > +int thermal_netlink_event(enum thermal_devices, enum thermal_events);
> not sure what is best, an int or even better request:
> struct thermal_zone_device* and then pass the ->id (additionally?)
> to userspace. I see that there might be drivers which cannot register as a
> thermal driver (e.g. getting an emergency notification from BIOS and no
> temperature
> or thermal trip points at all) and that there might be exceptions needed for
> the
> future, they could pass NULL or a specific value so that userspace knows it
> cannot read up further info from /sys/devices/virtual/thermal/thermal_zone-1.
> 
> Just some thoughts, I somehow like the idea of userspace being
> able to look up the thermal device in sysfs which has thrown the event.

Ok then I will make the first argument as the thermal_zone->id.

> 
> I try to find some time to read into the user definable trip points
> (THERMAL_CT_AUX1,..) and might be able to give more feedback then.
>

IMHO, you can refer to the IA32 Software developer's manual,(a pdf..
freely downloadable) to get a complete picture.

> About the userspace tool that should pick up these events,
> is this integrated into an existing project, is there
> code already you could point to?
> 

We are working on a Thermal Monitoring Agent for the MeeGo Distribution.
But there is no reason why it would not work on other distros.

Thanks,
Durga
