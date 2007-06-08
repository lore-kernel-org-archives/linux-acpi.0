From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: Docking support?
Date: Fri, 8 Jun 2007 09:04:03 -0700
Message-ID: <20070608090403.c712d79e.kristen.c.accardi@intel.com>
References: <20070608104706.GA10553@implementation>
	<20361107150045.GA25276@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50462 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S969845AbXFHQHc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Jun 2007 12:07:32 -0400
In-Reply-To: <20361107150045.GA25276@homac.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Holger Macht <hmacht@suse.de>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, linux-acpi@vger.kernel.org

On Fri, 7 Nov 2036 16:00:45 +0100
Holger Macht <hmacht@suse.de> wrote:

> On Fri 08. Jun - 18:47:06, Samuel Thibault wrote:
> [...]
> > Also, I'd really like to receive ACPI docking events in userland for
> > triggering video devices configuration for instance.
> 
> Via udev. Unfortunately....
> 
> I just tries and it doesn't work properly.
> 
> Dock driver contains something like this:
> 
> ---
>        /*
>         * here we need to generate the undock
>         * event prior to actually doing the undock
>         * so that the device struct still exists.
>         */
>         dock_event(ds, event, UNDOCK_EVENT);
>         hotplug_dock_devices(ds, ACPI_NOTIFY_EJECT_REQUEST);
>         undock(ds);
>         eject_dock(ds);
> ---
> 
> When udev receives the KOBJ_CHANGE event triggered by dock_event(), some
> application or udev itself does read the content of
> /sys/devices/platform/dock.0/docked. But the value is not updated
> yet. Checking manually with cat, it sometimes even needs up to two seconds
> for the right value (0) to show up. So we cannot rely on getting the real
> state at the point in time where the udev event is received.
> 
> At first, function dock_event(..) doesn't need any of the passed
> arguments. It only makes use of the static platform_device dock_device
> object to execute a kobject_uevent(). So wouldn't it be save to execute
> the dock_event() _after_ actually undocking? Something like the following?

Actually it does - the latest patches sent to Len contain modifications
to pass an ENV value with the dock event so that userspace can use that
to determine whether we are doing or undocking.   You might check out
the "immediate_undock" module parameter patch that I also sent to Len that
will allow you to write scripts to do work before the undock actually
happens - http://marc.info/?l=linux-kernel&m=117874881923973&w=2

Kristen
