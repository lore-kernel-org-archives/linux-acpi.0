From: Len Brown <lenb@kernel.org>
Subject: [PATCH 099/122] ACPICA: Remove obsolete debug levels (WARN and ERROR)
Date: Thu, 23 Oct 2008 02:39:13 -0400
Message-ID: <23d3e055beb12db2a3b91dfeee474c4d5ecc13b9.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms172071pub.verizon.net ([206.46.172.71]:62933 "EHLO
	vms172071pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755435AbYJWGk1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:27 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms172071.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9600GUMIJ5G112@vms172071.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:18 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Removed ACPI_DB_WARN and ACPI_DB_ERROR. These debug levels were
made obsolete by the ACPI_WARNING and ACPI_ERROR/ACPI_EXCEPTION
interfaces.  Also added ACPI_DB_EVENTS to correspond with the
existing ACPI_LV_EVENTS.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/debug.c              |    2 --
 drivers/acpi/executer/exstore.c   |    2 +-
 drivers/acpi/namespace/nssearch.c |    2 +-
 include/acpi/acoutput.h           |   32 +++++++++++++-------------------
 4 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/debug.c b/drivers/acpi/debug.c
index 6df564f..abf36b4 100644
--- a/drivers/acpi/debug.c
+++ b/drivers/acpi/debug.c
@@ -47,8 +47,6 @@ static const struct acpi_dlayer acpi_debug_layers[] = {
 };
 
 static const struct acpi_dlevel acpi_debug_levels[] = {
-	ACPI_DEBUG_INIT(ACPI_LV_ERROR),
-	ACPI_DEBUG_INIT(ACPI_LV_WARN),
 	ACPI_DEBUG_INIT(ACPI_LV_INIT),
 	ACPI_DEBUG_INIT(ACPI_LV_DEBUG_OBJECT),
 	ACPI_DEBUG_INIT(ACPI_LV_INFO),
diff --git a/drivers/acpi/executer/exstore.c b/drivers/acpi/executer/exstore.c
index 38b55e3..09e9684 100644
--- a/drivers/acpi/executer/exstore.c
+++ b/drivers/acpi/executer/exstore.c
@@ -403,7 +403,7 @@ acpi_ex_store(union acpi_operand_object *source_desc,
 
 		ACPI_ERROR((AE_INFO, "Unknown Reference opcode %X",
 			    ref_desc->reference.opcode));
-		ACPI_DUMP_ENTRY(ref_desc, ACPI_LV_ERROR);
+		ACPI_DUMP_ENTRY(ref_desc, ACPI_LV_INFO);
 
 		status = AE_AML_INTERNAL;
 		break;
diff --git a/drivers/acpi/namespace/nssearch.c b/drivers/acpi/namespace/nssearch.c
index 8399276..a9a80bf 100644
--- a/drivers/acpi/namespace/nssearch.c
+++ b/drivers/acpi/namespace/nssearch.c
@@ -331,7 +331,7 @@ acpi_ns_search_and_enter(u32 target_name,
 				      "Found bad character(s) in name, repaired: [%4.4s]\n",
 				      ACPI_CAST_PTR(char, &target_name)));
 		} else {
-			ACPI_DEBUG_PRINT((ACPI_DB_WARN,
+			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 					  "Found bad character(s) in name, repaired: [%4.4s]\n",
 					  ACPI_CAST_PTR(char, &target_name)));
 		}
diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index e17873d..09d33c7 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -80,12 +80,10 @@
 /*
  * Raw debug output levels, do not use these in the DEBUG_PRINT macros
  */
-#define ACPI_LV_ERROR               0x00000001
-#define ACPI_LV_WARN                0x00000002
-#define ACPI_LV_INIT                0x00000004
-#define ACPI_LV_DEBUG_OBJECT        0x00000008
-#define ACPI_LV_INFO                0x00000010
-#define ACPI_LV_ALL_EXCEPTIONS      0x0000001F
+#define ACPI_LV_INIT                0x00000001
+#define ACPI_LV_DEBUG_OBJECT        0x00000002
+#define ACPI_LV_INFO                0x00000004
+#define ACPI_LV_ALL_EXCEPTIONS      0x00000007
 
 /* Trace verbosity level 1 [Standard Trace Level] */
 
@@ -127,7 +125,6 @@
 #define ACPI_LV_VERBOSE_INFO        0x20000000
 #define ACPI_LV_FULL_TABLES         0x40000000
 #define ACPI_LV_EVENTS              0x80000000
-
 #define ACPI_LV_VERBOSE             0xF0000000
 
 /*
@@ -135,21 +132,17 @@
  */
 #define ACPI_DEBUG_LEVEL(dl)        (u32) dl,ACPI_DEBUG_PARAMETERS
 
-/* Exception level -- used in the global "DebugLevel" */
-
+/*
+ * Exception level -- used in the global "DebugLevel"
+ *
+ * Note: For errors, use the ACPI_ERROR or ACPI_EXCEPTION interfaces.
+ * For warnings, use ACPI_WARNING.
+ */
 #define ACPI_DB_INIT                ACPI_DEBUG_LEVEL (ACPI_LV_INIT)
 #define ACPI_DB_DEBUG_OBJECT        ACPI_DEBUG_LEVEL (ACPI_LV_DEBUG_OBJECT)
 #define ACPI_DB_INFO                ACPI_DEBUG_LEVEL (ACPI_LV_INFO)
 #define ACPI_DB_ALL_EXCEPTIONS      ACPI_DEBUG_LEVEL (ACPI_LV_ALL_EXCEPTIONS)
 
-/*
- * These two levels are essentially obsolete, all instances in the
- * ACPICA core code have been replaced by ACPI_ERROR and ACPI_WARNING
- * (Kept here because some drivers may still use them)
- */
-#define ACPI_DB_ERROR               ACPI_DEBUG_LEVEL (ACPI_LV_ERROR)
-#define ACPI_DB_WARN                ACPI_DEBUG_LEVEL (ACPI_LV_WARN)
-
 /* Trace level -- also used in the global "DebugLevel" */
 
 #define ACPI_DB_INIT_NAMES          ACPI_DEBUG_LEVEL (ACPI_LV_INIT_NAMES)
@@ -173,13 +166,14 @@
 #define ACPI_DB_USER_REQUESTS       ACPI_DEBUG_LEVEL (ACPI_LV_USER_REQUESTS)
 #define ACPI_DB_PACKAGE             ACPI_DEBUG_LEVEL (ACPI_LV_PACKAGE)
 #define ACPI_DB_MUTEX               ACPI_DEBUG_LEVEL (ACPI_LV_MUTEX)
+#define ACPI_DB_EVENTS              ACPI_DEBUG_LEVEL (ACPI_LV_EVENTS)
 
 #define ACPI_DB_ALL                 ACPI_DEBUG_LEVEL (ACPI_LV_ALL)
 
 /* Defaults for debug_level, debug and normal */
 
-#define ACPI_DEBUG_DEFAULT          (ACPI_LV_INIT | ACPI_LV_WARN | ACPI_LV_ERROR)
-#define ACPI_NORMAL_DEFAULT         (ACPI_LV_INIT | ACPI_LV_WARN | ACPI_LV_ERROR)
+#define ACPI_DEBUG_DEFAULT          (ACPI_LV_INIT | ACPI_LV_DEBUG_OBJECT)
+#define ACPI_NORMAL_DEFAULT         (ACPI_LV_INIT | ACPI_LV_DEBUG_OBJECT)
 #define ACPI_DEBUG_ALL              (ACPI_LV_AML_DISASSEMBLE | ACPI_LV_ALL_EXCEPTIONS | ACPI_LV_ALL)
 
 #endif				/* __ACOUTPUT_H__ */
-- 
1.5.5.1

