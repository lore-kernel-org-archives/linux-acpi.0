From: Johannes Stezenbach <js@sig21.net>
Subject: Re: Cherryview wake up events
Date: Tue, 20 Sep 2016 12:14:50 +0200
Message-ID: <20160920101450.ylohouriienzrgtj@sig21.net>
References: <20160919112117.55dim46nmqdmqjan@sig21.net>
 <20160919115619.GF1811@lahna.fi.intel.com>
 <20160919203622.ujh4l5eudrncv3rl@sig21.net>
 <20160920091840.GN1811@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.sig21.net ([80.244.240.74]:45043 "EHLO mail.sig21.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932560AbcITKPA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 20 Sep 2016 06:15:00 -0400
Content-Disposition: inline
In-Reply-To: <20160920091840.GN1811@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Sep 20, 2016 at 12:18:40PM +0300, Mika Westerberg wrote:
> On Mon, Sep 19, 2016 at 10:36:22PM +0200, Johannes Stezenbach wrote:
> > Now my question is, is this pin 0x004E the same as this
> > in /proc/interrupts which fires on LID event?
> > 
> >  158:          2          0          0          0  chv-gpio   43 ACPI:Event
> 
> Yes, it is that one and it triggers \_SB.GPO0._E4E() method to be called
> whenever low edge is detected on the GPIO line. This method then handles
> many things depending on what the AML code reads from ^^PCI0.I2C1.ENID
> notifying the power button device (PWRB) among other things.

Thanks for confirmation, but it circles back to the question
how to map the numbers.  Since the document that describes it
is not public, it would be useful if you could add comments
to pinctrl-cherryview.c that describes it.
Or did I just miss something?

> I suppose you already have CONFIG_ACPI_I2C_OPREGION=y in your .config?
> That allows the AML code to access the I2C bus using the I2C driver.
> 
> > The FADT has
> >             Control Method Power Button (V1) : 0
> >             Control Method Sleep Button (V1) : 1
> > 
> > PWRBTN_EN in PM1 is set.  But PWRBTN press causes thermal irq.
> 
> Yeah, it uses control method power button (PNP0C0C) and ACPI GPIO event
> to trigger changes in that.

I'm confused again because I thought "Control Method Power Button (V1) : 0"
means it is a fixed power button, however the DSDT also has

        Device (PWRB)
        {
            Name (_HID, EisaId ("PNP0C0C") /* Power Button Device */)  // _HID: Hardware ID
        }

        Device (SLPB)
        {
            Name (_HID, EisaId ("PNP0C0E") /* Sleep Button Device */)  // _HID: Hardware ID
        }


> > No SCI (irq 9) is ever generated, except by writing to the
> > BIOS_RLS bit in SMI_EN register (IO port 0x430).
> > 
> > GPE block addresses in FADT are 0.  GPE0a_EN register (IO 0x428)
> > is set to 0x6000 (TCO_EN + PME_B0_EN, but none of the GPIO enables).
> > 
> > Any advice how to continue?
> 
> Please check that you have that CONFIG_ACPI_I2C_OPREGION=y and
> CONFIG_MFD_AXP20X=y.
> 
> You should see the ACPI:Event interrupt count increasing in
> /proc/interrups when you press power button. When that works then we can
> start thinking about adding wake support :)

I had CONFIG_ACPI_I2C_OPREGION=y but excluded CONFIG_MFD_AXP20X
based on \_SB.PIC0.I2C7.PMI1._STA returning 0 in acpidbg,

            Device (PMI1)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "INT33F4" /* XPOWER PMIC Controller */)  // _HID: Hardware ID
                Name (_CID, "INT33F4" /* XPOWER PMIC Controller */)  // _CID: Compatible ID
                Name (_DDN, "XPOWER PMIC Controller")  // _DDN: DOS Device Name

but \_SB.PIC0.I2C7.PMI1._STA returns 0xf

            Device (PMI2)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Name (_HID, "INT33F5" /* TI PMIC Controller */)  // _HID: Hardware ID
                Name (_CID, "INT33F5" /* TI PMIC Controller */)  // _CID: Compatible ID
                Name (_DDN, "TI PMIC Controller")  // _DDN: DOS Device Name

So I tried CONFIG_MFD_AXP20X=y anyway, but as expected: no change.

Since TI doesn't even have a product page for the SND9039
(only a few references in TI support forum can be found),
I'm not sure what can be done.  So maybe a better short term
goal would be to get wakeup by LID working.

However, I still wonder why the power button can trigger
a thermal irq, is it related to the PMIC?  I couldn't
find out where the thermal irq is routed.


Thanks,
Johannes
