From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: Cherryview wake up events
Date: Tue, 20 Sep 2016 13:40:14 +0300
Message-ID: <20160920104014.GO1811@lahna.fi.intel.com>
References: <20160919112117.55dim46nmqdmqjan@sig21.net>
 <20160919115619.GF1811@lahna.fi.intel.com>
 <20160919203622.ujh4l5eudrncv3rl@sig21.net>
 <20160920091840.GN1811@lahna.fi.intel.com>
 <20160920101450.ylohouriienzrgtj@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160920101450.ylohouriienzrgtj@sig21.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Sep 20, 2016 at 12:14:50PM +0200, Johannes Stezenbach wrote:
> On Tue, Sep 20, 2016 at 12:18:40PM +0300, Mika Westerberg wrote:
> > On Mon, Sep 19, 2016 at 10:36:22PM +0200, Johannes Stezenbach wrote:
> > > Now my question is, is this pin 0x004E the same as this
> > > in /proc/interrupts which fires on LID event?
> > > 
> > >  158:          2          0          0          0  chv-gpio   43 ACPI:Event
> > 
> > Yes, it is that one and it triggers \_SB.GPO0._E4E() method to be called
> > whenever low edge is detected on the GPIO line. This method then handles
> > many things depending on what the AML code reads from ^^PCI0.I2C1.ENID
> > notifying the power button device (PWRB) among other things.
> 
> Thanks for confirmation, but it circles back to the question
> how to map the numbers.  Since the document that describes it
> is not public, it would be useful if you could add comments
> to pinctrl-cherryview.c that describes it.
> Or did I just miss something?

I don't think it is relevant here. The driver uses only wired OR
interrupt which is provided in _CRS of the device.

> > I suppose you already have CONFIG_ACPI_I2C_OPREGION=y in your .config?
> > That allows the AML code to access the I2C bus using the I2C driver.
> > 
> > > The FADT has
> > >             Control Method Power Button (V1) : 0
> > >             Control Method Sleep Button (V1) : 1
> > > 
> > > PWRBTN_EN in PM1 is set.  But PWRBTN press causes thermal irq.
> > 
> > Yeah, it uses control method power button (PNP0C0C) and ACPI GPIO event
> > to trigger changes in that.
> 
> I'm confused again because I thought "Control Method Power Button (V1) : 0"
> means it is a fixed power button, however the DSDT also has

I misread it, sorry about that.

Can you check if you have:

  Hardware Reduced (V5) : 1

in that FADT table?

If yes, it probably does not have the normal Fixed power button but
instead it has something called "Windows button array device" with
_HID/_CID of PNP0C40. Looking at your dsdt.dsl, this looks to be the
case.

That device is driven by soc_button_array.c driver which can be enabled
with CONFIG_KEYBOARD_GPIO=y and CONFIG_INPUT_SOC_BUTTON_ARRAY=y. Can you
check if you have that enabled already?

You should actually see it in /proc/interrupts with names like "power"
and so on.
