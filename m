From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 2/4] ACPI / gpio: Add support for naming GPIOs
Date: Fri, 7 Oct 2016 20:05:14 +0300
Message-ID: <CAHp75Ve8QctOkt58tXeMpLTqeE5s_jTqjr7D46u41bXPg_NiBw@mail.gmail.com>
References: <20160929133944.158596-1-mika.westerberg@linux.intel.com> <20160929133944.158596-3-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33295 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936419AbcJGRFQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Oct 2016 13:05:16 -0400
In-Reply-To: <20160929133944.158596-3-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Sep 29, 2016 at 4:39 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> DT has property 'gpio-line-names' to name GPIO lines the controller has if
> present. Use this very same property in ACPI as well to provide nice names
> for the GPIOS.

One nit below.

> @@ -835,6 +875,9 @@ void acpi_gpiochip_add(struct gpio_chip *chip)
>                 return;
>         }
>
> +       if (!chip->names)
> +               acpi_gpiochip_set_names(acpi_gpio);
> +

I'm okay with this, though wouldn't be better to call it
unconditionally like it's done for below call and move check inside?

>         acpi_gpiochip_request_regions(acpi_gpio);
>         acpi_walk_dep_device_list(handle);
>  }

-- 
With Best Regards,
Andy Shevchenko
