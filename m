From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: USB runtime D3
Date: Thu, 30 Jul 2009 15:22:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0907301516100.6087-100000@iolanthe.rowland.org>
References: <20090730190716.GB22016@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:36822 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751984AbZG3TWb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Jul 2009 15:22:31 -0400
In-Reply-To: <20090730190716.GB22016@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, 30 Jul 2009, Matthew Garrett wrote:

> On Thu, Jul 30, 2009 at 02:57:48PM -0400, Alan Stern wrote:
> > > event, even though port0en and port1n are set in USB_RES. Is there any 
> > > way to get UHCI to do this? I'm guessing that the power is being cut to 
> > > the port when it suspends with no device connected.
> > 
> > No, that doesn't sound right.  On the other hand, there's only one way 
> > to find out for certain.  Voltmeters do come in handy at times...
> 
> Thinking about it, I get plug events from EHCI, so it can't be that the 
> port is powered down. Maybe it's something to do with the port switching 
> logic.

Seems likely.  What happens if you suspend the UHCI controller but 
leave the EHCI controller active?  Then the port-switching logic should 
kick in.

> > > Anyone have any ideas? I've attached the current version of my code, 
> > > which is hacked up in various ways as I try to understand what's going 
> > > on but should give some idea what I'm trying.
> > 
> > Ugh...  Hacked is right.  I can't comment on the ACPI stuff, but the
> > USB parts are a mess.  You put stuff in the USB core that really
> > belongs in the PCI core and you put stuff in the kernel that belongs in
> > userspace.  Of course, there's nothing wrong with doing this as part of
> > a "proof-of-principle" thing.
> 
> Yes, I guess the correct model is for this to be in PCI and have the USB 
> code do nothing other than indicate that the PCI device is now idle.

Which reminds me...  One of the things you had to do was enable remote
wakeup for the host controllers.  The current initial state is
disabled, for a good reason.  People don't like it if they suspend
their laptop only to find that the computer wakes back up again when
they unplug the USB mouse.

If we do end up implementing runtime power management for USB host
controllers, something (a userspace program?) will have to turn off
remote wakeup before system sleeps and turn it back on afterward.

Alan Stern

