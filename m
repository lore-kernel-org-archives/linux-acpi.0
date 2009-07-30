From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: USB runtime D3
Date: Thu, 30 Jul 2009 14:57:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0907301447080.6087-100000@iolanthe.rowland.org>
References: <20090730020623.GB26389@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:59746 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750966AbZG3S5s (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Jul 2009 14:57:48 -0400
In-Reply-To: <20090730020623.GB26389@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, 30 Jul 2009, Matthew Garrett wrote:

> I've been playing with putting host controllers into D3 when the root 
> hub is suspended, with a certain amount of success. My current 
> implementation simply calls the suspend and resume functions in the HCD 
> device's pm struct on bus_suspend and bus_resume. It's also necessary to 
> flag the ACPI GPEs for the HCDs as runtime and enabled in order to get 
> wakeup events. This is good enough for already plugged devices to work, 
> and running lsusb powers up any idle ports and notices that devices have 
> been plugged in. I also get an event when devices are unplugged.
> 
> This is obviously not entirely ideal, for a couple of reasons.
> 
> The first is that UHCI works perfectly providing I provide a remote 
> wakeup. An SCI is fired via ACPI, a notification is sent to the 
> appropriate device and we resume it quite happily. Unplugs also trigger 
> the ACPI event. However, plugging in doesn't generate any kind of wakeup 
> event, even though port0en and port1n are set in USB_RES. Is there any 
> way to get UHCI to do this? I'm guessing that the power is being cut to 
> the port when it suspends with no device connected.

No, that doesn't sound right.  On the other hand, there's only one way 
to find out for certain.  Voltmeters do come in handy at times...

UHCI isn't very flexible or configurable.  It doesn't sound like 
there's anything more you can do about this.

> The second is that EHCI generates a PME# notification on device plugin. 
> This triggers an SCI and the PME# notification shows up as a GPE event. 
> This causes the kernel to evaluate _L0D. On this Dell, that looks 
> something like this:
> 
> _L0D {
> 	SMI(foo, Local0)
> 	if (Local0 & 0x1)
> 		Notify(some hardware)
> 	if (Local0 & 0x2)
> 		Notify(EHCI)
> 	if (Local0 & 0x4)
> 		Notify(EHCI 2)
> }
> 
> However, Local0 ends up being 0 and no notification is fired. I'm 
> therefore not able to acknowledge the PME and it fires again. This is 
> obviously not ideal. Does anyone have any idea why this might be? The 
> fact that this ends up in SMI code obviously makes things more awkward.
> 
> I've thought of a way that this could be made to work, but it's kind of 
> hacky. A generic GPE handler could be registered and then scan all PCIe 
> devices for a raised PME bit.

Something like that is probably needed anyway -- for all PCI devices, 
not just PCIe.  You have to do this on systems that support PCI-PM but 
don't have ACPI.

> It could then flag it and send a 
> notification to the attached driver. EHCI could then force a rescan of 
> all currently powered off USB devices.

It should send the notification for each such device to the bus
subsystem (i.e., the PCI core).  The bus is then responsible for
telling the drivers what to do.

> The downside to this (other than it being a hack) is that I can't see an 
> obvious way to work out what the appropriate GPE is. On Intel, internal 
> PCI devices generate an event on GPE 0xd - but the PCI object only 
> claims 0xb in its _PRW object.
> 
> Anyone have any ideas? I've attached the current version of my code, 
> which is hacked up in various ways as I try to understand what's going 
> on but should give some idea what I'm trying.

Ugh...  Hacked is right.  I can't comment on the ACPI stuff, but the
USB parts are a mess.  You put stuff in the USB core that really
belongs in the PCI core and you put stuff in the kernel that belongs in
userspace.  Of course, there's nothing wrong with doing this as part of
a "proof-of-principle" thing.

Alan Stern

