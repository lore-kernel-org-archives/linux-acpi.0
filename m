From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v10 3/3] gpio: dwapb: add gpio-signaled acpi event support
Date: Fri, 29 Apr 2016 11:25:17 +0200
Message-ID: <CACRpkdYHxy7BY8=aZu19RCeyyPvSsivNJjby2wp=x3t0Ape=Qg@mail.gmail.com>
References: <1461835923-68492-1-git-send-email-qiujiang@huawei.com>
	<1461835923-68492-4-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461835923-68492-4-git-send-email-qiujiang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiang Qiu <qiujiang@huawei.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Alan Tull <delicious.quinoa@gmail.com>, Jamie Iles <jamie@jamieiles.com>, charles.chenxin@huawei.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Apr 28, 2016 at 11:32 AM, Jiang Qiu <qiujiang@huawei.com> wrote:

> This patch adds gpio-signaled acpi event support. It is used for
> power button on hisilicon D02 board, an arm64 platform.
>
> The corresponding DSDT file is defined as follows:
> Device(GPI0) {
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
>                 }
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
> Signed-off-by: Jiang Qiu <qiujiang@huawei.com>

Patch applied.

Yours,
Linus Walleij
