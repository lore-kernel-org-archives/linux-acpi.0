From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] gpio / ACPI: Handle ACPI events in accordance with the
 spec
Date: Wed, 10 Apr 2013 10:53:19 +0300
Message-ID: <20130410075319.GN21818@intel.com>
References: <3043137.BtEKcMiXSu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:33173 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751574Ab3DJHtJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Apr 2013 03:49:09 -0400
Content-Disposition: inline
In-Reply-To: <3043137.BtEKcMiXSu@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, Mathias Nyman <mathias.nyman@linux.intel.com>, grant.likely@secretlab.ca, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Tue, Apr 09, 2013 at 03:57:25PM +0200, Rafael J. Wysocki wrote:
> +void acpi_gpiochip_free_interrupts(struct gpio_chip *chip)
> +{
> +	acpi_handle handle;
> +	acpi_status status;
> +	struct list_head *evt_pins;
> +	struct acpi_gpio_evt_pin *evt_pin, *ep;
> +
> +	if (!chip->dev || !chip->to_irq)
> +		return;
> +
> +	handle = ACPI_HANDLE(chip->dev);
> +	if (!handle)
> +		return;
> +
> +	status = acpi_get_data(handle, acpi_gpio_evt_dh, (void **)&evt_pins);
> +	if (ACPI_FAILURE(status))
> +		return;
> +
> +	list_for_each_entry_safe_reverse(evt_pin, ep, evt_pins, node) {
> +		devm_free_irq(chip->dev, evt_pin->irq, evt_pin);

How about using normal request/free_irq() functions for both _EVT and
non-_EVT events? Since we now need to call acpi_gpiochip_free_interrupts()
anyway, I don't see the point using devm_* functions here.

> +		list_del(&evt_pin->node);
> +		kfree(evt_pin);
> +	}
> +
> +	acpi_detach_data(handle, acpi_gpio_evt_dh);
> +	kfree(evt_pins);
> +}
> +EXPORT_SYMBOL(acpi_gpiochip_free_interrupts);
