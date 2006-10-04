From: Lennart Poettering <mzxreary@0pointer.de>
Subject: Re: [PATCH] misc,acpi,backlight: MSI S270 Laptop support
Date: Wed, 4 Oct 2006 03:53:34 +0200
Message-ID: <20061004015333.GA6356@tango.0pointer.de>
References: <20061003011056.GA28731@ecstasy.ring2.lan> <200610022227.10087.dtor@insightbb.com> <20061004012832.GA5171@tango.0pointer.de> <200610032137.29844.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tango.0pointer.de ([217.160.223.3]:19218 "EHLO
	tango.0pointer.de") by vger.kernel.org with ESMTP id S1030691AbWJDBxf
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Oct 2006 21:53:35 -0400
Content-Disposition: inline
In-Reply-To: <200610032137.29844.dtor@insightbb.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, 03.10.06 21:37, Dmitry Torokhov (dtor@insightbb.com) wrote:

> > If auto_brightness is 2 we assume that the user doesn't want the
> > module to fiddle with the automatic brightness control
> > automatically. So we don't do it, neither when loading nor when
> > unloading the module. However, if the user wants to fiddle with the
> > setting through sysfs he may do so and we will not reset his changes
> > when unloading the module. This allows the user to do something like
> > this to disable the brightness control without having the the driver
> > loaded the whole time:
> > 
> >   modprobe msi-laptop auto_brightness=2 && echo 0 > /sys/devices/platform/msi-laptop-pf/auto_brightness && modprobe -r msi-laptop
> > 
> > If auto_brightness is 1 or 0, we do as requested but reset the control
> > to the bootup default when unloading. (i.e. enable it again)
> 
> Normally drivers clean up after themselves as if they were never loaded,
> taht is why I questioned partial cleanup.

Sure. But "normally" the user wouldn't bother to pass
auto_brightness=2 to the module in which case we *do* "clean up" after
ourselves and reenable automatic brightness control on module unload.

The special behaviour when auto_brightness=2 is passed is merely a
special feature for those who need it. It was useful to me and was
trivial to implement, and hence I did it.

Lennart

-- 
Lennart Poettering; lennart [at] poettering [dot] net
ICQ# 11060553; GPG 0x1A015CC4; http://0pointer.net/lennart/
