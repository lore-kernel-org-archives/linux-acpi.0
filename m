From: Len Brown <lenb@kernel.org>
Subject: [PATCH 67/94] ACPICA: New: Public GPE group enable/disable interfaces
Date: Fri, 09 Jan 2009 04:27:09 -0500
Message-ID: <08ac07b826cfd9a9b28aa094f14e1c023bdc9864.1231492611.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:56614 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754502AbZAIKSA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 05:18:00 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700LXC8LRL4S7@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 04:17:59 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Added acpi_disable_all_gpes and acpi_enable_all_runtime_gpes for
public use.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evxfevnt.c |   58 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpixf.h          |   15 +++++++---
 2 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/events/evxfevnt.c b/drivers/acpi/events/evxfevnt.c
index aa4dec8..f7550da 100644
--- a/drivers/acpi/events/evxfevnt.c
+++ b/drivers/acpi/events/evxfevnt.c
@@ -810,3 +810,61 @@ acpi_ev_get_gpe_device(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 
 	return (AE_OK);
 }
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_disable_all_gpes
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Disable and clear all GPEs in all GPE blocks
+ *
+ ******************************************************************************/
+
+acpi_status acpi_disable_all_gpes(void)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(acpi_disable_all_gpes);
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	status = acpi_hw_disable_all_gpes();
+	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
+
+	return_ACPI_STATUS(status);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_enable_all_runtime_gpes
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Enable all "runtime" GPEs, in all GPE blocks
+ *
+ ******************************************************************************/
+
+acpi_status acpi_enable_all_runtime_gpes(void)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(acpi_enable_all_runtime_gpes);
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	status = acpi_hw_enable_all_runtime_gpes();
+	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
+
+	return_ACPI_STATUS(status);
+}
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index e09c237..6d8fb6f 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -229,6 +229,10 @@ acpi_install_gpe_handler(acpi_handle gpe_device,
 			 u32 gpe_number,
 			 u32 type, acpi_event_handler address, void *context);
 
+acpi_status
+acpi_remove_gpe_handler(acpi_handle gpe_device,
+			u32 gpe_number, acpi_event_handler address);
+
 #ifdef ACPI_FUTURE_USAGE
 acpi_status acpi_install_exception_handler(acpi_exception_handler handler);
 #endif
@@ -240,10 +244,6 @@ acpi_status acpi_acquire_global_lock(u16 timeout, u32 * handle);
 
 acpi_status acpi_release_global_lock(u32 handle);
 
-acpi_status
-acpi_remove_gpe_handler(acpi_handle gpe_device,
-			u32 gpe_number, acpi_event_handler address);
-
 acpi_status acpi_enable_event(u32 event, u32 flags);
 
 acpi_status acpi_disable_event(u32 event, u32 flags);
@@ -252,6 +252,9 @@ acpi_status acpi_clear_event(u32 event);
 
 acpi_status acpi_get_event_status(u32 event, acpi_event_status * event_status);
 
+/*
+ * GPE Interfaces
+ */
 acpi_status acpi_set_gpe_type(acpi_handle gpe_device, u32 gpe_number, u8 type);
 
 acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number);
@@ -265,6 +268,10 @@ acpi_get_gpe_status(acpi_handle gpe_device,
 		    u32 gpe_number,
 		    u32 flags, acpi_event_status * event_status);
 
+acpi_status acpi_disable_all_gpes(void);
+
+acpi_status acpi_enable_all_runtime_gpes(void);
+
 acpi_status acpi_get_gpe_device(u32 gpe_index, acpi_handle *gpe_device);
 
 acpi_status
-- 
1.5.6.6

