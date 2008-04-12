From: Len Brown <lenb@kernel.org>
Subject: [PATCH 71/73] ACPICA: Update for new Notify values
Date: Sat, 12 Apr 2008 00:25:54 -0400
Message-ID: <ea1286bbb8065f51640cdf882fe6986f1c53dfb2.1207973801.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:60403 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757806AbYDLE2R (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:17 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Implemented several changes for Notify handling: Added support
for new Notify values (ACPI 2.0+) and improved the Notify debug
output. Notify on PowerResource objects is no longer allowed,
as per the ACPI specification. (Bob Moore, Zhang Rui)

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evmisc.c      |   59 ++++++++++++++----------------------
 drivers/acpi/utilities/utglobal.c |   42 ++++++++++++++++++++++++++
 include/acpi/actypes.h            |   24 +++++++++-----
 include/acpi/acutils.h            |    2 +
 4 files changed, 82 insertions(+), 45 deletions(-)

diff --git a/drivers/acpi/events/evmisc.c b/drivers/acpi/events/evmisc.c
index 4e7a13a..16cf270 100644
--- a/drivers/acpi/events/evmisc.c
+++ b/drivers/acpi/events/evmisc.c
@@ -49,22 +49,7 @@
 #define _COMPONENT          ACPI_EVENTS
 ACPI_MODULE_NAME("evmisc")
 
-/* Names for Notify() values, used for debug output */
-#ifdef ACPI_DEBUG_OUTPUT
-static const char *acpi_notify_value_names[] = {
-	"Bus Check",
-	"Device Check",
-	"Device Wake",
-	"Eject Request",
-	"Device Check Light",
-	"Frequency Mismatch",
-	"Bus Mode Mismatch",
-	"Power Fault"
-};
-#endif
-
 /* Pointer to FACS needed for the Global Lock */
-
 static struct acpi_table_facs *facs = NULL;
 
 /* Local prototypes */
@@ -94,7 +79,6 @@ u8 acpi_ev_is_notify_object(struct acpi_namespace_node *node)
 	switch (node->type) {
 	case ACPI_TYPE_DEVICE:
 	case ACPI_TYPE_PROCESSOR:
-	case ACPI_TYPE_POWER:
 	case ACPI_TYPE_THERMAL:
 		/*
 		 * These are the ONLY objects that can receive ACPI notifications
@@ -139,17 +123,9 @@ acpi_ev_queue_notify_request(struct acpi_namespace_node * node,
 	 *   initiate soft-off or sleep operation?
 	 */
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Dispatching Notify(%X) on node %p\n", notify_value,
-			  node));
-
-	if (notify_value <= 7) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Notify value: %s\n",
-				  acpi_notify_value_names[notify_value]));
-	} else {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Notify value: 0x%2.2X **Device Specific**\n",
-				  notify_value));
-	}
+			  "Dispatching Notify on [%4.4s] Node %p Value 0x%2.2X (%s)\n",
+			  acpi_ut_get_node_name(node), node, notify_value,
+			  acpi_ut_get_notify_name(notify_value)));
 
 	/* Get the notify object attached to the NS Node */
 
@@ -159,10 +135,12 @@ acpi_ev_queue_notify_request(struct acpi_namespace_node * node,
 		/* We have the notify object, Get the right handler */
 
 		switch (node->type) {
+
+			/* Notify allowed only on these types */
+
 		case ACPI_TYPE_DEVICE:
 		case ACPI_TYPE_THERMAL:
 		case ACPI_TYPE_PROCESSOR:
-		case ACPI_TYPE_POWER:
 
 			if (notify_value <= ACPI_MAX_SYS_NOTIFY) {
 				handler_obj =
@@ -179,8 +157,13 @@ acpi_ev_queue_notify_request(struct acpi_namespace_node * node,
 		}
 	}
 
-	/* If there is any handler to run, schedule the dispatcher */
-
+	/*
+	 * If there is any handler to run, schedule the dispatcher.
+	 * Check for:
+	 * 1) Global system notify handler
+	 * 2) Global device notify handler
+	 * 3) Per-device notify handler
+	 */
 	if ((acpi_gbl_system_notify.handler
 	     && (notify_value <= ACPI_MAX_SYS_NOTIFY))
 	    || (acpi_gbl_device_notify.handler
@@ -190,6 +173,13 @@ acpi_ev_queue_notify_request(struct acpi_namespace_node * node,
 			return (AE_NO_MEMORY);
 		}
 
+		if (!handler_obj) {
+			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+					  "Executing system notify handler for Notify (%4.4s, %X) node %p\n",
+					  acpi_ut_get_node_name(node),
+					  notify_value, node));
+		}
+
 		notify_info->common.descriptor_type =
 		    ACPI_DESC_TYPE_STATE_NOTIFY;
 		notify_info->notify.node = node;
@@ -202,15 +192,12 @@ acpi_ev_queue_notify_request(struct acpi_namespace_node * node,
 		if (ACPI_FAILURE(status)) {
 			acpi_ut_delete_generic_state(notify_info);
 		}
-	}
-
-	if (!handler_obj) {
+	} else {
 		/*
-		 * There is no per-device notify handler for this device.
-		 * This may or may not be a problem.
+		 * There is no notify handler (per-device or system) for this device.
 		 */
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "No notify handler for Notify(%4.4s, %X) node %p\n",
+				  "No notify handler for Notify (%4.4s, %X) node %p\n",
 				  acpi_ut_get_node_name(node), notify_value,
 				  node));
 	}
diff --git a/drivers/acpi/utilities/utglobal.c b/drivers/acpi/utilities/utglobal.c
index d2097de..d0226fe 100644
--- a/drivers/acpi/utilities/utglobal.c
+++ b/drivers/acpi/utilities/utglobal.c
@@ -602,6 +602,48 @@ char *acpi_ut_get_mutex_name(u32 mutex_id)
 
 	return (acpi_gbl_mutex_names[mutex_id]);
 }
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_get_notify_name
+ *
+ * PARAMETERS:  notify_value    - Value from the Notify() request
+ *
+ * RETURN:      String corresponding to the Notify Value.
+ *
+ * DESCRIPTION: Translate a Notify Value to a notify namestring.
+ *
+ ******************************************************************************/
+
+/* Names for Notify() values, used for debug output */
+
+static const char *acpi_gbl_notify_value_names[] = {
+	"Bus Check",
+	"Device Check",
+	"Device Wake",
+	"Eject Request",
+	"Device Check Light",
+	"Frequency Mismatch",
+	"Bus Mode Mismatch",
+	"Power Fault",
+	"Capabilities Check",
+	"Device PLD Check",
+	"Reserved",
+	"System Locality Update"
+};
+
+const char *acpi_ut_get_notify_name(u32 notify_value)
+{
+
+	if (notify_value <= ACPI_NOTIFY_MAX) {
+		return (acpi_gbl_notify_value_names[notify_value]);
+	} else if (notify_value <= ACPI_MAX_SYS_NOTIFY) {
+		return ("Reserved");
+	} else {		/* Greater or equal to 0x80 */
+
+		return ("**Device Specific**");
+	}
+}
 #endif
 
 /*******************************************************************************
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 75ec153..cc24cef 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -402,14 +402,20 @@ typedef unsigned long long acpi_integer;
 /*
  * Standard notify values
  */
-#define ACPI_NOTIFY_BUS_CHECK           (u8) 0
-#define ACPI_NOTIFY_DEVICE_CHECK        (u8) 1
-#define ACPI_NOTIFY_DEVICE_WAKE         (u8) 2
-#define ACPI_NOTIFY_EJECT_REQUEST       (u8) 3
-#define ACPI_NOTIFY_DEVICE_CHECK_LIGHT  (u8) 4
-#define ACPI_NOTIFY_FREQUENCY_MISMATCH  (u8) 5
-#define ACPI_NOTIFY_BUS_MODE_MISMATCH   (u8) 6
-#define ACPI_NOTIFY_POWER_FAULT         (u8) 7
+#define ACPI_NOTIFY_BUS_CHECK           (u8) 0x00
+#define ACPI_NOTIFY_DEVICE_CHECK        (u8) 0x01
+#define ACPI_NOTIFY_DEVICE_WAKE         (u8) 0x02
+#define ACPI_NOTIFY_EJECT_REQUEST       (u8) 0x03
+#define ACPI_NOTIFY_DEVICE_CHECK_LIGHT  (u8) 0x04
+#define ACPI_NOTIFY_FREQUENCY_MISMATCH  (u8) 0x05
+#define ACPI_NOTIFY_BUS_MODE_MISMATCH   (u8) 0x06
+#define ACPI_NOTIFY_POWER_FAULT         (u8) 0x07
+#define ACPI_NOTIFY_CAPABILITIES_CHECK  (u8) 0x08
+#define ACPI_NOTIFY_DEVICE_PLD_CHECK    (u8) 0x09
+#define ACPI_NOTIFY_RESERVED            (u8) 0x0A
+#define ACPI_NOTIFY_LOCALITY_UPDATE     (u8) 0x0B
+
+#define ACPI_NOTIFY_MAX                 0x0B
 
 /*
  * Types associated with ACPI names and objects.  The first group of
@@ -584,7 +590,7 @@ typedef u32 acpi_event_status;
 
 #define ACPI_SYSTEM_NOTIFY              0x1
 #define ACPI_DEVICE_NOTIFY              0x2
-#define ACPI_ALL_NOTIFY                 0x3
+#define ACPI_ALL_NOTIFY                 (ACPI_SYSTEM_NOTIFY | ACPI_DEVICE_NOTIFY)
 #define ACPI_MAX_NOTIFY_HANDLER_TYPE    0x3
 
 #define ACPI_MAX_SYS_NOTIFY             0x7f
diff --git a/include/acpi/acutils.h b/include/acpi/acutils.h
index a291854..26115da 100644
--- a/include/acpi/acutils.h
+++ b/include/acpi/acutils.h
@@ -116,6 +116,8 @@ void acpi_ut_init_globals(void);
 
 char *acpi_ut_get_mutex_name(u32 mutex_id);
 
+const char *acpi_ut_get_notify_name(u32 notify_value);
+
 #endif
 
 char *acpi_ut_get_type_name(acpi_object_type type);
-- 
1.5.5.29.g7134

