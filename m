From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v7 3/3] gpio: dwapb: add gpio-signaled acpi event support
Date: Fri, 8 Apr 2016 10:26:28 +0200
Message-ID: <CACRpkdb63AZtEOSJ0R+EqdHfKXcUr7Hs8fh9N5XHNcWjQ1Ba8A@mail.gmail.com>
References: <1459926480-32966-1-git-send-email-qiujiang@huawei.com>
	<1459926480-32966-4-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1459926480-32966-4-git-send-email-qiujiang@huawei.com>
Sender: linux-gpio-owner@vger.kernel.org
To: qiujiang <qiujiang@huawei.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Alan Tull <delicious.quinoa@gmail.com>, Jamie Iles <jamie@jamieiles.com>, charles.chenxin@huawei.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 6, 2016 at 9:08 AM, qiujiang <qiujiang@huawei.com> wrote:

> This patch adds gpio-signaled acpi event support. It is used for
> power button on hisilicon D02 board, an arm64 platform.
>
> The corresponding DSDT file is defined as follows:
>  Device(GPI0) {
>         Name(_HID, "HISI0181")
>         Name(_ADR, 0)
>         Name(_UID, 0)
>
>         Name (_CRS, ResourceTemplate ()  {
>                 Memory32Fixed (ReadWrite, 0x802e0000, 0x10000)
>                 Interrupt (ResourceConsumer, Level, ActiveHigh,
>                 Exclusive,,,)  {344}
>         })
>
>         Device(PRTa) {
>                 Name (_DSD, Package () {
>                 Package () {
>                         Package () {"reg",0},
>                         Package () {"snps,nr-gpios",32},
>                         }
>                 })
>         }
>
>         Name (_AEI, ResourceTemplate () {
>                 GpioInt(Edge, ActiveLow, ExclusiveAndWake,
>                 PullUp, , " \\_SB.GPI0") {8}
>         })
>
>         Method (_E08, 0x0, NotSerialized) {
>                 Notify (\_SB.PWRB, 0x80)
>         }
> }
>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: qiujiang <qiujiang@huawei.com>

Admittedly I'm an ACPI novice and need help with deciding
about ACPI, but I mostly trust Mika to know these things right.

About this:

> +       /* Add GPIO-signaled ACPI event support */
> +       if (pp->irq)
> +               acpi_gpiochip_request_interrupts(&port->gc);

It's weird to me that the driver already has a requested IRQ and
everything, now it has to request it again from ACPI.

When I look into the acpi_gpiochip_request_interrupts()
I find it weird that it is void given how much can go wrong
inside it. Should it not return an errorcode?

> +               if (has_acpi_companion(dev) && pp->idx == 0)
> +                       pp->irq = platform_get_irq(to_platform_device(dev), 0);

As it was already fetched here and then later requested,
we still have to call acpi_gpiochip_request_interrupts()
further down the road? That is confusing to me, can you
explain what is going on?

Yours,
Linus Walleij
