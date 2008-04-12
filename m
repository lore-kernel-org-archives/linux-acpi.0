From: Len Brown <lenb@kernel.org>
Subject: [PATCH 53/73] ACPICA: Bulletproof disassembler for bad ACPI tables
Date: Sat, 12 Apr 2008 00:25:36 -0400
Message-ID: <9b2d9dbcf3ae62640951086ed7391c4b4f5e10bc.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:54694 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754331AbYDLE2N (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:13 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixed a problem with the disassembler where invalid ACPI tables
could cause faults or infinite loops.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acdisasm.h |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/acpi/acdisasm.h b/include/acpi/acdisasm.h
index 67d152e..07d5241 100644
--- a/include/acpi/acdisasm.h
+++ b/include/acpi/acdisasm.h
@@ -97,11 +97,12 @@ typedef const struct acpi_dmtable_info {
 #define ACPI_DMT_CHKSUM                 20
 #define ACPI_DMT_SPACEID                21
 #define ACPI_DMT_GAS                    22
-#define ACPI_DMT_DMAR                   23
-#define ACPI_DMT_MADT                   24
-#define ACPI_DMT_SRAT                   25
-#define ACPI_DMT_EXIT                   26
-#define ACPI_DMT_SIG                    27
+#define ACPI_DMT_ASF                    23
+#define ACPI_DMT_DMAR                   24
+#define ACPI_DMT_MADT                   25
+#define ACPI_DMT_SRAT                   26
+#define ACPI_DMT_EXIT                   27
+#define ACPI_DMT_SIG                    28
 
 typedef
 void (*acpi_dmtable_handler) (struct acpi_table_header * table);
@@ -195,7 +196,7 @@ extern struct acpi_dmtable_info acpi_dm_table_info_wdrt[];
  */
 void acpi_dm_dump_data_table(struct acpi_table_header *table);
 
-void
+acpi_status
 acpi_dm_dump_table(u32 table_length,
 		   u32 table_offset,
 		   void *table,
-- 
1.5.5.29.g7134

