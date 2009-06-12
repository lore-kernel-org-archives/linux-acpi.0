From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch update] Re: [linux-pm] Run-time PM idea (was: Re:
 [RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Fri, 12 Jun 2009 10:25:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906121023010.2915-100000@iolanthe.rowland.org>
References: <200906112143.57361.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:50718 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754806AbZFLOZd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Jun 2009 10:25:33 -0400
In-Reply-To: <200906112143.57361.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Oliver Neukum <oliver@neukum.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, 11 Jun 2009, Rafael J. Wysocki wrote:

> > > > It might also be nice to make sure that the driver core autoresumes a 
> > > > device before probing it and autosuspends a device (after some 
> > > > reasonable delay) after unbinding its driver.
> > > 
> > > Agreed.
> > 
> > This is another case where a usage counter comes in handy.  The driver
> > core resumes the device and increments the counter -- thus preventing
> > any unwanted autosuspends -- before making the probe and remove calls.
> 
> I like this idea.
> 
> BTW, where exactly the counter should be increased in that case?
> 
> I thought of driver_probe_device(), but is it sufficient?  Or is there a better
> place?

That's okay.  Or you could put it in really_probe().  Either one.

Alan Stern

