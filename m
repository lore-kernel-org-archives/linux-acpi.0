From: Len Brown <lenb@kernel.org>
Subject: [PATCH 26/65] ACPICA: Fix reference count issues for DdbHandle object
Date: Fri, 29 May 2009 21:42:04 -0400
Message-ID: <06366c149232f64c89f513f188ccc6783d0e444f.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:33022 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755898AbZE3Bm6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:42:58 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00BKBORHYE24@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:59 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

Fix a problem where the DdbHandle could be prematurely deleted,
possibly causing a fault.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/exconfig.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 3deb20a..c0348ff 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -229,6 +229,8 @@ acpi_ex_load_table_op(struct acpi_walk_state *walk_state,
 				       walk_state);
 		if (ACPI_FAILURE(status)) {
 			(void)acpi_ex_unload_table(ddb_handle);
+
+			acpi_ut_remove_reference(ddb_handle);
 			return_ACPI_STATUS(status);
 		}
 	}
@@ -454,6 +456,10 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 		return_ACPI_STATUS(status);
 	}
 
+	/* Remove the reference by added by acpi_ex_store above */
+
+	acpi_ut_remove_reference(ddb_handle);
+
 	/* Invoke table handler if present */
 
 	if (acpi_gbl_table_handler) {
@@ -530,8 +536,5 @@ acpi_status acpi_ex_unload_table(union acpi_operand_object *ddb_handle)
 	(void)acpi_tb_release_owner_id(table_index);
 	acpi_tb_set_table_loaded_flag(table_index, FALSE);
 
-	/* Table unloaded, remove a reference to the ddb_handle object */
-
-	acpi_ut_remove_reference(ddb_handle);
 	return_ACPI_STATUS(AE_OK);
 }
-- 
1.6.0.6

