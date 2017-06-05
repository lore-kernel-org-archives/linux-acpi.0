From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 18/53] ACPICA: disassembler: improve Switch support
Date: Mon,  5 Jun 2017 16:38:53 +0800
Message-ID: <b9b4e0368e9663d28ccc0aa70939e46fe9a9a3e2.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:32933 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751449AbdFEIi4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:38:56 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, Bob Moore <robert.moore@intel.com>

From: "David E. Box" <david.e.box@linux.intel.com>

ACPICA commit 3c36625deffdfb034378b1793e2ead9c8fdd767e

Changes the resource descriptor parse tree walk to a general
preprocessing walk and calls the Switch conversion code from here.
Move Switch code to new dmswitch.c file. Also improves algorithm to
handle multiple levels of Switch statements and perform legacy
disassembly for older or otherwise non-spec compliant Switch
implementations.

Link: https://github.com/acpica/acpica/commit/3c36625d
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acapps.h   | 4 ++--
 drivers/acpi/acpica/acglobal.h | 1 +
 drivers/acpi/acpica/aclocal.h  | 5 +++++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/acapps.h b/drivers/acpi/acpica/acapps.h
index b65f273..bb6a84b 100644
--- a/drivers/acpi/acpica/acapps.h
+++ b/drivers/acpi/acpica/acapps.h
@@ -158,8 +158,8 @@ acpi_dm_finish_namespace_load(union acpi_parse_object *parse_tree_root,
 			      acpi_owner_id owner_id);
 
 void
-acpi_dm_convert_resource_indexes(union acpi_parse_object *parse_tree_root,
-				 struct acpi_namespace_node *namespace_root);
+acpi_dm_convert_parse_objects(union acpi_parse_object *parse_tree_root,
+			      struct acpi_namespace_node *namespace_root);
 
 /*
  * adfile
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index abe8c31..896d548 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -315,6 +315,7 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_force_aml_disassembly, FALSE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_dm_opt_verbose, TRUE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_dm_emit_external_opcodes, FALSE);
 ACPI_INIT_GLOBAL(u8, acpi_gbl_do_disassembler_optimizations, TRUE);
+ACPI_INIT_GLOBAL(ACPI_PARSE_OBJECT_LIST, *acpi_gbl_temp_list_head, NULL);
 
 ACPI_GLOBAL(u8, acpi_gbl_dm_opt_disasm);
 ACPI_GLOBAL(u8, acpi_gbl_dm_opt_listing);
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index cd5016f..f63faa4 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -1182,6 +1182,11 @@ struct acpi_external_file {
 	struct acpi_external_file *next;
 };
 
+struct acpi_parse_object_list {
+	union acpi_parse_object *op;
+	struct acpi_parse_object_list *next;
+};
+
 /*****************************************************************************
  *
  * Debugger
-- 
2.7.4

