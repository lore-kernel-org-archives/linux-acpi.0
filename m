From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH RFC] PM / Runtime: Rework the "runtime idle" helper
 routine
Date: Thu, 30 May 2013 16:13:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1305301613120.887-100000@iolanthe.rowland.org>
References: <5291416.b4M4MTrzPC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:43079 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758866Ab3E3UNh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 May 2013 16:13:37 -0400
In-Reply-To: <5291416.b4M4MTrzPC@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, Linux PCI <linux-pci@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Thu, 30 May 2013, Rafael J. Wysocki wrote:

> > > > > Index: linux-pm/Documentation/power/runtime_pm.txt
> > > > > ===================================================================
> > > > > --- linux-pm.orig/Documentation/power/runtime_pm.txt
> > > > > +++ linux-pm/Documentation/power/runtime_pm.txt
> > > > > @@ -660,11 +660,6 @@ Subsystems may wish to conserve code spa
> > > > >  management callbacks provided by the PM core, defined in
> > > > >  driver/base/power/generic_ops.c:
> > > > >  
> > > > > -  int pm_generic_runtime_idle(struct device *dev);
> > > > > -    - invoke the ->runtime_idle() callback provided by the driver of this
> > > > > -      device, if defined, and call pm_runtime_suspend() for this device if the
> > > > > -      return value is 0 or the callback is not defined
> > > > > -
> > > > 
> > > > The documentation for the runtime-idle callback needs to be updated too.
> > > 
> > > Well, I actually couldn't find the part of it that would need to be updated. :-)
> > 
> > How about this?
> 
> Looks good! :-)
> 
> May I add your sign-off to it?

Go ahead.

Alan Stern

