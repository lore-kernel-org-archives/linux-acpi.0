From: Thomas Renninger <trenn@suse.de>
Subject: Re: thermal: Avoid CONFIG_NET compile dependency
Date: Thu, 27 Jan 2011 10:48:28 +0100
Message-ID: <201101271048.29091.trenn@suse.de>
References: <D6D887BA8C9DFF48B5233887EF046541094482F511@bgsmsx502.gar.corp.intel.com> <201101251718.36558.trenn@suse.de> <20110125162536.GD8024@ericsson.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:56140 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753872Ab1A0Jsb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Jan 2011 04:48:31 -0500
In-Reply-To: <20110125162536.GD8024@ericsson.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <jdelvare@suse.de>, "R, Durgadoss" <durgadoss.r@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Yu, Fenghua" <fenghua.yu@intel.com>

On Tuesday, January 25, 2011 05:25:36 PM Guenter Roeck wrote:
> On Tue, Jan 25, 2011 at 11:18:36AM -0500, Thomas Renninger wrote:
> > On Tuesday, January 25, 2011 02:43:15 PM Guenter Roeck wrote:
> > > On Tue, Jan 25, 2011 at 04:48:43AM -0500, Jean Delvare wrote:
> > > > On Tuesday 25 January 2011 05:47:56 am R, Durgadoss wrote:
> > ...
> > > > I don't remember the details, but one thing for sure if that you can't 
> > > > change the format of existing attributes the hwmon subsystem (and 
> > > > libsensors) is using. These are standardized per 
> > > > Documentation/hwmon/sysfs-interface, so they can't be changed. But there 
> > > > is no problem with registering a second class device with the thermal 
> > > > subsystem and adding whatever attributes you want to have there.
> > > > 
> > > A secondary problem is that thermal subsystem drivers register themselves
> > > with the hwmon subsystem - at least if CONFIG_THERMAL_HWMON is defined.
> > > So it doesn't really make much sense for a driver to register itself
> > > as thermal driver _and_ as hwmon driver, since it may end up being listed
> > > twice as hwmon device.
> > Having a very quick look at coretemp, this one only provides thermal data,
> > right?
> > So it should register as a thermal driver which in turn tells userspace
> > that lsmsensors can retrieve data from it.
> > The data would then get exported via:
> > /sys/devices/virtual/thermal/
> > and the whole platform code can get removed.
> > 
> That would be an option.
What would be the next steps then?
Whatabout:
   1) Reverting the current thermal_netlink implementation

   2) Make coretemp register as a thermal driver.
      This can be done on top of Durgadoss' enhancements.
      Revert the one thermal_netlink_event call

   3) Come up with a more generic and more thermal bound
      (do not export things to the whole kernel if possible)
      thermal netlink implementation.
      Important is a robust interface. No need to define all
      possible events, they can be added one by one if thinkpad
      or whatever users need them.
      But the format should not need to be changed in the recent
      future.
      Might be worth to put this into an own file:
      drivers/thermal/thermal_netlink.c

   4) Ideally coretemp.c does not need a special hook to trigger
      the event. If, it could be some kind of thermal driver
      callback it got when registering as a thermal driver.
      Like that the thermal netlink events are hidden and cannot be
      mis-used by arbitrary drivers, but drivers must register
      as a thermal driver to be able to trigger them.
      Like that it can also be insured that the netlink event
      always provides a pointer to a thermal device which can
      be looked up via sysfs.

Not sure whether 4. will work out as described.
2. + 3. can be implemented in parallel and connected with
a tiny on top patch with 4 (if necessary at all).

If the current thermal_netlink_event implementation is not
reverted, there would be one kernel revision with a thermal
netlink userspace notification implementation which should
not get used. Hm and in the end userspace apps need to be
able to detect the never used one, it should really get
reverted.
Len?

Is there still someone who could veto above or a mailinglist
that should get added or can this be started without
much risk of getting a NAK afterwards?

Thanks,

    Thomas
