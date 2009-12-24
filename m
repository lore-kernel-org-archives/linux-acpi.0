From: Len Brown <lenb@kernel.org>
Subject: [PATCH 13/34] ACPI: processor: introduce acpi_processor_alloc_pdc()
Date: Thu, 24 Dec 2009 01:23:44 -0500
Message-ID: <3b407aef573b82139c3bc4dcaad2731fad56c054.1261635793.git.len.brown@intel.com>
References: <1261635845-18306-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37630 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378AbZLXTbS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 14:31:18 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KV600GDH8VGSH71@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 24 Dec 2009 13:30:59 -0600 (CST)
In-reply-to: <1261635845-18306-1-git-send-email-lenb@kernel.org>
In-reply-to: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
References: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alex Chiang <achiang@hp.com>, Len Brown <len.brown@intel.com>

From: Alex Chiang <achiang@hp.com>

acpi_processor_init_pdc() isn't really doing anything interesting
with the struct acpi_processor * parameter. Its real job is to allocate
the buffer for the _PDC bits.

So rename the function to acpi_processor_alloc_pdc(), and just return
the struct acpi_object_list * it's supposed to allocate.

Signed-off-by: Alex Chiang <achiang@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_pdc.c |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index e786e2c..23d2828 100644
--- a/drivers/acpi/processor_pdc.c
+++ b/drivers/acpi/processor_pdc.c
@@ -54,26 +54,24 @@ static void acpi_set_pdc_bits(u32 *buf)
 	arch_acpi_set_pdc_bits(buf);
 }
 
-static void acpi_processor_init_pdc(struct acpi_processor *pr)
+static struct acpi_object_list *acpi_processor_alloc_pdc(void)
 {
 	struct acpi_object_list *obj_list;
 	union acpi_object *obj;
 	u32 *buf;
 
-	pr->pdc = NULL;
-
 	/* allocate and initialize pdc. It will be used later. */
 	obj_list = kmalloc(sizeof(struct acpi_object_list), GFP_KERNEL);
 	if (!obj_list) {
 		printk(KERN_ERR "Memory allocation error\n");
-		return;
+		return NULL;
 	}
 
 	obj = kmalloc(sizeof(union acpi_object), GFP_KERNEL);
 	if (!obj) {
 		printk(KERN_ERR "Memory allocation error\n");
 		kfree(obj_list);
-		return;
+		return NULL;
 	}
 
 	buf = kmalloc(12, GFP_KERNEL);
@@ -81,7 +79,7 @@ static void acpi_processor_init_pdc(struct acpi_processor *pr)
 		printk(KERN_ERR "Memory allocation error\n");
 		kfree(obj);
 		kfree(obj_list);
-		return;
+		return NULL;
 	}
 
 	acpi_set_pdc_bits(buf);
@@ -91,9 +89,8 @@ static void acpi_processor_init_pdc(struct acpi_processor *pr)
 	obj->buffer.pointer = (u8 *) buf;
 	obj_list->count = 1;
 	obj_list->pointer = obj;
-	pr->pdc = obj_list;
 
-	return;
+	return obj_list;
 }
 
 /*
@@ -142,10 +139,17 @@ static void acpi_processor_cleanup_pdc(struct acpi_processor *pr)
 
 void acpi_processor_set_pdc(struct acpi_processor *pr)
 {
+	struct acpi_object_list *obj_list;
+
 	if (arch_has_acpi_pdc() == false)
 		return;
 
-	acpi_processor_init_pdc(pr);
+	obj_list = acpi_processor_alloc_pdc();
+	if (!obj_list)
+		return;
+
+	pr->pdc = obj_list;
+
 	acpi_processor_eval_pdc(pr);
 	acpi_processor_cleanup_pdc(pr);
 }
-- 
1.6.0.6

