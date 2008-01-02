From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/4] PM: Introduce destroy_suspended_device()
Date: Wed, 2 Jan 2008 11:41:36 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801021122070.5062-100000@iolanthe.rowland.org>
References: <200801021433.47651.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:44013 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754521AbYABQlh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jan 2008 11:41:37 -0500
In-Reply-To: <200801021433.47651.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Ingo Molnar <mingo@elte.hu>, Greg KH <gregkh@suse.de>

On Wed, 2 Jan 2008, Rafael J. Wysocki wrote:

> On Wednesday, 2 of January 2008, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > It sometimes is necessary to destroy a device object during a suspend or
> > hibernation, but the PM core is supposed to control all device objects in that
> > cases.  For this reason, it is necessary to introduce a mechanism allowing one
> > to ask the PM core to remove a device object corresponding to a suspended
> > device on one's behalf.
> > 
> > Define function destroy_suspended_device() that will schedule the removal of
> > a device object corresponding to a suspended device by the PM core during the
> > subsequent resume.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Sorry, a small fix is needed for this patch.  Namely, dpm_sysfs_remove(dev)
> should not be called by device_pm_schedule_removal(), because it will be called
> anyway from device_pm_remove() when the device object is finally unregistered
> (we're talking here about unlikely error paths only, but still).

The situation is a little confusing, because the source files under 
drivers/base/power are maintained in Greg's tree and he already has 
gregkh-driver-pm-acquire-device-locks-prior-to-suspending.patch 
installed.  That patch conflicts with this one.

One of the these two patches will have to be rewritten to apply on top 
of the other.  Which do you think should be changed?

Alan Stern

