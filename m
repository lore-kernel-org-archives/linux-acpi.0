From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/18] ACPICA: Fix to allow region arguments to reference other
 scopes
Date: Sun, 11 Dec 2011 12:45:33 -0500
Message-ID: <f2b19261fb47d2512eb5b8ddfc6d2c410d3cb598.1323625426.git.len.brown@intel.com>
References: <1323625549-10775-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:58987 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964Ab1LKRqN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Dec 2011 12:46:13 -0500
Received: from localhost.localdomain ([unknown] [74.104.158.190])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LW100A7EW0KUPD4@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 11 Dec 2011 11:46:02 -0600 (CST)
In-reply-to: <1323625549-10775-1-git-send-email-lenb@kernel.org>
In-reply-to: <d40ba5ad56e98f9ff96c110a0fd4e8382b82229d.1323625426.git.len.brown@intel.com>
References: <d40ba5ad56e98f9ff96c110a0fd4e8382b82229d.1323625426.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

Allow referenced objects to be in a different scope.

http://www.acpica.org/bugzilla/show_bug.cgi?id=937
http://marc.info/?l=linux-acpi&m=131636632718222&w=2

ACPI Error: [RAMB] Namespace lookup failure, AE_NOT_FOUND (20110112/psargs-359)
ACPI Exception: AE_NOT_FOUND, Could not execute arguments for [RAMW] (Region) (20110112/nsinit-349)

    Scope (_SB)
    {
        Name (RAMB, 0xDF5A1018)
        OperationRegion (\RAMW, SystemMemory, RAMB, 0x00010000)
    }

For above ASL code, we need to save scope node(\_SB) to lookup
the argument node(\_SB.RAMB).

Reported-by: Jim Green <student.northwestern@gmail.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acobject.h |    1 +
 drivers/acpi/acpica/dsargs.c   |    2 +-
 drivers/acpi/acpica/excreate.c |    6 ++++++
 3 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index 1055769..6d276c2 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -358,6 +358,7 @@ typedef enum {
  */
 struct acpi_object_extra {
 	ACPI_OBJECT_COMMON_HEADER struct acpi_namespace_node *method_REG;	/* _REG method for this region (if any) */
+	struct acpi_namespace_node *scope_node;
 	void *region_context;	/* Region-specific data */
 	u8 *aml_start;
 	u32 aml_length;
diff --git a/drivers/acpi/acpica/dsargs.c b/drivers/acpi/acpica/dsargs.c
index 8c7b997..634f5b2 100644
--- a/drivers/acpi/acpica/dsargs.c
+++ b/drivers/acpi/acpica/dsargs.c
@@ -384,7 +384,7 @@ acpi_status acpi_ds_get_region_arguments(union acpi_operand_object *obj_desc)
 
 	/* Execute the argument AML */
 
-	status = acpi_ds_execute_arguments(node, node->parent,
+	status = acpi_ds_execute_arguments(node, extra_desc->extra.scope_node,
 					   extra_desc->extra.aml_length,
 					   extra_desc->extra.aml_start);
 	return_ACPI_STATUS(status);
diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/excreate.c
index 110711a..8a06dc5 100644
--- a/drivers/acpi/acpica/excreate.c
+++ b/drivers/acpi/acpica/excreate.c
@@ -330,6 +330,12 @@ acpi_ex_create_region(u8 * aml_start,
 	region_obj2 = obj_desc->common.next_object;
 	region_obj2->extra.aml_start = aml_start;
 	region_obj2->extra.aml_length = aml_length;
+	if (walk_state->scope_info) {
+		region_obj2->extra.scope_node =
+		    walk_state->scope_info->scope.node;
+	} else {
+		region_obj2->extra.scope_node = node;
+	}
 
 	/* Init the region from the operands */
 
-- 
1.7.7.rc0.72.g4b5ea

