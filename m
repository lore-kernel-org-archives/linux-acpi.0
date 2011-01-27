From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: thermal: Avoid CONFIG_NET compile dependency
Date: Thu, 27 Jan 2011 19:04:10 +0530
Message-ID: <D6D887BA8C9DFF48B5233887EF04654109448F3B18@bgsmsx502.gar.corp.intel.com>
References: <D6D887BA8C9DFF48B5233887EF046541094482F511@bgsmsx502.gar.corp.intel.com>
 <201101251718.36558.trenn@suse.de> <20110125162536.GD8024@ericsson.com>
 <201101271048.29091.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9257 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752962Ab1A0Net convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Jan 2011 08:34:49 -0500
In-Reply-To: <201101271048.29091.trenn@suse.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <jdelvare@suse.de>, "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Yu, Fenghua" <fenghua.yu@intel.com>

> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Thomas Renninger
> Sent: Thursday, January 27, 2011 3:18 PM
> To: Guenter Roeck
> Cc: Jean Delvare; R, Durgadoss; Zhang, Rui; Len Brown; linux-
> acpi@vger.kernel.org; Yu, Fenghua
> Subject: Re: thermal: Avoid CONFIG_NET compile dependency
> 
> On Tuesday, January 25, 2011 05:25:36 PM Guenter Roeck wrote:
> > On Tue, Jan 25, 2011 at 11:18:36AM -0500, Thomas Renninger wrote:
> > > On Tuesday, January 25, 2011 02:43:15 PM Guenter Roeck wrote:
> > > > On Tue, Jan 25, 2011 at 04:48:43AM -0500, Jean Delvare wrote:
> > > > > On Tuesday 25 January 2011 05:47:56 am R, Durgadoss wrote:
> > > ...
> > > > > I don't remember the details, but one thing for sure if that you can't
> > > > > change the format of existing attributes the hwmon subsystem (and
> > > > > libsensors) is using. These are standardized per
> > > > > Documentation/hwmon/sysfs-interface, so they can't be changed. But
> there
> > > > > is no problem with registering a second class device with the thermal
> > > > > subsystem and adding whatever attributes you want to have there.
> > > > >
> > > > A secondary problem is that thermal subsystem drivers register themselves
> > > > with the hwmon subsystem - at least if CONFIG_THERMAL_HWMON is defined.
> > > > So it doesn't really make much sense for a driver to register itself
> > > > as thermal driver _and_ as hwmon driver, since it may end up being listed
> > > > twice as hwmon device.
> > > Having a very quick look at coretemp, this one only provides thermal data,
> > > right?
> > > So it should register as a thermal driver which in turn tells userspace
> > > that lsmsensors can retrieve data from it.
> > > The data would then get exported via:
> > > /sys/devices/virtual/thermal/
> > > and the whole platform code can get removed.
> > >
> > That would be an option.
> What would be the next steps then?
> Whatabout:
>    1) Reverting the current thermal_netlink implementation
> 
>    2) Make coretemp register as a thermal driver.
>       This can be done on top of Durgadoss' enhancements.
>

Yes. 1) and 2) are fine with me.

> 
>    3) Come up with a more generic and more thermal bound
>       (do not export things to the whole kernel if possible)
>       thermal netlink implementation.
>       Important is a robust interface. No need to define all
>       possible events, they can be added one by one if thinkpad
>       or whatever users need them.
>       But the format should not need to be changed in the recent
>       future.
>       Might be worth to put this into an own file:
>       drivers/thermal/thermal_netlink.c

Since we are saying any driver that uses the netlink call _must_ register with
the thermal framework, its better this code be in thermal_sys.c.

>    4) Ideally coretemp.c does not need a special hook to trigger
>       the event. If, it could be some kind of thermal driver
>       callback it got when registering as a thermal driver.
>       Like that the thermal netlink events are hidden and cannot be
>       mis-used by arbitrary drivers, but drivers must register
>       as a thermal driver to be able to trigger them.

In this case, we should consider Jean's point of redundancy.
If CONFIG_THERMAL_HWMON is defined, the interfaces will be present in two
different places.
Or should we make it optional in the thermal framework to register or
Not register with hwmon ?
May be by passing some flag in thermal_zone_device_register?
Rui, need your suggestion here.

Moreover, if we make any driver that wants to use netlink, register with
the thermal framework (redundancy issue should be resolved though..), the problem of
unique originator id will be solved. Then, we can use enum like
the one Rui suggested, to start with. Later, when the need arises, we can add more.


Thanks,
Durga
