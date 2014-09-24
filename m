From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH v2 12/16] input: gpio_keys_polled - Add support for
 GPIO descriptors
Date: Wed, 24 Sep 2014 10:02:41 +0200
Message-ID: <CACRpkdaQNjeL5sQNO24xPzR-PJk_emBmrUgx40x7fMP9oogqGQ@mail.gmail.com>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com>
	<1410868367-11056-13-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410868367-11056-13-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Aaron Lu <aaron.lu@intel.com>, Darren Hart <dvhart@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Sep 16, 2014 at 1:52 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> From: Aaron Lu <aaron.lu@intel.com>
>
> GPIO descriptors are the preferred way over legacy GPIO numbers
> nowadays. Convert the driver to use GPIO descriptors internally but
> still allow passing legacy GPIO numbers from platform data to support
> existing platforms.
>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Great!

>  #include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>

Again <linux/gpio.h> should not be needed anymore.

> +               /*
> +                * Legacy GPIO number so request the GPIO here and
> +                * convert it to descriptor.
> +                */
> +               if (!button->gpiod && gpio_is_valid(button->gpio)) {
> +                       unsigned flags = 0;
> +
> +                       if (button->active_low)
> +                               flags |= GPIOF_ACTIVE_LOW;
> +
> +                       error = devm_gpio_request_one(&pdev->dev, button->gpio,
> +                                       flags, button->desc ? : DRV_NAME);
> +                       if (error) {
> +                               dev_err(dev, "unable to claim gpio %u, err=%d\n",
> +                                       button->gpio, error);
> +                               return error;
> +                       }
> +
> +                       button->gpiod = gpio_to_desc(button->gpio);

So the field button->gpio is still there, this is a bit disturbing, but when
I grep for it I see there is a multitude of users :-/

OK I guess these users have to be fixed one by one.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
