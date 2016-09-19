From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: Cherryview wake up events
Date: Mon, 19 Sep 2016 14:56:19 +0300
Message-ID: <20160919115619.GF1811@lahna.fi.intel.com>
References: <20160919112117.55dim46nmqdmqjan@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160919112117.55dim46nmqdmqjan@sig21.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Sep 19, 2016 at 01:21:17PM +0200, Johannes Stezenbach wrote:
> Hi,
> 
> Mika, I've been reading the thread about pinctrl-cherryview
> interrupts, but I have some basic questions in understanding
> the hardware and the relationship between ACPI and Linux drivers,
> so I decided to start a new thread.
> https://lkml.kernel.org/g/20160909085832.GK15313@lahna.fi.intel.com
> 
> I have one Asus E200HA (Atom x5-Z8300) where the power button
> doesn't generate any ACPI events (no SCI), instead it causes
> a Thermal Event irq:
> 
>  TRM:          3          3          3          4   Thermal event interrupts
> 
> [   51.825488] CPU0: Core temperature above threshold, cpu clock throttled (total events = 1)
> [   51.826933] CPU1: Core temperature above threshold, cpu clock throttled (total events = 1)
> [   51.826965] mce: [Hardware Error]: Machine check events logged
> [   51.841180] mce: [Hardware Error]: Machine check events logged
> 
> (These events are logged only sometimes, usually a power button
> press only increments the TRM count.)

Hmm, that's weird.

> I would like to understand how this is possible, when I boot
> with apic=debug I can't see anything claiming vector 0xfa.
> 
> The LID causes a gpio irq:
>  158:          2          0          0          0  chv-gpio   43 ACPI:Event
> 
> However, neither LID nor power button can wake up the
> device from "echo freeze >/sys/power/state".  :-(

The cherryview pinctrl driver does not (yet) support wake up events. It
currently just sets IRQCHIP_SKIP_SET_WAKE for the irqchip.

> "grep . /sys/firmware/acpi/interrupts/*" shows only zeros.
> 
> I put the DSDT and some other tables at:
> https://linuxtv.org/~js/e200ha/
> 
> During the last weeks I read what I could about the hardware
> and ACPI, and poked at it with acpidbg, devmem, ioport
> and in kernel source, but to no avail.
> 
> On Thu, Sep 15, 2016 at 06:52:10PM +0300, Mika Westerberg wrote:
> > It turns out that for north and southwest communities, they can only
> > generate GPIO interrupts for lower 8 interrupts (IntSel value). The upper
> > part (8-15) can only generate GPEs (General Purpose Events).
> 
> I got the Atom Z8000 series datasheet from
> http://www.intel.com/content/www/us/en/processors/atom/atom-technical-resources.html
> and tried to find the source for this.  The closest I
> could find is the GPIO_ROUT PMC register?
> However, the datasheet doesn't tell about the other
> interrupts not covered by GPIO_ROUT, if they are fixed
> IRQ or SCI or "no effect".

Source for this information is coming from an internal documentation for
the SoC. For some reason it is not included in the datasheet.

> I also don't get the mapping from intsel irq to IO-APIC pin
> number.  And also not the mapping between the pin numbers used
> on DSDT GpioInt to the pin numbers in pinctrl-cherryview.c.
> Could you shed a light on this?  Or point out where I can
> find information?

IntSel field is RO and filled in by the BIOS. The mapping from IntSel
and I/O-APIC pins seems also missing from the datasheet but for example
for north community, IntSel 0-7 maps to I/O-APIC pins 51-58 (and OR of
those is 48).

> It seems to imply BIOS sets up IntSel.  I'm generally confused
> about the responsibility of BIOS vs. drivers making use of the
> information from DSDT, e.g. Device (GPO1) has a list of
> GpioIo Connections, other devices like PMI2 use GpioInt
> from GPO1.  My E200HA has the INT33F5 TI PMIC
> Controller, which according to Windows driver strings
> seems to be the SND9039.
> Does it mean I need a PMIC driver that reads the _CRS and
> configures the GPIO?

The GPIOs under GPIO controller are generally used for either ACPI GPIO
events or GPIO Operation Region. Those are used by the AML code to
access the GPIO hardware with the help of OS.

The INT33F5 PMIC from your DSDT table seems to have one GpioInt()
resource which it uses as an interrupt. This is handled already by the
I2C core. In order to use that PMIC you need a driver and I'm not sure
if there is one for that particular part.

> BTW, the datasheet talks about 4 seconds for power button
> override, but it takes 10 seconds.  Maybe it means the
> power button is connected to the TI PMIC, not to the
> Cherryview SoC?

Or it may be handled by the embedded controller itself. The FADT ACPI
table should tell you if it has "fixed power button" or is it using some
other mechanism (like control method power button).

> Another question is about the virtual GPIO device that exists
> in hardware and is used by DSDT.  How does that work and
> why does pinctrl-cherryview.c exclude it?

Because it is "virtual" and does not expose any hardware. The
pinctrl-cherryview deals only with the GPIO block found on
Braswell/Cherryview.

IIRC that virtual GPIO thing was used to fix USB device wakeup or
something like that.

> Sorry for so many questions, any info is appreciated,
> and any suggestion what to try to get the thing to
> wake up from freeze.

I can make you a test patch which adds support for wakes for the pinctrl
driver if you like to test it out. However, that will happen most likely
near end of the week as I have other things right now.

> I was totally unfamiliar with ACPI until now, but I think
> the DSDT has some nasty surprise in several _REG methods
> that use OEM defined OperatingRegionIds to set some availabilty
> flags that are tested in other methods.  So it means if the
> Windows drivers aren't loaded, those methods won't do anything,
> right? Does anyone have suggestions or even examples how to deal with this?

Right, a driver is needed. There are bunch of custom OpRegion handlers
under drivers/acpi/pmic/*.
