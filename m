From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 2/2] ACPICA: Add new GPE public interface - acpi_mark_gpe_for_wake.
Date: Wed, 23 Jul 2014 13:12:16 +0800
Message-ID: <ce3d543efec1cb376b26e2c3e41baac70e7fc775.1406092278.git.lv.zheng@intel.com>
References: <7323172.bFe2jdDKx7@vostro.rjw.lan>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43803 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932387AbaGWFMV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Jul 2014 01:12:21 -0400
In-Reply-To: <7323172.bFe2jdDKx7@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

ACPICA release patch.

------------------

commit c49dbfed2bc069d0038ea7e1294409bfde7c2c8c upstream

Some potential callers of acpi_setup_gpe_for_wake may know in advance that
there won't be any notify handlers installed for device wake notifications
from the given GPE (one example is a button GPE in Linux). For these cases,
acpi_mark_gpe_for_wake should be used instead of acpi_setup_gpe_for_wake.
This will set the ACPI_GPE_CAN_WAKE flag for the GPE without trying to
setup implicit wake notification for it (since there's no handler method).
Rafael Wysocki.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/evxfgpe.c |   47 +++++++++++++++++++++++++++++++++++++++++
 include/acpi/acpixf.h         |    4 ++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index 82e5c14..0cf159c 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -187,6 +187,53 @@ ACPI_EXPORT_SYMBOL(acpi_disable_gpe)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_mark_gpe_for_wake
+ *
+ * PARAMETERS:  gpe_device          - Parent GPE Device. NULL for GPE0/GPE1
+ *              gpe_number          - GPE level within the GPE block
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Mark a GPE as having the ability to wake the system. Simply
+ *              sets the ACPI_GPE_CAN_WAKE flag.
+ *
+ * Some potential callers of acpi_setup_gpe_for_wake may know in advance that
+ * there won't be any notify handlers installed for device wake notifications
+ * from the given GPE (one example is a button GPE in Linux). For these cases,
+ * acpi_mark_gpe_for_wake should be used instead of acpi_setup_gpe_for_wake.
+ * This will set the ACPI_GPE_CAN_WAKE flag for the GPE without trying to
+ * setup implicit wake notification for it (since there's no handler method).
+ *
+ ******************************************************************************/
+acpi_status acpi_mark_gpe_for_wake(acpi_handle gpe_device, u32 gpe_number)
+{
+	struct acpi_gpe_event_info *gpe_event_info;
+	acpi_status status = AE_BAD_PARAMETER;
+	acpi_cpu_flags flags;
+
+	ACPI_FUNCTION_TRACE(acpi_mark_gpe_for_wake);
+
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+
+	/* Ensure that we have a valid GPE number */
+
+	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
+	if (gpe_event_info) {
+
+		/* Mark the GPE as a possible wake event */
+
+		gpe_event_info->flags |= ACPI_GPE_CAN_WAKE;
+		status = AE_OK;
+	}
+
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	return_ACPI_STATUS(status);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_mark_gpe_for_wake)
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_setup_gpe_for_wake
  *
  * PARAMETERS:  wake_device         - Device associated with the GPE (via _PRW)
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 854dd01..c3f38bc 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -673,6 +673,10 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 						u32 gpe_number))
 
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
+				acpi_mark_gpe_for_wake(acpi_handle gpe_device,
+						       u32 gpe_number))
+
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_setup_gpe_for_wake(acpi_handle
 							parent_device,
 							acpi_handle gpe_device,
-- 
1.7.10

