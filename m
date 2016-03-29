From: Alan Tull <delicious.quinoa@gmail.com>
Subject: Re: [PATCH v6 1/2] gpio: dwapb: convert device node to fwnode
Date: Tue, 29 Mar 2016 11:30:50 -0500
Message-ID: <CANk1AXT5yHMwPJ7=0kSZKr+eHHdC1QXQVgstQ6QhFbUPSKuD+A@mail.gmail.com>
References: <1458959496-57455-1-git-send-email-qiujiang@huawei.com>
	<1458959496-57455-2-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34945 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbcC2Qaw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Mar 2016 12:30:52 -0400
In-Reply-To: <1458959496-57455-2-git-send-email-qiujiang@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: qiujiang <qiujiang@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Jamie Iles <jamie@jamieiles.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linuxarm@huawei.com, haifeng.wei@huawei.com, charles.chenxin@huawei.com, atull <atull@opensource.altera.com>

On Fri, Mar 25, 2016 at 9:31 PM, qiujiang <qiujiang@huawei.com> wrote:

> -               if (pp->idx == 0 &&
> -                   of_property_read_bool(port_np, "interrupt-controller")) {
> -                       pp->irq = irq_of_parse_and_map(port_np, 0);
> +               if (dev->of_node && pp->idx == 0 &&
> +                       fwnode_property_read_bool(fwnode,
> +                                                 "interrupt-controller")) {
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
> +               if (dev->of_node)
> +                       pp->name = to_of_node(fwnode)->full_name;

Hi Jiang,

I tested lightly on a CycloneV and it worked fine (with device tree).

One suggestion for both patches: you could remove name from struct
dwapb_port_property and get rid of pp->name and nobody would miss it.
All it is used for is some dev_err's so the device info gets printed
anyway.  For example (if I leave the irq out of the DT)

gpio-dwapb ff708000.gpio: no irq for bank /soc/gpio@ff708000/gpio-controller@0

is redundant.  The only additional info here from the name is the port
index.  That could be added to the messages without having to get the
name through the two property/of methods.

Alan
