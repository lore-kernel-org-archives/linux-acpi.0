From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] gpio: acpi: Call enable_irq_wake for _IAE GpioInts with Wake set
Date: Mon, 20 Mar 2017 22:59:16 +0100
Message-ID: <2997741.ylvZKAC5a8@aspire.rjw.lan>
References: <20170320173221.3397-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59397 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754084AbdCTWEu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 Mar 2017 18:04:50 -0400
In-Reply-To: <20170320173221.3397-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-acpi@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org

On Monday, March 20, 2017 06:32:21 PM Hans de Goede wrote:
> On Bay Trail / Cherry Trail systems with a LID switch, the LID switch is
> often connect to a gpioint handled by an _IAE event handler.
> Before this commit such systems would not wake up when opening the lid,
> requiring the powerbutton to be pressed after opening the lid to wakeup.
> 
> Note that Bay Trail / Cherry Trail systems use suspend-to-idle, so
> the interrupts are generated anyway on those lines on lid switch changes,
> but they are treated by the IRQ subsystem as spurious while suspended if
> not marked as wakeup IRQs.
> 
> This commit calls enable_irq_wake() for _IAE GpioInts with a valid
> event handler which have their Wake flag set. This fixes such systems
> not waking up when opening the lid.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> Changes in v2:
> -Improve commit msg
> -Add Mika's Acked-by
> ---
>  drivers/gpio/gpiolib-acpi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 8cd3f66..18207b2 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -28,6 +28,7 @@ struct acpi_gpio_event {
>  	acpi_handle handle;
>  	unsigned int pin;
>  	unsigned int irq;
> +	bool irq_wake_enabled;
>  	struct gpio_desc *desc;
>  };
>  
> @@ -266,6 +267,11 @@ static acpi_status acpi_gpiochip_request_interrupt(struct acpi_resource *ares,
>  		goto fail_free_event;
>  	}
>  
> +	if (agpio->wake_capable == ACPI_WAKE_CAPABLE) {
> +		enable_irq_wake(irq);
> +		event->irq_wake_enabled = true;
> +	}
> +
>  	list_add_tail(&event->node, &acpi_gpio->events);
>  	return AE_OK;
>  
> @@ -339,6 +345,9 @@ void acpi_gpiochip_free_interrupts(struct gpio_chip *chip)
>  	list_for_each_entry_safe_reverse(event, ep, &acpi_gpio->events, node) {
>  		struct gpio_desc *desc;
>  
> +		if (event->irq_wake_enabled)

It has just occurred to me that if the event is in the list, the IRQ will be
enabled to wake up as long as agpio->wake_capable == ACPI_WAKE_CAPABLE, so it
looks like it should be sufficient to check

	if (agpio->wake_capable == ACPI_WAKE_CAPABLE)

here and the new flag is not necessary.  Or is it?

> +			disable_irq_wake(event->irq);
> +
>  		free_irq(event->irq, event);
>  		desc = event->desc;
>  		if (WARN_ON(IS_ERR(desc)))
> 

Thanks,
Rafael

