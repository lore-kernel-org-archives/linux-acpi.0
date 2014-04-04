From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 16/28] ACPICA: Tables: Fix the issue that table validations are not balanced.
Date: Fri,  4 Apr 2014 12:38:50 +0800
Message-ID: <b5cf1139d52c9088c39650f08c94ac49d6b1dd98.1396581591.git.lv.zheng@intel.com>
References: <cover.1396581591.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:29691 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751990AbaDDEiy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Apr 2014 00:38:54 -0400
In-Reply-To: <cover.1396581591.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

As acpi_tb_validate_table() returns failure on checksum verification without
doing invalidatation, all its invocations that are not done to a descriptor
stored in acpi_gbl_root_table_list are checked and balanced.

But this is not a real issue as the descritors that have been passed to
acpi_tb_add_table() are all virtual address tables and the validations are in
fact no-op.  The cleanup can ensure that any future extensions made on
acpi_tb_add_table() to allow it to be invoked with physical address tables
will not trigger memory leakage regressions.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/tbinstal.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 93a99ef..d3e1db2 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -236,6 +236,7 @@ acpi_tb_add_table(struct acpi_table_desc *table_desc, u32 *table_index)
 	if (!table_desc->pointer) {
 		status = acpi_tb_validate_table(table_desc);
 		if (ACPI_FAILURE(status) || !table_desc->pointer) {
+			acpi_tb_invalidate_table(table_desc);
 			return_ACPI_STATUS(status);
 		}
 	}
-- 
1.7.10

