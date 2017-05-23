From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] gpio: Add driver for ACPI INT0002 Virtual GPIO device
Date: Wed, 24 May 2017 01:58:55 +0200
Message-ID: <1568110.8i5Lk7glZA@aspire.rjw.lan>
References: <20170523201241.27520-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44474 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1760195AbdEXAFl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 May 2017 20:05:41 -0400
In-Reply-To: <20170523201241.27520-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-acpi@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, joeyli <jlee@suse.com>, Takashi Iwai <tiwai@suse.de>

On Tuesday, May 23, 2017 10:12:41 PM Hans de Goede wrote:
> Some peripherals on Baytrail and Cherrytrail platforms signal PME to the
> PMC to wakeup the system. When this happens software needs to clear the
> PME_B0_STS bit in the GPE0a_STS register to avoid an IRQ storm on IRQ 9.
> 
> This is modelled in ACPI through the INT0002 ACPI Virtual GPIO device.
> 
> This commit adds a driver which registers the Virtual GPIOs expected
> by the DSDT on these devices, this will make gpiolib-acpi claim the
> virtual GPIO and execute _L02 when the PME_B0_STS bit is set, avoiding
> the irq storm.
> 
> Cc: joeyli <jlee@suse.com>
> Cc: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Remove dev_err after malloc failure
> -Remove unused empty runtime pm callbacks
> -s/GPE0A_PME_/GPE0A_PME_B0_/
> -Fixed some checkpatch warnings (I forgot to run checkpatch on v1)
> Changes in v3:
> -Rewrite as gpiochip driver letting gpiolib-acpi deal with claiming the pin
>  0x0002 and calling the _L02 event handler when the virtual gpio-irq triggers
> -Rebase on 4.12-rc1
> ---
>  drivers/gpio/Kconfig        |  14 +++
>  drivers/gpio/Makefile       |   1 +
>  drivers/gpio/gpio-int0002.c | 211 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 226 insertions(+)
>  create mode 100644 drivers/gpio/gpio-int0002.c
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 23ca51e..11e7f9b 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -608,6 +608,20 @@ config GPIO_GPIO_MM
>  	  The base port addresses for the devices may be configured via the base
>  	  array module parameter.
>  
> +config GPIO_INT0002
> +	tristate "Intel ACPI INT0002 Virtual GPIO"
> +	depends on ACPI
> +	select GPIOLIB_IRQCHIP
> +	---help---
> +	  Some peripherals on Baytrail and Cherrytrail platforms signal
> +	  PME to the PMC to wakeup the system. When this happens software
> +	  needs to explicitly clear the interrupt source to avoid an IRQ
> +	  storm on IRQ 9. This is modelled in ACPI through the INT0002
> +	  Virtual GPIO ACPI device.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called gpio_int0002.
> +
>  config GPIO_IT87
>  	tristate "IT87xx GPIO support"
>  	help
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 68b9627..1f76c56 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_GPIO_GPIO_MM)	+= gpio-gpio-mm.o
>  obj-$(CONFIG_GPIO_GRGPIO)	+= gpio-grgpio.o
>  obj-$(CONFIG_HTC_EGPIO)		+= gpio-htc-egpio.o
>  obj-$(CONFIG_GPIO_ICH)		+= gpio-ich.o
> +obj-$(CONFIG_GPIO_INT0002)	+= gpio-int0002.o
>  obj-$(CONFIG_GPIO_IOP)		+= gpio-iop.o
>  obj-$(CONFIG_GPIO_IT87)		+= gpio-it87.o
>  obj-$(CONFIG_GPIO_JANZ_TTL)	+= gpio-janz-ttl.o
> diff --git a/drivers/gpio/gpio-int0002.c b/drivers/gpio/gpio-int0002.c
> new file mode 100644
> index 0000000..e73664d
> --- /dev/null
> +++ b/drivers/gpio/gpio-int0002.c
> @@ -0,0 +1,211 @@
> +/*
> + * Intel INT0002 "Virtual GPIO" driver
> + *
> + * Copyright (C) 2017 Hans de Goede <hdegoede@redhat.com>
> + *
> + * Loosely based on android x86 kernel code which is:
> + *
> + * Copyright (c) 2014, Intel Corporation.
> + *
> + * Author: Dyut Kumar Sil <dyut.k.sil@intel.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Some peripherals on Baytrail and Cherrytrail platforms signal PME to the
> + * PMC to wakeup the system. When this happens software needs to clear the
> + * PME_B0_STS bit in the GPE0a_STS register to avoid an IRQ storm on IRQ 9.
> + *
> + * This is modelled in ACPI through the INT0002 ACPI device, which is
> + * called a "Virtual GPIO controller" in ACPI because it defines the event
> + * handler to call when the PME triggers through _AEI and _L02 / _E02
> + * methods as would be done for a real GPIO interrupt in ACPI.
> + *
> + * This driver will bind to the INT0002 device, and register as a GPIO
> + * controller, letting gpiolib-acpi.c call the _L02 handler as it would
> + * for a real GPIO controller.
> + */
> +
> +#include <asm/cpu_device_id.h>
> +#include <asm/intel-family.h>
> +#include <linux/acpi.h>
> +#include <linux/gpio.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#define DRV_NAME			"INT0002 Virtual GPIO"
> +
> +/* For some reason the virtual GPIO pin tied to the GPE is numbered pin 2 */
> +#define GPE0A_PME_B0_VIRT_GPIO_PIN	2
> +
> +#define GPE0A_PME_B0_STS_BIT		0x2000
> +#define GPE0A_PME_B0_EN_BIT		0x2000
> +#define GPE0A_STS_PORT			0x420
> +#define GPE0A_EN_PORT			0x428
> +
> +#define ICPU(model)	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
> +
> +static const struct x86_cpu_id int0002_cpu_ids[] = {
> +/*
> + * Limit ourselves to Cherry Trail for now, until testing shows we
> + * need to handle the INT0002 device on Baytrail too.
> + *	ICPU(INTEL_FAM6_ATOM_SILVERMONT1),	 * Valleyview, Bay Trail *
> + */
> +	ICPU(INTEL_FAM6_ATOM_AIRMONT),		/* Braswell, Cherry Trail */
> +	{}
> +};
> +
> +static int int0002_gpio_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +	return 0;
> +}
> +
> +static void int0002_gpio_set(struct gpio_chip *chip, unsigned int offset,
> +			     int value)
> +{
> +}
> +
> +static int int0002_gpio_direction_output(struct gpio_chip *chip,
> +					 unsigned int offset, int value)
> +{
> +	return 0;
> +}
> +
> +static void int0002_irq_ack(struct irq_data *data)
> +{
> +	outl(GPE0A_PME_B0_STS_BIT, GPE0A_STS_PORT);
> +}
> +
> +static void int0002_irq_unmask(struct irq_data *data)
> +{
> +	u32 gpe_en_reg;
> +
> +	gpe_en_reg = inl(GPE0A_EN_PORT);
> +	gpe_en_reg |= GPE0A_PME_B0_EN_BIT;
> +	outl(gpe_en_reg, GPE0A_EN_PORT);
> +}
> +
> +static void int0002_irq_mask(struct irq_data *data)
> +{
> +	u32 gpe_en_reg;
> +
> +	gpe_en_reg = inl(GPE0A_EN_PORT);
> +	gpe_en_reg &= ~GPE0A_PME_B0_EN_BIT;
> +	outl(gpe_en_reg, GPE0A_EN_PORT);
> +}
> +
> +static irqreturn_t int0002_irq(int irq, void *data)
> +{
> +	struct gpio_chip *chip = data;
> +	u32 gpe_sts_reg;
> +
> +	gpe_sts_reg = inl(GPE0A_STS_PORT);
> +	if (!(gpe_sts_reg & GPE0A_PME_B0_STS_BIT))
> +		return IRQ_NONE;
> +
> +	generic_handle_irq(irq_find_mapping(chip->irqdomain,
> +					    GPE0A_PME_B0_VIRT_GPIO_PIN));
> +
> +	pm_wakeup_hard_event(chip->parent);

It may be better to just do pm_system_wakeup() here and drop the
device_init_wakeup() from _probe().

The reason why is that device_init_wakeup() allows user space to disable
this wakeup source via sysfs which probably never is a good idea, because
this thing is just for clearing PME status which should be done regardless
and the actual wakeup is triggered by something else.

Also in theory pm_system_wakeup() should not really be necessary for
wakeup via USB keyboard to work, because that should be signaled via
acpi_pm_notify_handler(), at least in principle.

Thanks,
Rafael

