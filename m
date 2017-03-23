From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 6/8] gpio: acpi: Explain how to get GPIO descriptors in ACPI case
Date: Thu, 23 Mar 2017 21:46:16 +0200
Message-ID: <20170323194618.26548-7-andriy.shevchenko@linux.intel.com>
References: <20170323194618.26548-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170323194618.26548-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Documentation lacks of explanation how we actually use device properties
for GPIO resources.

Add a section to the documentation about that.

Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/acpi/gpio-properties.txt | 60 ++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/Documentation/acpi/gpio-properties.txt b/Documentation/acpi/gpio-properties.txt
index 2aff0349facd..07954b7c3a12 100644
--- a/Documentation/acpi/gpio-properties.txt
+++ b/Documentation/acpi/gpio-properties.txt
@@ -156,3 +156,63 @@ pointed to by its first argument.  That should be done in the driver's .probe()
 routine.  On removal, the driver should unregister its GPIO mapping table by
 calling acpi_dev_remove_driver_gpios() on the ACPI device object where that
 table was previously registered.
+
+Using the _CRS fallback
+-----------------------
+
+If a device does not have _DSD or the driver does not create ACPI GPIO
+mapping, the Linux GPIO framework refuses to return any GPIOs. This is
+because the driver does not know what it actually gets. For example if we
+have a device like below:
+
+  Device (BTH)
+  {
+      Name (_HID, ...)
+
+      Name (_CRS, ResourceTemplate () {
+          GpioIo (Exclusive, PullNone, 0, 0, IoRestrictionNone,
+                  "\\_SB.GPO0", 0, ResourceConsumer) {15}
+          GpioIo (Exclusive, PullNone, 0, 0, IoRestrictionNone,
+                  "\\_SB.GPO0", 0, ResourceConsumer) {27}
+      })
+  }
+
+The driver might expect to get the right GPIO when it does:
+
+  desc = gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+
+but since there is no way to know the mapping between "reset" and
+the GpioIo() in _CRS desc will hold ERR_PTR(-ENOENT).
+
+The driver author can solve this by passing the mapping explictly
+(the recommended way and documented in the above chapter).
+
+Getting GPIO descriptor
+-----------------------
+
+There are two main approaches to get GPIO resource from ACPI:
+	desc = gpiod_get(dev, connection_id, flags);
+	desc = gpiod_get_index(dev, connection_id, index, flags);
+
+We may consider two different cases here, i.e. when connection ID is
+provided and otherwise.
+
+Case 1:
+	desc = gpiod_get(dev, "non-null-connection-id", flags);
+	desc = gpiod_get_index(dev, "non-null-connection-id", index, flags);
+
+Case 2:
+	desc = gpiod_get(dev, NULL, flags);
+	desc = gpiod_get_index(dev, NULL, index, flags);
+
+Case 1 assumes that corresponding ACPI device description must have
+defined device properties and will prevent to getting any GPIO resources
+otherwise.
+
+Case 2 explicitly tells GPIO core to look for resources in _CRS.
+
+Be aware that gpiod_get_index() in cases 1 and 2, assuming that there
+are two versions of ACPI device description provided and no mapping is
+present in the driver, will return different resources. That's why a
+certain driver has to handle them carefully as explained in previous
+chapter.
-- 
2.11.0
