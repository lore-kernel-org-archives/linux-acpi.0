From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v6] platform/x86: Add driver for ACPI INT0002 Virtual
 GPIO device
Date: Fri, 09 Jun 2017 12:18:08 +0300
Message-ID: <1496999888.22624.75.camel@linux.intel.com>
References: <20170602151507.22391-1-hdegoede@redhat.com>
         <20170602151507.22391-2-hdegoede@redhat.com>
         <CACRpkdYmu34BLvSGR840+psUVwgqe1v+mBzPyKQj25R7HTQnpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40039 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751528AbdFIJWn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 9 Jun 2017 05:22:43 -0400
In-Reply-To: <CACRpkdYmu34BLvSGR840+psUVwgqe1v+mBzPyKQj25R7HTQnpw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Darren Hart <dvhart@infradead.org>, Alexandre Courbot <gnurou@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, joeyli <jlee@suse.com>, Takashi Iwai <tiwai@suse.de>

On Fri, 2017-06-09 at 11:02 +0200, Linus Walleij wrote:
> On Fri, Jun 2, 2017 at 5:15 PM, Hans de Goede <hdegoede@redhat.com>
> wrote:
> 
> > Some peripherals on Bay Trail and Cherry Trail platforms signal a
> > Power Management Event (PME) to the Power Management Controller
> > (PMC)
> > to wakeup the system. When this happens software needs to explicitly
> > clear the PME bus 0 status bit in the GPE0a_STS register to avoid an
> > IRQ storm on IRQ 9.
> > 
> > This is modelled in ACPI through the INT0002 ACPI device, which is
> > called a "Virtual GPIO controller" in ACPI because it defines the
> > event handler to call when the PME triggers through _AEI and _L02
> > methods as would be done for a real GPIO interrupt in ACPI.
> > 
> > This commit adds a driver which registers the Virtual GPIOs expected
> > by the DSDT on these devices, letting gpiolib-acpi claim the
> > virtual GPIO and install a GPIO-interrupt handler which call the
> > _L02
> > handler as it would for a real GPIO controller.
> > 
> > Cc: joeyli <jlee@suse.com>
> > Cc: Takashi Iwai <tiwai@suse.de>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > Changes in v2:
> > -Remove dev_err after malloc failure
> > -Remove unused empty runtime pm callbacks
> > -s/GPE0A_PME_/GPE0A_PME_B0_/
> > -Fixed some checkpatch warnings (I forgot to run checkpatch on v1)
> > Changes in v3:
> > -Rewrite as gpiochip driver letting gpiolib-acpi deal with claiming
> > the pin
> >  0x0002 and calling the _L02 event handler when the virtual gpio-irq 
> > triggers
> > -Rebase on 4.12-rc1
> > Changes in v4:
> > -Drop device_init_wakeup() from _probe(), use pm_system_wakeup()
> > instead
> >  of pm_wakeup_hard_event(chip->parent)
> > -Improve commit message
> > Changes in v5:
> > -Use BIT() macro for FOO_BIT defines
> > -Drop unneeded ACPI_PTR macro usage
> > Changes in v6:
> > -Move back to drivers/platform/x86
> > -Expand certain acronyms (PME, PMC)
> > -Use linux/gpio/driver.h include instead of linux/gpio.h
> > -Document why the get / set / direction_output functions are dummys
> > -No functional changes
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> With Andy's changes.

Oops, when I removed this from PDx86 testing branch I removed my changes
together.

Here they are (Hans, perhaps you may resend with them included)
--- a/drivers/platform/x86/intel_int0002_vgpio.c
+++ b/drivers/platform/x86/intel_int0002_vgpio.c
@@ -30,9 +30,8 @@
  * for a real GPIO controller.
  */

-#include <asm/cpu_device_id.h>
-#include <asm/intel-family.h>
 #include <linux/acpi.h>
+#include <linux/bitmap.h>
 #include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -42,6 +41,9 @@
 #include <linux/slab.h>
 #include <linux/suspend.h>  

+#include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
+
 #define DRV_NAME                       "INT0002 Virtual GPIO"

 /* For some reason the virtual GPIO pin tied to the GPE is numbered pin
2 */
@@ -66,7 +68,7 @@ static const struct x86_cpu_id int0002_cpu_ids[] = {

 /*
  * As this is not a real GPIO at all, but just a hack to model an event
in
- * APCI the get / set functions are dummy functions.
+ * ACPI the get / set functions are dummy functions.
  */

 static int int0002_gpio_get(struct gpio_chip *chip, unsigned int
offset)
@@ -137,7 +139,7 @@ static int int0002_probe(struct platform_device
*pdev)
        struct device *dev = &pdev->dev;
        const struct x86_cpu_id *cpu_id;
        struct gpio_chip *chip;
-       int i, irq, ret;
+       int irq, ret;

        /* Menlow has a different INT0002 device? <sigh> */
        cpu_id = x86_match_cpu(int0002_cpu_ids);
@@ -171,8 +173,7 @@ static int int0002_probe(struct platform_device
*pdev)
                return ret;
        }

-       for (i = 0; i < GPE0A_PME_B0_VIRT_GPIO_PIN; i++)
-               clear_bit(i, chip->irq_valid_mask);
+       bitmap_clear(chip->irq_valid_mask, 0,
GPE0A_PME_B0_VIRT_GPIO_PIN);

        /*
         * We manually request the irq here instead of passing a flow-
handler

> 
> Please feel free to push this upstream through the platform tree
> or similar.
> 
> Yours,
> Linus Walleij

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
