From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] usb: Add support for runtime power management of the
 hcd
Date: Wed, 11 Nov 2009 14:06:14 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0911111400370.6882-100000@netrider.rowland.org>
References: <200911111827.14346.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:53942 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758351AbZKKTGL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Nov 2009 14:06:11 -0500
In-Reply-To: <200911111827.14346.oliver@neukum.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, USB list <linux-usb@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Wed, 11 Nov 2009, Oliver Neukum wrote:

> Am Mittwoch, 11. November 2009 18:08:17 schrieb Alan Stern:
> > On Wed, 11 Nov 2009, Oliver Neukum wrote:
> 
> > > That seems to be a bit harsh. If you do not specify that a device be
> > > able to wake the whole system, why would it be good for a request
> > > coming from it to abort a system sleep transition?
> > 
> > The way you specify that a device be able to wake the whole system is
> > by enabling its remote wakeup attribute.  If this attribute is not
> > enabled then the device will not send remote wakeup requests, so the
> > scenario described above will not occur -- no IRQ will be generated.
> 
> But what happens if a driver has requested remote wakeup requests
> to do runtime power management?

The driver mustn't tell the device to send remote wakeup requests if
the remote wakeup attribute isn't set.  If this means it can't do 
effective runtime PM, then so be it.

Now, this does raise another point, which has been mentioned before.  
To wit: devices really ought to have _two_ remote-wakeup attributes, 
one for runtime PM and one for system sleep.  But that would introduce 
yet more complexity and opportunities for confusion.

Alan Stern

