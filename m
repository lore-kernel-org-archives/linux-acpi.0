From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v7 2/3] gpio: dwapb: convert device node to fwnode
Date: Wed, 6 Apr 2016 16:01:49 +0300
Message-ID: <CAHp75Vc-Pd4swDq5gVKtwmOGD9fALkmDpyt1qah0JGQo2+422w@mail.gmail.com>
References: <1459926480-32966-1-git-send-email-qiujiang@huawei.com>
	<1459926480-32966-3-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459926480-32966-3-git-send-email-qiujiang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: qiujiang <qiujiang@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Alan Tull <delicious.quinoa@gmail.com>, Jamie Iles <jamie@jamieiles.com>, charles.chenxin@huawei.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linuxarm@huawei.com
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 6, 2016 at 10:07 AM, qiujiang <qiujiang@huawei.com> wrote:
> This patch converts device node to fwnode for dwapb driver, so
> as to provide a unified fwnode for DT and ACPI bindings.
>
> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: qiujiang <qiujiang@huawei.com>

>  static struct dwapb_platform_data *
> -dwapb_gpio_get_pdata_of(struct device *dev)
> +dwapb_gpio_get_pdata(struct device *dev)

I don't remember if I had asked already
does it fit now one row?

> @@ -495,9 +493,10 @@ dwapb_gpio_get_pdata_of(struct device *dev)
>                  * Only port A can provide interrupts in all configurations of
>                  * the IP.
>                  */
> -               if (pp->idx == 0 &&
> -                   of_property_read_bool(port_np, "interrupt-controller")) {
> -                       pp->irq = irq_of_parse_and_map(port_np, 0);
> +               if (dev->of_node && pp->idx == 0 &&

is_of_fwnode() && ?

> +                       fwnode_property_read_bool(fwnode,
> +                                                 "interrupt-controller")) {
> +                       pp->irq = irq_of_parse_and_map(to_of_node(fwnode), 0);
>                         if (!pp->irq)
>                                 dev_warn(dev, "no irq for this bank\n");

-- 
With Best Regards,
Andy Shevchenko
