From: Len Brown <lenb@kernel.org>
Subject: [PATCH 39/98] ACPICA: Add manifest constants for bit register values
Date: Sat, 28 Mar 2009 00:31:14 -0400
Message-ID: <768aaaf196e8a40f5cfc792d9d365795cc52ed13.1238214619.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:34767 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180AbZC1Ecr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:47 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH7006GM8MKHDLD@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:45 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Add and deploy constants for the PM status/enable/control
registers.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/evevent.c  |   12 +++++++-----
 drivers/acpi/acpica/evmisc.c   |    3 ++-
 drivers/acpi/acpica/evxfevnt.c |    6 +++---
 drivers/acpi/acpica/hwsleep.c  |   14 ++++++++++----
 include/acpi/actypes.h         |    9 +++++++++
 5 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpica/evevent.c b/drivers/acpi/acpica/evevent.c
index 246f877..cd55c77 100644
--- a/drivers/acpi/acpica/evevent.c
+++ b/drivers/acpi/acpica/evevent.c
@@ -183,7 +183,7 @@ acpi_status acpi_ev_install_xrupt_handlers(void)
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Install the fixed event handlers and enable the fixed events.
+ * DESCRIPTION: Install the fixed event handlers and disable all fixed events.
  *
  ******************************************************************************/
 
@@ -200,12 +200,13 @@ static acpi_status acpi_ev_fixed_event_initialize(void)
 		acpi_gbl_fixed_event_handlers[i].handler = NULL;
 		acpi_gbl_fixed_event_handlers[i].context = NULL;
 
-		/* Enable the fixed event */
+		/* Disable the fixed event */
 
 		if (acpi_gbl_fixed_event_info[i].enable_register_id != 0xFF) {
 			status =
 			    acpi_write_bit_register(acpi_gbl_fixed_event_info
-						    [i].enable_register_id, 0);
+						    [i].enable_register_id,
+						    ACPI_DISABLE_EVENT);
 			if (ACPI_FAILURE(status)) {
 				return (status);
 			}
@@ -289,7 +290,7 @@ static u32 acpi_ev_fixed_event_dispatch(u32 event)
 	/* Clear the status bit */
 
 	(void)acpi_write_bit_register(acpi_gbl_fixed_event_info[event].
-				      status_register_id, 1);
+				      status_register_id, ACPI_CLEAR_STATUS);
 
 	/*
 	 * Make sure we've got a handler. If not, report an error. The event is
@@ -297,7 +298,8 @@ static u32 acpi_ev_fixed_event_dispatch(u32 event)
 	 */
 	if (NULL == acpi_gbl_fixed_event_handlers[event].handler) {
 		(void)acpi_write_bit_register(acpi_gbl_fixed_event_info[event].
-					      enable_register_id, 0);
+					      enable_register_id,
+					      ACPI_DISABLE_EVENT);
 
 		ACPI_ERROR((AE_INFO,
 			    "No installed handler for fixed event [%08X]",
diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index 0e9e12b..417a9b9 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -535,7 +535,8 @@ acpi_status acpi_ev_release_global_lock(void)
 		if (pending) {
 			status =
 			    acpi_write_bit_register
-			    (ACPI_BITREG_GLOBAL_LOCK_RELEASE, 1);
+			    (ACPI_BITREG_GLOBAL_LOCK_RELEASE,
+			     ACPI_ENABLE_EVENT);
 		}
 
 		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index 484c979..d0a0807 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -173,7 +173,7 @@ acpi_status acpi_enable_event(u32 event, u32 flags)
 	 */
 	status =
 	    acpi_write_bit_register(acpi_gbl_fixed_event_info[event].
-				    enable_register_id, 1);
+				    enable_register_id, ACPI_ENABLE_EVENT);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -355,7 +355,7 @@ acpi_status acpi_disable_event(u32 event, u32 flags)
 	 */
 	status =
 	    acpi_write_bit_register(acpi_gbl_fixed_event_info[event].
-				    enable_register_id, 0);
+				    enable_register_id, ACPI_DISABLE_EVENT);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -408,7 +408,7 @@ acpi_status acpi_clear_event(u32 event)
 	 */
 	status =
 	    acpi_write_bit_register(acpi_gbl_fixed_event_info[event].
-				    status_register_id, 1);
+				    status_register_id, ACPI_CLEAR_STATUS);
 
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index 78d62b8..4d14b49 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -250,7 +250,8 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 
 	/* Clear wake status */
 
-	status = acpi_write_bit_register(ACPI_BITREG_WAKE_STATUS, 1);
+	status =
+	    acpi_write_bit_register(ACPI_BITREG_WAKE_STATUS, ACPI_CLEAR_STATUS);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -399,7 +400,10 @@ acpi_status asmlinkage acpi_enter_sleep_state_s4bios(void)
 
 	ACPI_FUNCTION_TRACE(acpi_enter_sleep_state_s4bios);
 
-	status = acpi_write_bit_register(ACPI_BITREG_WAKE_STATUS, 1);
+	/* Clear the wake status bit (PM1) */
+
+	status =
+	    acpi_write_bit_register(ACPI_BITREG_WAKE_STATUS, ACPI_CLEAR_STATUS);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
@@ -601,11 +605,13 @@ acpi_status acpi_leave_sleep_state(u8 sleep_state)
 
 	(void)
 	    acpi_write_bit_register(acpi_gbl_fixed_event_info
-			      [ACPI_EVENT_POWER_BUTTON].enable_register_id, 1);
+			      [ACPI_EVENT_POWER_BUTTON].
+			      enable_register_id, ACPI_ENABLE_EVENT);
 
 	(void)
 	    acpi_write_bit_register(acpi_gbl_fixed_event_info
-			      [ACPI_EVENT_POWER_BUTTON].status_register_id, 1);
+			      [ACPI_EVENT_POWER_BUTTON].
+			      status_register_id, ACPI_CLEAR_STATUS);
 
 	arg.integer.value = ACPI_SST_WORKING;
 	status = acpi_evaluate_object(NULL, METHOD_NAME__SST, &arg_list, NULL);
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 1b9601c..f555d92 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -787,6 +787,15 @@ typedef u8 acpi_adr_space_type;
 #define ACPI_BITREG_MAX                         0x13
 #define ACPI_NUM_BITREG                         ACPI_BITREG_MAX + 1
 
+/* Status register values. A 1 clears a status bit. 0 = no effect */
+
+#define ACPI_CLEAR_STATUS                       1
+
+/* Enable and Control register values */
+
+#define ACPI_ENABLE_EVENT                       1
+#define ACPI_DISABLE_EVENT                      0
+
 /*
  * External ACPI object definition
  */
-- 
1.6.0.6

