From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 2/2] gpio: designware: add gpio-signaled acpi events
 support for power button
Date: Wed, 24 Feb 2016 15:49:02 +0200
Message-ID: <CAHp75VeFydKKc6GmWbLJ2uSBmxG2ObGX51i-NrNBAdaR57nXCA@mail.gmail.com>
References: <1456317210-42742-1-git-send-email-qiujiang@huawei.com>
	<1456317210-42742-3-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456317210-42742-3-git-send-email-qiujiang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: qiujiang <qiujiang@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 24, 2016 at 2:33 PM, qiujiang <qiujiang@huawei.com> wrote:
> This patch modifies the designware gpio controller driver to
> support the gpio-signaled acpi events. This is used for power
> button on hisilicon D02 board(an arm64 platform).

> @@ -434,6 +436,10 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
>         else
>                 port->is_registered = true;
>
> +       /* Add GPIO-signaled ACPI event support */
> +       if (pp->irq)
> +               acpi_gpiochip_request_interrupts(&(port->gc));

Redundant parens.

> @@ -447,7 +453,7 @@ static void dwapb_gpio_unregister(struct dwapb_gpio *gpio)
>  }
>
>  static struct dwapb_platform_data *
> -dwapb_gpio_get_pdata_of(struct device *dev)
> +dwapb_gpio_get_pdata(struct device *dev)
>  {
>         struct fwnode_handle *fwnode;
>         struct dwapb_platform_data *pdata;
> @@ -455,9 +461,6 @@ dwapb_gpio_get_pdata_of(struct device *dev)
>         int nports;
>         int i;
>

> -       if (!IS_ENABLED(CONFIG_OF_GPIO) || !(dev->of_node))
> -               return ERR_PTR(-ENODEV);
> -

I think it belongs to patch 1.

> @@ -479,15 +482,13 @@ dwapb_gpio_get_pdata_of(struct device *dev)
>
>                 if (fwnode_property_read_u32(fwnode, "reg", &pp->idx) ||
>                     pp->idx >= DWAPB_MAX_PORTS) {
> -                       dev_err(dev, "missing/invalid port index for %s\n",
> -                               to_of_node(fwnode)->full_name);
> +                       dev_err(dev, "missing/invalid port index\n");

Ditto.

> -                       dev_info(dev, "failed to get number of gpios for %s\n",
> -                                to_of_node(fwnode)->full_name);
> +                       dev_info(dev, "failed to get number of gpios\n");

Ditto.

> @@ -495,7 +496,7 @@ dwapb_gpio_get_pdata_of(struct device *dev)
>                  * Only port A can provide interrupts in all configurations of
>                  * the IP.
>                  */
> -               if (pp->idx == 0 &&
> +               if (dev->of_node && pp->idx == 0 &&

Why is it needed?


-- 
With Best Regards,
Andy Shevchenko
