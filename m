From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/34] ACPI: processor: change acpi_processor_set_pdc()
 interface
Date: Thu, 24 Dec 2009 01:23:47 -0500
Message-ID: <43bab25ced218385f7e6a076c2459ea008cfd2e1.1261635793.git.len.brown@intel.com>
References: <1261635845-18306-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37630 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755205AbZLXTbT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 14:31:19 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KV600GDH8VGSH71@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 24 Dec 2009 13:31:01 -0600 (CST)
In-reply-to: <1261635845-18306-1-git-send-email-lenb@kernel.org>
In-reply-to: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
References: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alex Chiang <achiang@hp.com>, Len Brown <len.brown@intel.com>

From: Alex Chiang <achiang@hp.com>

When calling _PDC, we really only need the handle to the processor
to call the method; we don't look at any other parts of the
struct acpi_processor * given to us.

In the early path, when we walk the namespace, we are given the
handle directly, so just pass it through to acpi_processor_set_pdc()
without stuffing it into a wasteful struct acpi_processor allocated
on the stack each time

This saves 2834 bytes of stack.

Update the interface accordingly.

Signed-off-by: Alex Chiang <achiang@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_core.c |    2 +-
 drivers/acpi/processor_pdc.c  |   18 +++---------------
 include/acpi/processor.h      |    2 +-
 3 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index a19a4ff..9863c98 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -763,7 +763,7 @@ static int __cpuinit acpi_processor_add(struct acpi_device *device)
 	}
 
 	/* _PDC call should be done before doing anything else (if reqd.). */
-	acpi_processor_set_pdc(pr);
+	acpi_processor_set_pdc(pr->handle);
 
 #ifdef CONFIG_CPU_FREQ
 	acpi_processor_ppc_has_changed(pr, 0);
diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index deeba22..30e4dc0 100644
--- a/drivers/acpi/processor_pdc.c
+++ b/drivers/acpi/processor_pdc.c
@@ -125,7 +125,7 @@ acpi_processor_eval_pdc(acpi_handle handle, struct acpi_object_list *pdc_in)
 	return status;
 }
 
-void acpi_processor_set_pdc(struct acpi_processor *pr)
+void acpi_processor_set_pdc(acpi_handle handle)
 {
 	struct acpi_object_list *obj_list;
 
@@ -136,7 +136,7 @@ void acpi_processor_set_pdc(struct acpi_processor *pr)
 	if (!obj_list)
 		return;
 
-	acpi_processor_eval_pdc(pr->handle, obj_list);
+	acpi_processor_eval_pdc(handle, obj_list);
 
 	kfree(obj_list->pointer->buffer.pointer);
 	kfree(obj_list->pointer);
@@ -147,19 +147,7 @@ EXPORT_SYMBOL_GPL(acpi_processor_set_pdc);
 static acpi_status
 early_init_pdc(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
-	struct acpi_processor pr;
-
-	pr.handle = handle;
-
-	/* x86 implementation looks at pr.id to determine some
-	 * CPU capabilites. We can just hard code to 0 since we're
-	 * assuming the CPUs in the system are homogenous and all
-	 * have the same capabilities.
-	 */
-	pr.id = 0;
-
-	acpi_processor_set_pdc(&pr);
-
+	acpi_processor_set_pdc(handle);
 	return AE_OK;
 }
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 0873cd5..7cc433d 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -323,7 +323,7 @@ static inline int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
 #endif				/* CONFIG_CPU_FREQ */
 
 /* in processor_pdc.c */
-void acpi_processor_set_pdc(struct acpi_processor *pr);
+void acpi_processor_set_pdc(acpi_handle handle);
 
 /* in processor_throttling.c */
 int acpi_processor_tstate_has_changed(struct acpi_processor *pr);
-- 
1.6.0.6

