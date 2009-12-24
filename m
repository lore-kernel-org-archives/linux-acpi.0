From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/34] ACPI: processor: open code acpi_processor_cleanup_pdc
Date: Thu, 24 Dec 2009 01:23:46 -0500
Message-ID: <b9c2db783456bcbce31e2482214cd337528db295.1261635793.git.len.brown@intel.com>
References: <1261635845-18306-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37630 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193AbZLXTbJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 14:31:09 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KV600GDH8VGSH71@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 24 Dec 2009 13:30:57 -0600 (CST)
In-reply-to: <1261635845-18306-1-git-send-email-lenb@kernel.org>
In-reply-to: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
References: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alex Chiang <achiang@hp.com>, Len Brown <len.brown@intel.com>

From: Alex Chiang <achiang@hp.com>

We have the acpi_object_list * right there in acpi_processor_set_pdc()
so it doesn't seem necessary for an entire helper function just to
free it.

Signed-off-by: Alex Chiang <achiang@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_pdc.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index 974de4e..deeba22 100644
--- a/drivers/acpi/processor_pdc.c
+++ b/drivers/acpi/processor_pdc.c
@@ -125,16 +125,6 @@ acpi_processor_eval_pdc(acpi_handle handle, struct acpi_object_list *pdc_in)
 	return status;
 }
 
-static void acpi_processor_cleanup_pdc(struct acpi_processor *pr)
-{
-	if (pr->pdc) {
-		kfree(pr->pdc->pointer->buffer.pointer);
-		kfree(pr->pdc->pointer);
-		kfree(pr->pdc);
-		pr->pdc = NULL;
-	}
-}
-
 void acpi_processor_set_pdc(struct acpi_processor *pr)
 {
 	struct acpi_object_list *obj_list;
@@ -147,7 +137,10 @@ void acpi_processor_set_pdc(struct acpi_processor *pr)
 		return;
 
 	acpi_processor_eval_pdc(pr->handle, obj_list);
-	acpi_processor_cleanup_pdc(pr);
+
+	kfree(obj_list->pointer->buffer.pointer);
+	kfree(obj_list->pointer);
+	kfree(obj_list);
 }
 EXPORT_SYMBOL_GPL(acpi_processor_set_pdc);
 
-- 
1.6.0.6

