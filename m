From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] Skip deferred request irqs for devices known to fail
Date: Fri, 22 Mar 2019 13:42:54 +0200
Message-ID: <20190322114254.GT9224@smile.fi.intel.com>
References: <20190322110515.21499-1-ianwmorrison@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190322110515.21499-1-ianwmorrison@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian W MORRISON <ianwmorrison@gmail.com>
Cc: benjamin.tissoires@redhat.com, hdegoede@redhat.com, mika.westerberg@linux.intel.com, linus.walleij@linaro.org, bgolaszewski@baylibre.com, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Mar 22, 2019 at 10:05:15PM +1100, Ian W MORRISON wrote:

Thanks for the patch, my comments below.

> Patch ca876c7483b6 "gpiolib-acpi: make sure we trigger edge events at
> least once on boot" causes the MINIX family of mini PCs to fail to boot
> resulting in a "black screen". 

> This patch excludes MINIX devices from executing this trigger in order
> to successfully boot.

Hmm... Feels like this is symptomatic healing.
Hans, do you have anything in mind about this case?

>  #include <linux/interrupt.h>
>  #include <linux/mutex.h>
>  #include <linux/pinctrl/pinctrl.h>
> +#include <linux/dmi.h>

This should be in order.

>  /* Run deferred acpi_gpiochip_request_irqs() */
> +/* but exclude devices known to fail */

/*
 * This should be done in the similar style
 * as for multi-line comments. Like this one.
 */

> +	dmi_id = dmi_first_match(skip_deferred_request_irqs_table);
> +

Redundant blank line.

> +	if (! dmi_id) {

No space here, however, better to write positive conditional.

-- 
With Best Regards,
Andy Shevchenko
