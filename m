From: Tino Keitel <tino.keitel@gmx.de>
Subject: Re: [linux-pm] /proc/acpi/wakeup regression in 2.6.39-rc3
Date: Fri, 15 Apr 2011 16:54:57 +0200
Message-ID: <20110415145457.GA27650@eazy.amigager.de>
References: <201104150053.37037.rjw@sisk.pl> <Pine.LNX.4.44L0.1104151034580.2051-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eazy.amigager.de ([213.239.192.238]:58147 "EHLO
	eazy.amigager.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab1DOPCK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Apr 2011 11:02:10 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1104151034580.2051-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org

On Fri, Apr 15, 2011 at 10:38:47 -0400, Alan Stern wrote:
> On Fri, 15 Apr 2011, Rafael J. Wysocki wrote:
> 
> > On Friday, April 15, 2011, Tino Keitel wrote:
> > > Hi,
> > > 
> > > with 2.6.38, I enabled wakeup from suspend to RAM with the USB keyboard
> > > this way:
> > > 
> > > echo USB2 > /proc/acpi/wakeup
> > > 
> > > This does not work anymore with 2.6.39-rc3. Wakeup using the keyboard
> > > won't work, and the USB2 line in /proc/acpi/wakeup doesn't change to
> > > "enabled" after the echo command.
> > > 
> > > Is this intended? If yes, what is the new way to enable keyboard
> > > wakeup?
> > 
> > No, it's supposed to work IIRC.  I'll have a look at that code tomorrow.
> 
> Tino, can you check the contents of the power/wakeup files in the
> appropriate sysfs directories?  That would be the directory for the
> keyboard device itself and the directory for the USB host controller
> for the bus the keyboard is on.
> 
> By default, power/wakeup should be "enabled" for the keyboard device 
> and "disabled" for the host controller.  If you write "enabled" into 
> the host controller's file by hand, does that fix the problem?

I already tried to write "enable" into all USB related wakeup files
yesterday, not change.

I'll check again how these files look like in 2.6.38, what sysfs
wakeup files change when writing into /proc/acpi/wakeup, and what
differences to 2.6.39-rc can be seen.

Regards,
Tino
