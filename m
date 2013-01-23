From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 4/4] ACPI / PM: Expose lists of device power resources to
 user space
Date: Tue, 22 Jan 2013 17:03:59 -0800
Message-ID: <20130123010359.GA2024@kroah.com>
References: <3307415.pdOY6ovZLa@vostro.rjw.lan>
 <20130122235624.GF694@kroah.com>
 <4110339.gOkm8VAsyn@vostro.rjw.lan>
 <4989050.jK98Xm5BOW@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34667 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504Ab3AWBED (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jan 2013 20:04:03 -0500
Received: by mail-pa0-f45.google.com with SMTP id bg2so4407281pad.32
        for <linux-acpi@vger.kernel.org>; Tue, 22 Jan 2013 17:04:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4989050.jK98Xm5BOW@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Kristen C. Accardi" <kristen.c.accardi@intel.com>, Len Brown <lenb@kernel.org>

On Wed, Jan 23, 2013 at 01:17:47AM +0100, Rafael J. Wysocki wrote:
> On Wednesday, January 23, 2013 01:08:54 AM Rafael J. Wysocki wrote:
> > On Tuesday, January 22, 2013 03:56:24 PM Greg Kroah-Hartman wrote:
> > > On Tue, Jan 22, 2013 at 03:28:23AM +0100, Rafael J. Wysocki wrote:
> 
> [...]
> 
> > > Oh, and same question about racing userspace, you will have problems
> > > here in that the symlinks will be showing up after the device is
> > > created.  Perhaps, to make the whole thing easier, you just change the
> > > acpi core code to hold off on the notification until you get all of
> > > these links and files set up and then tell userspace.  That's probably
> > > an easier fix.
> > 
> > I suppose so.
> > 
> > How can I do that?
> 
> Should I set dev->kobj.uevent_suppress before calling device_register() and
> then clear it and call the kobject_uevent(&dev->kobj, KOBJ_ADD) from the ACPI
> core after device_register() has returned and the files have been created?

Ick, that might work, but the "traditional" way is to just do the
creation of the device in two steps.

First call device_initialize().  Then you can do what you want to the
device, add sysfs files, etc.  Then call device_add() which "finalizes"
the device in the driver core and tells userspace all about it.  The USB
core has been doing this since the beginning of time (well, since we
wrote the driver model) and it has worked out pretty well.

Calling dev_set_uevent_suppress() would also probably work, like you
point out the firmware core uses this.  Hm, it uses this to create some
sysfs files and then tell userspace about them, even though it uses
device_add(), that's "odd".

Either way should be fine, you can run 'udevadm monitor' as root to
watch the sysfs events be sent from the kernel to make sure you have it
all working properly.

Hope this helps,

greg k-h
