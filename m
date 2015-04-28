From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 2/2] i2c / ACPI: Assign IRQ for devices that have GpioInt automatically
Date: Tue, 28 Apr 2015 18:05:07 +0300
Message-ID: <1430233507-29389-3-git-send-email-mika.westerberg@linux.intel.com>
References: <1430233507-29389-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:53359 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965938AbbD1PFp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Apr 2015 11:05:45 -0400
In-Reply-To: <1430233507-29389-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Octavian Purdila <octavian.purdila@intel.com>, Robert Dolca <robert.dolca@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Following what DT already does. If the device does not have ACPI Interrupt
resource but instead it has one or more GpioInt resources listed below it,
we take the first GpioInt resource, convert it to suitable Linux IRQ number
and pass it to the driver instead.

This makes drivers simpler because the don't need to care about GPIOs at
all if only thing they need is interrupt.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/i2c/i2c-core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 987c124432c5..01ef731281e2 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -632,8 +632,13 @@ static int i2c_device_probe(struct device *dev)
 	if (!client)
 		return 0;
 
-	if (!client->irq && dev->of_node) {
-		int irq = of_irq_get(dev->of_node, 0);
+	if (client->irq <= 0) {
+		int irq = -ENOENT;
+
+		if (dev->of_node)
+			irq = of_irq_get(dev->of_node, 0);
+		else if (ACPI_COMPANION(dev))
+			irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(dev), 0);
 
 		if (irq == -EPROBE_DEFER)
 			return irq;
-- 
2.1.4

