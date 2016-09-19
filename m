From: Johannes Stezenbach <js@sig21.net>
Subject: Cherryview wake up events
Date: Mon, 19 Sep 2016 13:21:17 +0200
Message-ID: <20160919112117.55dim46nmqdmqjan@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.sig21.net ([80.244.240.74]:41099 "EHLO mail.sig21.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750825AbcISLVX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Sep 2016 07:21:23 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

Hi,

Mika, I've been reading the thread about pinctrl-cherryview
interrupts, but I have some basic questions in understanding
the hardware and the relationship between ACPI and Linux drivers,
so I decided to start a new thread.
https://lkml.kernel.org/g/20160909085832.GK15313@lahna.fi.intel.com

I have one Asus E200HA (Atom x5-Z8300) where the power button
doesn't generate any ACPI events (no SCI), instead it causes
a Thermal Event irq:

 TRM:          3          3          3          4   Thermal event interrupts

[   51.825488] CPU0: Core temperature above threshold, cpu clock throttled (total events = 1)
[   51.826933] CPU1: Core temperature above threshold, cpu clock throttled (total events = 1)
[   51.826965] mce: [Hardware Error]: Machine check events logged
[   51.841180] mce: [Hardware Error]: Machine check events logged

(These events are logged only sometimes, usually a power button
press only increments the TRM count.)

I would like to understand how this is possible, when I boot
with apic=debug I can't see anything claiming vector 0xfa.

The LID causes a gpio irq:
 158:          2          0          0          0  chv-gpio   43 ACPI:Event

However, neither LID nor power button can wake up the
device from "echo freeze >/sys/power/state".  :-(

"grep . /sys/firmware/acpi/interrupts/*" shows only zeros.

I put the DSDT and some other tables at:
https://linuxtv.org/~js/e200ha/

During the last weeks I read what I could about the hardware
and ACPI, and poked at it with acpidbg, devmem, ioport
and in kernel source, but to no avail.

On Thu, Sep 15, 2016 at 06:52:10PM +0300, Mika Westerberg wrote:
> It turns out that for north and southwest communities, they can only
> generate GPIO interrupts for lower 8 interrupts (IntSel value). The upper
> part (8-15) can only generate GPEs (General Purpose Events).

I got the Atom Z8000 series datasheet from
http://www.intel.com/content/www/us/en/processors/atom/atom-technical-resources.html
and tried to find the source for this.  The closest I
could find is the GPIO_ROUT PMC register?
However, the datasheet doesn't tell about the other
interrupts not covered by GPIO_ROUT, if they are fixed
IRQ or SCI or "no effect".

I also don't get the mapping from intsel irq to IO-APIC pin
number.  And also not the mapping between the pin numbers used
on DSDT GpioInt to the pin numbers in pinctrl-cherryview.c.
Could you shed a light on this?  Or point out where I can
find information?

It seems to imply BIOS sets up IntSel.  I'm generally confused
about the responsibility of BIOS vs. drivers making use of the
information from DSDT, e.g. Device (GPO1) has a list of
GpioIo Connections, other devices like PMI2 use GpioInt
from GPO1.  My E200HA has the INT33F5 TI PMIC
Controller, which according to Windows driver strings
seems to be the SND9039.
Does it mean I need a PMIC driver that reads the _CRS and
configures the GPIO?

BTW, the datasheet talks about 4 seconds for power button
override, but it takes 10 seconds.  Maybe it means the
power button is connected to the TI PMIC, not to the
Cherryview SoC?

Another question is about the virtual GPIO device that exists
in hardware and is used by DSDT.  How does that work and
why does pinctrl-cherryview.c exclude it?

Sorry for so many questions, any info is appreciated,
and any suggestion what to try to get the thing to
wake up from freeze.

I was totally unfamiliar with ACPI until now, but I think
the DSDT has some nasty surprise in several _REG methods
that use OEM defined OperatingRegionIds to set some availabilty
flags that are tested in other methods.  So it means if the
Windows drivers aren't loaded, those methods won't do anything,
right? Does anyone have suggestions or even examples how to deal with this?


Thanks,
Johannes
