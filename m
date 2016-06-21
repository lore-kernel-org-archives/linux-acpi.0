From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v4 5/5] ACPI 2.0 / AML: Fix module level execution by correctly parsing table as TermList
Date: Tue, 21 Jun 2016 12:34:52 +0800
Message-ID: <a04c5125d1f97ea07e903b136775a28a0f97933e.1466479787.git.lv.zheng@intel.com>
References: <0e65135af51d94db0410c7059f3bc3a2300fc3b5> <cover.1466479787.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:9245 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753514AbcFUEfI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Jun 2016 00:35:08 -0400
In-Reply-To: <cover.1466479787.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This experiment follows de-facto standard behavior, parsing entire
table as a single TermList, so that all module level executions are
possible during the table loading.

If regressions are found against the enabling of this experimental fix,
this patch is the only one that should get bisected out. Please report
the regressions to the kernel bugzilla for further root causing.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acpixf.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 22b0397..e21bdd1 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -196,9 +196,9 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_group_module_level_code, FALSE);
 
 /*
  * Optionally support module level code by parsing the entire table as
- * a term_list. Default is FALSE, do not execute entire table.
+ * a term_list. Default is TRUE, do execute entire table.
  */
-ACPI_INIT_GLOBAL(u8, acpi_gbl_parse_table_as_term_list, FALSE);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_parse_table_as_term_list, TRUE);
 
 /*
  * Optionally use 32-bit FADT addresses if and when there is a conflict
-- 
1.7.10

