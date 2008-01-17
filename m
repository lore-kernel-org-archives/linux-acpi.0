From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/4] ACPI: introduce new acpi execute type for device
	hotplug
Date: Thu, 17 Jan 2008 09:19:41 +0800
Message-ID: <1200532781.2935.68.camel@acpi-sony.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:17027 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752568AbYAQBOT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jan 2008 20:14:19 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, astarikovskiy@suse.de

From: Zhang Rui <rui.zhang@intel.com>

Introduce new acpi_execute_type OSL_DEVICE_HOTPLUG_HANDLER for device hotplug.
so that we can move the device hotplug notify handler to keventd_wq
and flush kacpi_notify_wq before removing the per-device notify handler.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/osl.c      |   20 ++++++++++++++++++--
 include/acpi/acpiosxf.h |    3 ++-
 2 files changed, 20 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/acpi/osl.c
===================================================================
--- linux-2.6.orig/drivers/acpi/osl.c
+++ linux-2.6/drivers/acpi/osl.c
@@ -684,13 +684,27 @@ acpi_status acpi_os_execute(acpi_execute
 	dpc->function = function;
 	dpc->context = context;
 
-	if (type == OSL_NOTIFY_HANDLER) {
+	switch (type) {
+	case OSL_NOTIFY_HANDLER:
 		INIT_WORK(&dpc->work, acpi_os_execute_notify);
 		if (!queue_work(kacpi_notify_wq, &dpc->work)) {
 			status = AE_ERROR;
 			kfree(dpc);
 		}
-	} else {
+		break;
+	case OSL_DEVICE_HOTPLUG_HANDLER:
+		/*
+		 * execute device hotplug in keventd_wq so that it
+		 * can flush kacpi_notify_wq and kacpid_wq before
+		 * removing the notify handler.
+		 */
+		INIT_WORK(&dpc->work, acpi_os_execute_notify);
+		if (!schedule_work(&dpc->work)) {
+			status = AE_ERROR;
+			kfree(dpc);
+		}
+		break;
+	default:
 		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
 		if (!queue_work(kacpid_wq, &dpc->work)) {
 			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
@@ -698,7 +712,9 @@ acpi_status acpi_os_execute(acpi_execute
 			status = AE_ERROR;
 			kfree(dpc);
 		}
+		break;
 	}
+
 	return_ACPI_STATUS(status);
 }
 
Index: linux-2.6/include/acpi/acpiosxf.h
===================================================================
--- linux-2.6.orig/include/acpi/acpiosxf.h
+++ linux-2.6/include/acpi/acpiosxf.h
@@ -58,7 +58,8 @@ typedef enum {
 	OSL_GPE_HANDLER,
 	OSL_DEBUGGER_THREAD,
 	OSL_EC_POLL_HANDLER,
-	OSL_EC_BURST_HANDLER
+	OSL_EC_BURST_HANDLER,
+	OSL_DEVICE_HOTPLUG_HANDLER
 } acpi_execute_type;
 
 #define ACPI_NO_UNIT_LIMIT          ((u32) -1)


