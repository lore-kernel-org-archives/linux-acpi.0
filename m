From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1 1/3] mfd: Add new mfd device TPS68470
Date: Tue, 6 Jun 2017 15:59:49 +0300
Message-ID: <CAHp75VfiTM2t=WxWpG4+kUfGA3DrfGfMOwxP6Cs42nGwHjAp7w@mail.gmail.com>
References: <1496750118-5570-1-git-send-email-rajmohan.mani@intel.com> <1496750118-5570-2-git-send-email-rajmohan.mani@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36680 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbdFFM7u (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Jun 2017 08:59:50 -0400
In-Reply-To: <1496750118-5570-2-git-send-email-rajmohan.mani@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rajmohan Mani <rajmohan.mani@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

On Tue, Jun 6, 2017 at 2:55 PM, Rajmohan Mani <rajmohan.mani@intel.com> wrote:
> The TPS68470 device is an advanced power management
> unit that powers a Compact Camera Module (CCM),
> generates clocks for image sensors, drives a dual
> LED for Flash and incorporates two LED drivers for
> general purpose indicators.
>
> This patch adds support for TPS68470 mfd device.

I dunno why you decide to send this out now, see my comments below.

> +static int tps68470_chip_init(struct tps68470 *tps)
> +{
> +       unsigned int version;
> +       int ret;

> +       /* FIXME: configure these dynamically */

So, what prevents you to fix this?

> +       /* Enable Daisy Chain LDO and configure relevant GPIOs as output */

> +}

> +static int tps68470_probe(struct i2c_client *client)
> +{
> +       struct tps68470 *tps;
> +       int ret;
> +
> +       tps = devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
> +       if (!tps)
> +               return -ENOMEM;
> +
> +       mutex_init(&tps->lock);
> +       i2c_set_clientdata(client, tps);
> +       tps->dev = &client->dev;
> +
> +       tps->regmap = devm_regmap_init_i2c(client, &tps68470_regmap_config);
> +       if (IS_ERR(tps->regmap)) {
> +               dev_err(tps->dev, "devm_regmap_init_i2c Error %d\n", ret);
> +               return PTR_ERR(tps->regmap);
> +       }
> +

> +       ret = mfd_add_devices(tps->dev, -1, tps68470s,
> +                             ARRAY_SIZE(tps68470s), NULL, 0, NULL);

devm_?

> +       if (ret < 0) {
> +               dev_err(tps->dev, "mfd_add_devices failed: %d\n", ret);
> +               return ret;
> +       }
> +
> +       ret = tps68470_chip_init(tps);
> +       if (ret < 0) {
> +               dev_err(tps->dev, "TPS68470 Init Error %d\n", ret);
> +               goto fail;
> +       }
> +
> +       return 0;

> +fail:
> +       mutex_lock(&tps->lock);

I'm not sure you need this mutex to be held here.
Otherwise your code has a bug with locking.

> +       mfd_remove_devices(tps->dev);
> +       mutex_unlock(&tps->lock);
> +
> +       return ret;

Taking above into consideration I suggest to clarify your locking scheme.

> +}
> +
> +static int tps68470_remove(struct i2c_client *client)
> +{
> +       struct tps68470 *tps = i2c_get_clientdata(client);
> +

> +       mutex_lock(&tps->lock);
> +       mfd_remove_devices(tps->dev);
> +       mutex_unlock(&tps->lock);

Ditto.

> +       return 0;
> +}

> +/**
> + * struct tps68470 - tps68470 sub-driver chip access routines
> + *

kbuild bot will be unhappy. You need to file a description per field.

> + * Device data may be used to access the TPS68470 chip
> + */
> +
> +struct tps68470 {
> +       struct device *dev;
> +       struct regmap *regmap;

> +       /*
> +        * Used to synchronize access to tps68470_ operations
> +        * and addition and removal of mfd devices
> +        */

Move it to kernel-doc above.

> +       struct mutex lock;
> +};

-- 
With Best Regards,
Andy Shevchenko
