From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [RFC][PATCH 0/3] PM: Asynchronous suspend and resume
Date: Sun, 16 Aug 2009 12:29:56 +0200
Message-ID: <200908161229.56362.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0908141717350.2922-100000@iolanthe.rowland.org> <200908142331.26855.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:44311 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751698AbZHPK31 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 16 Aug 2009 06:29:27 -0400
In-Reply-To: <200908142331.26855.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@linux.intel.com>ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Friday 14 August 2009, Rafael J. Wysocki wrote:
> On Friday 14 August 2009, Alan Stern wrote:
> > On Fri, 14 Aug 2009, Rafael J. Wysocki wrote:
> > 
> > > On Friday 14 August 2009, Alan Stern wrote:
> > > > On Thu, 13 Aug 2009, Rafael J. Wysocki wrote:
> > > > 
> > > > > > No, I've only tested it with a few selected drivers.  I'm going to try the
> > > > > > "async everyone" scenario, though.
> > > > > 
> > > > > On HP nx6325 booted with init=/bin/bash it doesn't pass the
> > > > > 'echo devices > /sys/power/pm_test && echo mem > /sys/power/state' test.
> > > > > 
> > > > > The suspend part actually seems to work, but the resume part crashes
> > > > > miserably.
> > > > 
> > > > Any details?  Can you tell where it crashes?
> > > 
> > > Unfortunately it ends up in a continuous flood of backtraces, so I can't
> > > say much.
> > 
> > Same sort of thing happened with me, but it appeared to happen during 
> > suspend.  (I say "appeared" because the system froze for a while at the 
> > start of the suspend until I hit a key.  This may be related to all the 
> > recent churn in the TTY layer, combined with the fact that I was using 
> > a serial console.  It didn't help -- none of the backtraces got sent 
> > out the serial port.)
> > 
> > > However, if I set async_suspend for all PCI devices, as well as for ACPI battery
> > > and i8042, everything apparently works, even with real suspend-resume.
> > 
> > I think it would be worthwhile to track down these unknown problems and 
> > dependencies.  It won't be easy, though...
> 
> Agreed.

One data point: I set async_syspend for all ACPI devices in addition to PCI
devices and that broke things.

Which isn't really strange given that PCI devices generally have ACPI
counterparts linked to them that I guess should be suspended later.

Thanks,
Rafael
