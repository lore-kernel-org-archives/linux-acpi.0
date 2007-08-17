From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 06/12] ACPI: Add acpi_bus_generate_event4() function
Date: Fri, 17 Aug 2007 14:25:40 +0800
Message-ID: <1187331940.2920.28.camel@acpi-hp.sh.intel.com>
References: <20070816140322.19441.63139.stgit@z61m>
	 <20070816140347.19441.31611.stgit@z61m>
	 <1187317411.2920.9.camel@acpi-hp.sh.intel.com> <46C52E05.2090404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:43910 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754934AbXHQGWO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Aug 2007 02:22:14 -0400
In-Reply-To: <46C52E05.2090404@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, astarikovskiy@suse.de

On Fri, 2007-08-17 at 13:11 +0800, Alexey Starikovskiy wrote:
> Zhang Rui wrote:
> > On Thu, 2007-08-16 at 18:03 +0400, Alexey Starikovskiy wrote:
> >> From: Alexey Starikovskiy <astarikovskiy@suse.de>
> >>
> >> acpi_bus_generate_event() takes two strings out of passed device
> object.
> >> SBS needs to supply these strings directly.
> >>
> > This doesn't make sense.
> > acpi_dev->dev.bus_id is the name we are using for ACPI device in
> sysfs.
> > That's why acpi_dev->dev.bus_id is exported via netlink message
> rather
> > than the acpi_dev.pnp.bus_id.
> > BTW: what's wrong with the old acpi_sbs_generate_event thing?
> There are up to 5 devices in SBS which could send a message.
those devices all have a device node in sysfs if they support the
power_supply class, right?
> From ACPI point of view this is one device.
That doesn't matter.
Both the device_class and bus_id are for user space to identify what the
event is.
So why not export "power_supply" as the device_class, and the sysfs
nodes name for these devices as the bus_id?
So that it's easy for user space to know this is a "power supply" event
and can configure the sys I/F in /sys/class/power_supply/bus_id/...

Thanks,
Rui
> Copying strings before and after sending event seems to be mess to me.
