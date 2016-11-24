From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] gpiolib: Forbid irqchip default trigger for ACPI enumerated devices
Date: Thu, 24 Nov 2016 02:33:55 +0100
Message-ID: <3728863.ohrj1SkIMB@vostro.rjw.lan>
References: <20160912112951.76598-1-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20160912112951.76598-1-mika.westerberg@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Monday, September 12, 2016 02:29:51 PM Mika Westerberg wrote:
> Follow DT and forbid default trigger if the GPIO irqchip device is
> enumerated from ACPI. Triggering for these devices will be configured
> automatically from ACPI interrupt resources provided by the BIOS.
> 
> Suggested-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> This is on top of Marc's patch here:
> 
>   https://lkml.org/lkml/2016/9/7/121
> 
>  drivers/gpio/gpiolib.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 5707b5d12b28..0efb67f387ea 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1618,13 +1618,18 @@ int _gpiochip_irqchip_add(struct gpio_chip *gpiochip,
>  		of_node = gpiochip->of_node;
>  #endif
>  	/*
> -	 * Specifying a default trigger is a terrible idea if DT is
> +	 * Specifying a default trigger is a terrible idea if DT or ACPI is
>  	 * used to configure the interrupts, as you may end-up with
>  	 * conflicting triggers. Tell the user, and reset to NONE.
>  	 */
>  	if (WARN(of_node && type != IRQ_TYPE_NONE,
>  		 "%s: Ignoring %d default trigger\n", of_node->full_name, type))
>  		type = IRQ_TYPE_NONE;
> +	if (has_acpi_companion(gpiochip->parent) && type != IRQ_TYPE_NONE) {
> +		acpi_handle_warn(ACPI_HANDLE(gpiochip->parent),
> +				 "Ignoring %d default trigger\n", type);
> +		type = IRQ_TYPE_NONE;
> +	}
>  
>  	gpiochip->irqchip = irqchip;
>  	gpiochip->irq_handler = handler;
> 

Has this gone anywhere already?

Thanks,
Rafael

