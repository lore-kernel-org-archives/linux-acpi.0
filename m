From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 1/2] gpio: designware: switch device node to fwnode and
 add acpi binding
Date: Mon, 29 Feb 2016 15:51:01 +0200
Message-ID: <CAHp75Ves-+6pj_LZccxkKugXxJ9NJUwSotSCRf6=aOveBOx=Jg@mail.gmail.com>
References: <1456751596-98963-1-git-send-email-qiujiang@huawei.com>
	<1456751596-98963-2-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:35400 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbcB2NvD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Feb 2016 08:51:03 -0500
In-Reply-To: <1456751596-98963-2-git-send-email-qiujiang@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: qiujiang <qiujiang@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com

On Mon, Feb 29, 2016 at 3:13 PM, qiujiang <qiujiang@huawei.com> wrote:
> This patch switches device node to fwnode and adds acpi
> binding. As a result, DT and acpi bingdings are compatible
> for this driver.

I'm not sure it makes sense to add ACPI binding here. It more logical
to me to add them in patch 2/2.
And I see that it touches different subsystems.

>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Due to above and Mika's Ack was only to ACPI parts, I think
you may be split this also to two and we will have clearly logical set:
1. Convert to fwnode
2. Add ACPI bindings
3. ACPI event support.

Does it sound okay to you?

If you do that I give my
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
to intel_quark_i2c_gpio.c part and
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
to the rest.

> Signed-off-by: qiujiang <qiujiang@huawei.com>
> ---
>  drivers/gpio/gpio-dwapb.c                | 62 +++++++++++++++++++-------------
>  drivers/mfd/intel_quark_i2c_gpio.c       |  2 +-
>  include/linux/platform_data/gpio-dwapb.h |  2 +-
>  3 files changed, 39 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> index 597de1e..7a37c65 100644
> --- a/drivers/gpio/gpio-dwapb.c
> +++ b/drivers/gpio/gpio-dwapb.c
> @@ -7,6 +7,7 @@
>   *
>   * All enquiries to support@picochip.com
>   */
> +#include <linux/acpi.h>

+#include <linux/property.h> instead (see above).

>  #include <linux/gpio/driver.h>
>  /* FIXME: for gpio_get_value(), replace this with direct register read */
>  #include <linux/gpio.h>

> @@ -496,18 +492,27 @@ dwapb_gpio_get_pdata_of(struct device *dev)
>                  * Only port A can provide interrupts in all configurations of
>                  * the IP.
>                  */
> -               if (pp->idx == 0 &&
> -                   of_property_read_bool(port_np, "interrupt-controller")) {
> -                       pp->irq = irq_of_parse_and_map(port_np, 0);
> +               if (dev->of_node && pp->idx == 0 &&
> +                       of_property_read_bool(to_of_node(fwnode),
> +                               "interrupt-controller")) {

> +               if (has_acpi_companion(dev) && pp->idx == 0)
> +                       pp->irq = platform_get_irq(to_platform_device(dev), 0);
> +

To patch 2.

>                 pp->irq_shared  = false;
>                 pp->gpio_base   = -1;

> -               pp->name        = port_np->full_name;
> +
> +               if (dev->of_node)
> +                       pp->name = to_of_node(fwnode)->full_name;
> +

And here you have to provide something in case of default / built-in
device properties.


> +               if (has_acpi_companion(dev))
> +                       pp->name = acpi_dev_name(to_acpi_device_node(fwnode));

To patch 2.

>         }
>
>         return pdata;

> @@ -580,6 +585,12 @@ static const struct of_device_id dwapb_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, dwapb_of_match);
>
> +static const struct acpi_device_id dwapb_acpi_match[] = {
> +       {"HISI0181", 0},
> +       { }
> +};
> +MODULE_DEVICE_TABLE(acpi, dwapb_acpi_match);
> +
>  #ifdef CONFIG_PM_SLEEP
>  static int dwapb_gpio_suspend(struct device *dev)
>  {
> @@ -674,6 +685,7 @@ static struct platform_driver dwapb_gpio_driver = {
>                 .name   = "gpio-dwapb",
>                 .pm     = &dwapb_gpio_pm_ops,
>                 .of_match_table = of_match_ptr(dwapb_of_match),
> +               .acpi_match_table = ACPI_PTR(dwapb_acpi_match),
>         },
>         .probe          = dwapb_gpio_probe,
>         .remove         = dwapb_gpio_remove,

Ditto to the above hunks.

-- 
With Best Regards,
Andy Shevchenko
