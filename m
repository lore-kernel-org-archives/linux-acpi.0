From: Len Brown <lenb@kernel.org>
Subject: Re: controlling ACPI IRQ routing
Date: Sat, 29 Dec 2007 03:39:48 -0500
Message-ID: <200712290339.48354.lenb@kernel.org>
References: <47742083.5060903@howardsilvan.com> <477489B8.20700@howardsilvan.com> <1198821979.20548.9.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47125 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752479AbXL2IkL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 29 Dec 2007 03:40:11 -0500
In-Reply-To: <1198821979.20548.9.camel@sli10-desk.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Lee Howard <faxguy@howardsilvan.com>, linux-acpi@vger.kernel.org

On Friday 28 December 2007 01:06, Shaohua Li wrote:
> 
> On Thu, 2007-12-27 at 21:29 -0800, Lee Howard wrote:
> > Shaohua Li wrote:
> > > In IOAPIC mode, interrupt priority isn't related with the pin (in your
> > > case, irq 16 or 19), but the vector of the pin. How vector of a pin is
> > > allocated is quite random. Usually driver who calls pci_enable_device
> > > earier will get a lower priority vector.
> > 
> > You used the words "random" and "usually".  Could you elaborate on
> > the 
> > randomness and when usually doesn't apply?
> > 
> > So the means to prioritize a driver is to see that it gets installed 
> > earlier?  There is no other mechanism to "reserve" pin vector 
> > allocations for a specific device or driver?

> Currently vector is allocated when pci_enable_device is called. So which
> vector is allocated depends on how many drivers already called the
> routine. The first vector is 0x31, later higher priority (higher) vector
> will be allocated. In latest kernel, a vector of a irq could be variable
> when irq affinity is set, so it's much complex. There is no existing
> method to reserve a vector for a device.

1000 interrupts/second isn't a lot on modern hardware.
Indeed, many linux distros run with 1000 clock ticks/second today.

I don't understand why interrupt priority has anything to do
with what you are seeing.  To notice such a thing, you'd have
to have a lot of competing interrupts firing at the same time
and the messages queued up inside the LAPIC and the processor
spending a large % of its time in interrupt context.
(does top(1) say that you're running a large %sys?)

What is the total interrupt rate on the system when this
device is doing 1000/second?

Are there multiple cores on the system?  If so,
are the interrupts bound to certain cores or is
irqbalance running?

-Len

