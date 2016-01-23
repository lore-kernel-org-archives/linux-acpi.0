From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH V2 2/4] acpi: cppc: optimized cpc_read and cpc_write
Date: Fri, 22 Jan 2016 18:07:18 -0700
Message-ID: <1453511240-20792-3-git-send-email-pprakash@codeaurora.org>
References: <1453511240-20792-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50665 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754948AbcAWBHk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Jan 2016 20:07:40 -0500
In-Reply-To: <1453511240-20792-1-git-send-email-pprakash@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: ashwin.chaugule@linaro.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Prashanth Prakash <pprakash@codeaurora.org>

cpc_read and cpc_write are used while holding the pcc_lock spin_lock,
so they need to be as fast as possible. acpi_os_read/write_memory
APIs linearly search through a list for cached mapping which is
quite expensive. Since the PCC subspace is already mapped into
virtual address space during initialization, we can just add the
offset and access the necessary CPPC registers.

This patch + similar changes to PCC driver reduce the time per freq.
transition from around 200us to about 20us for cppc cpufreq driver

Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
Acked-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/acpi/cppc_acpi.c | 80 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 64 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 36c3e4d..b85759d 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -67,6 +67,9 @@ static int pcc_subspace_idx = -1;
 static bool pcc_channel_acquired;
 static ktime_t deadline;
 
+/* pcc mapped address + header size + offset within PCC subspace */
+#define GET_PCC_VADDR(offs) (pcc_comm_addr + 0x8 + (offs))
+
 /*
  * Arbitrary Retries in case the remote processor is slow to respond
  * to PCC commands. Keeping it high enough to cover emulators where
@@ -585,29 +588,74 @@ void acpi_cppc_processor_exit(struct acpi_processor *pr)
 }
 EXPORT_SYMBOL_GPL(acpi_cppc_processor_exit);
 
-static u64 get_phys_addr(struct cpc_reg *reg)
-{
-	/* PCC communication addr space begins at byte offset 0x8. */
-	if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM)
-		return (u64)comm_base_addr + 0x8 + reg->address;
-	else
-		return reg->address;
-}
+/*
+ * Since cpc_read and cpc_write are called while holding pcc_lock, it should be
+ * as fast as possible. We have already mapped the PCC subspace during init, so
+ * we can directly write to it.
+ */
 
-static void cpc_read(struct cpc_reg *reg, u64 *val)
+static int cpc_read(struct cpc_reg *reg, u64 *val)
 {
-	u64 addr = get_phys_addr(reg);
+	int ret_val = 0;
+
+	*val = 0;
+	if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
+		void *vaddr = GET_PCC_VADDR(reg->address);
 
-	acpi_os_read_memory((acpi_physical_address)addr,
-			val, reg->bit_width);
+		switch (reg->bit_width) {
+		case 8:
+			*val = readb(vaddr);
+			break;
+		case 16:
+			*val = readw(vaddr);
+			break;
+		case 32:
+			*val = readl(vaddr);
+			break;
+		case 64:
+			*val = readq(vaddr);
+			break;
+		default:
+			pr_debug("Error: Cannot read %u bit width from PCC\n",
+				reg->bit_width);
+			ret_val = -EFAULT;
+		}
+	} else
+		ret_val = acpi_os_read_memory((acpi_physical_address)reg->address,
+					val, reg->bit_width);
+	return ret_val;
 }
 
-static void cpc_write(struct cpc_reg *reg, u64 val)
+static int cpc_write(struct cpc_reg *reg, u64 val)
 {
-	u64 addr = get_phys_addr(reg);
+	int ret_val = 0;
+
+	if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
+		void *vaddr = GET_PCC_VADDR(reg->address);
 
-	acpi_os_write_memory((acpi_physical_address)addr,
-			val, reg->bit_width);
+		switch (reg->bit_width) {
+		case 8:
+			writeb(val, vaddr);
+			break;
+		case 16:
+			writew(val, vaddr);
+			break;
+		case 32:
+			writel(val, vaddr);
+			break;
+		case 64:
+			writeq(val, vaddr);
+			break;
+		default:
+			pr_debug("Error: Cannot write %u bit width to PCC\n",
+				reg->bit_width);
+			ret_val = -EFAULT;
+			break;
+		}
+	} else
+		ret_val = acpi_os_write_memory((acpi_physical_address)reg->address,
+				val, reg->bit_width);
+	return ret_val;
 }
 
 /**
-- 
Qualcomm Technologies, Inc. on behalf
of the Qualcomm Innovation Center, Inc.  The Qualcomm Innovation Center, Inc. 
is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

