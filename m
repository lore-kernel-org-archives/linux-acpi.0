From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] usb: Add support for runtime power management of the
 hcd
Date: Thu, 12 Nov 2009 11:50:40 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0911121147400.3000-100000@iolanthe.rowland.org>
References: <20091112145121.GB6709@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:57400 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753409AbZKLQug (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2009 11:50:36 -0500
In-Reply-To: <20091112145121.GB6709@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Oliver Neukum <oliver@neukum.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, USB list <linux-usb@vger.kernel.org>

On Thu, 12 Nov 2009, Matthew Garrett wrote:

> On Thu, Nov 12, 2009 at 08:41:11AM +0100, Oliver Neukum wrote:
> > Am Donnerstag, 12. November 2009 01:33:12 schrieb Matthew Garrett:
> > > On Wed, Nov 11, 2009 at 06:09:24PM -0500, Alan Stern wrote:
> > > > That's okay.  There's no harm in trying to enable remote wakeup on a 
> > > > device which doesn't support it.
> > > 
> > > There's harm if we're using the ability to generate remote waleups as a 
> > > condition for whether we can perform runtime pm on the device...
> > 
> > That I would consider backwards. If the user enables runtime power management
> > of a device, he has to live with remote wakeup being enabled. At most
> > the kernel might resume and switch off remote wakeup on the device,
> > but we might also leave this to user space.
> 
> My point was that if we don't have remote wakeup support at runtime, we 
> can't enable runtime PM of the device. So we need to be able to 
> distinguish between runtime remote wakeup and system sleep remote 
> wakeup.

You are mixing up two different scenarios.  The real trouble arises if
we can't tell whether runtime remote wakeup is available, or we think
it is available when in fact it isn't.

But if we know accurately that remote wakeup isn't available at runtime
then there's no problem -- the driver simply doesn't use runtime PM.
Even if the "wakeup" attribute in sysfs is enabled.

Alan Stern

