From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [RFC 10/15] of: No need to include property.h, fwnode.h is sufficient
Date: Wed,  5 Oct 2016 01:45:43 +0300
Message-ID: <1475621148-21427-11-git-send-email-sakari.ailus@linux.intel.com>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:22043 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753334AbcJDWr3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 4 Oct 2016 18:47:29 -0400
In-Reply-To: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: mika.westerberg@linux.intel.com, rafael@kernel.org

of.h requires a definition of struct fwnode_handle, and for that it
includes linux/property.h. struct fwnode_handle, however, is defined in
linux/fwnode.h. Include linux/fwnode.h directly.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/base/core.c                    | 1 +
 drivers/input/touchscreen/ad7879.c     | 1 +
 drivers/input/touchscreen/edt-ft5x06.c | 1 +
 drivers/phy/phy-tusb1210.c             | 1 +
 drivers/usb/common/common.c            | 1 +
 drivers/usb/dwc3/host.c                | 1 +
 include/linux/of.h                     | 2 +-
 sound/soc/codecs/ts3a227e.c            | 1 +
 8 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 93c1d3f..353d78a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -24,6 +24,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/sysfs.h>
diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index e16a446..38ad365 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -34,6 +34,7 @@
 #include <linux/input/touchscreen.h>
 #include <linux/platform_data/ad7879.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include "ad7879.h"
 
 #define AD7879_REG_ZEROS		0
diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 703e295..81d114d 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -39,6 +39,7 @@
 #include <linux/input/mt.h>
 #include <linux/input/touchscreen.h>
 #include <linux/of_device.h>
+#include <linux/property.h>
 
 #define WORK_REGISTER_THRESHOLD		0x00
 #define WORK_REGISTER_REPORT_RATE	0x08
diff --git a/drivers/phy/phy-tusb1210.c b/drivers/phy/phy-tusb1210.c
index 4f6d5e7..f7dd21aa 100644
--- a/drivers/phy/phy-tusb1210.c
+++ b/drivers/phy/phy-tusb1210.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/ulpi/driver.h>
 #include <linux/gpio/consumer.h>
+#include <linux/property.h>
 
 #include "ulpi_phy.h"
 
diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
index 5ef8da6..534a498 100644
--- a/drivers/usb/common/common.c
+++ b/drivers/usb/common/common.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/property.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/of.h>
 #include <linux/usb/otg.h>
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index f6533c6..4cf6546 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/platform_device.h>
+#include <linux/property.h>
 
 #include "core.h"
 
diff --git a/include/linux/of.h b/include/linux/of.h
index c9a7962..91b2308 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -23,7 +23,7 @@
 #include <linux/spinlock.h>
 #include <linux/topology.h>
 #include <linux/notifier.h>
-#include <linux/property.h>
+#include <linux/fwnode.h>
 #include <linux/list.h>
 
 #include <asm/byteorder.h>
diff --git a/sound/soc/codecs/ts3a227e.c b/sound/soc/codecs/ts3a227e.c
index 4356843..e80b28b 100644
--- a/sound/soc/codecs/ts3a227e.c
+++ b/sound/soc/codecs/ts3a227e.c
@@ -14,6 +14,7 @@
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/of_gpio.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 
 #include <sound/core.h>
-- 
2.7.4

