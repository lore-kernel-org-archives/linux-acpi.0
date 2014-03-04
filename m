From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: [PATCH 1/2] trace, RAS: Add basic RAS trace event
Date: Tue,  4 Mar 2014 04:23:16 -0500
Message-ID: <1393924997-8992-2-git-send-email-gong.chen@linux.intel.com>
References: <1393924997-8992-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:34685 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756462AbaCDJpu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 4 Mar 2014 04:45:50 -0500
In-Reply-To: <1393924997-8992-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de, m.chehab@samsung.com
Cc: arozansk@redhat.com, linux-acpi@vger.kernel.org, "Chen, Gong" <gong.chen@linux.intel.com>

To avoid the confuision of usage for RAS related trace event, add
an unified RAS trace event stub.

Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
---
 drivers/edac/edac_mc.c    |  3 ---
 kernel/trace/Makefile     |  1 +
 kernel/trace/ras-traces.c | 12 ++++++++++++
 3 files changed, 13 insertions(+), 3 deletions(-)
 create mode 100644 kernel/trace/ras-traces.c

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
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 1378e84..167193a 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -52,6 +52,7 @@ endif
 obj-$(CONFIG_EVENT_TRACING) += trace_events_filter.o
 obj-$(CONFIG_EVENT_TRACING) += trace_events_trigger.o
 obj-$(CONFIG_KPROBE_EVENT) += trace_kprobe.o
+obj-$(CONFIG_TRACEPOINTS) += ras-traces.o
 obj-$(CONFIG_TRACEPOINTS) += power-traces.o
 ifeq ($(CONFIG_PM_RUNTIME),y)
 obj-$(CONFIG_TRACEPOINTS) += rpm-traces.o
diff --git a/kernel/trace/ras-traces.c b/kernel/trace/ras-traces.c
new file mode 100644
index 0000000..b0c6ed1
--- /dev/null
+++ b/kernel/trace/ras-traces.c
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
1.8.4.3

