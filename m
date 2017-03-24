From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3] gpio: acpi: Call enable_irq_wake for _IAE GpioInts
 with Wake set
Date: Fri, 24 Mar 2017 13:34:03 +0200
Message-ID: <1490355243.21738.3.camel@linux.intel.com>
References: <20170324100847.25434-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170324100847.25434-1-hdegoede@redhat.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-gpio@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 2017-03-24 at 11:08 +0100, Hans de Goede wrote:
> On Bay Trail / Cherry Trail systems with a LID switch, the LID switch
> is
> often connect to a gpioint handled by an _IAE event handler.
> Before this commit such systems would not wake up when opening the
> lid,
> requiring the powerbutton to be pressed after opening the lid to
> wakeup.
> 
> Note that Bay Trail / Cherry Trail systems use suspend-to-idle, so
> the interrupts are generated anyway on those lines on lid switch
> changes,
> but they are treated by the IRQ subsystem as spurious while suspended
> if
> not marked as wakeup IRQs.
> 
> This commit calls enable_irq_wake() for _IAE GpioInts with a valid
> event handler which have their Wake flag set. This fixes such systems
> not waking up when opening the lid.
> 

FWIW:
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> Changes in v2:
> -Improve commit msg
> -Add Mika's Acked-by
> Changes in v3:
> -Use irqd_is_wakeup_set rather then tracking this ourselves
> ---
>  drivers/gpio/gpiolib-acpi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 8cd3f66..2972cad 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -266,6 +266,9 @@ static acpi_status
> acpi_gpiochip_request_interrupt(struct acpi_resource *ares,
>  		goto fail_free_event;
>  	}
>  
> +	if (agpio->wake_capable == ACPI_WAKE_CAPABLE)
> +		enable_irq_wake(irq);
> +
>  	list_add_tail(&event->node, &acpi_gpio->events);
>  	return AE_OK;
>  
> @@ -339,6 +342,9 @@ void acpi_gpiochip_free_interrupts(struct
> gpio_chip *chip)
>  	list_for_each_entry_safe_reverse(event, ep, &acpi_gpio-
> >events, node) {
>  		struct gpio_desc *desc;
>  
> +		if (irqd_is_wakeup_set(irq_get_irq_data(event->irq)))
> +			disable_irq_wake(event->irq);
> +
>  		free_irq(event->irq, event);
>  		desc = event->desc;
>  		if (WARN_ON(IS_ERR(desc)))

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
