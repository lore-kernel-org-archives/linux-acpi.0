From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: [PATCH 1/5] trace, RAS: Add basic RAS trace event
Date: Fri, 28 Mar 2014 01:52:57 -0400
Message-ID: <1395985981-20476-2-git-send-email-gong.chen@linux.intel.com>
References: <1395985981-20476-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7961 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751006AbaC1GQv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Mar 2014 02:16:51 -0400
In-Reply-To: <1395985981-20476-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de, m.chehab@samsung.com
Cc: rostedt@goodmis.org, linux-acpi@vger.kernel.org, arozansk@redhat.com, "Chen, Gong" <gong.chen@linux.intel.com>

To avoid the confuision of usage for RAS related trace event, add
an unified RAS trace event stub.

Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
---
 drivers/Kconfig          |  2 ++
 drivers/Makefile         |  1 +
 drivers/edac/edac_mc.c   |  3 ---
 drivers/ras/Kconfig      |  4 ++++
 drivers/ras/Makefile     |  1 +
 drivers/ras/ras-traces.c | 12 ++++++++++++
 6 files changed, 20 insertions(+), 3 deletions(-)
 create mode 100644 drivers/ras/Kconfig
 create mode 100644 drivers/ras/Makefile
 create mode 100644 drivers/ras/ras-traces.c

diff --git a/drivers/Kconfig b/drivers/Kconfig
index b3138fb..d70f7ba 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -170,4 +170,6 @@ source "drivers/phy/Kconfig"
 
 source "drivers/powercap/Kconfig"
 
+source "drivers/ras/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index 8e3b8b0..10aaab0 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -155,3 +155,4 @@ obj-$(CONFIG_IPACK_BUS)		+= ipack/
 obj-$(CONFIG_NTB)		+= ntb/
 obj-$(CONFIG_FMC)		+= fmc/
 obj-$(CONFIG_POWERCAP)		+= powercap/
+obj-$(CONFIG_RAS_TRACE)		+= ras/
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
index 0000000..6e4aec5
--- /dev/null
+++ b/drivers/ras/Kconfig
@@ -0,0 +1,4 @@
+# RAS_TRACE always gets selected by whoever wants it.
+config RAS_TRACE
+	def_bool y
+	depends on EDAC_MM_EDAC
diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile
new file mode 100644
index 0000000..826afc6
--- /dev/null
+++ b/drivers/ras/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_RAS_TRACE) += ras-traces.o
diff --git a/drivers/ras/ras-traces.c b/drivers/ras/ras-traces.c
new file mode 100644
index 0000000..b0c6ed1
--- /dev/null
+++ b/drivers/ras/ras-traces.c
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
1.9.0

