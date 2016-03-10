From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 3/3] gpio: designware: add gpio-signaled acpi event support
Date: Thu, 10 Mar 2016 22:31:43 +0200
Message-ID: <CAHp75Vcr_uynzQPndYcp5DTVxhD4nMZ_0wz2hxFGqS23=MV6+Q@mail.gmail.com>
References: <1457077474-124064-1-git-send-email-qiujiang@huawei.com>
	<1457077474-124064-4-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36399 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932120AbcCJUbo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2016 15:31:44 -0500
In-Reply-To: <1457077474-124064-4-git-send-email-qiujiang@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: qiujiang <qiujiang@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com

On Fri, Mar 4, 2016 at 9:44 AM, qiujiang <qiujiang@huawei.com> wrote:
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
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: qiujiang <qiujiang@huawei.com>

This one fine to me.

> ---
>  drivers/gpio/gpio-dwapb.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> index 2ae506f..043e1c2 100644
> --- a/drivers/gpio/gpio-dwapb.c
> +++ b/drivers/gpio/gpio-dwapb.c
> @@ -28,6 +28,8 @@
>  #include <linux/platform_data/gpio-dwapb.h>
>  #include <linux/slab.h>
>
> +#include "gpiolib.h"
> +
>  #define GPIO_SWPORTA_DR                0x00
>  #define GPIO_SWPORTA_DDR       0x04
>  #define GPIO_SWPORTB_DR                0x0c
> @@ -437,6 +439,10 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
>         else
>                 port->is_registered = true;
>
> +       /* Add GPIO-signaled ACPI event support */
> +       if (pp->irq)
> +               acpi_gpiochip_request_interrupts(&port->gc);
> +
>         return err;
>  }
>
> --
> 1.9.1
>



-- 
With Best Regards,
Andy Shevchenko
