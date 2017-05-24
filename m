From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4] gpio: Add driver for ACPI INT0002 Virtual GPIO device
Date: Wed, 24 May 2017 13:27:51 +0300
Message-ID: <1495621671.6967.88.camel@linux.intel.com>
References: <20170524075801.9152-1-hdegoede@redhat.com>
         <20170524075801.9152-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170524075801.9152-2-hdegoede@redhat.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, joeyli <jlee@suse.com>, Takashi Iwai <tiwai@suse.de>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2017-05-24 at 09:58 +0200, Hans de Goede wrote:
> Some peripherals on Bay Trail and Cherry Trail platforms signal PME to
> the
> PMC to wakeup the system. When this happens software needs to clear
> the
> PME_B0_STS bit in the GPE0a_STS register to avoid an IRQ storm on IRQ
> 9.
> 
> This is modeled in ACPI through the INT0002 ACPI Virtual GPIO device.
> 
> This commit adds a driver which registers the Virtual GPIOs expected
> by the DSDT on these devices, letting gpiolib-acpi claim the
> virtual GPIO and install a GPIO-interrupt handler which call the _L02
> handler as it would for a real GPIO controller.

Some issues below, after addressing them
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> +config GPIO_INT0002
> +	tristate "Intel ACPI INT0002 Virtual GPIO"
> +	depends on ACPI

&& X86 (see below why)

> +#include <asm/cpu_device_id.h>
> +#include <asm/intel-family.h>

Please, move this after <linux/*> headers with empty line in between.

Because you are using specific x86 headers you must depend on X86.

> +#include <linux/acpi.h>
> +#include <linux/gpio.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/suspend.h>

> +
> +/* For some reason the virtual GPIO pin tied to the GPE is numbered
> pin 2 */
> +#define GPE0A_PME_B0_VIRT_GPIO_PIN	2
> +

> +#define GPE0A_PME_B0_STS_BIT		0x2000
> +#define GPE0A_PME_B0_EN_BIT		0x2000

BIT() ?

> +#define GPE0A_STS_PORT			0x420
> +#define GPE0A_EN_PORT			0x428
> +

> +static int int0002_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	const struct x86_cpu_id *cpu_id;
> +	struct gpio_chip *chip;
> +	int i, irq, ret;
> +

> +	/* Menlow has a different INT0002 device? <sigh> */

Perhaps we can remove that all code. I will look at it when I have spare
time.

For now we may go with your code as is.

> +	cpu_id = x86_match_cpu(int0002_cpu_ids);
> +	if (!cpu_id)
> +		return -ENODEV;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(dev, "Error getting IRQ: %d\n", irq);
> +		return irq;
> +	}
> +
> +	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->label = DRV_NAME;
> +	chip->parent = dev;
> +	chip->owner = THIS_MODULE;
> +	chip->get = int0002_gpio_get;
> +	chip->set = int0002_gpio_set;
> +	chip->direction_input = int0002_gpio_get;
> +	chip->direction_output = int0002_gpio_direction_output;
> +	chip->base = -1;
> +	chip->ngpio = GPE0A_PME_B0_VIRT_GPIO_PIN + 1;
> +	chip->irq_need_valid_mask = true;
> +
> +	ret = devm_gpiochip_add_data(&pdev->dev, chip, NULL);
> +	if (ret) {
> +		dev_err(dev, "Error adding gpio chip: %d\n", ret);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < GPE0A_PME_B0_VIRT_GPIO_PIN; i++)
> +		clear_bit(i, chip->irq_valid_mask);
> +
> +	/*
> +	 * We manually request the irq here instead of passing a
> flow-handler
> +	 * to gpiochip_set_chained_irqchip, because the irq is
> shared.
> +	 */

Linus, I'm just wondering if we can provide generic solution for such
cases (AFAIU this is copied from some of Intel pin control driver, so,
we have two or more users already).

For now let's go with current proposal.

> +	ret = devm_request_irq(dev, irq, int0002_irq,
> +			       IRQF_SHARED | IRQF_NO_THREAD,
> "INT0002", chip);
> +	if (ret) {
> +		dev_err(dev, "Error requesting IRQ %d: %d\n", irq,
> ret);
> +		return ret;
> +	}
> +
> 

> +
> +static const struct acpi_device_id int0002_acpi_ids[] = {
> +	{ "INT0002", 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, int0002_acpi_ids);
> +
> +static struct platform_driver int0002_driver = {
> +	.driver = {
> +		.name			= DRV_NAME,
> +		.acpi_match_table	= 

> ACPI_PTR(int0002_acpi_ids),

No #ifdef, so ACPI_PTR can be dropped.

> +	},
> +	.probe	= int0002_probe,
> +};

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
