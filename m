From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/10] ACPI: processor: only evaluate _PDC once per processor
Date: Tue, 16 Feb 2010 04:46:02 -0500
Message-ID: <a4932299d03a1c20e58e4cc40a66fb0a048fb3a7.1266313501.git.len.brown@intel.com>
References: <1266313570-6490-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:47289 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756834Ab0BPJqU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2010 04:46:20 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KXX008MKHT2ORT9@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 16 Feb 2010 03:46:16 -0600 (CST)
In-reply-to: <1266313570-6490-1-git-send-email-lenb@kernel.org>
In-reply-to: <0406ad336c066190770cbf350b552d608e43ed09.1266313501.git.len.brown@intel.com>
References: <0406ad336c066190770cbf350b552d608e43ed09.1266313501.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alex Chiang <achiang@hp.com>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>

From: Alex Chiang <achiang@hp.com>

If we evaluate _PDC in the early path, we do not want to evaluate
it again when the processor driver is loaded.

Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Alex Chiang <achiang@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_pdc.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index 3bbafe9..e306ba9 100644
--- a/drivers/acpi/processor_pdc.c
+++ b/drivers/acpi/processor_pdc.c
@@ -125,6 +125,8 @@ acpi_processor_eval_pdc(acpi_handle handle, struct acpi_object_list *pdc_in)
 	return status;
 }
 
+static int early_pdc_done;
+
 void acpi_processor_set_pdc(acpi_handle handle)
 {
 	struct acpi_object_list *obj_list;
@@ -132,6 +134,9 @@ void acpi_processor_set_pdc(acpi_handle handle)
 	if (arch_has_acpi_pdc() == false)
 		return;
 
+	if (early_pdc_done)
+		return;
+
 	obj_list = acpi_processor_alloc_pdc();
 	if (!obj_list)
 		return;
@@ -199,4 +204,6 @@ void __init acpi_early_processor_set_pdc(void)
 	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
 			    ACPI_UINT32_MAX,
 			    early_init_pdc, NULL, NULL, NULL);
+
+	early_pdc_done = 1;
 }
-- 
1.6.0.6

