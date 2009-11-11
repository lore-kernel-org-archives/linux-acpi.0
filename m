From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] usb: Add support for runtime power management of the
 hcd
Date: Wed, 11 Nov 2009 18:09:24 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0911111806100.12919-100000@netrider.rowland.org>
References: <200911112324.58076.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:52434 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759486AbZKKXJU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Nov 2009 18:09:20 -0500
In-Reply-To: <200911112324.58076.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Oliver Neukum <oliver@neukum.org>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, USB list <linux-usb@vger.kernel.org>

On Wed, 11 Nov 2009, Rafael J. Wysocki wrote:

> > Now, this does raise another point, which has been mentioned before.  
> > To wit: devices really ought to have _two_ remote-wakeup attributes, 
> > one for runtime PM and one for system sleep.
> 
> Yes, they do and there's another reason.  Namely, there apparently are
> devices which can wake up the system from a sleep state and that are
> unable to generate runtime wakeup events.

That's okay.  There's no harm in trying to enable remote wakeup on a 
device which doesn't support it.

> >   But that would introduce  yet more complexity and opportunities for
> >   confusion.
> 
> Nevertheless.

The real question is whether there are devices for which we explicitly
want to enable remote wakeup during runtime PM but not system sleep (or
vice versa, but this seems rather unlikely).  USB host controllers
might be a good example; as a rule people don't want their laptops to
wake up when they unplug a USB mouse after suspending the machine.

Alan Stern

