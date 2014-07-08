From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [RFC PATCH 1/2] ACPICA: Add acpi_check_gpe_method() to check GPE method
Date: Tue,  8 Jul 2014 14:57:57 +0800
Message-ID: <1404802679-24019-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robert.moore@intel.com, lv.zheng@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch is to expose acpi_check_gpe_method() to check whether there
is a GPE method for the given gpe. Enabling ACPI button devices' gpes
will depend on the new function's result.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/acpica/evxface.c | 39 ++++++++++++++++++++++++++++++++++++++-
 include/acpi/acpixf.h         |  3 +++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index 11e5803..0fcb248 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -717,6 +717,44 @@ ACPI_EXPORT_SYMBOL(acpi_remove_fixed_event_handler)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_check_gpe_method
+ *
+ * PARAMETERS:  gpe_device      - Namespace node for the GPE (NULL for FADT
+ *                                defined GPEs)
+ *              gpe_number      - The event to remove a handler
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Check whether the given GPE has associated event method.
+ *
+ ******************************************************************************/
+acpi_status
+acpi_check_gpe_method(acpi_handle gpe_device, u32 gpe_number)
+{
+	struct acpi_gpe_event_info *gpe_event_info;
+	acpi_status status = AE_NOT_EXIST;
+	acpi_cpu_flags flags;
+
+	ACPI_FUNCTION_TRACE(acpi_check_gpe_method);
+
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
+	if (!gpe_event_info) {
+		status = AE_ERROR;
+		goto unlock_and_exit;
+	}
+
+	if (gpe_event_info->flags & ACPI_GPE_DISPATCH_METHOD)
+		status = AE_OK;
+
+unlock_and_exit:
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	return status;
+}
+ACPI_EXPORT_SYMBOL(acpi_check_gpe_method)
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_install_gpe_handler
  *
  * PARAMETERS:  gpe_device      - Namespace node for the GPE (NULL for FADT
@@ -821,7 +859,6 @@ free_and_exit:
 	ACPI_FREE(handler);
 	goto unlock_and_exit;
 }
-
 ACPI_EXPORT_SYMBOL(acpi_install_gpe_handler)
 
 /*******************************************************************************
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 35b525c..5b475c6 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -554,6 +554,9 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 							  address,
 							  void *context))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
+				acpi_check_gpe_method(acpi_handle gpe_device,
+							u32 gpe_number))
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				 acpi_remove_gpe_handler(acpi_handle gpe_device,
 							 u32 gpe_number,
 							 acpi_gpe_handler
-- 
1.8.4.rc0.1.g8f6a3e5.dirty
