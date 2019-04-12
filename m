From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3] gpio: merrifield: Fix build err without CONFIG_ACPI
Date: Fri, 12 Apr 2019 20:56:15 +0300
Message-ID: <20190412175615.GB9224@smile.fi.intel.com>
References: <20190405142112.26592-1-yuehaibing@huawei.com>
 <20190412151911.12084-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190412151911.12084-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yue Haibing <yuehaibing@huawei.com>
Cc: linus.walleij@linaro.org, bgolaszewski@baylibre.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Apr 12, 2019 at 11:19:11PM +0800, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> When building CONFIG_ACPI is not set
> gcc warn this:
> 
> drivers/gpio/gpio-merrifield.c: In function mrfld_gpio_get_pinctrl_dev_name:
> drivers/gpio/gpio-merrifield.c:388:19: error: dereferencing pointer to incomplete type struct acpi_device
>    put_device(&adev->dev);
>                    ^~
> 

Thank you.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes:d00d2109c367 ("gpio: merrifield: Convert to use acpi_dev_get_first_match_dev()")
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v3: move helper to acpi_bus.h, and change name to acpi_dev_put
> ---
>  drivers/gpio/gpio-merrifield.c | 2 +-
>  include/acpi/acpi_bus.h        | 4 ++++
>  include/linux/acpi.h           | 2 ++
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-merrifield.c
> index 2383dc7..3302125 100644
> --- a/drivers/gpio/gpio-merrifield.c
> +++ b/drivers/gpio/gpio-merrifield.c
> @@ -385,7 +385,7 @@ static const char *mrfld_gpio_get_pinctrl_dev_name(struct mrfld_gpio *priv)
>  	adev = acpi_dev_get_first_match_dev("INTC1002", NULL, -1);
>  	if (adev) {
>  		name = devm_kstrdup(priv->dev, acpi_dev_name(adev), GFP_KERNEL);
> -		put_device(&adev->dev);
> +		acpi_dev_put(adev);
>  	} else {
>  		name = "pinctrl-merrifield";
>  	}
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index f798175..2a462cf 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -687,6 +687,10 @@ static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
>  		adev->power.states[ACPI_STATE_D3_HOT].flags.explicit_set);
>  }
>  
> +static inline void acpi_dev_put(struct acpi_device *adev)
> +{
> +	put_device(&adev->dev);
> +}
>  #else	/* CONFIG_ACPI */
>  
>  static inline int register_acpi_bus_type(void *bus) { return 0; }
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index a1bd789..e22c237 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -679,6 +679,8 @@ acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
>  	return NULL;
>  }
>  
> +static inline void acpi_dev_put(struct acpi_device *adev) {}
> +
>  static inline bool is_acpi_node(struct fwnode_handle *fwnode)
>  {
>  	return false;
> -- 
> 2.7.4
> 
> 

-- 
With Best Regards,
Andy Shevchenko
