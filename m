From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: Cherryview wake up events
Date: Tue, 20 Sep 2016 12:18:40 +0300
Message-ID: <20160920091840.GN1811@lahna.fi.intel.com>
References: <20160919112117.55dim46nmqdmqjan@sig21.net>
 <20160919115619.GF1811@lahna.fi.intel.com>
 <20160919203622.ujh4l5eudrncv3rl@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160919203622.ujh4l5eudrncv3rl@sig21.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Sep 19, 2016 at 10:36:22PM +0200, Johannes Stezenbach wrote:
> On Mon, Sep 19, 2016 at 02:56:19PM +0300, Mika Westerberg wrote:
> > On Mon, Sep 19, 2016 at 01:21:17PM +0200, Johannes Stezenbach wrote:
> > > 
> > > The LID causes a gpio irq:
> > >  158:          2          0          0          0  chv-gpio   43 ACPI:Event
> > > 
> > > However, neither LID nor power button can wake up the
> > > device from "echo freeze >/sys/power/state".  :-(
> > 
> > The cherryview pinctrl driver does not (yet) support wake up events. It
> > currently just sets IRQCHIP_SKIP_SET_WAKE for the irqchip.
> 
> OK, but shouldn't the wakeup usually be handled by ACPI?
> Clearly I don't understand this.  I mean on the non-ACPI
> embedded ARM systems I'm used to I need to enable specific
> irqs as wakeup sources, but on ACPI, isn't SCI the implicit
> wakeup irq?  Probably I'm just totally confused, so let
> me ask another way, below.

It is typically handled by ACPI but it requires some hardware as well.
Looks like your machine does not use SCIs at all but instead events are
triggered using GPIO signals instead of GPEs.

> > I can make you a test patch which adds support for wakes for the pinctrl
> > driver if you like to test it out. However, that will happen most likely
> > near end of the week as I have other things right now.
> 
> That would be great!
> 
> 
> I found in the DSDT:
> 
>     Scope (_SB.GPO0)
>     {
>         Name (EVBF, Buffer (0x03) {})
>         CreateByteField (EVBF, Zero, EVST)
>         CreateByteField (EVBF, One, ELEN)
>         CreateByteField (EVBF, 0x02, ENVT)
>         Name (LIDZ, One)
>         Method (_E4E, 0, Serialized)  // _Exx: Edge-Triggered GPE
>         {
>             Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
>             If (^^PCI0.I2C1.AVBL != One)
>             {
>                 Return (Zero)
>             }
> 
>             EVBF = ^^PCI0.I2C1.ENID /* \_SB_.PCI0.I2C1.ENID */
> ...
>             _T_0 = ENVT /* \_SB_.GPO0.ENVT */
> ...
>                 ElseIf (_T_0 == 0xA9)
>                 {
>                     Notify (PWRB, 0x80) // Status Change
>                     Break
>                 }
> 
> and
>         Device (GPO0)
>         {
> ...
>             Method (_AEI, 0, NotSerialized)  // _AEI: ACPI Event Interrupts
>             {
>                 Name (WBUF, ResourceTemplate ()
>                 {
>                     GpioInt (Edge, ActiveLow, ExclusiveAndWake, PullUp, 0x0000,
>                         "\\_SB.GPO0", 0x00, ResourceConsumer, ,
>                         )
>                         {   // Pin list
>                             0x004E
>                         }
>                 })
>                 If (OSID == One)
>                 {
>                     Return (WBUF) /* \_SB_.GPO0._AEI.WBUF */
>                 }
>             }
> 
> and OSID is a field in 
>     OperationRegion (GNVS, SystemMemory, 0x7A158000, 0x0362)
> which is inside what /proc/iomem lists as "ACPI no-volatile storage".
> OSID is read a lot in the DSDT but never written to.
> But calling \_SB.GPO0._AEI in acpidbg returns a buffer of size 25.
> 
> Now my question is, is this pin 0x004E the same as this
> in /proc/interrupts which fires on LID event?
> 
>  158:          2          0          0          0  chv-gpio   43 ACPI:Event

Yes, it is that one and it triggers \_SB.GPO0._E4E() method to be called
whenever low edge is detected on the GPIO line. This method then handles
many things depending on what the AML code reads from ^^PCI0.I2C1.ENID
notifying the power button device (PWRB) among other things.

I suppose you already have CONFIG_ACPI_I2C_OPREGION=y in your .config?
That allows the AML code to access the I2C bus using the I2C driver.

> The FADT has
>             Control Method Power Button (V1) : 0
>             Control Method Sleep Button (V1) : 1
> 
> PWRBTN_EN in PM1 is set.  But PWRBTN press causes thermal irq.

Yeah, it uses control method power button (PNP0C0C) and ACPI GPIO event
to trigger changes in that.

> No SCI (irq 9) is ever generated, except by writing to the
> BIOS_RLS bit in SMI_EN register (IO port 0x430).
> 
> GPE block addresses in FADT are 0.  GPE0a_EN register (IO 0x428)
> is set to 0x6000 (TCO_EN + PME_B0_EN, but none of the GPIO enables).
> 
> Any advice how to continue?

Please check that you have that CONFIG_ACPI_I2C_OPREGION=y and
CONFIG_MFD_AXP20X=y.

You should see the ACPI:Event interrupt count increasing in
/proc/interrups when you press power button. When that works then we can
start thinking about adding wake support :)
