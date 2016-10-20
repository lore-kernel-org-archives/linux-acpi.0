From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/4] ACPI / gpio: Add support for naming GPIOs
Date: Thu, 20 Oct 2016 14:06:42 +0200
Message-ID: <CACRpkdYRWdd9anAcufadb-0sWSZ3reA-K+=z5Bc0Vk9dBrG29g@mail.gmail.com>
References: <20160929133944.158596-1-mika.westerberg@linux.intel.com> <20160929133944.158596-3-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:34145 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbcJTMGo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Oct 2016 08:06:44 -0400
Received: by mail-qt0-f178.google.com with SMTP id q7so50802818qtq.1
        for <linux-acpi@vger.kernel.org>; Thu, 20 Oct 2016 05:06:44 -0700 (PDT)
In-Reply-To: <20160929133944.158596-3-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Sep 29, 2016 at 3:39 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> DT has property 'gpio-line-names' to name GPIO lines the controller has if
> present. Use this very same property in ACPI as well to provide nice names
> for the GPIOS.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Oh wait:

> +static void acpi_gpiochip_set_names(struct acpi_gpio_chip *achip)
> +{
> +       struct gpio_chip *chip = achip->chip;
> +       struct gpio_device *gdev = chip->gpiodev;
> +       const char **names;
> +       int ret, i;
> +
> +       ret = device_property_read_string_array(chip->parent, "gpio-line-names",
> +                                               NULL, 0);
> +       if (ret < 0)
> +               return;
> +
> +       if (ret != gdev->ngpio) {
> +               dev_warn(chip->parent,
> +                        "names %d do not match number of GPIOs %d\n", ret,
> +                        gdev->ngpio);
> +               return;
> +       }
> +
> +       names = kcalloc(gdev->ngpio, sizeof(*names), GFP_KERNEL);
> +       if (!names)
> +               return;
> +
> +       ret = device_property_read_string_array(chip->parent, "gpio-line-names",
> +                                               names, gdev->ngpio);
> +       if (ret < 0) {
> +               dev_warn(chip->parent, "Failed to read GPIO line names\n");
> +               return;
> +       }
> +
> +       /*
> +        * It is fine to assign the name, it will be allocated as long as
> +        * the ACPI device exists.
> +        */
> +       for (i = 0; i < gdev->ngpio; i++)
> +               gdev->descs[i].name = names[i];
> +
> +       kfree(names);
> +}

Wouldn't this entire function work just as fine on device tree?

So should this snippet using device_property_* be moved into
a file like gpiolib-devprop.c+gpiolib.h signature and get used from
both gpiolib-of.c and gpiolib-acpi.c, replacing the DT-specific
code in gpiolib-of.c?

Yours,
Linus Walleij
