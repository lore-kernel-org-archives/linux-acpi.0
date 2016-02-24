From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 1/2] gpio: designware: switch device node to fwnode
Date: Wed, 24 Feb 2016 15:46:21 +0200
Message-ID: <CAHp75Vd4dNJpuiMMizYbOpv+pZd30RcNA+kPoF6_4Vukk62iFw@mail.gmail.com>
References: <1456317210-42742-1-git-send-email-qiujiang@huawei.com>
	<1456317210-42742-2-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456317210-42742-2-git-send-email-qiujiang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: qiujiang <qiujiang@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 24, 2016 at 2:33 PM, qiujiang <qiujiang@huawei.com> wrote:
> This patch switch device node to fwnode in dwapb_port_property,
> so as to apply a unified data structure for DT and ACPI.
>
> This change also needs to be done in intel_quark_i2c_gpio driver,
> since it depends on gpio-dwapb driver.
>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: qiujiang <qiujiang@huawei.com>

Yes, something like this.
Though I have questions:
 - why do you use fwnode_*() instead of device_property_*() calls?
What prevents us to move to device property API directly?

> -       gpio->domain = irq_domain_add_linear(node, ngpio,
> -                                            &irq_generic_chip_ops, gpio);
> +       gpio->domain = irq_domain_create_linear(fwnode, ngpio,
> +                                                &irq_generic_chip_ops, gpio);

Are they equivalent?

> @@ -415,7 +415,7 @@ static int dwapb_gpio_add_port(struct dwapb_gpio *gpio,
>         }
>
>  #ifdef CONFIG_OF_GPIO
> -       port->gc.of_node = pp->node;
> +       port->gc.of_node = to_of_node(pp->fwnode);

If fwnode is not OF one?
Perhaps, something like ... = is_of_node() ? to_of_node() : NULL;


> -       node = dev->of_node;
> -       if (!IS_ENABLED(CONFIG_OF_GPIO) || !node)
> +       if (!IS_ENABLED(CONFIG_OF_GPIO) || !(dev->of_node))
>                 return ERR_PTR(-ENODEV);

So, since you converted to fwnode, do you still need this check?

>
> -       nports = of_get_child_count(node);
> +       nports = device_get_child_node_count(dev);
>         if (nports == 0)
>                 return ERR_PTR(-ENODEV);

...I think this one fail if it will not found any child.

> -               if (of_property_read_u32(port_np, "reg", &pp->idx) ||
> +               if (fwnode_property_read_u32(fwnode, "reg", &pp->idx) ||

device_property_*() ?

>                     pp->idx >= DWAPB_MAX_PORTS) {
>                         dev_err(dev, "missing/invalid port index for %s\n",
> -                               port_np->full_name);
> +                               to_of_node(fwnode)->full_name);

If it's not OF?

> -               if (of_property_read_u32(port_np, "snps,nr-gpios",
> +               if (fwnode_property_read_u32(fwnode, "snps,nr-gpios",

Ditto.

>                                          &pp->ngpio)) {
>                         dev_info(dev, "failed to get number of gpios for %s\n",
> -                                port_np->full_name);
> +                                to_of_node(fwnode)->full_name);

Ditto.

>                 if (pp->idx == 0 &&
> -                   of_property_read_bool(port_np, "interrupt-controller")) {
> -                       pp->irq = irq_of_parse_and_map(port_np, 0);
> +                       of_property_read_bool(to_of_node(fwnode),
> +                               "interrupt-controller")) {

device_property_*() ?

> +                       pp->irq = irq_of_parse_and_map(to_of_node(fwnode), 0);
>                         if (!pp->irq) {
>                                 dev_warn(dev, "no irq for bank %s\n",
> -                                        port_np->full_name);
> +                                        to_of_node(fwnode)->full_name);
>                         }
>                 }
>
>                 pp->irq_shared  = false;
>                 pp->gpio_base   = -1;
> -               pp->name        = port_np->full_name;
> +               pp->name = to_of_node(fwnode)->full_name;
>         }
>
>         return pdata;


-- 
With Best Regards,
Andy Shevchenko
