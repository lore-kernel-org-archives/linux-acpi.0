From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 2/2] gpio: designware: add gpio-signaled acpi event support
Date: Mon, 29 Feb 2016 15:54:12 +0200
Message-ID: <CAHp75VeyArt-W16KkvzfK8dMQ6YQA0eWZKqhVn6mMBvtRe1yZw@mail.gmail.com>
References: <1456751596-98963-1-git-send-email-qiujiang@huawei.com>
	<1456751596-98963-3-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:35266 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbcB2NyN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Feb 2016 08:54:13 -0500
In-Reply-To: <1456751596-98963-3-git-send-email-qiujiang@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: qiujiang <qiujiang@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com

On Mon, Feb 29, 2016 at 3:13 PM, qiujiang <qiujiang@huawei.com> wrote:
> This patch adds the support for the gpio-signaled acpi event.
> This is used for power button on hisilicon D02 board, which
> is an arm64 platform.
>
> To support this function, _AEI and _Exx objects must be
> defined in the corresponding GPIO device as follows:
>
>     Name (_AEI, ResourceTemplate () {
>             GpioInt(Edge, ActiveLow, ExclusiveAndWake, PullUp,
>                         , " \\_SB.GPI0") {8}
>     })
>     Method (_E08, 0x0, NotSerialized) {
>         Notify (\_SB.PWRB, 0x80)
>     }
>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

One minor below and
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: qiujiang <qiujiang@huawei.com>
> ---
>  drivers/gpio/gpio-dwapb.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> index 7a37c65..4955112 100644
> --- a/drivers/gpio/gpio-dwapb.c
> +++ b/drivers/gpio/gpio-dwapb.c
> @@ -27,6 +27,8 @@
>  #include <linux/platform_data/gpio-dwapb.h>
>  #include <linux/slab.h>
>
> +#include "gpiolib.h"
> +
>  #define GPIO_SWPORTA_DR                0x00
>  #define GPIO_SWPORTA_DDR       0x04
>  #define GPIO_SWPORTB_DR                0x0c
> @@ -436,6 +438,10 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
>         else
>                 port->is_registered = true;
>
> +       /* Add GPIO-signaled ACPI event support */
> +       if (pp->irq)
> +               acpi_gpiochip_request_interrupts(&(port->gc));


Redundant parens.

> +
>         return err;
>  }

-- 
With Best Regards,
Andy Shevchenko
