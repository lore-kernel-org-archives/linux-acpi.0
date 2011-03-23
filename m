From: Len Brown <lenb@kernel.org>
Subject: [PATCH 18/42] ACPICA: Remove use of unreliable FADT revision field
Date: Wed, 23 Mar 2011 02:42:31 -0400
Message-ID: <64b3db22c04586997ab4be46dd5a5b99f8a2d390.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:33781 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187Ab1CWIHd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 04:07:33 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LII00IQB3WFAQB4@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 03:07:32 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

The revision number in the FADT has been found to be completely
unreliable and cannot be trusted. Only the table length can be
used to infer the actual version.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/tbfadt.c |    5 ++++-
 include/acpi/actbl.h         |   16 ++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 428d44e..6f5588e 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -384,8 +384,11 @@ static void acpi_tb_convert_fadt(void)
 	 *
 	 * The ACPI 1.0 reserved fields that will be zeroed are the bytes located at
 	 * offset 45, 55, 95, and the word located at offset 109, 110.
+	 *
+	 * Note: The FADT revision value is unreliable. Only the length can be
+	 * trusted.
 	 */
-	if (acpi_gbl_FADT.header.revision < FADT2_REVISION_ID) {
+	if (acpi_gbl_FADT.header.length <= ACPI_FADT_V2_SIZE) {
 		acpi_gbl_FADT.preferred_profile = 0;
 		acpi_gbl_FADT.pstate_control = 0;
 		acpi_gbl_FADT.cst_control = 0;
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index 7e42bfe..d41c948 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -343,4 +343,20 @@ struct acpi_table_desc {
 #include <acpi/actbl1.h>
 #include <acpi/actbl2.h>
 
+/*
+ * Sizes of the various flavors of FADT. We need to look closely
+ * at the FADT length because the version number essentially tells
+ * us nothing because of many BIOS bugs where the version does not
+ * match the expected length. In other words, the length of the
+ * FADT is the bottom line as to what the version really is.
+ *
+ * For reference, the values below are as follows:
+ *     FADT V1  size: 0x74
+ *     FADT V2  size: 0x84
+ *     FADT V3+ size: 0xF4
+ */
+#define ACPI_FADT_V1_SIZE       (u32) (ACPI_FADT_OFFSET (flags) + 4)
+#define ACPI_FADT_V2_SIZE       (u32) (ACPI_FADT_OFFSET (reserved4[0]) + 3)
+#define ACPI_FADT_V3_SIZE       (u32) (sizeof (struct acpi_table_fadt))
+
 #endif				/* __ACTBL_H__ */
-- 
1.7.4.1.343.ga91df

