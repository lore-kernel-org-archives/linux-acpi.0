From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] gpio / ACPI: Add support for retrieving GpioInt
 resources from a device
Date: Tue, 5 May 2015 15:29:54 +0300
Message-ID: <20150505122954.GD1541@lahna.fi.intel.com>
References: <1430233507-29389-1-git-send-email-mika.westerberg@linux.intel.com>
 <1430233507-29389-2-git-send-email-mika.westerberg@linux.intel.com>
 <1988723.gb0XCG22Xj@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1988723.gb0XCG22Xj@vostro.rjw.lan>
Sender: linux-gpio-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Octavian Purdila <octavian.purdila@intel.com>, Robert Dolca <robert.dolca@intel.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, May 05, 2015 at 01:47:36AM +0200, Rafael J. Wysocki wrote:
> On Tuesday, April 28, 2015 06:05:06 PM Mika Westerberg wrote:
> > ACPI specification knows two types of GPIOs: GpioIo and GpioInt. The latter
> > is used to describe that a given device interrupt line is connected to a
> > specific GPIO pin. Typical ACPI _CRS entry for such device looks like
> > below:
> > 
> >     Name (_CRS, ResourceTemplate ()
> >     {
> >         I2cSerialBus (0x004A, ControllerInitiated, 0x00061A80,
> >                       AddressingMode7Bit, "\\_SB.PCI0.I2C6",
> >                       0x00, ResourceConsumer)
> >         GpioIo (Exclusive, PullDefault, 0x0000, 0x0000,
> >                 IoRestrictionOutputOnly, "\\_SB.GPO0",
> >                 0x00, ResourceConsumer)
> >         {
> >             0x004B
> >         }
> >         GpioInt (Level, ActiveLow, Shared, PullDefault, 0x0000,
> >                  "\\_SB.GPO0", 0x00, ResourceConsumer)
> >         {
> >             0x004C
> >         }
> >     })
> > 
> > Currently drivers need to request a GPIO corresponding to the right GpioInt
> > and then translate that to Linux IRQ number. This adds unnecessary lines of
> > boiler-plate code.
> > 
> > We can ease this a bit by introducing acpi_dev_gpio_irq_get() analogous to
> > of_irq_get(). This function translates given GpioInt resource under the
> > device in question to the suitable Linux IRQ number.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks Rafael.

I'm going to change the other patch a bit to address conserns from
Wolfram so that we will use irq == 0 to indicate an invalid interrupt
instead of -1.
