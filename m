From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 20/53] ACPICA: Add support for new PCCT subtables
Date: Mon,  5 Jun 2017 16:39:08 +0800
Message-ID: <eacfc2cde0f4d649050e2f378d789e1d63ac977e.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:25640 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751449AbdFEIjL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:39:11 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, Bob Moore <robert.moore@intel.com>

From: "David E. Box" <david.e.box@linux.intel.com>

ACPICA commit e7b817e3c405a4fb9ae9ee7ae4992b8c1f20d284

Extended PCC Subspaces (types 3 and 4)

Link: https://github.com/acpica/acpica/commit/e7b817e3
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/mailbox/pcc.c | 10 +++----
 include/acpi/actbl3.h | 77 +++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 77 insertions(+), 10 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index dd9ecd35..ac91fd0 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -203,7 +203,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
 		struct acpi_pcct_hw_reduced_type2 *pcct2_ss = chan->con_priv;
 		u32 id = chan - pcc_mbox_channels;
 
-		doorbell_ack = &pcct2_ss->doorbell_ack_register;
+		doorbell_ack = &pcct2_ss->platform_ack_register;
 		doorbell_ack_preserve = pcct2_ss->ack_preserve_mask;
 		doorbell_ack_write = pcct2_ss->ack_write_mask;
 
@@ -416,11 +416,11 @@ static int parse_pcc_subspace(struct acpi_subtable_header *header,
 static int pcc_parse_subspace_irq(int id,
 				  struct acpi_pcct_hw_reduced *pcct_ss)
 {
-	pcc_doorbell_irq[id] = pcc_map_interrupt(pcct_ss->doorbell_interrupt,
+	pcc_doorbell_irq[id] = pcc_map_interrupt(pcct_ss->platform_interrupt,
 						 (u32)pcct_ss->flags);
 	if (pcc_doorbell_irq[id] <= 0) {
 		pr_err("PCC GSI %d not registered\n",
-		       pcct_ss->doorbell_interrupt);
+		       pcct_ss->platform_interrupt);
 		return -EINVAL;
 	}
 
@@ -429,8 +429,8 @@ static int pcc_parse_subspace_irq(int id,
 		struct acpi_pcct_hw_reduced_type2 *pcct2_ss = (void *)pcct_ss;
 
 		pcc_doorbell_ack_vaddr[id] = acpi_os_ioremap(
-				pcct2_ss->doorbell_ack_register.address,
-				pcct2_ss->doorbell_ack_register.bit_width / 8);
+				pcct2_ss->platform_ack_register.address,
+				pcct2_ss->platform_ack_register.bit_width / 8);
 		if (!pcc_doorbell_ack_vaddr[id]) {
 			pr_err("Failed to ioremap PCC ACK register\n");
 			return -ENOMEM;
diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index dc6de4e..5bde2e7 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -467,7 +467,7 @@ struct acpi_mpst_shared {
 /*******************************************************************************
  *
  * PCCT - Platform Communications Channel Table (ACPI 5.0)
- *        Version 1
+ *        Version 2 (ACPI 6.2)
  *
  ******************************************************************************/
 
@@ -487,7 +487,9 @@ enum acpi_pcct_type {
 	ACPI_PCCT_TYPE_GENERIC_SUBSPACE = 0,
 	ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE = 1,
 	ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2 = 2,	/* ACPI 6.1 */
-	ACPI_PCCT_TYPE_RESERVED = 3	/* 3 and greater are reserved */
+	ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE = 3,	/* ACPI 6.2 */
+	ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE = 4,	/* ACPI 6.2 */
+	ACPI_PCCT_TYPE_RESERVED = 5	/* 5 and greater are reserved */
 };
 
 /*
@@ -513,7 +515,7 @@ struct acpi_pcct_subspace {
 
 struct acpi_pcct_hw_reduced {
 	struct acpi_subtable_header header;
-	u32 doorbell_interrupt;
+	u32 platform_interrupt;
 	u8 flags;
 	u8 reserved;
 	u64 base_address;
@@ -530,7 +532,7 @@ struct acpi_pcct_hw_reduced {
 
 struct acpi_pcct_hw_reduced_type2 {
 	struct acpi_subtable_header header;
-	u32 doorbell_interrupt;
+	u32 platform_interrupt;
 	u8 flags;
 	u8 reserved;
 	u64 base_address;
@@ -541,11 +543,67 @@ struct acpi_pcct_hw_reduced_type2 {
 	u32 latency;
 	u32 max_access_rate;
 	u16 min_turnaround_time;
-	struct acpi_generic_address doorbell_ack_register;
+	struct acpi_generic_address platform_ack_register;
 	u64 ack_preserve_mask;
 	u64 ack_write_mask;
 };
 
+/* 3: Extended PCC Master Subspace Type 3 (ACPI 6.2) */
+
+struct acpi_pcct_ext_pcc_master {
+	struct acpi_subtable_header header;
+	u32 platform_interrupt;
+	u8 flags;
+	u8 reserved1;
+	u64 base_address;
+	u32 length;
+	struct acpi_generic_address doorbell_register;
+	u64 preserve_mask;
+	u64 write_mask;
+	u32 latency;
+	u32 max_access_rate;
+	u32 min_turnaround_time;
+	struct acpi_generic_address platform_ack_register;
+	u64 ack_preserve_mask;
+	u64 ack_set_mask;
+	u64 reserved2;
+	struct acpi_generic_address cmd_complete_register;
+	u64 cmd_complete_mask;
+	struct acpi_generic_address cmd_update_register;
+	u64 cmd_update_preserve_mask;
+	u64 cmd_update_set_mask;
+	struct acpi_generic_address error_status_register;
+	u64 error_status_mask;
+};
+
+/* 4: Extended PCC Slave Subspace Type 4 (ACPI 6.2) */
+
+struct acpi_pcct_ext_pcc_slave {
+	struct acpi_subtable_header header;
+	u32 platform_interrupt;
+	u8 flags;
+	u8 reserved1;
+	u64 base_address;
+	u32 length;
+	struct acpi_generic_address doorbell_register;
+	u64 preserve_mask;
+	u64 write_mask;
+	u32 latency;
+	u32 max_access_rate;
+	u32 min_turnaround_time;
+	struct acpi_generic_address platform_ack_register;
+	u64 ack_preserve_mask;
+	u64 ack_set_mask;
+	u64 reserved2;
+	struct acpi_generic_address cmd_complete_register;
+	u64 cmd_complete_mask;
+	struct acpi_generic_address cmd_update_register;
+	u64 cmd_update_preserve_mask;
+	u64 cmd_update_set_mask;
+	struct acpi_generic_address error_status_register;
+	u64 error_status_mask;
+};
+
 /* Values for doorbell flags above */
 
 #define ACPI_PCCT_INTERRUPT_POLARITY    (1)
@@ -563,6 +621,15 @@ struct acpi_pcct_shared_memory {
 	u16 status;
 };
 
+/* Extended PCC Subspace Shared Memory Region (ACPI 6.2) */
+
+struct acpi_pcct_ext_pcc_shared_memory {
+	u32 signature;
+	u32 flags;
+	u32 length;
+	u32 command;
+};
+
 /*******************************************************************************
  *
  * PMTT - Platform Memory Topology Table (ACPI 5.0)
-- 
2.7.4

