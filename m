From: Lv Zheng <lv.zheng@intel.com>
Subject: [RFC PATCH 3/8] ACPICA: Tables: Fix an issue the dynamic table loading contains code with MTX_TABLES released
Date: Thu, 24 Mar 2016 16:30:42 +0800
Message-ID: <4e12ec88db5571bd07844fae7e1d86c1f224b6a9.1458808078.git.lv.zheng@intel.com>
References: <cover.1458808078.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:23179 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754933AbcCXIay (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Mar 2016 04:30:54 -0400
In-Reply-To: <cover.1458808078.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

Panic can be seen when OS runs _PDC from different CPUs to dynamically
"Load" the tables. And this is because acpi_tb_validate_table() is an
early stage only API and cannot be deployed to the racing environment.
While here we want the table to be transitioned into the "VALIDATED"
state before being transitioned into "LOADED" state, so
acpi_tb_validate_table_by_index() is actually the proper API that should be
invoked here and it properly locks the table descriptor with MTX_TABLES
mutex. Lv Zheng.

Link: https://bugs.acpica.org/show_bug.cgi?id=1254
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/exconfig.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/exconfig.c b/drivers/acpi/acpica/exconfig.c
index 98102af..3418c90 100644
--- a/drivers/acpi/acpica/exconfig.c
+++ b/drivers/acpi/acpica/exconfig.c
@@ -493,10 +493,12 @@ acpi_ex_load_op(union acpi_operand_object *obj_desc,
 	/*
 	 * Note: Now table is "INSTALLED", it must be validated before
 	 * loading.
+	 * As Table pointer has been installed, no code from here will still be
+	 * using the original pointer. Furthermore, the table handler actually
+	 * wants a validation result of the table. So this pointer is refilled
+	 * by the returning value of acpi_tb_validate_table_by_index().
 	 */
-	status =
-	    acpi_tb_validate_table(&acpi_gbl_root_table_list.
-				   tables[table_index]);
+	status = acpi_tb_validate_table_by_index(table_index, &table);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
-- 
1.7.10

