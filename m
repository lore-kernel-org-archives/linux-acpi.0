From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Regression] USB wakeup problem on Toshiba Portege R500
Date: Mon, 12 Jan 2009 22:10:43 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0901122207400.18052-100000@netrider.rowland.org>
References: <200901122353.59887.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:3662 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752040AbZAMDKp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Jan 2009 22:10:45 -0500
In-Reply-To: <200901122353.59887.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Frans Pop <elendil@planet.nl>, oliver@neukum.org, gregkh@suse.de, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, pavel@suse.cz, torvalds@linux-foundation.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Mon, 12 Jan 2009, Rafael J. Wysocki wrote:

> On Monday 12 January 2009, Alan Stern wrote:
> > On Fri, 9 Jan 2009, Rafael J. Wysocki wrote:
> > 
> > > > My proposal:
> > > > 
> > > > 	Devices and events that are clearly associated with system
> > > > 	wakeup should be enabled by default.  For example: Power
> > > > 	button and laptop lid.
> > > 
> > > Agreed.
> > > 
> > > > 	All other devices capable of waking up the system should be
> > > > 	disabled by default.  This presumably includes every PCI
> > > > 	device.  If users want keyboard or mouse events to cause
> > > > 	a system resume then they will have to configure their
> > > > 	desktop management program to enable it.
> > > 
> > > I generally agree, with one exception.  There are network adapters which
> > > can be enabled to wake up by the BIOS and their drivers set them up for WoL
> > > currently on this basis.  These should remain enabled IMO.
> > 
> > How do we know which adapters these are?  IMO the PCI core should
> > disable wakeup by default for all devices when they are detected.
> 
> This is what we do.
> 
> > Is it sufficient to have the adapter drivers enable wakeup during
> > their probe routines?
> 
> Yes, it is.

Therefore all we need is a patch to change the USB host controller
drivers.  They should call device_set_wakeup_capable() instead of
device_init_wakeup().

I just got back from vacation so things will be busy for a few days, 
but I'll send out such a patch soon.

Alan Stern

