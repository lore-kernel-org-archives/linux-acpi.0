From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 06/12] gpio: acpi: Explain how to get GPIO descriptors in ACPI case
Date: Tue, 23 May 2017 20:03:21 +0300
Message-ID: <20170523170327.18055-7-andriy.shevchenko@linux.intel.com>
References: <20170523170327.18055-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:4948 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1764849AbdEWRED (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 May 2017 13:04:03 -0400
In-Reply-To: <20170523170327.18055-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jagadish Krishnamoorthy <jagadish.krishnamoorthy@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Documentation lacks of explanation how we actually use device properties
for GPIO resources.

Add a section to the documentation about that.

Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 Documentation/acpi/gpio-properties.txt | 65 ++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/Documentation/acpi/gpio-properties.txt b/Documentation/acpi/gpio-properties.txt
index 2aff0349facd..88c65cb5bf0a 100644
--- a/Documentation/acpi/gpio-properties.txt
+++ b/Documentation/acpi/gpio-properties.txt
@@ -156,3 +156,68 @@ pointed to by its first argument.  That should be done in the driver's .probe()
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
+The ACPI GPIO mapping tables should not contaminate drivers that are not
+knowing about which exact device they are servicing on. It implies that
+the ACPI GPIO mapping tables are hardly linked to ACPI ID and certain
+objects, as listed in the above chapter, of the device in question.
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

