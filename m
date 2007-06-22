From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] Re: [2.6.22-rc1-mm1] vaio laptop (SZ72B) immediately
 resumes after STR
Date: Fri, 22 Jun 2007 10:33:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0706221022190.3290-100000@iolanthe.rowland.org>
References: <200706220308.27447.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:59753 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754493AbXFVOdo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Jun 2007 10:33:44 -0400
In-Reply-To: <200706220308.27447.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, Mattia Dongili <malattia@linux.it>, linux-pm@lists.linux-foundation.org

On Fri, 22 Jun 2007, David Brownell wrote:

> On Wednesday 20 June 2007, Rafael J. Wysocki wrote:
> 
> > Well, there's nothing interesting in there, AFAICS:
> > 
> > Device	S-state	  Status   Sysfs node
> > P0P4	  S4	 disabled  pci:0000:00:1e.0
> > BNIC	  S4	 disabled  pci:0000:02:05.0
> > USB1	  S4	 disabled  pci:0000:00:1d.0
> > USB2	  S4	 disabled  pci:0000:00:1d.1
> > USB3	  S4	 disabled  pci:0000:00:1d.2
> > EUSB	  S4	 disabled  pci:0000:00:1d.7
> > PS2K	  S4	 disabled  pnp:00:0b
> > PS2M	  S4	 disabled  pnp:00:0c
> 
> The interesting thing there is that all those devices are
> able to wake from S4 state ... including USB controllers.
> 
> That's not very common for USB.  EHCI ("EUSB" above) at
> least has a spec for how that should work ... it relies on
> the PCI Vaux power well to maintain power sessions, though
> I don't know that the EHCI code has been tested against
> that part of the spec.  UHCI likely relies on black magic
> to achieve that effect.

"Black magic"?  Intel's datasheet for the ICH4 board documents a 
non-standard PCI register in the UHCI configuration space at address 
0xc4 called "USB_RES USB Resume Enable Register".  The two low-order 
bits determine whether or not the UHCI controller will monitor the two 
USB ports for wakeup events.

But the datasheet says nothing about supplying suspend current to the
ports -- presumably they do remain powered even in S4 or else how could
they generate wakeup events?  And the datasheet says nothing about 
_how_ these events are reported.  The lspci output doesn't show any 
power management capabilities.

I haven't added support for this register to uhci-hcd.  Partly because 
the issue has never arisen and partly because it wasn't clear whether 
the ACPI code would handle it already.

Alan Stern

