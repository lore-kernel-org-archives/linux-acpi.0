From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v0] gpio: xgene: add ACPI support for APM X-Gene GPIO
 standby driver
Date: Fri, 29 May 2015 12:25:01 +0300
Message-ID: <20150529092501.GI1747@lahna.fi.intel.com>
References: <1432795588-17476-1-git-send-email-yvo@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432795588-17476-1-git-send-email-yvo@apm.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Y Vo <yvo@apm.com>
Cc: linus.walleij@linaro.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Phong Vo <pvo@apm.com>, Toan Le <toanle@apm.com>, Loc Ho <lho@apm.com>, patches@apm.com
List-Id: linux-acpi@vger.kernel.org

On Thu, May 28, 2015 at 01:46:28PM +0700, Y Vo wrote:
> +#ifdef CONFIG_ACPI
> +	if (priv->nirq > 0) {
> +		/* Register interrupt handlers for gpio signaled acpi events */
> +		acpi_gpiochip_request_interrupts(&priv->bgc.gc);
> +	}
> +#endif

You don't need to check CONFIG_ACPI as acpi_gpiochip_request_interrupts()
will be stubbed out if !CONFIG_ACPI.

Should you call acpi_gpiochip_free_interrupts() somewhere to unregister
the interrupts as well?

Even better if you can switch your driver to use GPIOLIB_IRQCHIP all
this is done automatically for you.
