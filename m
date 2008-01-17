From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/4] ACPI: flush kacpi_notify_wq before removing notify
	handler
Date: Thu, 17 Jan 2008 09:19:30 +0800
Message-ID: <1200532770.2935.67.camel@acpi-sony.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:15339 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335AbYAQBOJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jan 2008 20:14:09 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, astarikovskiy@suse.de

From: Zhang Rui <rui.zhang@intel.com>

Flush kacpi_notify_wq before notify handler is removed.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/osl.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/drivers/acpi/osl.c
===================================================================
--- linux-2.6.orig/drivers/acpi/osl.c
+++ linux-2.6/drivers/acpi/osl.c
@@ -707,6 +707,7 @@ EXPORT_SYMBOL(acpi_os_execute);
 void acpi_os_wait_events_complete(void *context)
 {
 	flush_workqueue(kacpid_wq);
+	flush_workqueue(kacpi_notify_wq);
 }
 
 EXPORT_SYMBOL(acpi_os_wait_events_complete);


