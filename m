From: Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: thermal: Avoid CONFIG_NET compile dependency
Date: Tue, 25 Jan 2011 08:25:36 -0800
Message-ID: <20110125162536.GD8024@ericsson.com>
References: <D6D887BA8C9DFF48B5233887EF046541094482F511@bgsmsx502.gar.corp.intel.com>
 <201101251048.43227.jdelvare@suse.de>
 <20110125134315.GA7301@ericsson.com>
 <201101251718.36558.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from imr4.ericy.com ([198.24.6.8]:32795 "EHLO imr4.ericy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751251Ab1AYQZt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Jan 2011 11:25:49 -0500
Content-Disposition: inline
In-Reply-To: <201101251718.36558.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Jean Delvare <jdelvare@suse.de>, "R, Durgadoss" <durgadoss.r@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Yu, Fenghua" <fenghua.yu@intel.com>

On Tue, Jan 25, 2011 at 11:18:36AM -0500, Thomas Renninger wrote:
> On Tuesday, January 25, 2011 02:43:15 PM Guenter Roeck wrote:
> > On Tue, Jan 25, 2011 at 04:48:43AM -0500, Jean Delvare wrote:
> > > On Tuesday 25 January 2011 05:47:56 am R, Durgadoss wrote:
> ...
> > > I don't remember the details, but one thing for sure if that you can't 
> > > change the format of existing attributes the hwmon subsystem (and 
> > > libsensors) is using. These are standardized per 
> > > Documentation/hwmon/sysfs-interface, so they can't be changed. But there 
> > > is no problem with registering a second class device with the thermal 
> > > subsystem and adding whatever attributes you want to have there.
> > > 
> > A secondary problem is that thermal subsystem drivers register themselves
> > with the hwmon subsystem - at least if CONFIG_THERMAL_HWMON is defined.
> > So it doesn't really make much sense for a driver to register itself
> > as thermal driver _and_ as hwmon driver, since it may end up being listed
> > twice as hwmon device.
> Having a very quick look at coretemp, this one only provides thermal data,
> right?
> So it should register as a thermal driver which in turn tells userspace
> that lsmsensors can retrieve data from it.
> The data would then get exported via:
> /sys/devices/virtual/thermal/
> and the whole platform code can get removed.
> 
That would be an option.

Guenter

