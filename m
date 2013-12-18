From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 13/15] ACPICA: Linux: Remove <asm/acpi.h> inclusion from ACPICA headers.
Date: Wed, 18 Dec 2013 17:07:08 +0800
Message-ID: <f001ffc5442bf3f49291e91a294210d2678ea8f4.1387336613.git.lv.zheng@intel.com>
References: <cover.1387336613.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1387336613.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch removes <asm/acpi.h> inclusion from <acpi/platform/aclinux.h> as
it no longer contains useful prototypes for ACPICA.
This patch also introduces a top level header <linux/acpica.h> to be
included by other kernel source code.
Note that this patch changes the logic so that ACPICA header files
inclusions are no longer dependent on CONFIG_ACPI=y environment.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/platform/aclinux.h |    1 -
 include/linux/acpi.h            |   13 ++++---------
 include/linux/acpica.h          |   22 ++++++++++++++++++++++
 3 files changed, 26 insertions(+), 10 deletions(-)
 create mode 100644 include/linux/acpica.h

diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index b754bfa..8bdb773 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -83,7 +83,6 @@
 #ifdef CONFIG_ARCH_SUPPORTS_ACPICA
 #include <asm/acenv.h>
 #endif
-#include <asm/acpi.h>
 
 #ifdef CONFIG_ACPI
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 72c88f4..a197f64 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -28,22 +28,17 @@
 #include <linux/errno.h>
 #include <linux/ioport.h>	/* for struct resource */
 #include <linux/device.h>
-
-#ifdef	CONFIG_ACPI
-
-#ifndef _LINUX
-#define _LINUX
-#endif
-
 #include <linux/list.h>
 #include <linux/mod_devicetable.h>
+#include <linux/acpica.h>
+
+#ifdef	CONFIG_ACPI
 
-#include <acpi/acpi.h>
+#include <asm/acpi.h>	/* Definitions in it can be used by <acpi/x.h> headers */
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_numa.h>
 #include <acpi/acpi_io.h>
-#include <asm/acpi.h>
 
 static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
 {
diff --git a/include/linux/acpica.h b/include/linux/acpica.h
new file mode 100644
index 0000000..a67d3cf
--- /dev/null
+++ b/include/linux/acpica.h
@@ -0,0 +1,22 @@
+#ifndef _LINUX_ACPICA_H
+#define _LINUX_ACPICA_H
+
+/*
+ * Top level ACPICA header for Linux kernel
+ *
+ * Copyright (C) 2013, Intel Corporation
+ *   Author: Lv Zheng <lv.zheng@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/* Support <acpi/platform/aclinux.h> inclusions for broken compilers */
+#ifndef _LINUX
+#define _LINUX
+#endif
+
+#include <acpi/acpi.h>
+
+#endif /* _LINUX_ACPICA_H */
-- 
1.7.10.4
