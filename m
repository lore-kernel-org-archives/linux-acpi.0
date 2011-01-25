From: Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: thermal: Avoid CONFIG_NET compile dependency
Date: Tue, 25 Jan 2011 05:43:15 -0800
Message-ID: <20110125134315.GA7301@ericsson.com>
References: <D6D887BA8C9DFF48B5233887EF046541094482F511@bgsmsx502.gar.corp.intel.com>
 <201101241135.23576.trenn@suse.de>
 <D6D887BA8C9DFF48B5233887EF046541094488BDF5@bgsmsx502.gar.corp.intel.com>
 <201101251048.43227.jdelvare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from imr4.ericy.com ([198.24.6.8]:57058 "EHLO imr4.ericy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753183Ab1AYNnc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Jan 2011 08:43:32 -0500
Content-Disposition: inline
In-Reply-To: <201101251048.43227.jdelvare@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: "R, Durgadoss" <durgadoss.r@intel.com>, Thomas Renninger <trenn@suse.de>, "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Yu, Fenghua" <fenghua.yu@intel.com>

On Tue, Jan 25, 2011 at 04:48:43AM -0500, Jean Delvare wrote:
> On Tuesday 25 January 2011 05:47:56 am R, Durgadoss wrote:
> > > The thermal_netlink_events could then only be declared for
> > > thermal_sys.c scope, so that other drivers cannot misuse them
> > > and the netlink event can then get triggered by the driver through
> > > thermal driver callbacks.
> > 
> > Yep!! This was my initial idea, with which I added the netlink
> >  support here.
> > 
> > If we make the coretemp register with the thermal framework, we have
> >  to modify the sysfs _store and _show functions a bit. Hence, the
> >  coretemp people were not very happy with the idea of making coretemp
> >  register with the thermal framework. So, I just added support to the
> >  core thresholds, and when current temperature crosses them, it sends
> >  a netlink event.
> 
> I don't remember the details, but one thing for sure if that you can't 
> change the format of existing attributes the hwmon subsystem (and 
> libsensors) is using. These are standardized per 
> Documentation/hwmon/sysfs-interface, so they can't be changed. But there 
> is no problem with registering a second class device with the thermal 
> subsystem and adding whatever attributes you want to have there.
> 
A secondary problem is that thermal subsystem drivers register themselves
with the hwmon subsystem - at least if CONFIG_THERMAL_HWMON is defined.
So it doesn't really make much sense for a driver to register itself
as thermal driver _and_ as hwmon driver, since it may end up being listed
twice as hwmon device.

> 
> Another problem is that we really want pkgtemp to be merged with 
> coretemp before intrusive changes are made to these drivers.
> 
Unfortunately, that request seems to go to deaf ears.

Guenter
