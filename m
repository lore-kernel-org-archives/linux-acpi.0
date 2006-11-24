From: Len Brown <len.brown@intel.com>
Subject: [PATCH 19/65] ACPICA: Disable all wake GPEs after first one recieved
Date: Fri, 24 Nov 2006 02:18:29 -0500
Message-ID: <11643527812144-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com> <11643527804057-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:59186 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1757614AbWKXHPn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:15:43 -0500
In-Reply-To: <11643527804057-git-send-email-len.brown@intel.com>
Message-Id: <023eab64321d171542941abe76d9248d11a52778.1164352293.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Change for GPE support: when a wake GPE is
received, now all wake GPEs are immediately disabled to
prevent the waking GPE from firing again, and to prevent
other wake GPEs from interrupting the wake process.

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evgpe.c |   78 +++++++++---------------------------------
 include/acpi/acglobal.h     |   68 ++++++++++++++++++-------------------
 include/acpi/actypes.h      |    6 +---
 3 files changed, 51 insertions(+), 101 deletions(-)

diff --git a/drivers/acpi/events/evgpe.c b/drivers/acpi/events/evgpe.c
index d9f71dd..df92c9e 100644
--- a/drivers/acpi/events/evgpe.c
+++ b/drivers/acpi/events/evgpe.c
@@ -635,20 +635,23 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_eve
 		}
 	}
 
-	/* Save current system state */
-
-	if (acpi_gbl_system_awake_and_running) {
-		ACPI_SET_BIT(gpe_event_info->flags, ACPI_GPE_SYSTEM_RUNNING);
-	} else {
-		ACPI_CLEAR_BIT(gpe_event_info->flags, ACPI_GPE_SYSTEM_RUNNING);
+	if (!acpi_gbl_system_awake_and_running) {
+		/*
+		 * We just woke up because of a wake GPE. Disable any further GPEs
+		 * until we are fully up and running (Only wake GPEs should be enabled
+		 * at this time, but we just brute-force disable them all.)
+		 * 1) We must disable this particular wake GPE so it won't fire again
+		 * 2) We want to disable all wake GPEs, since we are now awake
+		 */
+		(void)acpi_hw_disable_all_gpes();
 	}
 
 	/*
-	 * Dispatch the GPE to either an installed handler, or the control
-	 * method associated with this GPE (_Lxx or _Exx).
-	 * If a handler exists, we invoke it and do not attempt to run the method.
-	 * If there is neither a handler nor a method, we disable the level to
-	 * prevent further events from coming in here.
+	 * Dispatch the GPE to either an installed handler, or the control method
+	 * associated with this GPE (_Lxx or _Exx). If a handler exists, we invoke
+	 * it and do not attempt to run the method. If there is neither a handler
+	 * nor a method, we disable this GPE to prevent further such pointless
+	 * events from firing.
 	 */
 	switch (gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) {
 	case ACPI_GPE_DISPATCH_HANDLER:
@@ -679,8 +682,8 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_eve
 	case ACPI_GPE_DISPATCH_METHOD:
 
 		/*
-		 * Disable GPE, so it doesn't keep firing before the method has a
-		 * chance to run.
+		 * Disable the GPE, so it doesn't keep firing before the method has a
+		 * chance to run (it runs asynchronously with interrupts enabled).
 		 */
 		status = acpi_ev_disable_gpe(gpe_event_info);
 		if (ACPI_FAILURE(status)) {
@@ -713,7 +716,7 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_eve
 			    gpe_number));
 
 		/*
-		 * Disable the GPE.  The GPE will remain disabled until the ACPI
+		 * Disable the GPE. The GPE will remain disabled until the ACPI
 		 * Core Subsystem is restarted, or a handler is installed.
 		 */
 		status = acpi_ev_disable_gpe(gpe_event_info);
@@ -728,50 +731,3 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_eve
 
 	return_UINT32(ACPI_INTERRUPT_HANDLED);
 }
-
-#ifdef ACPI_GPE_NOTIFY_CHECK
-/*******************************************************************************
- * TBD: NOT USED, PROTOTYPE ONLY AND WILL PROBABLY BE REMOVED
- *
- * FUNCTION:    acpi_ev_check_for_wake_only_gpe
- *
- * PARAMETERS:  gpe_event_info  - info for this GPE
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Determine if a a GPE is "wake-only".
- *
- *              Called from Notify() code in interpreter when a "DeviceWake"
- *              Notify comes in.
- *
- ******************************************************************************/
-
-acpi_status
-acpi_ev_check_for_wake_only_gpe(struct acpi_gpe_event_info *gpe_event_info)
-{
-	acpi_status status;
-
-	ACPI_FUNCTION_TRACE(ev_check_for_wake_only_gpe);
-
-	if ((gpe_event_info) &&	/* Only >0 for _Lxx/_Exx */
-	    ((gpe_event_info->flags & ACPI_GPE_SYSTEM_MASK) == ACPI_GPE_SYSTEM_RUNNING)) {	/* System state at GPE time */
-		/* This must be a wake-only GPE, disable it */
-
-		status = acpi_ev_disable_gpe(gpe_event_info);
-
-		/* Set GPE to wake-only.  Do not change wake disabled/enabled status */
-
-		acpi_ev_set_gpe_type(gpe_event_info, ACPI_GPE_TYPE_WAKE);
-
-		ACPI_INFO((AE_INFO,
-			   "GPE %p was updated from wake/run to wake-only",
-			   gpe_event_info));
-
-		/* This was a wake-only GPE */
-
-		return_ACPI_STATUS(AE_WAKE_ONLY_GPE);
-	}
-
-	return_ACPI_STATUS(AE_OK);
-}
-#endif
diff --git a/include/acpi/acglobal.h b/include/acpi/acglobal.h
index 019b86e..a2b8340 100644
--- a/include/acpi/acglobal.h
+++ b/include/acpi/acglobal.h
@@ -58,41 +58,6 @@
 #define ACPI_INIT_GLOBAL(a,b) a
 #endif
 
-/*
- * Keep local copies of these FADT-based registers.  NOTE: These globals
- * are first in this file for alignment reasons on 64-bit systems.
- */
-ACPI_EXTERN struct acpi_generic_address acpi_gbl_xpm1a_enable;
-ACPI_EXTERN struct acpi_generic_address acpi_gbl_xpm1b_enable;
-
-/*****************************************************************************
- *
- * Debug support
- *
- ****************************************************************************/
-
-/* Runtime configuration of debug print levels */
-
-extern u32 acpi_dbg_level;
-extern u32 acpi_dbg_layer;
-
-/* Procedure nesting level for debug output */
-
-extern u32 acpi_gbl_nesting_level;
-
-/* Event counters */
-
-ACPI_EXTERN u32 acpi_gpe_count;
-
-/* Support for dynamic control method tracing mechanism */
-
-ACPI_EXTERN u32 acpi_gbl_original_dbg_level;
-ACPI_EXTERN u32 acpi_gbl_original_dbg_layer;
-ACPI_EXTERN acpi_name acpi_gbl_trace_method_name;
-ACPI_EXTERN u32 acpi_gbl_trace_dbg_level;
-ACPI_EXTERN u32 acpi_gbl_trace_dbg_layer;
-ACPI_EXTERN u32 acpi_gbl_trace_flags;
-
 /*****************************************************************************
  *
  * Runtime configuration (static defaults that can be overriden at runtime)
@@ -139,6 +104,34 @@ ACPI_EXTERN u8 ACPI_INIT_GLOBAL(acpi_gbl
 
 /*****************************************************************************
  *
+ * Debug support
+ *
+ ****************************************************************************/
+
+/* Runtime configuration of debug print levels */
+
+extern u32 acpi_dbg_level;
+extern u32 acpi_dbg_layer;
+
+/* Procedure nesting level for debug output */
+
+extern u32 acpi_gbl_nesting_level;
+
+/* Event counters */
+
+ACPI_EXTERN u32 acpi_gpe_count;
+
+/* Support for dynamic control method tracing mechanism */
+
+ACPI_EXTERN u32 acpi_gbl_original_dbg_level;
+ACPI_EXTERN u32 acpi_gbl_original_dbg_layer;
+ACPI_EXTERN acpi_name acpi_gbl_trace_method_name;
+ACPI_EXTERN u32 acpi_gbl_trace_dbg_level;
+ACPI_EXTERN u32 acpi_gbl_trace_dbg_layer;
+ACPI_EXTERN u32 acpi_gbl_trace_flags;
+
+/*****************************************************************************
+ *
  * ACPI Table globals
  *
  ****************************************************************************/
@@ -153,6 +146,11 @@ ACPI_EXTERN struct acpi_internal_rsdt ac
 ACPI_EXTERN struct acpi_table_fadt acpi_gbl_FADT;
 extern acpi_native_uint acpi_gbl_permanent_mmap;
 
+/* These addresses are calculated from FADT address values */
+
+ACPI_EXTERN struct acpi_generic_address acpi_gbl_xpm1a_enable;
+ACPI_EXTERN struct acpi_generic_address acpi_gbl_xpm1b_enable;
+
 /*
  * Handle both ACPI 1.0 and ACPI 2.0 Integer widths. The integer width is
  * determined by the revision of the DSDT: If the DSDT revision is less than
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index b0cdee6..fe9eb0e 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -592,7 +592,7 @@ typedef u32 acpi_event_status;
  *  | | |  +--- Type of dispatch -- to method, handler, or none
  *  | | +--- Enabled for runtime?
  *  | +--- Enabled for wake?
- *  +--- System state when GPE ocurred (running/waking)
+ *  +--- Unused
  */
 #define ACPI_GPE_XRUPT_TYPE_MASK        (u8) 0x01
 #define ACPI_GPE_LEVEL_TRIGGERED        (u8) 0x01
@@ -618,10 +618,6 @@ typedef u32 acpi_event_status;
 
 #define ACPI_GPE_ENABLE_MASK            (u8) 0x60	/* Both run/wake */
 
-#define ACPI_GPE_SYSTEM_MASK            (u8) 0x80
-#define ACPI_GPE_SYSTEM_RUNNING         (u8) 0x80
-#define ACPI_GPE_SYSTEM_WAKING          (u8) 0x00
-
 /*
  * Flags for GPE and Lock interfaces
  */
-- 
1.4.4.1
