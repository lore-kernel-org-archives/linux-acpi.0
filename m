From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/20] ACPI / ACPICA: Fix reference counting problems with GPE
 handlers
Date: Sun, 15 Aug 2010 01:23:11 -0400
Message-ID: <28f4f8a9def2b1f3a6066bae791c77043ec49524.1281849737.git.len.brown@intel.com>
References: <1281849804-7455-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:56508 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019Ab0HOFXd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Aug 2010 01:23:33 -0400
Received: from localhost.localdomain ([unknown] [64.140.212.33])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L7600AY9HN75KN0@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 15 Aug 2010 00:23:32 -0500 (CDT)
In-reply-to: <1281849804-7455-1-git-send-email-lenb@kernel.org>
In-reply-to: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
References: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Moore, Robert" <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

If a handler is installed for a GPE associated with an AML method and
such that it cannot wake up the system from sleep states, the GPE
remains enabled after the handler has been installed, although it
should be disabled in that case to avoid spurious execution of the
handler.

Fix this issue by making acpi_install_gpe_handler() disable GPEs
that were previously associated with AML methods and cannot wake up
the system from sleep states.

Analogously, make acpi_remove_gpe_handler() enable the GPEs that
are associated with AML methods after their handlers have been
removed and cannot wake up the system from sleep states.  In addition
to that, fix a code ordering issue in acpi_remove_gpe_handler() that
renders the locking ineffective (ACPI_MTX_EVENTS is released
temporarily in the middle of the routine to wait for the completion
of events already in progress).

For this purpose introduce acpi_raw_disable_gpe() and
acpi_raw_enable_gpe() to be called with acpi_gbl_gpe_lock held
and rework acpi_disable_gpe() and acpi_enable_gpe(), respectively, to
use them.  Also rework acpi_gpe_can_wake() to use
acpi_raw_disable_gpe() instead of calling acpi_disable_gpe() after
releasing the lock to avoid the possible theoretical race with
acpi_install_gpe_handler().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Cc: "Moore, Robert" <robert.moore@intel.com>
Cc: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acevents.h |    4 ++
 drivers/acpi/acpica/aclocal.h  |    1 +
 drivers/acpi/acpica/evgpe.c    |   73 +++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/evxface.c  |   77 +++++++++++++++++++++++++++-------------
 drivers/acpi/acpica/evxfevnt.c |   62 +++++---------------------------
 5 files changed, 139 insertions(+), 78 deletions(-)

diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index e0e6aff..36867cd 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -82,6 +82,10 @@ acpi_ev_update_gpe_enable_mask(struct acpi_gpe_event_info *gpe_event_info);
 
 acpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info);
 
+acpi_status acpi_raw_enable_gpe(struct acpi_gpe_event_info *gpe_event_info);
+
+acpi_status acpi_raw_disable_gpe(struct acpi_gpe_event_info *gpe_event_info);
+
 struct acpi_gpe_event_info *acpi_ev_get_gpe_event_info(acpi_handle gpe_device,
 						       u32 gpe_number);
 
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 1ee0bcf..df85b53 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -412,6 +412,7 @@ struct acpi_handler_info {
 	acpi_event_handler address;	/* Address of handler, if any */
 	void *context;		/* Context to be passed to handler */
 	struct acpi_namespace_node *method_node;	/* Method node for this GPE level (saved) */
+	u8 orig_flags;		/* Original misc info about this GPE */
 };
 
 union acpi_gpe_dispatch_info {
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 7a6a3e6..f226eac 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -137,6 +137,79 @@ acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_raw_enable_gpe
+ *
+ * PARAMETERS:  gpe_event_info  - GPE to enable
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Add a reference to a GPE. On the first reference, the GPE is
+ *              hardware-enabled.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_raw_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
+{
+	acpi_status status = AE_OK;
+
+	if (gpe_event_info->runtime_count == ACPI_UINT8_MAX) {
+		return_ACPI_STATUS(AE_LIMIT);
+	}
+
+	gpe_event_info->runtime_count++;
+	if (gpe_event_info->runtime_count == 1) {
+		status = acpi_ev_update_gpe_enable_mask(gpe_event_info);
+		if (ACPI_SUCCESS(status)) {
+			status = acpi_ev_enable_gpe(gpe_event_info);
+		}
+
+		if (ACPI_FAILURE(status)) {
+			gpe_event_info->runtime_count--;
+		}
+	}
+
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_raw_disable_gpe
+ *
+ * PARAMETERS:  gpe_event_info  - GPE to disable
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Remove a reference to a GPE. When the last reference is
+ *              removed, the GPE is hardware-disabled.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_raw_disable_gpe(struct acpi_gpe_event_info *gpe_event_info)
+{
+	acpi_status status = AE_OK;
+
+	if (!gpe_event_info->runtime_count) {
+		return_ACPI_STATUS(AE_LIMIT);
+	}
+
+	gpe_event_info->runtime_count--;
+	if (!gpe_event_info->runtime_count) {
+		status = acpi_ev_update_gpe_enable_mask(gpe_event_info);
+		if (ACPI_SUCCESS(status)) {
+			status = acpi_hw_low_set_gpe(gpe_event_info,
+						     ACPI_GPE_DISABLE);
+		}
+
+		if (ACPI_FAILURE(status)) {
+			gpe_event_info->runtime_count++;
+		}
+	}
+
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ev_low_get_gpe_info
  *
  * PARAMETERS:  gpe_number          - Raw GPE number
diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index 4a531cd..14e48ad 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -691,12 +691,22 @@ acpi_install_gpe_handler(acpi_handle gpe_device,
 		return_ACPI_STATUS(status);
 	}
 
+	/* Allocate memory for the handler object */
+
+	handler = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_handler_info));
+	if (!handler) {
+		status = AE_NO_MEMORY;
+		goto unlock_and_exit;
+	}
+
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+
 	/* Ensure that we have a valid GPE number */
 
 	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
 	if (!gpe_event_info) {
 		status = AE_BAD_PARAMETER;
-		goto unlock_and_exit;
+		goto free_and_exit;
 	}
 
 	/* Make sure that there isn't a handler there already */
@@ -704,24 +714,30 @@ acpi_install_gpe_handler(acpi_handle gpe_device,
 	if ((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) ==
 	    ACPI_GPE_DISPATCH_HANDLER) {
 		status = AE_ALREADY_EXISTS;
-		goto unlock_and_exit;
+		goto free_and_exit;
 	}
 
 	/* Allocate and init handler object */
 
-	handler = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_handler_info));
-	if (!handler) {
-		status = AE_NO_MEMORY;
-		goto unlock_and_exit;
-	}
-
 	handler->address = address;
 	handler->context = context;
 	handler->method_node = gpe_event_info->dispatch.method_node;
+	handler->orig_flags = gpe_event_info->flags &
+			(ACPI_GPE_XRUPT_TYPE_MASK | ACPI_GPE_DISPATCH_MASK);
+
+	/*
+	 * If the GPE is associated with a method and it cannot wake up the
+	 * system from sleep states, it was enabled automatically during
+	 * initialization, so it has to be disabled now to avoid spurious
+	 * execution of the handler.
+	 */
+
+	if ((handler->orig_flags & ACPI_GPE_DISPATCH_METHOD)
+	    && !(gpe_event_info->flags & ACPI_GPE_CAN_WAKE))
+		(void)acpi_raw_disable_gpe(gpe_event_info);
 
 	/* Install the handler */
 
-	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 	gpe_event_info->dispatch.handler = handler;
 
 	/* Setup up dispatch flags to indicate handler (vs. method) */
@@ -735,6 +751,11 @@ acpi_install_gpe_handler(acpi_handle gpe_device,
 unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
 	return_ACPI_STATUS(status);
+
+free_and_exit:
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	ACPI_FREE(handler);
+	goto unlock_and_exit;
 }
 
 ACPI_EXPORT_SYMBOL(acpi_install_gpe_handler)
@@ -770,11 +791,17 @@ acpi_remove_gpe_handler(acpi_handle gpe_device,
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
+	/* Make sure all deferred tasks are completed */
+
+	acpi_os_wait_events_complete(NULL);
+
 	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
 
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+
 	/* Ensure that we have a valid GPE number */
 
 	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
@@ -798,34 +825,34 @@ acpi_remove_gpe_handler(acpi_handle gpe_device,
 		goto unlock_and_exit;
 	}
 
-	/* Make sure all deferred tasks are completed */
-
-	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
-	acpi_os_wait_events_complete(NULL);
-	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
 	/* Remove the handler */
 
-	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 	handler = gpe_event_info->dispatch.handler;
 
 	/* Restore Method node (if any), set dispatch flags */
 
 	gpe_event_info->dispatch.method_node = handler->method_node;
-	gpe_event_info->flags &= ~ACPI_GPE_DISPATCH_MASK;	/* Clear bits */
-	if (handler->method_node) {
-		gpe_event_info->flags |= ACPI_GPE_DISPATCH_METHOD;
-	}
-	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	gpe_event_info->flags &=
+		~(ACPI_GPE_XRUPT_TYPE_MASK | ACPI_GPE_DISPATCH_MASK);
+	gpe_event_info->flags |= handler->orig_flags;
+
+	/*
+	 * If the GPE was previously associated with a method and it cannot wake
+	 * up the system from sleep states, it should be enabled at this point
+	 * to restore the post-initialization configuration.
+	 */
+
+	if ((handler->orig_flags & ACPI_GPE_DISPATCH_METHOD)
+	    && !(gpe_event_info->flags & ACPI_GPE_CAN_WAKE))
+		(void)acpi_raw_enable_gpe(gpe_event_info);
 
 	/* Now we can free the handler object */
 
 	ACPI_FREE(handler);
 
-      unlock_and_exit:
+unlock_and_exit:
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+
 	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index 53d591a..0fb9e94 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -291,7 +291,7 @@ ACPI_EXPORT_SYMBOL(acpi_gpe_wakeup)
  ******************************************************************************/
 acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number)
 {
-	acpi_status status = AE_OK;
+	acpi_status status = AE_BAD_PARAMETER;
 	struct acpi_gpe_event_info *gpe_event_info;
 	acpi_cpu_flags flags;
 
@@ -302,28 +302,10 @@ acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number)
 	/* Ensure that we have a valid GPE number */
 
 	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
-	if (!gpe_event_info) {
-		status = AE_BAD_PARAMETER;
-		goto unlock_and_exit;
+	if (gpe_event_info) {
+		status = acpi_raw_enable_gpe(gpe_event_info);
 	}
 
-	if (gpe_event_info->runtime_count == ACPI_UINT8_MAX) {
-		status = AE_LIMIT;	/* Too many references */
-		goto unlock_and_exit;
-	}
-
-	gpe_event_info->runtime_count++;
-	if (gpe_event_info->runtime_count == 1) {
-		status = acpi_ev_update_gpe_enable_mask(gpe_event_info);
-		if (ACPI_SUCCESS(status)) {
-			status = acpi_ev_enable_gpe(gpe_event_info);
-		}
-		if (ACPI_FAILURE(status)) {
-			gpe_event_info->runtime_count--;
-		}
-	}
-
-unlock_and_exit:
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 	return_ACPI_STATUS(status);
 }
@@ -345,7 +327,7 @@ ACPI_EXPORT_SYMBOL(acpi_enable_gpe)
  ******************************************************************************/
 acpi_status acpi_disable_gpe(acpi_handle gpe_device, u32 gpe_number)
 {
-	acpi_status status = AE_OK;
+	acpi_status status = AE_BAD_PARAMETER;
 	struct acpi_gpe_event_info *gpe_event_info;
 	acpi_cpu_flags flags;
 
@@ -356,32 +338,10 @@ acpi_status acpi_disable_gpe(acpi_handle gpe_device, u32 gpe_number)
 	/* Ensure that we have a valid GPE number */
 
 	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
-	if (!gpe_event_info) {
-		status = AE_BAD_PARAMETER;
-		goto unlock_and_exit;
-	}
-
-	/* Hardware-disable a runtime GPE on removal of the last reference */
-
-	if (!gpe_event_info->runtime_count) {
-		status = AE_LIMIT;	/* There are no references to remove */
-		goto unlock_and_exit;
+	if (gpe_event_info) {
+		status = acpi_raw_disable_gpe(gpe_event_info) ;
 	}
 
-	gpe_event_info->runtime_count--;
-	if (!gpe_event_info->runtime_count) {
-		status = acpi_ev_update_gpe_enable_mask(gpe_event_info);
-		if (ACPI_SUCCESS(status)) {
-			status =
-			    acpi_hw_low_set_gpe(gpe_event_info,
-						ACPI_GPE_DISABLE);
-		}
-		if (ACPI_FAILURE(status)) {
-			gpe_event_info->runtime_count++;
-		}
-	}
-
-unlock_and_exit:
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 	return_ACPI_STATUS(status);
 }
@@ -408,7 +368,6 @@ acpi_status acpi_gpe_can_wake(acpi_handle gpe_device, u32 gpe_number)
 	acpi_status status = AE_OK;
 	struct acpi_gpe_event_info *gpe_event_info;
 	acpi_cpu_flags flags;
-	u8 disable = 0;
 
 	ACPI_FUNCTION_TRACE(acpi_gpe_can_wake);
 
@@ -427,15 +386,12 @@ acpi_status acpi_gpe_can_wake(acpi_handle gpe_device, u32 gpe_number)
 	}
 
 	gpe_event_info->flags |= ACPI_GPE_CAN_WAKE;
-	disable = (gpe_event_info->flags & ACPI_GPE_DISPATCH_METHOD)
-		&& gpe_event_info->runtime_count;
+	if (gpe_event_info->flags & ACPI_GPE_DISPATCH_METHOD) {
+		(void)acpi_raw_disable_gpe(gpe_event_info);
+	}
 
 unlock_and_exit:
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
-
-	if (disable)
-		status = acpi_disable_gpe(gpe_device, gpe_number);
-
 	return_ACPI_STATUS(status);
 }
 ACPI_EXPORT_SYMBOL(acpi_gpe_can_wake)
-- 
1.7.2.1.95.g3d045

