From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/34] ACPI: processor: change acpi_processor_eval_pdc interface
Date: Thu, 24 Dec 2009 01:23:45 -0500
Message-ID: <fa118564ed66f785f957d8230745b62e9244700d.1261635793.git.len.brown@intel.com>
References: <1261635845-18306-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37630 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738AbZLXTbJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 14:31:09 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KV600GDH8VGSH71@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 24 Dec 2009 13:30:58 -0600 (CST)
In-reply-to: <1261635845-18306-1-git-send-email-lenb@kernel.org>
In-reply-to: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
References: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alex Chiang <achiang@hp.com>, Len Brown <len.brown@intel.com>

From: Alex Chiang <achiang@hp.com>

acpi_processor_eval_pdc() really only needs a handle and an
acpi_object_list * to do its work.

No need to pass in a struct acpi_processor *, so let's be more specific
about what we want.

Signed-off-by: Alex Chiang <achiang@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_pdc.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index 23d2828..974de4e 100644
--- a/drivers/acpi/processor_pdc.c
+++ b/drivers/acpi/processor_pdc.c
@@ -97,13 +97,11 @@ static struct acpi_object_list *acpi_processor_alloc_pdc(void)
  * _PDC is required for a BIOS-OS handshake for most of the newer
  * ACPI processor features.
  */
-static int acpi_processor_eval_pdc(struct acpi_processor *pr)
+static int
+acpi_processor_eval_pdc(acpi_handle handle, struct acpi_object_list *pdc_in)
 {
-	struct acpi_object_list *pdc_in = pr->pdc;
 	acpi_status status = AE_OK;
 
-	if (!pdc_in)
-		return status;
 	if (idle_nomwait) {
 		/*
 		 * If mwait is disabled for CPU C-states, the C2C3_FFH access
@@ -118,7 +116,7 @@ static int acpi_processor_eval_pdc(struct acpi_processor *pr)
 		buffer[2] &= ~(ACPI_PDC_C_C2C3_FFH | ACPI_PDC_C_C1_FFH);
 
 	}
-	status = acpi_evaluate_object(pr->handle, "_PDC", pdc_in, NULL);
+	status = acpi_evaluate_object(handle, "_PDC", pdc_in, NULL);
 
 	if (ACPI_FAILURE(status))
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
@@ -148,9 +146,7 @@ void acpi_processor_set_pdc(struct acpi_processor *pr)
 	if (!obj_list)
 		return;
 
-	pr->pdc = obj_list;
-
-	acpi_processor_eval_pdc(pr);
+	acpi_processor_eval_pdc(pr->handle, obj_list);
 	acpi_processor_cleanup_pdc(pr);
 }
 EXPORT_SYMBOL_GPL(acpi_processor_set_pdc);
-- 
1.6.0.6

