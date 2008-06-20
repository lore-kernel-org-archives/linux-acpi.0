From: Len Brown <lenb@kernel.org>
Subject: [PATCH 36/70] ACPICA: Fixes warning from exconfig.c on 64-bit build.
Date: Fri, 20 Jun 2008 03:43:38 -0400
Message-ID: <b16f32d8b814bdabb45ba34f25e6772990403272.1213947350.git.len.brown@intel.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:38101 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247AbYFTHot (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:44:49 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K2R00DOO46DS3P1@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:44:38 -0500 (CDT)
In-reply-to: <1213947852-10924-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

drivers/acpi/executer/exconfig.c:99: warning: cast to pointer from integer of different size

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exconfig.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/executer/exconfig.c b/drivers/acpi/executer/exconfig.c
index dc62bfe..641ed8e 100644
--- a/drivers/acpi/executer/exconfig.c
+++ b/drivers/acpi/executer/exconfig.c
@@ -96,7 +96,7 @@ acpi_ex_add_table(u32 table_index,
 
 	/* Install the new table into the local data structures */
 
-	obj_desc->reference.object = ACPI_CAST_PTR(void, table_index);
+	obj_desc->reference.object = ACPI_TO_POINTER(table_index);
 
 	/* Add the table to the namespace */
 
@@ -359,6 +359,7 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 
 		ACPI_MEMCPY(table_desc.pointer, obj_desc->buffer.pointer,
 			    length);
+		table_desc.address = ACPI_TO_INTEGER (table_desc.pointer);
 		table_desc.length = length;
 		table_desc.flags = ACPI_TABLE_ORIGIN_ALLOCATED;
 		break;
-- 
1.5.6

