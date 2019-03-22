From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] Skip deferred request irqs for devices known to fail
Date: Fri, 22 Mar 2019 15:45:23 +0100
Message-ID: <b5a7b895-e08d-f432-8606-4d8c776d4a8a@redhat.com>
References: <20190322110515.21499-1-ianwmorrison@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322110515.21499-1-ianwmorrison@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ian W MORRISON <ianwmorrison@gmail.com>, benjamin.tissoires@redhat.com, mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On 3/22/19 12:05 PM, Ian W MORRISON wrote:
> Patch ca876c7483b6 "gpiolib-acpi: make sure we trigger edge events at
> least once on boot" causes the MINIX family of mini PCs to fail to boot
> resulting in a "black screen".
> 
> This patch excludes MINIX devices from executing this trigger in order
> to successfully boot.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Ian W MORRISON <ianwmorrison@gmail.com>

IMHO we need to root-cause this problem a bit more before applying this
kludge.

Can you provide an ACPI dump of one of the affected machines ?

Regards,

Hans



> ---
>   drivers/gpio/gpiolib-acpi.c | 28 +++++++++++++++++++++++-----
>   1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 259cf6ab969b..8d855dc9b020 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -16,9 +16,21 @@
>   #include <linux/interrupt.h>
>   #include <linux/mutex.h>
>   #include <linux/pinctrl/pinctrl.h>
> +#include <linux/dmi.h>
>   
>   #include "gpiolib.h"
>   
> +static const struct dmi_system_id skip_deferred_request_irqs_table[] = {
> +	{
> +		.ident = "MINIX Z83-4",
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "MINIX"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Z83-4"),
> +		},
> +	},
> +	{}
> +};
> +
>   /**
>    * struct acpi_gpio_event - ACPI GPIO event handler data
>    *
> @@ -1219,18 +1231,24 @@ bool acpi_can_fallback_to_crs(struct acpi_device *adev, const char *con_id)
>   }
>   
>   /* Run deferred acpi_gpiochip_request_irqs() */
> +/* but exclude devices known to fail */
>   static int acpi_gpio_handle_deferred_request_irqs(void)
>   {
>   	struct acpi_gpio_chip *acpi_gpio, *tmp;
> +	const struct dmi_system_id *dmi_id;
>   
> -	mutex_lock(&acpi_gpio_deferred_req_irqs_lock);
> -	list_for_each_entry_safe(acpi_gpio, tmp,
> +	dmi_id = dmi_first_match(skip_deferred_request_irqs_table);
> +
> +	if (! dmi_id) {
> +		mutex_lock(&acpi_gpio_deferred_req_irqs_lock);
> +		list_for_each_entry_safe(acpi_gpio, tmp,
>   				 &acpi_gpio_deferred_req_irqs_list,
>   				 deferred_req_irqs_list_entry)
> -		acpi_gpiochip_request_irqs(acpi_gpio);
> +			acpi_gpiochip_request_irqs(acpi_gpio);
>   
> -	acpi_gpio_deferred_req_irqs_done = true;
> -	mutex_unlock(&acpi_gpio_deferred_req_irqs_lock);
> +		acpi_gpio_deferred_req_irqs_done = true;
> +		mutex_unlock(&acpi_gpio_deferred_req_irqs_lock);
> +	}
>   
>   	return 0;
>   }
> 
