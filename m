From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] usb: Add support for runtime power management of the
	hcd
Date: Thu, 12 Nov 2009 14:51:22 +0000
Message-ID: <20091112145121.GB6709@srcf.ucam.org>
References: <200911112324.58076.rjw@sisk.pl> <Pine.LNX.4.44L0.0911111806100.12919-100000@netrider.rowland.org> <20091112003312.GA27572@srcf.ucam.org> <200911120841.11263.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:37529 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891AbZKLOvX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2009 09:51:23 -0500
Content-Disposition: inline
In-Reply-To: <200911120841.11263.oliver@neukum.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, USB list <linux-usb@vger.kernel.org>

On Thu, Nov 12, 2009 at 08:41:11AM +0100, Oliver Neukum wrote:
> Am Donnerstag, 12. November 2009 01:33:12 schrieb Matthew Garrett:
> > On Wed, Nov 11, 2009 at 06:09:24PM -0500, Alan Stern wrote:
> > > That's okay.  There's no harm in trying to enable remote wakeup on a 
> > > device which doesn't support it.
> > 
> > There's harm if we're using the ability to generate remote waleups as a 
> > condition for whether we can perform runtime pm on the device...
> 
> That I would consider backwards. If the user enables runtime power management
> of a device, he has to live with remote wakeup being enabled. At most
> the kernel might resume and switch off remote wakeup on the device,
> but we might also leave this to user space.

My point was that if we don't have remote wakeup support at runtime, we 
can't enable runtime PM of the device. So we need to be able to 
distinguish between runtime remote wakeup and system sleep remote 
wakeup.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
