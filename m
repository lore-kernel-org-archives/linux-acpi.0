From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 2/4] ACPICA: Tables: Add mechanism to allow to balance late stage acpi_get_table() independently
Date: Fri, 28 Apr 2017 13:30:20 +0800
Message-ID: <89693a14ceb97e3d1fa7cc098b15c73f5b176863.1493357251.git.lv.zheng@intel.com>
References: <5361b51c7c257b3216475018a3a5cc4f8b6b21c6.1493281247.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:36155 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164568AbdD1Fa1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 28 Apr 2017 01:30:27 -0400
In-Reply-To: <5361b51c7c257b3216475018a3a5cc4f8b6b21c6.1493281247.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>

For all frequent late stage acpi_get_table() clone invocations, we should
only fix them altogether, otherwise, excessive acpi_put_table() could
unexpectedly unmap the table used by the other users. Thus the current plan
is to fix all acpi_get_table() clones together or to fix none of them. This
prevents kernel developers from improving the late stage code quality
without waiting for the ACPICA upstream to improve first.

This patch adds a mechanism to stop decrementing validation count to
prevent the table unmapping operations so that acpi_put_table() balance
fixes can be done independently to each others.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/tbutils.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index 7abe665..b517bd0 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -445,12 +445,18 @@ void acpi_tb_put_table(struct acpi_table_desc *table_desc)
 
 	ACPI_FUNCTION_TRACE(acpi_tb_put_table);
 
-	if (table_desc->validation_count == 0) {
+	if ((table_desc->validation_count + 1) == 0) {
 		ACPI_WARNING((AE_INFO,
-			      "Table %p, Validation count is zero before decrement\n",
+			      "Table %p, Validation count is about to expire, decrement is unsafe\n",
 			      table_desc));
 		return_VOID;
 	}
+	if (table_desc->validation_count == 0) {
+		ACPI_ERROR((AE_INFO,
+			   "Table %p, Validation count is zero before decrement\n",
+			   table_desc));
+		return_VOID;
+	}
 	table_desc->validation_count--;
 
 	if (table_desc->validation_count == 0) {
-- 
2.7.4

