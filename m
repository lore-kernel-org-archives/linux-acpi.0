From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH V4 3/5] mailbox: pcc: optimized pcc_send_data
Date: Wed, 17 Feb 2016 13:21:01 -0700
Message-ID: <1455740463-19192-4-git-send-email-pprakash@codeaurora.org>
References: <1455740463-19192-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53074 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965451AbcBQUV0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Feb 2016 15:21:26 -0500
In-Reply-To: <1455740463-19192-1-git-send-email-pprakash@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: ashwin.chaugule@linaro.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, alexey.klimov@arm.com, Prashanth Prakash <pprakash@codeaurora.org>

pcc_send_data can be invoked during the execution of performance
critical code as in cppc_cpufreq driver. With acpi_* APIs, the
doorbell register accessed in pcc_send_data if present in system
memory will be searched (in cached virt to phys addr mapping),
mapped, read/written and then unmapped. These operations take
significant amount of time.

This patch maps the performance critical doorbell register
during init and then reads/writes to it directly using the
mapped virtual address. This patch + similar changes to CPPC
acpi driver reduce the time per freq. transition from around
200us to about 20us for cppc cpufreq driver

Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
Acked-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/mailbox/pcc.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 104 insertions(+), 7 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 8f779a1..0ddf638 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -63,6 +63,7 @@
 #include <linux/platform_device.h>
 #include <linux/mailbox_controller.h>
 #include <linux/mailbox_client.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 #include "mailbox.h"
 
@@ -70,6 +71,9 @@
 
 static struct mbox_chan *pcc_mbox_channels;
 
+/* Array of cached virtual address for doorbell registers */
+static void __iomem **pcc_doorbell_vaddr;
+
 static struct mbox_controller pcc_mbox_ctrl = {};
 /**
  * get_pcc_channel - Given a PCC subspace idx, get
@@ -160,6 +164,66 @@ void pcc_mbox_free_channel(struct mbox_chan *chan)
 }
 EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
 
+/*
+ * PCC can be used with perf critical drivers such as CPPC
+ * So it makes sense to locally cache the virtual address and
+ * use it to read/write to PCC registers such as doorbell register
+ *
+ * The below read_register and write_registers are used to read and
+ * write from perf critical registers such as PCC doorbell register
+ */
+static int read_register(void __iomem *vaddr, u64 *val, unsigned int bit_width)
+{
+	int ret_val = 0;
+
+	switch (bit_width) {
+	case 8:
+		*val = readb(vaddr);
+		break;
+	case 16:
+		*val = readw(vaddr);
+		break;
+	case 32:
+		*val = readl(vaddr);
+		break;
+	case 64:
+		*val = readq(vaddr);
+		break;
+	default:
+		pr_debug("Error: Cannot read register of %u bit width",
+			bit_width);
+		ret_val = -EFAULT;
+		break;
+	}
+	return ret_val;
+}
+
+static int write_register(void __iomem *vaddr, u64 val, unsigned int bit_width)
+{
+	int ret_val = 0;
+
+	switch (bit_width) {
+	case 8:
+		writeb(val, vaddr);
+		break;
+	case 16:
+		writew(val, vaddr);
+		break;
+	case 32:
+		writel(val, vaddr);
+		break;
+	case 64:
+		writeq(val, vaddr);
+		break;
+	default:
+		pr_debug("Error: Cannot write register of %u bit width",
+			bit_width);
+		ret_val = -EFAULT;
+		break;
+	}
+	return ret_val;
+}
+
 /**
  * pcc_send_data - Called from Mailbox Controller code. Used
  *		here only to ring the channel doorbell. The PCC client
@@ -175,21 +239,39 @@ EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
 static int pcc_send_data(struct mbox_chan *chan, void *data)
 {
 	struct acpi_pcct_hw_reduced *pcct_ss = chan->con_priv;
-	struct acpi_generic_address doorbell;
+	struct acpi_generic_address *doorbell;
 	u64 doorbell_preserve;
 	u64 doorbell_val;
 	u64 doorbell_write;
+	u32 id = chan - pcc_mbox_channels;
+	int ret = 0;
+
+	if (id >= pcc_mbox_ctrl.num_chans) {
+		pr_debug("pcc_send_data: Invalid mbox_chan passed\n");
+		return -ENOENT;
+	}
 
-	doorbell = pcct_ss->doorbell_register;
+	doorbell = &pcct_ss->doorbell_register;
 	doorbell_preserve = pcct_ss->preserve_mask;
 	doorbell_write = pcct_ss->write_mask;
 
 	/* Sync notification from OS to Platform. */
-	acpi_read(&doorbell_val, &doorbell);
-	acpi_write((doorbell_val & doorbell_preserve) | doorbell_write,
-			&doorbell);
-
-	return 0;
+	if (pcc_doorbell_vaddr[id]) {
+		ret = read_register(pcc_doorbell_vaddr[id], &doorbell_val,
+			doorbell->bit_width);
+		if (ret)
+			return ret;
+		ret = write_register(pcc_doorbell_vaddr[id],
+			(doorbell_val & doorbell_preserve) | doorbell_write,
+			doorbell->bit_width);
+	} else {
+		ret = acpi_read(&doorbell_val, doorbell);
+		if (ret)
+			return ret;
+		ret = acpi_write((doorbell_val & doorbell_preserve) | doorbell_write,
+			doorbell);
+	}
+	return ret;
 }
 
 static const struct mbox_chan_ops pcc_chan_ops = {
@@ -265,14 +347,29 @@ static int __init acpi_pcc_probe(void)
 		return -ENOMEM;
 	}
 
+	pcc_doorbell_vaddr = kcalloc(count, sizeof(void *), GFP_KERNEL);
+	if (!pcc_doorbell_vaddr) {
+		kfree(pcc_mbox_channels);
+		return -ENOMEM;
+	}
+
 	/* Point to the first PCC subspace entry */
 	pcct_entry = (struct acpi_subtable_header *) (
 		(unsigned long) pcct_tbl + sizeof(struct acpi_table_pcct));
 
 	for (i = 0; i < count; i++) {
+		struct acpi_generic_address *db_reg;
+		struct acpi_pcct_hw_reduced *pcct_ss;
 		pcc_mbox_channels[i].con_priv = pcct_entry;
 		pcct_entry = (struct acpi_subtable_header *)
 			((unsigned long) pcct_entry + pcct_entry->length);
+
+		/* If doorbell is in system memory cache the virt address */
+		pcct_ss = (struct acpi_pcct_hw_reduced *)pcct_entry;
+		db_reg = &pcct_ss->doorbell_register;
+		if (db_reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
+			pcc_doorbell_vaddr[i] = acpi_os_ioremap(db_reg->address,
+							db_reg->bit_width/8);
 	}
 
 	pcc_mbox_ctrl.num_chans = count;
-- 
Qualcomm Technologies, Inc. on behalf
of the Qualcomm Innovation Center, Inc.  The Qualcomm Innovation Center, Inc. 
is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

