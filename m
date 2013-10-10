From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 5/5] gpiolib / ACPI: document the GPIO descriptor based interface
Date: Thu, 10 Oct 2013 11:01:11 +0300
Message-ID: <1381392071-21407-6-git-send-email-mika.westerberg@linux.intel.com>
References: <1381392071-21407-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381392071-21407-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Mathias Nyman <mathias.nyman@linux.intel.com>, Alexandre Courbot <acourbot@nvidia.com>, Rob Landley <rob@landley.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

In addition to the existing ACPI specific GPIO interface, document the new
descriptor based GPIO interface in Documentation/acpi/enumeration.txt, so
it is clear that this new interface is preferred over the ACPI specific
version.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
---
 Documentation/acpi/enumeration.txt | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/Documentation/acpi/enumeration.txt b/Documentation/acpi/enumeration.txt
index aca4e69..b994bcb 100644
--- a/Documentation/acpi/enumeration.txt
+++ b/Documentation/acpi/enumeration.txt
@@ -295,10 +295,6 @@ These GPIO numbers are controller relative and path "\\_SB.PCI0.GPI0"
 specifies the path to the controller. In order to use these GPIOs in Linux
 we need to translate them to the Linux GPIO numbers.
 
-The driver can do this by including <linux/acpi_gpio.h> and then calling
-acpi_get_gpio(path, gpio). This will return the Linux GPIO number or
-negative errno if there was no translation found.
-
 In a simple case of just getting the Linux GPIO number from device
 resources one can use acpi_get_gpio_by_index() helper function. It takes
 pointer to the device and index of the GpioIo/GpioInt descriptor in the
@@ -322,3 +318,25 @@ suitable to the gpiolib before passing them.
 
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
