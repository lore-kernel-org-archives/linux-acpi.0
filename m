From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: thermal: Avoid CONFIG_NET compile dependency
Date: Tue, 25 Jan 2011 15:54:22 +0800
Message-ID: <1295942062.1866.1198.camel@rui>
References: <D6D887BA8C9DFF48B5233887EF046541094482F511@bgsmsx502.gar.corp.intel.com>
	 <1295832150.1866.797.camel@rui>
	 <D6D887BA8C9DFF48B5233887EF046541094488B86F@bgsmsx502.gar.corp.intel.com>
	 <201101241135.23576.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:19442 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751275Ab1AYH4I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Jan 2011 02:56:08 -0500
In-Reply-To: <201101241135.23576.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "R, Durgadoss" <durgadoss.r@intel.com>, "jdelvare@novell.com" <jdelvare@novell.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, 2011-01-24 at 18:35 +0800, Thomas Renninger wrote:
> Hi,
> 
> On Monday, January 24, 2011 05:39:26 AM R, Durgadoss wrote:
> > Hi Rui,
> > 
> ...
> > This refers to the patch that you acknowledged.
> > So, you are not missing any patch in the middle.
> > 
> > Also, the thermal_aux0 and _aux1, we can use the final format specified by you.
> > enum events {
> >  	THERMAL_CRITICAL,
> >  	/* user defined thermal events */
> >  	THERMAL_USER_AUX0,
> >  	THERMAL_USER_AUX1,
> >  	THERMAL_DEV_FAULT,
> >  };
> Something else...
> I've now seen your HW specific core/pkg temp threshold support.
> I didn't look at it that closely, but if you introduce generic
> thermal netlink events in the thermal driver those should match
> all kind of possible thermal events, not only the once introduced
> by the driver you added.
> 
> For example it would be great to get the ACPI specific thermal
> events which are currently exported as ACPI driven ones:
> drivers/acpi/thermal.c:acpi_thermal_notify()
> integrated there as well. So there should also be events like:
> >  	THERMAL_CRITICAL,
> >  	/* user defined thermal events */
> >  	THERMAL_USER_AUX0,
> >  	THERMAL_USER_AUX1,
> >  	THERMAL_DEV_FAULT,
> THERMAL_PASSIVE
> THERMAL_ACTIVE
> THERMAL_HOT
> 
Agree.

> At some point of time we should be able
> to get rid of the ACPI specific thermal events at all?

well. I'm not sure about this.
currently, we have acpid that handles all acpi events. And our plan is
to convert acpid to support ACPI genetlink events instead
of /proc/acpi/events. so that this is transparent to user space
applications, e.g. the scripts under /etc/acpi/, that depend on acpid.
And this means we should export ACPI thermal events via the ACPI
genetlink family like we do today.

But on the other side, exporting generic thermal netlink events from
ACPI thermal driver also makes sense. I think this depends on what kind
of user space applications we will have. Ideally, we should have user
space app. that handles the generic thermal netlink events and remove
all the thermal stuff in acpid.

BTW: to be honest, I don't see any scripts in /etc/acpi that handle ACPI
thermal events so far, what about you?

> There seem to be nothing like a kind of
> "available netlink events and their format" API in Documentation.
> Each driver seem to do this and document it itself.
> But as it is an interface to userspace, these thermal netlink events
> should get documented in:
> Documentation/thermal
> 
> Currently you only export one of the above 4 thermal events as a
> number via netlink, right?
> Are there any userspace programs you have in mind which should make
> use of it?
> 
> Some data which should get exported as well:
>    - The temperature if available
>    - The number of the thermal zone, e.g. if 0, userspace can look
>      up sysfs for further info in:
>      /sys/devices/virtual/thermal/thermal_zone0/*
>    - The trip point affected if any, e.g. if 0, userspace can look it up
>      in sysfs for further info:
>      /sys/devices/virtual/thermal/thermal_zone0/trip_point_0_{temp,type}
>    - more?
> 
I think a thermal zone id and an event id is enough.
Applications should rescan /sys/class/power_supply/ to see what is
actually going on. :)

> Ehh, this core and package thermal driver you added threshold support,
> does this somehow register as a thermal driver?
> I can see that it registers for hwmon: hwmon_device_register(&pdev->dev);
> But is it somehow connected to thermal_sys.c other than that it just
> throws your newly introduced thermal_netlink_events?
> This driver should first register as a thermal driver, export
> trip points to:
> /sys/devices/virtual/thermal/thermal_zone0/trip_point_0_{temp,type}
> e.g.
> cat trip_point_0_type
> critical
> cat trip_point_1_type
> user_aux0
> 
> The thermal_netlink_events could then only be declared for
> thermal_sys.c scope, so that other drivers cannot misuse them
> and the netlink event can then get triggered by the driver through
> thermal driver callbacks.
> 
> Rui: What do you think?
> This implementation looks much too static, could you help to better
> adjust it to the generic thermal driver needs, you know this stuff best.
> 
> This is merged already. I wonder whether we still could get a thermal
> event netlink API for 2.6.38 which is more robust so that userspace does
> not need to differ its version with the next kernel.
> Maybe it's best to remove the thermal netlink parts again for now.
> 
a question for Durgadoss,
int thermal_netlink_event(u32 orig, enum events event)
what does parameter "orig" stand for?

If we only need to change the enum event, what about a patch to fix the
enum event first and then shipping the coretemp/pkgtemp driver patch on
top of it?

thanks,
rui
> 
>      Thomas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


