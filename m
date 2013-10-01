From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 5/5] gpiolib / ACPI: document the GPIO descriptor based interface
Date: Tue,  1 Oct 2013 17:58:57 +0300
Message-ID: <1380639537-23406-6-git-send-email-mika.westerberg@linux.intel.com>
References: <1380639537-23406-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1380639537-23406-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org
Cc: rjw@rjwysocki.net, Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Mathias Nyman <mathias.nyman@linux.intel.com>, Alexandre Courbot <acourbot@nvidia.com>, Rob Landley <rob@landley.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

In addition to the existing ACPI specific GPIO interface, document the new
descriptor based GPIO interface in Documentation/acpi/enumeration.txt, so
it is clear that this new interface is preferred over the ACPI specific
version.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 Documentation/acpi/enumeration.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/acpi/enumeration.txt b/Documentation/acpi/enumeration.txt
index aca4e69..48bb9ab 100644
--- a/Documentation/acpi/enumeration.txt
+++ b/Documentation/acpi/enumeration.txt
@@ -322,3 +322,25 @@ suitable to the gpiolib before passing them.
 
 In case of GpioInt resource an additional call to gpio_to_irq() must be
 done before calling request_irq().
+
+Note that the above API is ACPI specific and not recommended for drivers
+that need to support non-ACPI systems. The recommended way is to use
+the descriptor based GPIO interfaces. The above example looks like this
+when converted to the GPIO desc:
+
+	#include <linux/gpio/consumer.h>
+	...
+
+	struct gpio_desc *irq_desc, *power_desc;
+
+	irq_desc = gpiod_get_index(dev, NULL, 1);
+	if (IS_ERR(irq_desc))
+		/* handle error */
+
+	power_desc = gpiod_get_index(dev, NULL, 0);
+	if (IS_ERR(power_desc))
+		/* handle error */
+
+	/* Now we can use the GPIO descriptors */
+
+See also Documentation/gpio.txt.
-- 
1.8.4.rc3

