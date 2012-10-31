From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 20/26] ACPICA: Update support for ACPI 5 MPST table
Date: Wed, 31 Oct 2012 10:27:56 +0800
Message-ID: <3b8ac09363395c18a5a24a4962bc794e48c5442d.1351649951.git.lv.zheng@intel.com>
References: <cover.1351649949.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:39918 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932324Ab2JaC2C (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2012 22:28:02 -0400
In-Reply-To: <cover.1351649949.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixes some problems introduced by late changes to the table as it
was added to the ACPI 5.0 specification.  Both the table compiler
and the disassembler and the main header support for the table.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actbl3.h |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 8c61b5f..6585141 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -277,10 +277,10 @@ struct acpi_table_gtdt {
  ******************************************************************************/
 
 #define ACPI_MPST_CHANNEL_INFO \
-	u16                             reserved1; \
 	u8                              channel_id; \
-	u8                              reserved2; \
-	u16                             power_node_count;
+	u8                              reserved1[3]; \
+	u16                             power_node_count; \
+	u16                             reserved2;
 
 /* Main table */
 
@@ -304,9 +304,8 @@ struct acpi_mpst_power_node {
 	u32 length;
 	u64 range_address;
 	u64 range_length;
-	u8 num_power_states;
-	u8 num_physical_components;
-	u16 reserved2;
+	u32 num_power_states;
+	u32 num_physical_components;
 };
 
 /* Values for Flags field above */
@@ -332,10 +331,11 @@ struct acpi_mpst_component {
 
 struct acpi_mpst_data_hdr {
 	u16 characteristics_count;
+	u16 reserved;
 };
 
 struct acpi_mpst_power_data {
-	u8 revision;
+	u8 structure_id;
 	u8 flags;
 	u16 reserved1;
 	u32 average_power;
@@ -356,10 +356,10 @@ struct acpi_mpst_shared {
 	u32 signature;
 	u16 pcc_command;
 	u16 pcc_status;
-	u16 command_register;
-	u16 status_register;
-	u16 power_state_id;
-	u16 power_node_id;
+	u32 command_register;
+	u32 status_register;
+	u32 power_state_id;
+	u32 power_node_id;
 	u64 energy_consumed;
 	u64 average_power;
 };
-- 
1.7.10

