From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 06/13] gpio / ACPI: Add support for _DSD device properties
Date: Wed, 15 Oct 2014 11:46:20 +0300
Message-ID: <20141015084620.GO2255@lahna.fi.intel.com>
References: <2660541.BycO7TFnA2@vostro.rjw.lan>
 <1651636.CsIdshL7Av@vostro.rjw.lan>
 <20141014134403.66480C408A6@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141014134403.66480C408A6@trevor.secretlab.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Darren Hart <dvhart@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Oct 14, 2014 at 03:44:03PM +0200, Grant Likely wrote:
> On Tue, 07 Oct 2014 02:15:18 +0200
> , "Rafael J. Wysocki" <rjw@rjwysocki.net>
>  wrote:
> > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > 
> > With release of ACPI 5.1 and _DSD method we can finally name GPIOs (and
> > other things as well) returned by _CRS. Previously we were only able to
> > use integer index to find the corresponding GPIO, which is pretty error
> > prone if the order changes.
> > 
> > With _DSD we can now query GPIOs using name instead of an integer index,
> > like the below example shows:
> > 
> >   // Bluetooth device with reset and shutdown GPIOs
> >   Device (BTH)
> >   {
> >       Name (_HID, ...)
> > 
> >       Name (_CRS, ResourceTemplate ()
> >       {
> >           GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly,
> >                   "\\_SB.GPO0", 0, ResourceConsumer) {15}
> >           GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly,
> >                   "\\_SB.GPO0", 0, ResourceConsumer) {27, 31}
> >       })
> > 
> >       Name (_DSD, Package ()
> >       {
> >           ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> >           Package ()
> > 	  {
> >               Package () {"reset-gpio", Package() {^BTH, 1, 1, 0 }},
> >               Package () {"shutdown-gpio", Package() {^BTH, 0, 0, 0 }},
> >           }
> >       })
> >   }
> > 
> > The format of the supported GPIO property is:
> > 
> >   Package () { "name", Package () { ref, index, pin, active_low }}
> > 
> >   ref - The device that has _CRS containing GpioIo()/GpioInt() resources,
> >         typically this is the device itself (BTH in our case).
> >   index - Index of the GpioIo()/GpioInt() resource in _CRS starting from zero.
> >   pin - Pin in the GpioIo()/GpioInt() resource. Typically this is zero.
> >   active_low - If 1 the GPIO is marked as active_low.
> > 
> > Since ACPI GpioIo() resource does not have field saying whether it is
> > active low or high, the "active_low" argument can be used here. Setting
> > it to 1 marks the GPIO as active low.
> > 
> > In our Bluetooth example the "reset-gpio" refers to the second GpioIo()
> > resource, second pin in that resource with the GPIO number of 31.
> > 
> > This patch implements necessary support to gpiolib for extracting GPIOs
> > using _DSD device properties.
> 
> Patch looks good, but please put the above description into
> /Documentation until we've got a better place to document extra bindings.

Thanks for the review.

If you don't mind, I would like to make a separate patch on top of this
series adding this description to Documentation/acpi/properties.txt.
