From: Mattia Dongili <malattia@linux.it>
Subject: Re: [linux-pm] Re: [2.6.22-rc1-mm1] vaio laptop (SZ72B) immediately resumes after STR
Date: Fri, 22 Jun 2007 18:22:59 +0900
Message-ID: <20070622092258.GC25100@inferi.kami.home>
References: <20070621064215.GB9050@inferi.kami.home> <Pine.LNX.4.44L0.0706211132470.3547-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi13.ns.itscom.net ([219.110.2.183]:34695 "EHLO
	mtoichi13.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbXFVJYP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Jun 2007 05:24:15 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0706211132470.3547-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Zhang Rui <rui.zhang@intel.com>, David Brownell <dbrownell@users.sourceforge.net>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org

On Thu, Jun 21, 2007 at 11:45:36AM -0400, Alan Stern wrote:
> On Thu, 21 Jun 2007, Mattia Dongili wrote:
> 
> > > The log shows suspicious behavior on the part of the Sony UMH-U09
> > > device, the first one in your ehci-only list above.  When it was
> > > suspended it apparently disconnected itself from the USB bus, thereby
> > > triggering a wakeup signal.  If at all possible, try unplugging the USB
> > > cable to that device and then see what happens when you suspend.
> > 
> > wow, spotted!
> > 
> > This device is an express card (SD/MMC reader). Do you have any
> > suggestion to make suspend work without any workarounds?
> 
> You mean, do I have any suggestion about how to make the card reader 
> behave properly?  No.  That needs more than a software change...  :-)

ok than we are on the broken HW case...

> > I mean, all of this started by enabling wakeup on the ehci controller
> > USB1	  S3	 disabled  pci:0000:00:1d.0
> > USB2	  S3	 disabled  pci:0000:00:1d.1
> > USB3	  S3	 disabled  pci:0000:00:1d.2
> > USB4	  S3	 disabled  pci:0000:00:1d.3
> > USB7	  S3	 enabled   pci:0000:00:1d.7
> > 
> > and this was triggered when trying to understand if enabling wakeup by
> > default on PCI devices was good or not (and the patch itself was
> > responsible or not for problems).
> > So, from my POV it's either not good or there has to be some way of
> > dealing with disconnecting devices on suspend.
> 
> There _is_ a way: Disable wakeup on that USB controller.
> 
> > Just to simplify, in this situation, if I had an usb mouse attached to
> > this usb controller and removed the mouse while suspended, would the
> > laptop wakeup?
> 
> If the USB controller was enabled for wakeup and was working correctly,
> it would wake up the laptop.  USB wakeup events are defined as: new
> connection, disconnection, overcurrent, plus any wakeup requests
> received from devices on the USB bus.
> 
> > If so that's not what I most probably want. :)
> 
> Maybe we should change the kernel so that the default wakeup setting 
> for USB controllers is disabled.  Then people would have to enable 
> wakeup explicitly if they wanted to be able to start up their system by 
> typing on a USB keyboard, for instance.

Don't know, I guess this could be easy automated in userspace actually.
But if connect/disconnect are wakeup events my vote goes to default to
disabled for usb controllers and manage selective enable with some nice
userspace tool. Not that my opinion counts that much :)

> > > You also ought to be able to prevent this immediate resume by disabling
> > > wakeup on the EHCI controller.  For example:
> > > 
> > > 	echo disable >/sys/bus/usb/devices/usb5/power/wakeup
> > > 	echo disable >/sys/bus/usb/devices/usb5/../power/wakeup
> > 
> > that doesn't seem to work very well (on -rc5 at least):
> > $ echo disable > /sys/bus/usb/devices/usb2/power/wakeup
> > echo: write error: invalid argument
> > 
> > The only value that seems to be accepted is 0 but reading the value
> > gives always "enabled".
> 
> Whoops, yes, it should be "disabled" instead of "disable".  And of 
> course you have to use the correct USB bus number in the path -- I 
> wrote usb5 because that was the bus number of the EHCI controller in 
> your log.

yes, sorry. That device is usb2 with uhci and becomes usb5 with ehci
loaded.

-- 
mattia
:wq!
