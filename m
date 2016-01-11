From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 2/2] ACPI: amba bus probing support
Date: Mon, 11 Jan 2016 17:13:20 +0200
Message-ID: <CAHp75Vew8HMMrc2vdKbSVuB2reOCrwZZg3-a4nBUyfiQ=c0Y4A@mail.gmail.com>
References: <1452518790-27053-1-git-send-email-aleksey.makarov@linaro.org>
	<1452518790-27053-3-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:36081 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757521AbcAKPNV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Jan 2016 10:13:21 -0500
In-Reply-To: <1452518790-27053-3-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Graeme Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Shannon Zhao <shannon.zhao@linaro.org>, Vladimir Zapolskiy <vz@mleia.com>, Len Brown <lenb@kernel.org>

On Mon, Jan 11, 2016 at 3:26 PM, Aleksey Makarov
<aleksey.makarov@linaro.org> wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
>
> On ARM64 some devices use the AMBA device and not the platform bus for
> probing so add support for this. Uses a dummy clock for apb_pclk as ACPI
> does not have a suitable clock representation and to keep the core
> AMBA bus code unchanged between probing methods.
>

My comments below.

> +++ b/drivers/acpi/acpi_amba.c
> @@ -0,0 +1,122 @@
> +
> +/*
> + * ACPI support for platform bus type.
> + *
> + * Copyright (C) 2015, Linaro Ltd
> + * Author: Graeme Gregory <graeme.gregory@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/amba/bus.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/ioport.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +#include "internal.h"
> +
> +static const struct acpi_device_id amba_id_list[] = {
> +       {"ARMH0061", 0}, /* PL061 GPIO Device */
> +       {"", 0},
> +};
> +
> +static void amba_register_dummy_clk(void)
> +{
> +       static struct clk *amba_dummy_clk;
> +
> +       /* If clock already registered */
> +       if (amba_dummy_clk)
> +               return;
> +
> +       amba_dummy_clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL,
> +                                               CLK_IS_ROOT, 0);
> +       clk_register_clkdev(amba_dummy_clk, "apb_pclk", NULL);
> +}
> +
> +static int amba_handler_attach(struct acpi_device *adev,
> +                               const struct acpi_device_id *id)
> +{
> +       struct amba_device *dev;
> +       struct resource_entry *rentry;
> +       struct list_head resource_list;
> +       bool address_found = false;
> +       int irq_no = 0;
> +       int ret;
> +
> +       /* If the ACPI node already has a physical device attached, skip it. */
> +       if (adev->physical_node_count)
> +               return 0;
> +
> +       dev = amba_device_alloc(dev_name(&adev->dev), 0, 0);
> +       if (!dev) {
> +               dev_err(&adev->dev, "%s(): amba_device_alloc() failed\n",
> +                       __func__);
> +               return -ENOMEM;
> +       }
> +
> +       INIT_LIST_HEAD(&resource_list);
> +       ret = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
> +       if (ret < 0)
> +               goto err_free;
> +
> +       list_for_each_entry(rentry, &resource_list, node) {
> +               switch (resource_type(rentry->res)) {
> +               case IORESOURCE_MEM:
> +                       if (!address_found) {
> +                               dev->res = *rentry->res;

dev->res is 0 before this one, right? Could you use this fact instead
of address_found flag?

> +                               address_found = true;
> +                       }
> +                       break;
> +               case IORESOURCE_IRQ:
> +                       if (irq_no < AMBA_NR_IRQS)
> +                               dev->irq[irq_no++] = rentry->res->start;
> +                       break;
> +               default:
> +                       dev_warn(&adev->dev, "Invalid resource\n");

Why? Isn't possible to have other resources for the devices?

> +                       break;
> +               }
> +       }
> +
> +       acpi_dev_free_resource_list(&resource_list);
> +
> +       /*
> +        * If the ACPI node has a parent and that parent has a physical device
> +        * attached to it, that physical device should be the parent of
> +        * the amba device we are about to create.
> +        */
> +       if (adev->parent)
> +               dev->dev.parent = acpi_get_first_physical_node(adev->parent);
> +
> +       ACPI_COMPANION_SET(&dev->dev, adev);
> +
> +       ret = amba_device_add(dev, &iomem_resource);
> +       if (ret) {

ret < 0?

What to do if ret > 0? It will be considered as not error. Please,
check what function returns and adjust this.

> +               dev_err(&adev->dev, "%s(): amba_device_add() failed (%d)\n",
> +                      __func__, ret);
> +               goto err_free;
> +       }
> +
> +       return 1;
> +
> +err_free:
> +       amba_device_put(dev);
> +       return ret;
> +}


-- 
With Best Regards,
Andy Shevchenko
