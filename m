From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 1/3] mfd: Add new mfd device TPS68470
Date: Sun, 11 Jun 2017 16:17:26 +0300
Message-ID: <CAHp75VdJh13-_cpk07v7Jp4LiOQa_OM7PPF6XR0ifBTRpX9hZg@mail.gmail.com>
References: <1497161395-36504-1-git-send-email-rajmohan.mani@intel.com> <1497161395-36504-2-git-send-email-rajmohan.mani@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34243 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbdFKNR1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Jun 2017 09:17:27 -0400
In-Reply-To: <1497161395-36504-2-git-send-email-rajmohan.mani@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rajmohan Mani <rajmohan.mani@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

On Sun, Jun 11, 2017 at 9:09 AM, Rajmohan Mani <rajmohan.mani@intel.com> wrote:
> The TPS68470 device is an advanced power management
> unit that powers a Compact Camera Module (CCM),
> generates clocks for image sensors, drives a dual
> LED for Flash and incorporates two LED drivers for
> general purpose indicators.
>
> This patch adds support for TPS68470 mfd device.

Thanks! This looks much better, though see my few comments below.

> +/*
> + * This lookup table for the TPS68470 GPIOs, lists
> + * the 7 GPIOs (that can be configured as input or output
> + * as appropriate) and 3 special purpose GPIOs that are
> + * "output only". Exporting these GPIOs in a system mounted
> + * with the TPS68470, in conjunction with the gpio-tps68470
> + * driver, allows the platform firmware to configure these
> + * GPIOs appropriately, through the ACPI operation region.
> + * These 7 configurable GPIOs can be connected to power rails,
> + * sensor control (e.g sensor reset), while the 3 GPIOs can
> + * be used for sensor control.
> + */

> +struct gpiod_lookup_table gpios_table = {
> +       .dev_id = NULL,

Why dev_id is NULL?

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

I don't remember if I asked already why this table exists at all in
the driver. Shouldn't it be provided by ACPI _DSD?

> +static int tps68470_chip_init(struct device *dev, struct regmap *regmap)
> +{
> +       unsigned int version;
> +       int ret;
> +
> +       ret = regmap_read(regmap, TPS68470_REG_REVID, &version);
> +       if (ret < 0) {
> +               dev_err(dev, "Failed to read revision register: %d\n", ret);
> +               return ret;
> +       }
> +

> +       dev_info(dev, "TPS68470 REVID: 0x%x\n", version);

This will confuse user when probe fails. Should be printed only when
we return 0 for sure.

> +       ret = regmap_write(regmap, TPS68470_REG_RESET, 0xff);
> +       if (ret < 0)
> +               return ret;
> +

> +       /* FIXME: configure these dynamically */

Please, either fix or remove this comment.

> +       /* Enable daisy chain */
> +       ret = regmap_update_bits(regmap, TPS68470_REG_S_I2C_CTL, 1, 1);
> +       if (ret < 0)
> +               return ret;
> +

> +       usleep_range(TPS68470_DAISY_CHAIN_DELAY_US,
> +                       TPS68470_DAISY_CHAIN_DELAY_US + 10);

This might require a comment, though I'm fine with it as long as it
close to previous excerpt.

> +       return 0;
> +}

> +static int tps68470_probe(struct i2c_client *client)
> +{
> +       struct device *dev = &client->dev;
> +       struct regmap *regmap;
> +       int ret;
> +
> +       regmap = devm_regmap_init_i2c(client, &tps68470_regmap_config);
> +       if (IS_ERR(regmap)) {

> +               dev_err(dev, "devm_regmap_init_i2c Error %ld\n",
> +               PTR_ERR(regmap));

1. Indentation.
2. Do we really need this message?

> +               return PTR_ERR(regmap);
> +       }
> +
> +       i2c_set_clientdata(client, regmap);
> +
> +       gpiod_add_lookup_table(&gpios_table);
> +

> +       ret = devm_mfd_add_devices(dev, -1, tps68470s,
> +                             ARRAY_SIZE(tps68470s), NULL, 0, NULL);

-1 has a definition for such case, use it instead.

> +       if (ret < 0) {
> +               dev_err(dev, "mfd_add_devices failed: %d\n", ret);
> +               return ret;
> +       }

> +static const struct i2c_device_id tps68470_id_table[] = {
> +       {},
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, tps68470_id_table);

Either choose ->probe() over ->probe_new() or remove above.

> +static struct i2c_driver tps68470_driver = {
> +       .driver = {
> +                  .name = "tps68470",

> +                  .acpi_match_table = ACPI_PTR(tps68470_acpi_ids),

ACPI_PTR() is redundant.

> +#include <linux/i2c.h>

And this is for...?

...

> +#define TPS68470_PLL_STARTUP_DELAY_US  1000
> +#define TPS68470_DAISY_CHAIN_DELAY_US  3000
> +
> +#endif /* __LINUX_MFD_TPS68470_H */

-- 
With Best Regards,
Andy Shevchenko
