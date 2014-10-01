From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 13/15] input: gpio_keys_polled - Add ACPI probing
 support
Date: Wed, 1 Oct 2014 00:48:46 -0700
Message-ID: <20141001074846.GA17700@dtor-glaptop>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com>
 <1852462.V1jlbi8OPt@vostro.rjw.lan>
 <17237242.r7oKCjnQJM@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <17237242.r7oKCjnQJM@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Aaron Lu <aaron.lu@intel.com>, Darren Hart <dvhart@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 01, 2014 at 04:20:43AM +0200, Rafael J. Wysocki wrote:
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Allow the driver to probe from ACPI namespace.
> 
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/input/keyboard/gpio_keys_polled.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> Index: linux-pm/drivers/input/keyboard/gpio_keys_polled.c
> ===================================================================
> --- linux-pm.orig/drivers/input/keyboard/gpio_keys_polled.c
> +++ linux-pm/drivers/input/keyboard/gpio_keys_polled.c
> @@ -181,6 +181,12 @@ static const struct of_device_id gpio_ke
>  };
>  MODULE_DEVICE_TABLE(of, gpio_keys_polled_of_match);
>  
> +static const struct acpi_device_id gpio_keys_polled_acpi_match[] = {
> +	{ "PRP0001" }, /* Device Tree shoehorned into ACPI */
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, gpio_keys_polled_acpi_match);
> +
>  static int gpio_keys_polled_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -309,6 +315,7 @@ static struct platform_driver gpio_keys_
>  		.name	= DRV_NAME,
>  		.owner	= THIS_MODULE,
>  		.of_match_table = gpio_keys_polled_of_match,
> +		.acpi_match_table = gpio_keys_polled_acpi_match,
o
Hmm, why do we need the generic "PRP0001" in every driver? The ACPI device
should have PRP0001 and ACPI bus should know to look into OF matching table
for such devices.

Thanks.

-- 
Dmitry
