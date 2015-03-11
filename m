From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH 1/2] gpio / ACPI: Avoid unnecessary checks in __gpiod_get_index()
Date: Wed, 11 Mar 2015 09:36:15 +0800
Message-ID: <54FF9C0F.3060107@huawei.com>
References: <4032246.STUT1iRmIk@vostro.rjw.lan> <1829371.gDPkhnsp25@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:63279 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbbCKBg1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Mar 2015 21:36:27 -0400
In-Reply-To: <1829371.gDPkhnsp25@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

On 2015/3/11 6:08, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> If dev is NULL in __gpiod_get_index() and both ACPI and OF are
> enabled, it will be checked twice before the code decides to give
> up with DT/ACPI lookup, so avoid that.
>
> Also use the observation that ACPI_COMPANION() is much more efficient
> than ACPI_HANDLE(), because the latter uses the former and carries out
> a check and a pointer dereference on top of it, so replace the
> ACPI_HANDLE() check with an ACPI_COMPANION() one which does not
> require the additional IS_ENABLED(CONFIG_ACPI) check too.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Quite straight forward to me, for both two patches,

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun

> ---
>  drivers/gpio/gpiolib.c |   16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> Index: linux-pm/drivers/gpio/gpiolib.c
> ===================================================================
> --- linux-pm.orig/drivers/gpio/gpiolib.c
> +++ linux-pm/drivers/gpio/gpiolib.c
> @@ -1865,13 +1865,15 @@ struct gpio_desc *__must_check __gpiod_g
>  
>  	dev_dbg(dev, "GPIO lookup for consumer %s\n", con_id);
>  
> -	/* Using device tree? */
> -	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node) {
> -		dev_dbg(dev, "using device tree for GPIO lookup\n");
> -		desc = of_find_gpio(dev, con_id, idx, &lookupflags);
> -	} else if (IS_ENABLED(CONFIG_ACPI) && dev && ACPI_HANDLE(dev)) {
> -		dev_dbg(dev, "using ACPI for GPIO lookup\n");
> -		desc = acpi_find_gpio(dev, con_id, idx, &lookupflags);
> +	if (dev) {
> +		/* Using device tree? */
> +		if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
> +			dev_dbg(dev, "using device tree for GPIO lookup\n");
> +			desc = of_find_gpio(dev, con_id, idx, &lookupflags);
> +		} else if (ACPI_COMPANION(dev)) {
> +			dev_dbg(dev, "using ACPI for GPIO lookup\n");
> +			desc = acpi_find_gpio(dev, con_id, idx, &lookupflags);
> +		}
>  	}
>  
>  	/*
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> .
>


