From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 3/6] ACPI / glue: Add acpi_platform_notify() function
Date: Mon,  5 Nov 2018 17:59:25 +0300
Message-ID: <20181105145928.46819-4-heikki.krogerus@linux.intel.com>
References: <20181105145928.46819-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181105145928.46819-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Instead of relying on the "platform_notify" callback hook,
introducing separate notification function
acpi_platform_notify() and calling that directly from
drivers core when device entries are added and removed.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/bus.c      |  1 -
 drivers/acpi/glue.c     | 21 +++++++++++++--------
 drivers/acpi/internal.h |  1 -
 drivers/base/core.c     |  7 +++++++
 include/linux/acpi.h    | 10 ++++++++++
 5 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index bb3d96dea6db..99d820a693a8 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1237,7 +1237,6 @@ static int __init acpi_init(void)
 		acpi_kobj = NULL;
 	}
 
-	init_acpi_device_notify();
 	result = acpi_bus_init();
 	if (result) {
 		disable_acpi();
diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 12ba2bee8789..edd10b3c7ec8 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -296,7 +296,7 @@ int acpi_unbind_one(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(acpi_unbind_one);
 
-static int acpi_platform_notify(struct device *dev)
+static int acpi_device_notify(struct device *dev)
 {
 	struct acpi_bus_type *type = acpi_get_bus_type(dev);
 	struct acpi_device *adev;
@@ -343,7 +343,7 @@ static int acpi_platform_notify(struct device *dev)
 	return ret;
 }
 
-static int acpi_platform_notify_remove(struct device *dev)
+static int acpi_device_notify_remove(struct device *dev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct acpi_bus_type *type;
@@ -361,12 +361,17 @@ static int acpi_platform_notify_remove(struct device *dev)
 	return 0;
 }
 
-void __init init_acpi_device_notify(void)
+int acpi_platform_notify(struct device *dev, enum kobject_action action)
 {
-	if (platform_notify || platform_notify_remove) {
-		printk(KERN_ERR PREFIX "Can't use platform_notify\n");
-		return;
+	switch (action) {
+	case KOBJ_ADD:
+		acpi_device_notify(dev);
+		break;
+	case KOBJ_REMOVE:
+		acpi_device_notify_remove(dev);
+		break;
+	default:
+		break;
 	}
-	platform_notify = acpi_platform_notify;
-	platform_notify_remove = acpi_platform_notify_remove;
+	return 0;
 }
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 530a3f675490..83a7dfb7d1cf 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -23,7 +23,6 @@
 int early_acpi_osi_init(void);
 int acpi_osi_init(void);
 acpi_status acpi_os_initialize1(void);
-void init_acpi_device_notify(void);
 int acpi_scan_init(void);
 void acpi_pci_root_init(void);
 void acpi_pci_link_init(void);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3972ef3f080b..260cbdf44f1d 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -8,6 +8,7 @@
  * Copyright (c) 2006 Novell, Inc.
  */
 
+#include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/fwnode.h>
@@ -731,6 +732,12 @@ static inline int device_is_not_partition(struct device *dev)
 static int
 device_platform_notify(struct device *dev, enum kobject_action action)
 {
+	int ret;
+
+	ret = acpi_platform_notify(dev, action);
+	if (ret)
+		return ret;
+
 	if (platform_notify && action == KOBJ_ADD)
 		platform_notify(dev);
 	else if (platform_notify_remove && action == KOBJ_REMOVE)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ed80f147bd50..4ba2e2d24676 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1313,4 +1313,14 @@ static inline int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
 }
 #endif
 
+#ifdef CONFIG_ACPI
+extern int acpi_platform_notify(struct device *dev, enum kobject_action action);
+#else
+static inline int
+acpi_platform_notify(struct device *dev, enum kobject_action action)
+{
+	return 0;
+}
+#endif
+
 #endif	/*_LINUX_ACPI_H*/
-- 
2.19.1
