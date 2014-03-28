From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: [PATCH 5/5] trace, AER: Move trace into unified interface
Date: Fri, 28 Mar 2014 01:53:01 -0400
Message-ID: <1395985981-20476-6-git-send-email-gong.chen@linux.intel.com>
References: <1395985981-20476-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:1675 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061AbaC1GRE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 28 Mar 2014 02:17:04 -0400
In-Reply-To: <1395985981-20476-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de, m.chehab@samsung.com
Cc: rostedt@goodmis.org, linux-acpi@vger.kernel.org, arozansk@redhat.com, "Chen, Gong" <gong.chen@linux.intel.com>

AER uses a separate trace interface by now. To make it
consistent, move it into unified RAS trace interface.

Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
---
 drivers/pci/pcie/aer/aerdrv_errprint.c |  4 +-
 drivers/ras/Kconfig                    |  2 +-
 include/ras/ras_event.h                | 64 ++++++++++++++++++++++++++++
 include/trace/events/ras.h             | 77 ----------------------------------
 4 files changed, 66 insertions(+), 81 deletions(-)
 delete mode 100644 include/trace/events/ras.h

diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
index 34ff702..73e73b7 100644
--- a/drivers/pci/pcie/aer/aerdrv_errprint.c
+++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
@@ -22,9 +22,7 @@
 #include <linux/cper.h>
 
 #include "aerdrv.h"
-
-#define CREATE_TRACE_POINTS
-#include <trace/events/ras.h>
+#include <ras/ras_event.h>
 
 #define AER_AGENT_RECEIVER		0
 #define AER_AGENT_REQUESTER		1
diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
index 64f09641..75845b9 100644
--- a/drivers/ras/Kconfig
+++ b/drivers/ras/Kconfig
@@ -1,4 +1,4 @@
 # RAS_TRACE always gets selected by whoever wants it.
 config RAS_TRACE
 	def_bool y
-	depends on EDAC_MM_EDAC || ACPI_EXTLOG
+	depends on EDAC_MM_EDAC || ACPI_EXTLOG || PCIEAER
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index dfda854..375d318 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -9,6 +9,7 @@
 #include <linux/edac.h>
 #include <linux/ktime.h>
 #include <linux/cper.h>
+#include <linux/aer.h>
 
 /*
  * MCE Extended Error Log trace event
@@ -154,6 +155,69 @@ TRACE_EVENT(mc_event,
 		  __get_str(driver_detail))
 );
 
+/*
+ * PCIe AER Trace event
+ *
+ * These events are generated when hardware detects a corrected or
+ * uncorrected event on a PCIe device. The event report has
+ * the following structure:
+ *
+ * char * dev_name -	The name of the slot where the device resides
+ *			([domain:]bus:device.function).
+ * u32 status -		Either the correctable or uncorrectable register
+ *			indicating what error or errors have been seen
+ * u8 severity -	error severity 0:NONFATAL 1:FATAL 2:CORRECTED
+ */
+
+#define aer_correctable_errors		\
+	{BIT(0),	"Receiver Error"},		\
+	{BIT(6),	"Bad TLP"},			\
+	{BIT(7),	"Bad DLLP"},			\
+	{BIT(8),	"RELAY_NUM Rollover"},		\
+	{BIT(12),	"Replay Timer Timeout"},	\
+	{BIT(13),	"Advisory Non-Fatal"}
+
+#define aer_uncorrectable_errors		\
+	{BIT(4),	"Data Link Protocol"},		\
+	{BIT(12),	"Poisoned TLP"},		\
+	{BIT(13),	"Flow Control Protocol"},	\
+	{BIT(14),	"Completion Timeout"},		\
+	{BIT(15),	"Completer Abort"},		\
+	{BIT(16),	"Unexpected Completion"},	\
+	{BIT(17),	"Receiver Overflow"},		\
+	{BIT(18),	"Malformed TLP"},		\
+	{BIT(19),	"ECRC"},			\
+	{BIT(20),	"Unsupported Request"}
+
+TRACE_EVENT(aer_event,
+	TP_PROTO(const char *dev_name,
+		 const u32 status,
+		 const u8 severity),
+
+	TP_ARGS(dev_name, status, severity),
+
+	TP_STRUCT__entry(
+		__string(	dev_name,	dev_name	)
+		__field(	u32,		status		)
+		__field(	u8,		severity	)
+	),
+
+	TP_fast_assign(
+		__assign_str(dev_name, dev_name);
+		__entry->status		= status;
+		__entry->severity	= severity;
+	),
+
+	TP_printk("%s PCIe Bus Error: severity=%s, %s\n",
+		__get_str(dev_name),
+		__entry->severity == AER_CORRECTABLE ? "Corrected" :
+			__entry->severity == AER_FATAL ?
+			"Fatal" : "Uncorrected, non-fatal",
+		__entry->severity == AER_CORRECTABLE ?
+		__print_flags(__entry->status, "|", aer_correctable_errors) :
+		__print_flags(__entry->status, "|", aer_uncorrectable_errors))
+);
+
 #endif /* _TRACE_HW_EVENT_MC_H */
 
 /* This part must be outside protection */
diff --git a/include/trace/events/ras.h b/include/trace/events/ras.h
deleted file mode 100644
index 1c875ad..0000000
--- a/include/trace/events/ras.h
+++ /dev/null
@@ -1,77 +0,0 @@
-#undef TRACE_SYSTEM
-#define TRACE_SYSTEM ras
-
-#if !defined(_TRACE_AER_H) || defined(TRACE_HEADER_MULTI_READ)
-#define _TRACE_AER_H
-
-#include <linux/tracepoint.h>
-#include <linux/aer.h>
-
-
-/*
- * PCIe AER Trace event
- *
- * These events are generated when hardware detects a corrected or
- * uncorrected event on a PCIe device. The event report has
- * the following structure:
- *
- * char * dev_name -	The name of the slot where the device resides
- *			([domain:]bus:device.function).
- * u32 status -		Either the correctable or uncorrectable register
- *			indicating what error or errors have been seen
- * u8 severity -	error severity 0:NONFATAL 1:FATAL 2:CORRECTED
- */
-
-#define aer_correctable_errors		\
-	{BIT(0),	"Receiver Error"},		\
-	{BIT(6),	"Bad TLP"},			\
-	{BIT(7),	"Bad DLLP"},			\
-	{BIT(8),	"RELAY_NUM Rollover"},		\
-	{BIT(12),	"Replay Timer Timeout"},	\
-	{BIT(13),	"Advisory Non-Fatal"}
-
-#define aer_uncorrectable_errors		\
-	{BIT(4),	"Data Link Protocol"},		\
-	{BIT(12),	"Poisoned TLP"},		\
-	{BIT(13),	"Flow Control Protocol"},	\
-	{BIT(14),	"Completion Timeout"},		\
-	{BIT(15),	"Completer Abort"},		\
-	{BIT(16),	"Unexpected Completion"},	\
-	{BIT(17),	"Receiver Overflow"},		\
-	{BIT(18),	"Malformed TLP"},		\
-	{BIT(19),	"ECRC"},			\
-	{BIT(20),	"Unsupported Request"}
-
-TRACE_EVENT(aer_event,
-	TP_PROTO(const char *dev_name,
-		 const u32 status,
-		 const u8 severity),
-
-	TP_ARGS(dev_name, status, severity),
-
-	TP_STRUCT__entry(
-		__string(	dev_name,	dev_name	)
-		__field(	u32,		status		)
-		__field(	u8,		severity	)
-	),
-
-	TP_fast_assign(
-		__assign_str(dev_name, dev_name);
-		__entry->status		= status;
-		__entry->severity	= severity;
-	),
-
-	TP_printk("%s PCIe Bus Error: severity=%s, %s\n",
-		__get_str(dev_name),
-		__entry->severity == AER_CORRECTABLE ? "Corrected" :
-			__entry->severity == AER_FATAL ?
-			"Fatal" : "Uncorrected, non-fatal",
-		__entry->severity == AER_CORRECTABLE ?
-		__print_flags(__entry->status, "|", aer_correctable_errors) :
-		__print_flags(__entry->status, "|", aer_uncorrectable_errors))
-);
-
-#endif /* _TRACE_AER_H */
-
-/* This part must be outside protection */
-#include <trace/define_trace.h>
-- 
1.9.0

