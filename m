From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] gpiolib: Forbid irqchip default trigger for ACPI enumerated devices
Date: Mon, 12 Sep 2016 14:29:51 +0300
Message-ID: <20160912112951.76598-1-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:27850 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753421AbcILL3z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Sep 2016 07:29:55 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org

Follow DT and forbid default trigger if the GPIO irqchip device is
enumerated from ACPI. Triggering for these devices will be configured
automatically from ACPI interrupt resources provided by the BIOS.

Suggested-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
This is on top of Marc's patch here:

  https://lkml.org/lkml/2016/9/7/121

 drivers/gpio/gpiolib.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 5707b5d12b28..0efb67f387ea 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1618,13 +1618,18 @@ int _gpiochip_irqchip_add(struct gpio_chip *gpiochip,
 		of_node = gpiochip->of_node;
 #endif
 	/*
-	 * Specifying a default trigger is a terrible idea if DT is
+	 * Specifying a default trigger is a terrible idea if DT or ACPI is
 	 * used to configure the interrupts, as you may end-up with
 	 * conflicting triggers. Tell the user, and reset to NONE.
 	 */
 	if (WARN(of_node && type != IRQ_TYPE_NONE,
 		 "%s: Ignoring %d default trigger\n", of_node->full_name, type))
 		type = IRQ_TYPE_NONE;
+	if (has_acpi_companion(gpiochip->parent) && type != IRQ_TYPE_NONE) {
+		acpi_handle_warn(ACPI_HANDLE(gpiochip->parent),
+				 "Ignoring %d default trigger\n", type);
+		type = IRQ_TYPE_NONE;
+	}
 
 	gpiochip->irqchip = irqchip;
 	gpiochip->irq_handler = handler;
-- 
2.9.3

