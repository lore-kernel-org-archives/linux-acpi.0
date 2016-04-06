From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v7 1/3] gpio: dwapb: remove name from dwapb_port_property
Date: Wed, 6 Apr 2016 15:57:39 +0300
Message-ID: <CAHp75Vc4OxOtA1jseX+BOP9zRzsV98z4VKiY=rdpLdi7K2umNg@mail.gmail.com>
References: <1459926480-32966-1-git-send-email-qiujiang@huawei.com>
	<1459926480-32966-2-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1459926480-32966-2-git-send-email-qiujiang@huawei.com>
Sender: linux-gpio-owner@vger.kernel.org
To: qiujiang <qiujiang@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Alan Tull <delicious.quinoa@gmail.com>, Jamie Iles <jamie@jamieiles.com>, charles.chenxin@huawei.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linuxarm@huawei.com
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 6, 2016 at 10:07 AM, qiujiang <qiujiang@huawei.com> wrote:
> This patch removed the name property from dwapb_port_property.
> The name property is redundant because we can get those info
> from dwapb_gpio dev and pp->idx property.

Where idx is used in such replacements?

> --- a/drivers/gpio/gpio-dwapb.c
> +++ b/drivers/gpio/gpio-dwapb.c
> @@ -409,8 +409,7 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
>         err = bgpio_init(&port->gc, gpio->dev, 4, dat, set, NULL, dirout,
>                          NULL, false);
>         if (err) {
> -               dev_err(gpio->dev, "failed to init gpio chip for %s\n",
> -                       pp->name);
> +               dev_err(gpio->dev, "failed to init gpio chip\n");

Do we have any port index here available (expected value I suppose)?

> @@ -429,8 +428,7 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
>
>         err = gpiochip_add_data(&port->gc, port);
>         if (err)
> -               dev_err(gpio->dev, "failed to register gpiochip for %s\n",
> -                       pp->name);
> +               dev_err(gpio->dev, "failed to register gpiochip\n");

Ditto.


> @@ -499,15 +498,12 @@ dwapb_gpio_get_pdata_of(struct device *dev)
>                 if (pp->idx == 0 &&
>                     of_property_read_bool(port_np, "interrupt-controller")) {
>                         pp->irq = irq_of_parse_and_map(port_np, 0);
> -                       if (!pp->irq) {
> -                               dev_warn(dev, "no irq for bank %s\n",
> -                                        port_np->full_name);
> -                       }
> +                       if (!pp->irq)
> +                               dev_warn(dev, "no irq for this bank\n");

pp->idx here?

dev_warn(dev, "no irq for port%d\n", pp->idx);

> --- a/drivers/mfd/intel_quark_i2c_gpio.c
> +++ b/drivers/mfd/intel_quark_i2c_gpio.c
> @@ -220,7 +220,6 @@ static int intel_quark_gpio_setup(struct pci_dev *pdev, struct mfd_cell *cell)
>
>         /* Set the properties for portA */
>         pdata->properties->node         = NULL;
> -       pdata->properties->name         = "intel-quark-x1000-gpio-portA";
>         pdata->properties->idx          = 0;
>         pdata->properties->ngpio        = INTEL_QUARK_MFD_NGPIO;
>         pdata->properties->gpio_base    = INTEL_QUARK_MFD_GPIO_BASE;

For Quark part:
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
