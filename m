From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] gpio / ACPI: return -ENOENT when no mapping exists
Date: Thu, 12 Dec 2013 02:39:13 +0100
Message-ID: <1818897.EILY1COPGZ@vostro.rjw.lan>
References: <1386669627-31365-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1386669627-31365-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alex Courbot <acourbot@nvidia.com>, linux-gpio@vger.kernel.org, Mathias Nyman <mathias.nyman@linux.intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday, December 10, 2013 12:00:27 PM Mika Westerberg wrote:
> Doing this allows drivers to distinguish between a real error case (if
> there was an error when we tried to resolve the GPIO) and when the optional
> GPIO line was not available.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/gpio/gpiolib-acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 8506e4ce41f7..716ee9843110 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -307,7 +307,7 @@ struct gpio_desc *acpi_get_gpiod_by_index(struct device *dev, int index,
>  	if (lookup.desc && info)
>  		*info = lookup.info;
>  
> -	return lookup.desc ? lookup.desc : ERR_PTR(-ENODEV);
> +	return lookup.desc ? lookup.desc : ERR_PTR(-ENOENT);
>  }
>  
>  void acpi_gpiochip_add(struct gpio_chip *chip)
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
