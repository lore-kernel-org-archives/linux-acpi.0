From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] pinctrl: baytrail: Add back Baytrail-T ACPI ID
Date: Fri, 16 May 2014 14:10:47 +0200
Message-ID: <1593450.1tg6AZy8cc@vostro.rjw.lan>
References: <1400167727-20233-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400167727-20233-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jin Yao <yao.jin@intel.com>, Aubrey Li <aubrey.li@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thursday, May 15, 2014 06:28:46 PM Mika Westerberg wrote:
> From: Jin Yao <yao.jin@intel.com>
> 
> Now that the x86 dynamic IRQ allocation problem has been resolved with
> commmit 62a08ae2a576 (genirq: x86: Ensure that dynamic irq allocation does
> not conflict), we can add back Baytrail-T ACPI ID to the pinctrl driver.
> 
> This makes the driver to work on Asus T100 where it is needed for several
> things like ACPI GPIO events and SD card detection.
> 
> References: https://bugzilla.kernel.org/show_bug.cgi?id=68291
> Signed-off-by: Jin Yao <yao.jin@intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

And I think this is pinctrl material really.

> ---
>  drivers/acpi/acpi_lpss.c           | 1 +
>  drivers/pinctrl/pinctrl-baytrail.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 24e49a52cefb..c314d709e5a6 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -189,6 +189,7 @@ static const struct acpi_device_id acpi_lpss_device_ids[] = {
>  	{ "80860F14", (unsigned long)&byt_sdio_dev_desc },
>  	{ "80860F41", (unsigned long)&byt_i2c_dev_desc },
>  	{ "INT33B2", },
> +	{ "INT33FC", },
>  
>  	{ "INT3430", (unsigned long)&lpt_dev_desc },
>  	{ "INT3431", (unsigned long)&lpt_dev_desc },
> diff --git a/drivers/pinctrl/pinctrl-baytrail.c b/drivers/pinctrl/pinctrl-baytrail.c
> index 6e8301f77187..447f1dc25ea6 100644
> --- a/drivers/pinctrl/pinctrl-baytrail.c
> +++ b/drivers/pinctrl/pinctrl-baytrail.c
> @@ -572,6 +572,7 @@ static const struct dev_pm_ops byt_gpio_pm_ops = {
>  
>  static const struct acpi_device_id byt_gpio_acpi_match[] = {
>  	{ "INT33B2", 0 },
> +	{ "INT33FC", 0 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, byt_gpio_acpi_match);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
