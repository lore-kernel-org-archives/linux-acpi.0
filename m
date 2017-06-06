From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1 2/3] gpio: Add support for TPS68470 GPIOs
Date: Tue, 6 Jun 2017 17:15:55 +0300
Message-ID: <CAHp75Vc6PSDqc=Vxj2z-d49p+E-7tciunhki=8a7HPjQGuSwXQ@mail.gmail.com>
References: <1496750118-5570-1-git-send-email-rajmohan.mani@intel.com> <1496750118-5570-3-git-send-email-rajmohan.mani@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35721 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdFFOP5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Jun 2017 10:15:57 -0400
In-Reply-To: <1496750118-5570-3-git-send-email-rajmohan.mani@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rajmohan Mani <rajmohan.mani@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

On Tue, Jun 6, 2017 at 2:55 PM, Rajmohan Mani <rajmohan.mani@intel.com> wrote:
> This patch adds support for TPS68470 GPIOs.
> There are 7 GPIOs and a few sensor related GPIOs.
> These GPIOs can be requested and configured as
> appropriate.

Besides my below comments, just put it here that I recommended earlier
to provide 2 GPIO chips (one per bank of GPIOs).
It's up to Linus to decide since you didn't follow the recommendation.

> +#include <linux/gpio.h>
> +#include <linux/gpio/machine.h>

These shouldn't be in the driver.
Instead use
#include <linux/gpio/driver.h>

> +#include <linux/mfd/tps68470.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>

> +       if (offset >= TPS68470_N_REGULAR_GPIO) {
> +               offset -= TPS68470_N_REGULAR_GPIO;
> +               reg = TPS68470_REG_SGPO;
> +       }

Two GPIO chips makes this gone.

> +struct gpiod_lookup_table gpios_table = {
> +       .dev_id = NULL,
> +       .table = {
> +                 GPIO_LOOKUP("tps68470-gpio", 0, "gpio.0", GPIO_ACTIVE_HIGH),
> +                 GPIO_LOOKUP("tps68470-gpio", 1, "gpio.1", GPIO_ACTIVE_HIGH),
> +                 GPIO_LOOKUP("tps68470-gpio", 2, "gpio.2", GPIO_ACTIVE_HIGH),
> +                 GPIO_LOOKUP("tps68470-gpio", 3, "gpio.3", GPIO_ACTIVE_HIGH),
> +                 GPIO_LOOKUP("tps68470-gpio", 4, "gpio.4", GPIO_ACTIVE_HIGH),
> +                 GPIO_LOOKUP("tps68470-gpio", 5, "gpio.5", GPIO_ACTIVE_HIGH),
> +                 GPIO_LOOKUP("tps68470-gpio", 6, "gpio.6", GPIO_ACTIVE_HIGH),
> +                 GPIO_LOOKUP("tps68470-gpio", 7, "s_enable", GPIO_ACTIVE_HIGH),
> +                 GPIO_LOOKUP("tps68470-gpio", 8, "s_idle", GPIO_ACTIVE_HIGH),
> +                 GPIO_LOOKUP("tps68470-gpio", 9, "s_resetn", GPIO_ACTIVE_HIGH),
> +                 {},
> +       },
> +};

This doesn't belong to the driver.

> +static int tps68470_gpio_probe(struct platform_device *pdev)
> +{
> +       struct tps68470 *tps68470 = dev_get_drvdata(pdev->dev.parent);
> +       struct tps68470_gpio_data *tps68470_gpio;

> +       int i, ret;

unsingned int i;

> +       ret = gpiochip_add(&tps68470_gpio->gc);

devm_ ?

> +       gpiod_add_lookup_table(&gpios_table);

Doesn't belong to the driver either.
I suppose it's a part of MFD (patch 1)

> +       /*
> +        * Initialize all the GPIOs to 0, just to make sure all
> +        * GPIOs start with known default values. This protects against
> +        * any GPIOs getting set with a value of 1, after TPS68470 reset

So, this is hardware bug. Right? Or misconfiguration of the chip we may avoid?

> +        */
> +       for (i = 0; i < tps68470_gpio->gc.ngpio; i++)
> +               tps68470_gpio_set(&tps68470_gpio->gc, i, 0);
> +
> +       return ret;
> +}

> +
> +static int tps68470_gpio_remove(struct platform_device *pdev)
> +{
> +       struct tps68470_gpio_data *tps68470_gpio = platform_get_drvdata(pdev);
> +
> +       gpiod_remove_lookup_table(&gpios_table);
> +       gpiochip_remove(&tps68470_gpio->gc);
> +
> +       return 0;
> +}

Should gone after devm_ in use.

-- 
With Best Regards,
Andy Shevchenko
