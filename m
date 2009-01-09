From: Len Brown <lenb@kernel.org>
Subject: [PATCH 69/94] ACPI: sony-laptop.c: call acpi_get_object_info to get
 node info
Date: Fri, 09 Jan 2009 04:27:11 -0500
Message-ID: <30823736162ff91512965e3c730557e34fa71d6d.1231492611.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:56614 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463AbZAIKR6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 05:17:58 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700LXC8LRL4S7@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 04:17:58 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

Avoid using internal acpica structures acpi_namespace_node and acpi_operand_object
Call acpi_get_object_info to get node ascii name and method arg count

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/sony-laptop.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 571b211..537959d 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -935,14 +935,17 @@ static void sony_acpi_notify(acpi_handle handle, u32 event, void *data)
 static acpi_status sony_walk_callback(acpi_handle handle, u32 level,
 				      void *context, void **return_value)
 {
-	struct acpi_namespace_node *node;
-	union acpi_operand_object *operand;
+	struct acpi_device_info *info;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
 
-	node = (struct acpi_namespace_node *)handle;
-	operand = (union acpi_operand_object *)node->object;
+	if (ACPI_SUCCESS(acpi_get_object_info(handle, &buffer))) {
+		info = buffer.pointer;
 
-	printk(KERN_WARNING DRV_PFX "method: name: %4.4s, args %X\n", node->name.ascii,
-	       (u32) operand->method.param_count);
+		printk(KERN_WARNING DRV_PFX "method: name: %4.4s, args %X\n",
+			(char *)&info->name, info->param_count);
+
+		kfree(buffer.pointer);
+	}
 
 	return AE_OK;
 }
-- 
1.5.6.6

