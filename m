From: Len Brown <lenb@kernel.org>
Subject: [PATCH 27/65] ACPICA: Invalidate DdbHandle after table unload
Date: Fri, 29 May 2009 21:42:05 -0400
Message-ID: <e0be6f5a9863b626c19f0be04946c6285cc9db56.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:61730 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755657AbZE3Bmv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:42:51 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00J1HORHXEP2@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:54 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

Mark the DdbHandle as invalid after the table it refers to is
unloaded.  This is needed because the handle itself may not be
deleted after the table unload, depending on whether it has been
stored in a named object by the caller.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/exconfig.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index c0348ff..0731fd6 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -91,6 +91,7 @@ acpi_ex_add_table(u32 table_index,
 
 	/* Init the table handle */
 
+	obj_desc->common.flags |= AOPOBJ_DATA_VALID;
 	obj_desc->reference.class = ACPI_REFCLASS_TABLE;
 	*ddb_handle = obj_desc;
 
@@ -501,13 +502,18 @@ acpi_status acpi_ex_unload_table(union acpi_operand_object *ddb_handle)
 
 	/*
 	 * Validate the handle
-	 * Although the handle is partially validated in acpi_ex_reconfiguration(),
+	 * Although the handle is partially validated in acpi_ex_reconfiguration()
 	 * when it calls acpi_ex_resolve_operands(), the handle is more completely
 	 * validated here.
+	 *
+	 * Handle must be a valid operand object of type reference. Also, the
+	 * ddb_handle must still be marked valid (table has not been previously
+	 * unloaded)
 	 */
 	if ((!ddb_handle) ||
 	    (ACPI_GET_DESCRIPTOR_TYPE(ddb_handle) != ACPI_DESC_TYPE_OPERAND) ||
-	    (ddb_handle->common.type != ACPI_TYPE_LOCAL_REFERENCE)) {
+	    (ddb_handle->common.type != ACPI_TYPE_LOCAL_REFERENCE) ||
+	    (!(ddb_handle->common.flags & AOPOBJ_DATA_VALID))) {
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
@@ -515,6 +521,12 @@ acpi_status acpi_ex_unload_table(union acpi_operand_object *ddb_handle)
 
 	table_index = table_desc->reference.value;
 
+	/* Ensure the table is still loaded */
+
+	if (!acpi_tb_is_table_loaded(table_index)) {
+		return_ACPI_STATUS(AE_NOT_EXIST);
+	}
+
 	/* Invoke table handler if present */
 
 	if (acpi_gbl_table_handler) {
@@ -536,5 +548,10 @@ acpi_status acpi_ex_unload_table(union acpi_operand_object *ddb_handle)
 	(void)acpi_tb_release_owner_id(table_index);
 	acpi_tb_set_table_loaded_flag(table_index, FALSE);
 
+	/*
+	 * Invalidate the handle. We do this because the handle may be stored
+	 * in a named object and may not be actually deleted until much later.
+	 */
+	ddb_handle->common.flags &= ~AOPOBJ_DATA_VALID;
 	return_ACPI_STATUS(AE_OK);
 }
-- 
1.6.0.6

