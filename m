From: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH] gpio: merrifield: Fix build err without CONFIG_ACPI
Date: Thu, 4 Apr 2019 22:04:04 +0800
Message-ID: <271a33ae-b4fc-0528-cf59-5053dc46cce0@huawei.com>
References: <20190404103925.25652-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190404103925.25652-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org, bgolaszewski@baylibre.com, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

+cc Rafael and linux-acpi

On 2019/4/4 18:39, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> When building CONFIG_ACPI is not set
> gcc warn this:
> 
> drivers/gpio/gpio-merrifield.c: In function mrfld_gpio_get_pinctrl_dev_name:
> drivers/gpio/gpio-merrifield.c:388:19: error: dereferencing pointer to incomplete type struct acpi_device
>    put_device(&adev->dev);
>                    ^
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes:d00d2109c367 ("gpio: merrifield: Convert to use acpi_dev_get_first_match_dev()")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpio/gpio-merrifield.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-merrifield.c
> index 2383dc7..78ac32f 100644
> --- a/drivers/gpio/gpio-merrifield.c
> +++ b/drivers/gpio/gpio-merrifield.c
> @@ -379,17 +379,18 @@ static void mrfld_irq_init_hw(struct mrfld_gpio *priv)
>  
>  static const char *mrfld_gpio_get_pinctrl_dev_name(struct mrfld_gpio *priv)
>  {
> -	struct acpi_device *adev;
>  	const char *name;
> +#ifdef CONFIG_ACPI
> +	struct acpi_device *adev;
>  
>  	adev = acpi_dev_get_first_match_dev("INTC1002", NULL, -1);
>  	if (adev) {
>  		name = devm_kstrdup(priv->dev, acpi_dev_name(adev), GFP_KERNEL);
>  		put_device(&adev->dev);
> -	} else {
> -		name = "pinctrl-merrifield";
>  	}
> -
> +#else
> +	name = "pinctrl-merrifield";
> +#endif
>  	return name;
>  }
>  
> 
