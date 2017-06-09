From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 2/3] gpio: Add support for TPS68470 GPIOs
Date: Fri, 9 Jun 2017 13:15:21 +0200
Message-ID: <CACRpkda4v=QaFzAsR1903Ybx3+2Faz-q+YrPN5dBiLDsRMj5TA@mail.gmail.com>
References: <1496750118-5570-1-git-send-email-rajmohan.mani@intel.com> <1496750118-5570-3-git-send-email-rajmohan.mani@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:37143 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751528AbdFILPX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jun 2017 07:15:23 -0400
Received: by mail-it0-f41.google.com with SMTP id m47so30388287iti.0
        for <linux-acpi@vger.kernel.org>; Fri, 09 Jun 2017 04:15:22 -0700 (PDT)
In-Reply-To: <1496750118-5570-3-git-send-email-rajmohan.mani@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rajmohan Mani <rajmohan.mani@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

On Tue, Jun 6, 2017 at 1:55 PM, Rajmohan Mani <rajmohan.mani@intel.com> wrote:

> This patch adds support for TPS68470 GPIOs.
> There are 7 GPIOs and a few sensor related GPIOs.
> These GPIOs can be requested and configured as
> appropriate.
>
> Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>

Same comments as Andy already sent, plus:

> +static inline struct tps68470_gpio_data *to_gpio_data(struct gpio_chip *gpiochp)
> +{
> +       return container_of(gpiochp, struct tps68470_gpio_data, gc);
> +}

Please use the data pointe inside gpio_chip.

struct tps68470_gpio_data *foo = gpiochip_get_data(gc);

> +       ret = tps68470_reg_read(tps, reg, &val);
(...)
> +       tps68470_update_bits(tps, reg, BIT(offset), value ? BIT(offset) : 0);
(...)
> +       return tps68470_update_bits(tps, TPS68470_GPIO_CTL_REG_A(offset),
> +                                TPS68470_GPIO_MODE_MASK,
> +                                TPS68470_GPIO_MODE_OUT_CMOS);
(...)
> +       return tps68470_update_bits(tps, TPS68470_GPIO_CTL_REG_A(offset),
> +                                  TPS68470_GPIO_MODE_MASK, 0x00);

This looks like a reimplementation of regmap. Is it not possible
to create a regmap in the MFD driver and pass that around instead?

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

Hm that's why you include <linux/gpio/machine.h> I guess.

This warrants a big comment above it explaining why this is done like
that and what the use is inside any system with this chip mounted.

> +       tps68470_gpio->gc.label = "tps68470-gpio";
> +       tps68470_gpio->gc.owner = THIS_MODULE;
> +       tps68470_gpio->gc.direction_input = tps68470_gpio_input;
> +       tps68470_gpio->gc.direction_output = tps68470_gpio_output;

Please implement .get_direction()

> +       tps68470_gpio->gc.get = tps68470_gpio_get;
> +       tps68470_gpio->gc.set = tps68470_gpio_set;
> +       tps68470_gpio->gc.can_sleep = true;
> +       tps68470_gpio->gc.ngpio = TPS68470_N_GPIO;
> +       tps68470_gpio->gc.base = -1;
> +       tps68470_gpio->gc.parent = &pdev->dev;

Consider assigning the .names() array some sensible line names.

> +static int tps68470_gpio_remove(struct platform_device *pdev)
> +{
> +       struct tps68470_gpio_data *tps68470_gpio = platform_get_drvdata(pdev);
> +
> +       gpiod_remove_lookup_table(&gpios_table);
> +       gpiochip_remove(&tps68470_gpio->gc);

You can't use devm_gpiochip_add()?

Yours,
Linus Walleij
