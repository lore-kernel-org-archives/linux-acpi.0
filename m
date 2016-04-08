From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v7 3/3] gpio: dwapb: add gpio-signaled acpi event support
Date: Fri, 8 Apr 2016 11:38:30 +0300
Message-ID: <20160408083830.GT1727@lahna.fi.intel.com>
References: <1459926480-32966-1-git-send-email-qiujiang@huawei.com>
 <1459926480-32966-4-git-send-email-qiujiang@huawei.com>
 <CACRpkdb63AZtEOSJ0R+EqdHfKXcUr7Hs8fh9N5XHNcWjQ1Ba8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdb63AZtEOSJ0R+EqdHfKXcUr7Hs8fh9N5XHNcWjQ1Ba8A@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: qiujiang <qiujiang@huawei.com>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Alan Tull <delicious.quinoa@gmail.com>, Jamie Iles <jamie@jamieiles.com>, charles.chenxin@huawei.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, Apr 08, 2016 at 10:26:28AM +0200, Linus Walleij wrote:
> On Wed, Apr 6, 2016 at 9:08 AM, qiujiang <qiujiang@huawei.com> wrote:
> 
> > This patch adds gpio-signaled acpi event support. It is used for
> > power button on hisilicon D02 board, an arm64 platform.
> >
> > The corresponding DSDT file is defined as follows:
> >  Device(GPI0) {
> >         Name(_HID, "HISI0181")
> >         Name(_ADR, 0)
> >         Name(_UID, 0)
> >
> >         Name (_CRS, ResourceTemplate ()  {
> >                 Memory32Fixed (ReadWrite, 0x802e0000, 0x10000)
> >                 Interrupt (ResourceConsumer, Level, ActiveHigh,
> >                 Exclusive,,,)  {344}
> >         })
> >
> >         Device(PRTa) {
> >                 Name (_DSD, Package () {
> >                 Package () {
> >                         Package () {"reg",0},
> >                         Package () {"snps,nr-gpios",32},
> >                         }
> >                 })
> >         }
> >
> >         Name (_AEI, ResourceTemplate () {
> >                 GpioInt(Edge, ActiveLow, ExclusiveAndWake,
> >                 PullUp, , " \\_SB.GPI0") {8}
> >         })
> >
> >         Method (_E08, 0x0, NotSerialized) {
> >                 Notify (\_SB.PWRB, 0x80)
> >         }
> > }
> >
> > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: qiujiang <qiujiang@huawei.com>
> 
> Admittedly I'm an ACPI novice and need help with deciding
> about ACPI, but I mostly trust Mika to know these things right.
> 
> About this:
> 
> > +       /* Add GPIO-signaled ACPI event support */
> > +       if (pp->irq)
> > +               acpi_gpiochip_request_interrupts(&port->gc);
> 
> It's weird to me that the driver already has a requested IRQ and
> everything, now it has to request it again from ACPI.

This is different thing, though.

Calling acpi_gpiochip_request_interrupts() results _AEI ACPI method
being evaluated that returns a list of GPIOs which are used as event
sources. acpi_gpiochip_request_interrupts() then goes and installs
interrupt handler per each GPIO in that list.

> When I look into the acpi_gpiochip_request_interrupts()
> I find it weird that it is void given how much can go wrong
> inside it. Should it not return an errorcode?

Currently it just complains if something goes wrong. The GPIO driver
itself can still work just fine (including interrupts).

I'm fine to change it to return an error code.

> > +               if (has_acpi_companion(dev) && pp->idx == 0)
> > +                       pp->irq = platform_get_irq(to_platform_device(dev), 0);
> 
> As it was already fetched here and then later requested,
> we still have to call acpi_gpiochip_request_interrupts()
> further down the road? That is confusing to me, can you
> explain what is going on?

See above.
