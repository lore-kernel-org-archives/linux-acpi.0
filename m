From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v5] gpio: Add driver for ACPI INT0002 Virtual GPIO device
Date: Fri, 2 Jun 2017 16:01:11 +0200
Message-ID: <43d9ef7b-265d-44ed-b1ba-ed5ffaad48c4@redhat.com>
References: <20170524104216.23643-1-hdegoede@redhat.com>
 <CACRpkdb9C0+3SLm9guYqHA_e+F4Tt3mbJJA00+d5PsjeuwzrpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750813AbdFBOBP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 2 Jun 2017 10:01:15 -0400
In-Reply-To: <CACRpkdb9C0+3SLm9guYqHA_e+F4Tt3mbJJA00+d5PsjeuwzrpA@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, joeyli <jlee@suse.com>, Takashi Iwai <tiwai@suse.de>

Hi,

On 06/01/2017 05:23 PM, Linus Walleij wrote:
> On Wed, May 24, 2017 at 12:42 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Some peripherals on Bay Trail and Cherry Trail platforms signal PME to the
>> PMC to wakeup the system. When this happens software needs to clear the
>> PME_B0_STS bit in the GPE0a_STS register to avoid an IRQ storm on IRQ 9.
>>
>> This is modeled in ACPI through the INT0002 ACPI Virtual GPIO device.
>>
>> This commit adds a driver which registers the Virtual GPIOs expected
>> by the DSDT on these devices, letting gpiolib-acpi claim the
>> virtual GPIO and install a GPIO-interrupt handler which call the _L02
>> handler as it would for a real GPIO controller.
>>
>> Cc: joeyli <jlee@suse.com>
>> Cc: Takashi Iwai <tiwai@suse.de>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
>> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> 
> Please move this thing to drivers/platform/x86.
> 
>> +config GPIO_INT0002
>> +       tristate "Intel ACPI INT0002 Virtual GPIO"
>> +       depends on ACPI
>> +       select GPIOLIB_IRQCHIP
>> +       ---help---
>> +         Some peripherals on Baytrail and Cherrytrail platforms signal
>> +         PME to the PMC to wakeup the system. When this happens software
> 
> Spell out the acronyms.
> 
>> +         needs to explicitly clear the interrupt source to avoid an IRQ
>> +         storm on IRQ 9. This is modelled in ACPI through the INT0002
>> +         Virtual GPIO ACPI device.
> 
> I.e. it is not really GPIO.
> 
> Virtual GPIO == not GPIO at all, obviously.
> 
> Please write something about this weird newspeak here.
> 
>> +++ b/drivers/gpio/gpio-int0002.c
> (...)
>> + * Some peripherals on Bay Trail and Cherry Trail platforms signal PME to the
>> + * PMC to wakeup the system. When this happens software needs to clear the
>> + * PME_B0_STS bit in the GPE0a_STS register to avoid an IRQ storm on IRQ 9.
> 
> Spell out acronyms.
> 
>> +#include <asm/cpu_device_id.h>
>> +#include <asm/intel-family.h>
>> +#include <linux/acpi.h>
>> +#include <linux/gpio.h>
> 
> No <linux/gpio.h>, only:
> #include <linux/gpio/driver.h>
> 
> in drivers.

The above is all fixed for the next version.

>> +/* For some reason the virtual GPIO pin tied to the GPE is numbered pin 2 */
>> +#define GPE0A_PME_B0_VIRT_GPIO_PIN     2
> 
> I think it's not weird at all, it is a 32bit word which is not a GPIO
> register at all, but
> misc IPC register, where bits 0 and 1 does something else.

That is not true the bus 0 status bit we're reacting to and which we're
clearing in this driver is bit 13 ...

> 
>> +static int int0002_gpio_get(struct gpio_chip *chip, unsigned int offset)
>> +{
>> +       return 0;
>> +}
>> +
>> +static void int0002_gpio_set(struct gpio_chip *chip, unsigned int offset,
>> +                            int value)
>> +{
>> +}
>> +
>> +static int int0002_gpio_direction_output(struct gpio_chip *chip,
>> +                                        unsigned int offset, int value)
>> +{
>> +       return 0;
>> +}
> 
> If you're anyways pretending to be a GPIO chip, then you could implement
> these. But I guess you're not implementing them, because this is not
> a GPIO chip, so let's add a big fat comment above these stating clearly
> why they are not implemented proper.

Done for v6.

> 
>> +static irqreturn_t int0002_irq(int irq, void *data)
>> +{
>> +       struct gpio_chip *chip = data;
>> +       u32 gpe_sts_reg;
>> +
>> +       gpe_sts_reg = inl(GPE0A_STS_PORT);
>> +       if (!(gpe_sts_reg & GPE0A_PME_B0_STS_BIT))
>> +               return IRQ_NONE;
> 
> I wonder what happens the day an IRQ start arriving on the other
> bits. Oh well, that day we handle that.
> 
>> +       for (i = 0; i < GPE0A_PME_B0_VIRT_GPIO_PIN; i++)
>> +               clear_bit(i, chip->irq_valid_mask);
> 
> That's neat.
> 
> Yours,
> Linus Walleij
> 

Regards,

Hans
