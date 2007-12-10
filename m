From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Recent Lenovo ThinkPads define a dummy grahpics
	device, find it and ignore it
Date: Mon, 10 Dec 2007 13:48:26 +0100
Message-ID: <1197290906.28990.329.camel@queen.suse.de>
References: <1197032113.28990.155.camel@queen.suse.de>
	 <20071207225025.GA2055@srcf.ucam.org>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:57291 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751337AbXLJMs3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Dec 2007 07:48:29 -0500
In-Reply-To: <20071207225025.GA2055@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@osdl.org>, "Li, Shaohua" <shaohua.li@intel.com>

On Fri, 2007-12-07 at 22:50 +0000, Matthew Garrett wrote:
> On Fri, Dec 07, 2007 at 01:55:13PM +0100, Thomas Renninger wrote:
> > Hi Matthew,
> > 
> > I posted this one already and you had some concerns about it:
> > http://www.mail-archive.com/linux-acpi@vger.kernel.org/msg09510.html
> > 
> > IMO, this one should still be added to -mm, because:
> >   - The patch itself is correct, it is the function that is called
> >     that must make sure to return the corresponding pci device
> 
> No, I don't think that follows. The semantics of 
> acpi_get_physical_device are currently to return a physical device only 
> if the node directly corresponds to one. What's the correct physical 
> device for the video extension? It may be a PCI device, but it's just as 
> easy to argue that it corresponds to some piece of platform-specific 
> hardware.
What do you mean with "platform-specific" hardware?
A graphics card on an ACPI capable system should always be PCI, PCIe or
AGP driven and a call to acpi_get_physical_device should return its
struct pci structure. AFAIK it may return the bridge device atm, this
could be fixed up later, in this case it does not matter as no values of
the PCI device are needed, it's only needed to check whether it exists
at all and if the bridge exists it's enough.

> We could change the semantics and ensure that all leaf nodes of an ACPI 
> node representing a PCI device share the same physical device. That 
> would avoid the bug your patch currently introduces of ignoring 
> functional devices, but would immediately cause the second video device 
> to reappear on Thinkpads.
I thought it is done that way?
You mean e.g. going up to the PCI bus object and get the bus value, then
get func and slot from the child on which branch our device sits:


         PCI0 (bus0)
         /   \
       XY  
(slot 2, func1)
   /    |     \
  A     B      C

You mean here device A, B and C should all return the pci device at
0:2.1, this should be the case?
It at least was with the "find pci device" func I came up with my very
first patch, before you pointed me to: acpi_get_physical_device

This would also work for ThinkPads:

         PCI0 (bus0)
         /          \
       VID           AGP
(slot2, func0)      (slot1, func0)
                       |
                      VID
                    (ADR 0x00)

Slot, func no.s are made up.
0:1.0 would point to a PCI-PCI bridge, which only exists on external/
      discrete graphics card (with own mem etc.)
      acpi_get_physical_device could get extended to point to the
      real graphics pci device behind the bridge
0:2.0 would point to the internal graphics card sitting on a PCIe bus

> Incidentally, have you tried this on a Thinkpad with a discrete graphics 
> controller? I /suspect/ (but can't verify) that you'll end up discarding 
> the working video extension.
No, it should work, see above.
Brightness switching may not work because the current ACPI
implementation requires a new graphics card driver feature which should
be supported by the latest Intel driver (or at least soon).
Anyway it is the specified mechanism how things should work.

> In summary, I don't think this approach can be made to work.
You cannot check in kernel whether an ACPI graphics device exists, but
you can in userspace? I doubt that.
> You're 
> throwing out legitimate and working devices.
Please prove. I tested this on three totally different machines:
  - Lenovo
  - Toshiba
  - HP
Only recent Vista capable systems should need this, that means those
tests cover a reasonable amount of all video extension supporting
machines.

> Instead, we should export 
> information about the addresses of the video extensions and let 
> whoever's handling the graphics (which is userspace right now) handle 
> it.
No, this is wrong.
Please explain how this should work more detailed, a solution is needed
now.

Currently the video driver is severely broken for a lot machines (at
least Lenovo and Toshiba). Severely means that HW registers are accessed
for which no device exist. E.g. if you hit the brightness up/down button
on a Lenovo ThinkPad, it may happen that the wrong device brightness
functions are served (this is why you may see brightness switching
working with an internal Intel graphics card, because the Nvidia/ATI
external device's brightness functions are processed which also works
with the other device by luck).
On the Toshiba, brightness switching does not work (jumps irregularly)
with both devices registered and it's again luck that the machine is
simply not freezing at all.

   Thomas

