From: Len Brown <lenb@kernel.org>
Subject: [PATCH 60/73] ACPICA: Additional GPE/Notify handling change
Date: Sat, 12 Apr 2008 00:25:43 -0400
Message-ID: <e7a27fb06130ca7e04e71d0c5f11cf5e187f2395.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:15947 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756773AbYDLE2Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:16 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Implemented another MS compatibility design change for GPE/Notify
handling. GPEs are now cleared/enabled asynchronously to
allow all pending notifies to complete first. It is expected
that the OSL will queue the enable request behind all pending
notify requests (may require changes to the local host OSL in
AcpiOsExecute). Alexey Starikovskiy

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evgpe.c |   40 ++++++++++++++++++++++++++++++----------
 1 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/events/evgpe.c b/drivers/acpi/events/evgpe.c
index 0dadd2a..897baed 100644
--- a/drivers/acpi/events/evgpe.c
+++ b/drivers/acpi/events/evgpe.c
@@ -51,6 +51,8 @@ ACPI_MODULE_NAME("evgpe")
 /* Local prototypes */
 static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context);
 
+static void ACPI_SYSTEM_XFACE acpi_ev_asynch_enable_gpe(void *context);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ev_set_gpe_type
@@ -505,13 +507,22 @@ static void acpi_ev_asynch_enable_gpe(void *context);
 
 static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 {
-	struct acpi_gpe_event_info *gpe_event_info = (void *)context;
+	struct acpi_gpe_event_info *gpe_event_info = context;
 	acpi_status status;
-	struct acpi_gpe_event_info local_gpe_event_info;
+	struct acpi_gpe_event_info *local_gpe_event_info;
 	struct acpi_evaluate_info *info;
 
 	ACPI_FUNCTION_TRACE(ev_asynch_execute_gpe_method);
 
+	/* Allocate a local GPE block */
+
+	local_gpe_event_info =
+	    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_gpe_event_info));
+	if (!local_gpe_event_info) {
+		ACPI_EXCEPTION((AE_INFO, AE_NO_MEMORY, "while handling a GPE"));
+		return_VOID;
+	}
+
 	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
 	if (ACPI_FAILURE(status)) {
 		return_VOID;
@@ -532,7 +543,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 	 * Take a snapshot of the GPE info for this level - we copy the
 	 * info to prevent a race condition with remove_handler/remove_block.
 	 */
-	ACPI_MEMCPY(&local_gpe_event_info, gpe_event_info,
+	ACPI_MEMCPY(local_gpe_event_info, gpe_event_info,
 		    sizeof(struct acpi_gpe_event_info));
 
 	status = acpi_ut_release_mutex(ACPI_MTX_EVENTS);
@@ -544,7 +555,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 	 * Must check for control method type dispatch one more
 	 * time to avoid race with ev_gpe_install_handler
 	 */
-	if ((local_gpe_event_info.flags & ACPI_GPE_DISPATCH_MASK) ==
+	if ((local_gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) ==
 	    ACPI_GPE_DISPATCH_METHOD) {
 
 		/* Allocate the evaluation information block */
@@ -558,10 +569,10 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 			 * control method that corresponds to this GPE
 			 */
 			info->prefix_node =
-			    local_gpe_event_info.dispatch.method_node;
+			    local_gpe_event_info->dispatch.method_node;
 			info->parameters =
 			    ACPI_CAST_PTR(union acpi_operand_object *,
-					  gpe_event_info);
+					  local_gpe_event_info);
 			info->parameter_type = ACPI_PARAM_GPE;
 			info->flags = ACPI_IGNORE_RETURN_VALUE;
 
@@ -573,13 +584,18 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 			ACPI_EXCEPTION((AE_INFO, status,
 					"while evaluating GPE method [%4.4s]",
 					acpi_ut_get_node_name
-					(local_gpe_event_info.dispatch.
+					(local_gpe_event_info->dispatch.
 					 method_node)));
 		}
 	}
 	/* Defer enabling of GPE until all notify handlers are done */
-	acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_ev_asynch_enable_gpe,
+	status = acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_ev_asynch_enable_gpe,
 				gpe_event_info);
+
+	if (ACPI_FAILURE(status)) {
+		ACPI_FREE(local_gpe_event_info);
+	}
+
 	return_VOID;
 }
 
@@ -595,12 +611,15 @@ static void acpi_ev_asynch_enable_gpe(void *context)
 		 */
 		status = acpi_hw_clear_gpe(gpe_event_info);
 		if (ACPI_FAILURE(status)) {
-			return_VOID;
+			goto exit;
 		}
 	}
 
 	/* Enable this GPE */
 	(void)acpi_hw_write_gpe_enable_reg(gpe_event_info);
+  exit:
+	ACPI_FREE(gpe_event_info);
+	return;
 	return_VOID;
 }
 
@@ -621,7 +640,8 @@ static void acpi_ev_asynch_enable_gpe(void *context)
  ******************************************************************************/
 
 u32
-acpi_ev_gpe_dispatch(struct acpi_gpe_event_info *gpe_event_info, u32 gpe_number)
+acpi_ev_gpe_dispatch(struct acpi_gpe_event_info * gpe_event_info,
+		     u32 gpe_number)
 {
 	acpi_status status;
 
-- 
1.5.5.29.g7134

