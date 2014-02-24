From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 3/6] gpio / ACPI: Rename acpi_gpio_evt_pin to acpi_gpio_event
Date: Mon, 24 Feb 2014 18:00:08 +0200
Message-ID: <1393257611-18031-4-git-send-email-mika.westerberg@linux.intel.com>
References: <1393257611-18031-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393257611-18031-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alexandre Courbot <gnurou@gmail.com>, Lan Tianyu <tianyu.lan@intel.com>, Lv Zheng <lv.zheng@intel.com>, Alan Cox <alan.cox@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

In order to consolidate _Exx, _Lxx and _EVT to use the same structure we
make the structure name reflect that we are dealing with any event, not
just _EVT.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 56 ++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 5f5f107c2099..cb99dc2c552e 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -19,7 +19,7 @@
 
 #include "gpiolib.h"
 
-struct acpi_gpio_evt_pin {
+struct acpi_gpio_event {
 	struct list_head node;
 	acpi_handle *evt_handle;
 	unsigned int pin;
@@ -28,7 +28,7 @@ struct acpi_gpio_evt_pin {
 
 struct acpi_gpio_chip {
 	struct gpio_chip *chip;
-	struct list_head *evt_pins;
+	struct list_head *events;
 };
 
 static int acpi_gpiochip_find(struct gpio_chip *gc, void *data)
@@ -79,9 +79,9 @@ static irqreturn_t acpi_gpio_irq_handler(int irq, void *data)
 
 static irqreturn_t acpi_gpio_irq_handler_evt(int irq, void *data)
 {
-	struct acpi_gpio_evt_pin *evt_pin = data;
+	struct acpi_gpio_event *event = data;
 
-	acpi_execute_simple_method(evt_pin->evt_handle, NULL, evt_pin->pin);
+	acpi_execute_simple_method(event->evt_handle, NULL, event->pin);
 
 	return IRQ_HANDLED;
 }
@@ -107,7 +107,7 @@ static void acpi_gpiochip_request_interrupts(struct acpi_gpio_chip *achip)
 	struct gpio_chip *chip = achip->chip;
 	struct acpi_resource *res;
 	acpi_handle handle, evt_handle;
-	struct list_head *evt_pins = NULL;
+	struct list_head *events = NULL;
 	acpi_status status;
 	unsigned int pin;
 	int irq, ret;
@@ -126,10 +126,10 @@ static void acpi_gpiochip_request_interrupts(struct acpi_gpio_chip *achip)
 
 	status = acpi_get_handle(handle, "_EVT", &evt_handle);
 	if (ACPI_SUCCESS(status)) {
-		evt_pins = kzalloc(sizeof(*evt_pins), GFP_KERNEL);
-		if (evt_pins) {
-			INIT_LIST_HEAD(evt_pins);
-			achip->evt_pins = evt_pins;
+		events = kzalloc(sizeof(*events), GFP_KERNEL);
+		if (events) {
+			INIT_LIST_HEAD(events);
+			achip->events = events;
 		}
 	}
 
@@ -168,19 +168,19 @@ static void acpi_gpiochip_request_interrupts(struct acpi_gpio_chip *achip)
 				data = ev_handle;
 			}
 		}
-		if (!handler && evt_pins) {
-			struct acpi_gpio_evt_pin *evt_pin;
+		if (!handler && events) {
+			struct acpi_gpio_event *event;
 
-			evt_pin = kzalloc(sizeof(*evt_pin), GFP_KERNEL);
-			if (!evt_pin)
+			event = kzalloc(sizeof(*event), GFP_KERNEL);
+			if (!event)
 				continue;
 
-			list_add_tail(&evt_pin->node, evt_pins);
-			evt_pin->evt_handle = evt_handle;
-			evt_pin->pin = pin;
-			evt_pin->irq = irq;
+			list_add_tail(&event->node, events);
+			event->evt_handle = evt_handle;
+			event->pin = pin;
+			event->irq = irq;
 			handler = acpi_gpio_irq_handler_evt;
-			data = evt_pin;
+			data = event;
 		}
 		if (!handler)
 			continue;
@@ -207,23 +207,23 @@ static void acpi_gpiochip_request_interrupts(struct acpi_gpio_chip *achip)
  */
 static void acpi_gpiochip_free_interrupts(struct acpi_gpio_chip *achip)
 {
-	struct list_head *evt_pins;
-	struct acpi_gpio_evt_pin *evt_pin, *ep;
+	struct list_head *events;
+	struct acpi_gpio_event *event, *ep;
 	struct gpio_chip *chip = achip->chip;
 
-	if (!chip->dev || !chip->to_irq || !achip->evt_pins)
+	if (!chip->dev || !chip->to_irq || !achip->events)
 		return;
 
-	evt_pins = achip->evt_pins;
-	achip->evt_pins = NULL;
+	events = achip->events;
+	achip->events = NULL;
 
-	list_for_each_entry_safe_reverse(evt_pin, ep, evt_pins, node) {
-		devm_free_irq(chip->dev, evt_pin->irq, evt_pin);
-		list_del(&evt_pin->node);
-		kfree(evt_pin);
+	list_for_each_entry_safe_reverse(event, ep, events, node) {
+		devm_free_irq(chip->dev, event->irq, event);
+		list_del(&event->node);
+		kfree(event);
 	}
 
-	kfree(evt_pins);
+	kfree(events);
 }
 
 struct acpi_gpio_lookup {
-- 
1.9.0.rc3
