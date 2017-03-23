From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v1 2/8] gpio: acpi: Align acpi_find_gpio() with DT version
Date: Thu, 23 Mar 2017 13:13:22 -0700
Message-ID: <20170323201322.GC2502@dtor-ws>
References: <20170323194618.26548-1-andriy.shevchenko@linux.intel.com>
 <20170323194618.26548-3-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170323194618.26548-3-andriy.shevchenko@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 23, 2017 at 09:46:12PM +0200, Andy Shevchenko wrote:
> By some reason acpi_find_gpio() and acpi_gpio_count() have compared connection
> ID to "gpios" when tries to check if suffix is needed or not.
> 
> Don't do any assumptions about what connection ID can be and, when defined, use
> it only with suffix as it's done in the device tree version.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/gpio/gpiolib-acpi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 56a6b1be3a17..3bda3166d418 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -593,7 +593,7 @@ struct gpio_desc *acpi_find_gpio(struct device *dev,
>  
>  	/* Try first from _DSD */
>  	for (i = 0; i < ARRAY_SIZE(gpio_suffixes); i++) {
> -		if (con_id && strcmp(con_id, "gpios")) {
> +		if (con_id) {
>  			snprintf(propname, sizeof(propname), "%s-%s",
>  				 con_id, gpio_suffixes[i]);
>  		} else {
> @@ -1081,7 +1081,7 @@ int acpi_gpio_count(struct device *dev, const char *con_id)
>  
>  	/* Try first from _DSD */
>  	for (i = 0; i < ARRAY_SIZE(gpio_suffixes); i++) {
> -		if (con_id && strcmp(con_id, "gpios"))
> +		if (con_id)
>  			snprintf(propname, sizeof(propname), "%s-%s",
>  				 con_id, gpio_suffixes[i]);
>  		else
> -- 
> 2.11.0
> 

-- 
Dmitry
