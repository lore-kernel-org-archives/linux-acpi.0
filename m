From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: [PATCH 1/7 v5] trace, RAS: Add basic RAS trace event
Date: Thu, 15 May 2014 04:30:40 -0400
Message-ID: <1400142646-10127-2-git-send-email-gong.chen@linux.intel.com>
References: <1400142646-10127-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47149 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751052AbaEOI7v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 May 2014 04:59:51 -0400
In-Reply-To: <1400142646-10127-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de, m.chehab@samsung.com
Cc: linux-acpi@vger.kernel.org, "Chen, Gong" <gong.chen@linux.intel.com>

To avoid confuision and conflict of usage for RAS related trace event,
add an unified RAS trace event stub.

v5 -> v4: remove explicit RAS menuconfig.
v4 -> v3: change dependency rule of RAS_TRACE.
v3 -> v2: fix dependency in Kconfig.
v2 -> v1: adjust Kconfig to take RAS as a separate subsystem.

Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
---
 drivers/Kconfig        |  2 ++
 drivers/Makefile       |  1 +
 drivers/edac/Kconfig   |  1 +
 drivers/edac/edac_mc.c |  3 ---
 drivers/ras/Kconfig    |  6 ++++++
 drivers/ras/Makefile   |  1 +
 drivers/ras/ras.c      | 12 ++++++++++++
 7 files changed, 23 insertions(+), 3 deletions(-)
 create mode 100644 drivers/ras/Kconfig
 create mode 100644 drivers/ras/Makefile
 create mode 100644 drivers/ras/ras.c

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 0a0a90f..547e73a 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -174,4 +174,6 @@ source "drivers/powercap/Kconfig"
 
 source "drivers/mcb/Kconfig"
 
+source "drivers/ras/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index d05d81b..71a4985 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -157,3 +157,4 @@ obj-$(CONFIG_NTB)		+= ntb/
 obj-$(CONFIG_FMC)		+= fmc/
 obj-$(CONFIG_POWERCAP)		+= powercap/
 obj-$(CONFIG_MCB)		+= mcb/
+obj-$(CONFIG_RAS)		+= ras/
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 878f090..1589a86 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -72,6 +72,7 @@ config EDAC_MCE_INJ
 
 config EDAC_MM_EDAC
 	tristate "Main Memory EDAC (Error Detection And Correction) reporting"
+	select RAS_TRACE
 	help
 	  Some systems are able to detect and correct errors in main
 	  memory.  EDAC can report statistics on memory error
diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 33edd67..28c1695 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -33,9 +33,6 @@
 #include <asm/edac.h>
 #include "edac_core.h"
 #include "edac_module.h"
-
-#define CREATE_TRACE_POINTS
-#define TRACE_INCLUDE_PATH ../../include/ras
 #include <ras/ras_event.h>
 
 /* lock to memory controller's control array */
diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
new file mode 100644
index 0000000..85febfd
--- /dev/null
+++ b/drivers/ras/Kconfig
@@ -0,0 +1,6 @@
+config RAS_TRACE
+	def_bool n
+	select RAS
+
+config RAS
+	bool
diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile
new file mode 100644
index 0000000..223e806
--- /dev/null
+++ b/drivers/ras/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_RAS) += ras.o
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
new file mode 100644
index 0000000..b0c6ed1
--- /dev/null
+++ b/drivers/ras/ras.c
@@ -0,0 +1,12 @@
+/*
+ * Copyright (C) 2014 Intel Corporation
+ *
+ * Authors:
+ *	Chen, Gong <gong.chen@linux.intel.com>
+ */
+
+#define CREATE_TRACE_POINTS
+#define TRACE_INCLUDE_PATH ../../include/ras
+#include <ras/ras_event.h>
+
+EXPORT_TRACEPOINT_SYMBOL_GPL(mc_event);
-- 
2.0.0.rc0

