From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6] platform/x86: Add driver for ACPI INT0002 Virtual GPIO device
Date: Fri, 2 Jun 2017 18:31:13 +0300
Message-ID: <CAHp75VfR0EJYMwWpsJ=435rTUjH=1s-OYLbF-nt2V35semr4GQ@mail.gmail.com>
References: <20170602151507.22391-1-hdegoede@redhat.com> <20170602151507.22391-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170602151507.22391-2-hdegoede@redhat.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Darren Hart <dvhart@infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, joeyli <jlee@suse.com>, Takashi Iwai <tiwai@suse.de>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jun 2, 2017 at 6:15 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Some peripherals on Bay Trail and Cherry Trail platforms signal a
> Power Management Event (PME) to the Power Management Controller (PMC)
> to wakeup the system. When this happens software needs to explicitly
> clear the PME bus 0 status bit in the GPE0a_STS register to avoid an
> IRQ storm on IRQ 9.
>
> This is modelled in ACPI through the INT0002 ACPI device, which is
> called a "Virtual GPIO controller" in ACPI because it defines the
> event handler to call when the PME triggers through _AEI and _L02
> methods as would be done for a real GPIO interrupt in ACPI.
>
> This commit adds a driver which registers the Virtual GPIOs expected
> by the DSDT on these devices, letting gpiolib-acpi claim the
> virtual GPIO and install a GPIO-interrupt handler which call the _L02
> handler as it would for a real GPIO controller.
>

Alexandre is not anymore in GPIO boat.

Linus, I would like to have your formal tag on this (since linux/gpio/driver.h).

> +#include <asm/cpu_device_id.h>
> +#include <asm/intel-family.h>

I would move this after linux/* section.

> +#include <linux/acpi.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/suspend.h>

> +/*
> + * As this is not a real GPIO at all, but just a hack to model an event in

> + * APCI the get / set functions are dummy functions.

ACPI ?

> + */

> +static int int0002_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       const struct x86_cpu_id *cpu_id;
> +       struct gpio_chip *chip;
> +       int i, irq, ret;
> +

> +       /* Menlow has a different INT0002 device? <sigh> */
> +       cpu_id = x86_match_cpu(int0002_cpu_ids);
> +       if (!cpu_id)
> +               return -ENODEV;

Consider this in my TODO list to check if we can get rid of ancient
Menlow code for good.

> +       for (i = 0; i < GPE0A_PME_B0_VIRT_GPIO_PIN; i++)
> +               clear_bit(i, chip->irq_valid_mask);

bitmap_clear();

I would fix all above when applying, so, just waiting for Linus' tag.

-- 
With Best Regards,
Andy Shevchenko
