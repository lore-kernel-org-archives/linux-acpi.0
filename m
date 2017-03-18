From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] gpio: acpi: Call enable_irq_wake for _IAE GpioInts with Wake set
Date: Sun, 19 Mar 2017 00:35:24 +0100
Message-ID: <20170318233524.5047-1-hdegoede@redhat.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On baytrail / cherrytrail systems with a LID switch the LID switch is
often connect to a gpioint handled by an _IAE event handler.
Before this commit such systems would not wake up when opening the lid,
requiring the powerbutton to be pressed after opening the lid to wakeup.

This commit calls enable_irq_wake() for _IAE GpioInts with a valid
event handler which have their Wake flag set. This fixes such systems
not waking up when opening the lid.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpio/gpiolib-acpi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 8cd3f66..18207b2 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -28,6 +28,7 @@ struct acpi_gpio_event {
 	acpi_handle handle;
 	unsigned int pin;
 	unsigned int irq;
+	bool irq_wake_enabled;
 	struct gpio_desc *desc;
 };
 
@@ -266,6 +267,11 @@ static acpi_status acpi_gpiochip_request_interrupt(struct acpi_resource *ares,
 		goto fail_free_event;
 	}
 
+	if (agpio->wake_capable == ACPI_WAKE_CAPABLE) {
+		enable_irq_wake(irq);
+		event->irq_wake_enabled = true;
+	}
+
 	list_add_tail(&event->node, &acpi_gpio->events);
 	return AE_OK;
 
@@ -339,6 +345,9 @@ void acpi_gpiochip_free_interrupts(struct gpio_chip *chip)
 	list_for_each_entry_safe_reverse(event, ep, &acpi_gpio->events, node) {
 		struct gpio_desc *desc;
 
+		if (event->irq_wake_enabled)
+			disable_irq_wake(event->irq);
+
 		free_irq(event->irq, event);
 		desc = event->desc;
 		if (WARN_ON(IS_ERR(desc)))
-- 
2.9.3

