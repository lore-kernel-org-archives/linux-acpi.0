From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC PATCH 2/3] PCI: parallel resume for pci devices
 on bus 0
Date: Mon, 22 Dec 2008 10:52:53 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0812221038010.17981-100000@netrider.rowland.org>
References: <1229914579.562.150.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:2246 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753939AbYLVPwz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Dec 2008 10:52:55 -0500
In-Reply-To: <1229914579.562.150.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Barnes, Jesse" <jesse.barnes@intel.com>

On Mon, 22 Dec 2008, Zhang Rui wrote:

> On Fri, 2008-12-19 at 23:09 +0800, Alan Stern wrote:
> > On Fri, 19 Dec 2008, Zhang Rui wrote:
> > 
> > > device parallel resume support for PCI devices
> > 
> > There are some PCI devices which won't work right if they are resumed
> > in parallel.  The example I have in mind is a USB host controller
> > device with both a high-speed EHCI controller function and some
> > companion low/full-speed UHCI or OHCI controller functions.  The EHCI
> > driver relies on the fact that the EHCI controller has a higher
> > function number and therefore is resumed _after_ the companion
> > controllers.
> > 
> well, I never got this problem before.
> is this normal? does this exist on the Intel hardware?
> I'd like to do some test if I have chance.

Yes, it is normal, and it does exist on Intel hardware.  It isn't a 
_problem_ (or at least, it hasn't been a problem up until now) because 
the order of resuming devices is always the same as the order of 
registration, which in turn is the same as the order of discovery.

You can see this on any Intel ICHx chipset.  I don't have an example 
right here, but take a look at the machines you have lying around.  
There are PCI UHCI controllers at 1d.0, 1d.1, ... and a PCI EHCI 
controller at 1d.7.

The issue arises when you have a low-speed or full-speed device plugged 
in.  The device is handed over from the EHCI controller to one of the 
companion UHCI controllers, because EHCI manages only high-speed 
devices.

Now consider what happens when the system wakes up from hibernation.  
The controllers are re-initialized, and when ehci-hcd sees the
low/full-speed device, it tries to hand the device over to the
companion controller again.  But if the EHCI controller's resume method
runs first then the handover will fail, because the companion
controller has not yet been initialized.  As a result, the device will
be lost and will have to go through rediscovery and re-enumeration.  
This could be very annoying if, for example, the device contains a
mounted filesystem.

> Just like the case above, can you give me a lspci output and show me
> what exactly the dependency is?

The dependency is simple: The 1d.7 device must be resumed _after_ 1d.0, 
1d.1, ..., 1d.6.

Alan Stern

