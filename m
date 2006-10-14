From: Len Brown <len.brown@intel.com>
Subject: [PATCH 23/28] ACPI: fix printk format warnings
Date: Sat, 14 Oct 2006 04:06:04 -0400
Message-ID: <11608131992851-git-send-email-len.brown@intel.com>
References: <11608131691346-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:15632 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1752126AbWJNIDS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Oct 2006 04:03:18 -0400
In-Reply-To: <11608131691346-git-send-email-len.brown@intel.com>
Message-Id: <a790b323fb1b73f9388426bf3b96f153d1c90d2c.1160812999.git.len.brown@intel.com>
In-Reply-To: <288f3ad406460f03642a41bb945826891a7b866f.1160812999.git.len.brown@intel.com>
References: <288f3ad406460f03642a41bb945826891a7b866f.1160812999.git.len.brown@intel.com>
Date: Tue, 10 Oct 2006 14:20:32 -0700
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Randy Dunlap <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>

From: Randy Dunlap <rdunlap@xenotime.net>

Fix printk format warnings in drivers/acpi:
drivers/acpi/tables/tbget.c:326: warning: format '%X' expects type 'unsigned int', but argument 5 has type 'long unsigned int'
drivers/acpi/tables/tbrsdt.c:189: warning: format '%X' expects type 'unsigned int', but argument 5 has type 'long unsigned int'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/tables/tbget.c  |    2 +-
 drivers/acpi/tables/tbrsdt.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/tables/tbget.c b/drivers/acpi/tables/tbget.c
index 7856db7..11e2d44 100644
--- a/drivers/acpi/tables/tbget.c
+++ b/drivers/acpi/tables/tbget.c
@@ -324,7 +324,7 @@ acpi_tb_get_this_table(struct acpi_point
 
 	if (header->length < sizeof(struct acpi_table_header)) {
 		ACPI_ERROR((AE_INFO,
-			    "Table length (%X) is smaller than minimum (%X)",
+			    "Table length (%X) is smaller than minimum (%zX)",
 			    header->length, sizeof(struct acpi_table_header)));
 
 		return_ACPI_STATUS(AE_INVALID_TABLE_LENGTH);
diff --git a/drivers/acpi/tables/tbrsdt.c b/drivers/acpi/tables/tbrsdt.c
index 0ad3dbb..86a5fca 100644
--- a/drivers/acpi/tables/tbrsdt.c
+++ b/drivers/acpi/tables/tbrsdt.c
@@ -187,7 +187,7 @@ acpi_status acpi_tb_validate_rsdt(struct
 
 	if (table_ptr->length < sizeof(struct acpi_table_header)) {
 		ACPI_ERROR((AE_INFO,
-			    "RSDT/XSDT length (%X) is smaller than minimum (%X)",
+			    "RSDT/XSDT length (%X) is smaller than minimum (%zX)",
 			    table_ptr->length,
 			    sizeof(struct acpi_table_header)));
 
-- 
1.4.3.rc2.g23bed-dirty
