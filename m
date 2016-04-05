From: hotran <hotran@apm.com>
Subject: [PATCH] mailbox: pcc: Support HW-Reduced Communication Subspace Type 2
Date: Tue,  5 Apr 2016 15:14:07 -0700
Message-ID: <1459894447-15400-1-git-send-email-hotran@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org
Cc: lho@apm.com, hotran@apm.com, dhdang@apm.com
List-Id: linux-acpi@vger.kernel.org

ACPI 6.1 has a HW-Reduced Communication Subspace Type 2 intended for
use on HW-Reduce ACPI Platform, which requires read-modify-write sequence
to acknowledge doorbell interrupt. This patch provides the implementation
for the Communication Subspace Type 2.

Signed-off-by: Hoan Tran <hotran@apm.com>
---
 drivers/mailbox/pcc.c | 384 +++++++++++++++++++++++++++++++++++++-------------
 include/acpi/actbl3.h |   8 +-
 2 files changed, 294 insertions(+), 98 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 0ddf638..4ed8153 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -59,6 +59,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/platform_device.h>
 #include <linux/mailbox_controller.h>
@@ -68,27 +69,178 @@
 #include "mailbox.h"
 
 #define MAX_PCC_SUBSPACES	256
+#define MBOX_IRQ_NAME		"pcc-mbox"
 
-static struct mbox_chan *pcc_mbox_channels;
+/**
+ * PCC mailbox channel information
+ *
+ * @chan:	Pointer to mailbox communication channel
+ * @pcc_doorbell_vaddr: PCC doorbell register address
+ * @pcc_doorbell_ack_vaddr: PCC doorbell ack register address
+ * @irq:	Interrupt number of the channel
+ */
+struct pcc_mbox_chan {
+	struct mbox_chan	*chan;
+	void __iomem		*pcc_doorbell_vaddr;
+	void __iomem		*pcc_doorbell_ack_vaddr;
+	int			irq;
+};
 
-/* Array of cached virtual address for doorbell registers */
-static void __iomem **pcc_doorbell_vaddr;
+/**
+ * PCC mailbox controller data
+ *
+ * @mb_ctrl:	Representation of the communication channel controller
+ * @mbox_chan:	Array of PCC mailbox channels of the controller
+ * @chans:	Array of mailbox communication channels
+ */
+struct pcc_mbox {
+	struct mbox_controller	mbox_ctrl;
+	struct pcc_mbox_chan	*mbox_chans;
+	struct mbox_chan	*chans;
+};
+
+static struct pcc_mbox pcc_mbox_ctx = {};
 
-static struct mbox_controller pcc_mbox_ctrl = {};
 /**
  * get_pcc_channel - Given a PCC subspace idx, get
- *	the respective mbox_channel.
+ *	the respective pcc mbox_channel.
  * @id: PCC subspace index.
  *
  * Return: ERR_PTR(errno) if error, else pointer
- *	to mbox channel.
+ *	to pcc mbox channel.
  */
-static struct mbox_chan *get_pcc_channel(int id)
+static struct pcc_mbox_chan *get_pcc_channel(int id)
 {
-	if (id < 0 || id > pcc_mbox_ctrl.num_chans)
+	if (id < 0 || id > pcc_mbox_ctx.mbox_ctrl.num_chans)
 		return ERR_PTR(-ENOENT);
 
-	return &pcc_mbox_channels[id];
+	return &pcc_mbox_ctx.mbox_chans[id];
+}
+
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
+/**
+ * pcc_map_interrupt - Map a PCC subspace GSI to a linux IRQ number
+ * @interrupt: GSI number.
+ * @flags: interrupt flags
+ *
+ * Returns: a valid linux IRQ number on success
+ *		0 or -EINVAL on failure
+ */
+static int pcc_map_interrupt(u32 interrupt, u32 flags)
+{
+	int trigger, polarity;
+
+	if (!interrupt)
+		return 0;
+
+	trigger = (flags & ACPI_PCCT_INTERRUPT_MODE) ? ACPI_EDGE_SENSITIVE
+			: ACPI_LEVEL_SENSITIVE;
+
+	polarity = (flags & ACPI_PCCT_INTERRUPT_POLARITY) ? ACPI_ACTIVE_LOW
+			: ACPI_ACTIVE_HIGH;
+
+	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
+}
+
+/**
+ * pcc_mbox_irq - PCC mailbox interrupt handler
+ */
+static irqreturn_t pcc_mbox_irq(int irq, void *id)
+{
+	struct acpi_generic_address *doorbell_ack;
+	struct acpi_pcct_hw_reduced *pcct_ss;
+	struct pcc_mbox_chan *pcc_chan = id;
+	u64 doorbell_ack_preserve;
+	struct mbox_chan *chan;
+	u64 doorbell_ack_write;
+	u64 doorbell_ack_val;
+	int ret = 0;
+
+	chan = pcc_chan->chan;
+	pcct_ss = chan->con_priv;
+
+	/* Clear interrupt status */
+	if (pcct_ss->header.type == ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
+		doorbell_ack = &pcct_ss->doorbell_ack_register;
+		doorbell_ack_preserve = pcct_ss->ack_preserve_mask;
+		doorbell_ack_write = pcct_ss->ack_write_mask;
+
+		ret = read_register(pcc_chan->pcc_doorbell_ack_vaddr,
+				    &doorbell_ack_val,
+				    doorbell_ack->bit_width);
+		if (ret)
+			return ret;
+
+		ret = write_register(pcc_chan->pcc_doorbell_ack_vaddr,
+				     (doorbell_ack_val & doorbell_ack_preserve)
+					| doorbell_ack_write,
+				     doorbell_ack->bit_width);
+		if (ret)
+			return ret;
+	}
+
+	mbox_chan_received_data(chan, NULL);
+
+	return IRQ_HANDLED;
 }
 
 /**
@@ -107,7 +259,8 @@ static struct mbox_chan *get_pcc_channel(int id)
 struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *cl,
 		int subspace_id)
 {
-	struct device *dev = pcc_mbox_ctrl.dev;
+	struct device *dev = pcc_mbox_ctx.mbox_ctrl.dev;
+	struct pcc_mbox_chan *pcc_chan;
 	struct mbox_chan *chan;
 	unsigned long flags;
 
@@ -118,8 +271,13 @@ struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *cl,
 	 * This returns a pointer to the PCC subspace
 	 * for the Client to operate on.
 	 */
-	chan = get_pcc_channel(subspace_id);
+	pcc_chan = get_pcc_channel(subspace_id);
+	if (IS_ERR(pcc_chan)) {
+		dev_err(dev, "PCC Channel not found for idx: %d\n", subspace_id);
+		return ERR_PTR(-EBUSY);
+	}
 
+	chan = pcc_chan->chan;
 	if (IS_ERR(chan) || chan->cl) {
 		dev_err(dev, "Channel not found for idx: %d\n", subspace_id);
 		return ERR_PTR(-EBUSY);
@@ -135,6 +293,18 @@ struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *cl,
 	if (chan->txdone_method == TXDONE_BY_POLL && cl->knows_txdone)
 		chan->txdone_method |= TXDONE_BY_ACK;
 
+	if (chan->mbox->txdone_irq) {
+		int rc;
+
+		rc = devm_request_irq(dev, pcc_chan->irq, pcc_mbox_irq, 0,
+				      MBOX_IRQ_NAME, pcc_chan);
+		if (unlikely(rc)) {
+			dev_err(dev, "failed to register PCC interrupt %d\n",
+				pcc_chan->irq);
+			chan = ERR_PTR(rc);
+		}
+	}
+
 	spin_unlock_irqrestore(&chan->lock, flags);
 
 	return chan;
@@ -160,69 +330,18 @@ void pcc_mbox_free_channel(struct mbox_chan *chan)
 	if (chan->txdone_method == (TXDONE_BY_POLL | TXDONE_BY_ACK))
 		chan->txdone_method = TXDONE_BY_POLL;
 
-	spin_unlock_irqrestore(&chan->lock, flags);
-}
-EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
+	if (chan->mbox->txdone_irq) {
+		struct acpi_pcct_hw_reduced *pcct_ss = chan->con_priv;
+		int irq = 0;
 
-/*
- * PCC can be used with perf critical drivers such as CPPC
- * So it makes sense to locally cache the virtual address and
- * use it to read/write to PCC registers such as doorbell register
- *
- * The below read_register and write_registers are used to read and
- * write from perf critical registers such as PCC doorbell register
- */
-static int read_register(void __iomem *vaddr, u64 *val, unsigned int bit_width)
-{
-	int ret_val = 0;
-
-	switch (bit_width) {
-	case 8:
-		*val = readb(vaddr);
-		break;
-	case 16:
-		*val = readw(vaddr);
-		break;
-	case 32:
-		*val = readl(vaddr);
-		break;
-	case 64:
-		*val = readq(vaddr);
-		break;
-	default:
-		pr_debug("Error: Cannot read register of %u bit width",
-			bit_width);
-		ret_val = -EFAULT;
-		break;
+		if (acpi_gsi_to_irq(pcct_ss->doorbell_interrupt, &irq) == 0)
+			devm_free_irq(chan->mbox->dev, irq, chan);
 	}
-	return ret_val;
-}
-
-static int write_register(void __iomem *vaddr, u64 val, unsigned int bit_width)
-{
-	int ret_val = 0;
 
-	switch (bit_width) {
-	case 8:
-		writeb(val, vaddr);
-		break;
-	case 16:
-		writew(val, vaddr);
-		break;
-	case 32:
-		writel(val, vaddr);
-		break;
-	case 64:
-		writeq(val, vaddr);
-		break;
-	default:
-		pr_debug("Error: Cannot write register of %u bit width",
-			bit_width);
-		ret_val = -EFAULT;
-		break;
-	}
-	return ret_val;
+	spin_unlock_irqrestore(&chan->lock, flags);
 }
+EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
+
 
 /**
  * pcc_send_data - Called from Mailbox Controller code. Used
@@ -240,28 +359,35 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
 {
 	struct acpi_pcct_hw_reduced *pcct_ss = chan->con_priv;
 	struct acpi_generic_address *doorbell;
+	struct pcc_mbox_chan *pcc_chan;
 	u64 doorbell_preserve;
 	u64 doorbell_val;
 	u64 doorbell_write;
-	u32 id = chan - pcc_mbox_channels;
+	u32 id = chan - pcc_mbox_ctx.chans;
 	int ret = 0;
 
-	if (id >= pcc_mbox_ctrl.num_chans) {
+	if (id >= pcc_mbox_ctx.mbox_ctrl.num_chans) {
 		pr_debug("pcc_send_data: Invalid mbox_chan passed\n");
 		return -ENOENT;
 	}
 
+	pcc_chan = get_pcc_channel(id);
+	if (IS_ERR(pcc_chan)) {
+		pr_debug("PCC Channel not found for idx: %d\n", id);
+		return -EBUSY;
+	}
+
 	doorbell = &pcct_ss->doorbell_register;
 	doorbell_preserve = pcct_ss->preserve_mask;
 	doorbell_write = pcct_ss->write_mask;
 
 	/* Sync notification from OS to Platform. */
-	if (pcc_doorbell_vaddr[id]) {
-		ret = read_register(pcc_doorbell_vaddr[id], &doorbell_val,
+	if (pcc_chan->pcc_doorbell_vaddr) {
+		ret = read_register(pcc_chan->pcc_doorbell_vaddr, &doorbell_val,
 			doorbell->bit_width);
 		if (ret)
 			return ret;
-		ret = write_register(pcc_doorbell_vaddr[id],
+		ret = write_register(pcc_chan->pcc_doorbell_vaddr,
 			(doorbell_val & doorbell_preserve) | doorbell_write,
 			doorbell->bit_width);
 	} else {
@@ -293,11 +419,13 @@ static int parse_pcc_subspace(struct acpi_subtable_header *header,
 {
 	struct acpi_pcct_hw_reduced *pcct_ss;
 
-	if (pcc_mbox_ctrl.num_chans <= MAX_PCC_SUBSPACES) {
+	if (pcc_mbox_ctx.mbox_ctrl.num_chans <= MAX_PCC_SUBSPACES) {
 		pcct_ss = (struct acpi_pcct_hw_reduced *) header;
 
-		if (pcct_ss->header.type !=
-				ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE) {
+		if ((pcct_ss->header.type !=
+				ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE)
+		    && (pcct_ss->header.type !=
+				ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2)) {
 			pr_err("Incorrect PCC Subspace type detected\n");
 			return -EINVAL;
 		}
@@ -307,6 +435,41 @@ static int parse_pcc_subspace(struct acpi_subtable_header *header,
 }
 
 /**
+ * pcc_parse_subspace_irq - Parse the PCC IRQ and PCC ACK register
+ *		There should be one entry per PCC client.
+ * @mbox_chans: Pointer to the PCC mailbox channel data
+ * @pcct_ss: Pointer to the ACPI subtable header under the PCCT.
+ *
+ * Return: 0 for Success, else errno.
+ *
+ * This gets called for each entry in the PCC table.
+ */
+static int pcc_parse_subspace_irq(struct pcc_mbox_chan *mbox_chans,
+		struct acpi_pcct_hw_reduced *pcct_ss)
+{
+	mbox_chans->irq = pcc_map_interrupt(pcct_ss->doorbell_interrupt,
+					    (u32)pcct_ss->flags);
+	if (mbox_chans->irq <= 0) {
+		pr_err("PCC GSI %d not registered\n",
+		       pcct_ss->doorbell_interrupt);
+		return -EINVAL;
+	}
+
+	if (pcct_ss->header.type
+		== ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
+		mbox_chans->pcc_doorbell_ack_vaddr = acpi_os_ioremap(
+				pcct_ss->doorbell_ack_register.address,
+				pcct_ss->doorbell_ack_register.bit_width / 8);
+		if (!mbox_chans->pcc_doorbell_ack_vaddr) {
+			pr_err("Failed to ioremap PCC ACK register\n");
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+/**
  * acpi_pcc_probe - Parse the ACPI tree for the PCCT.
  *
  * Return: 0 for Success, else errno.
@@ -316,7 +479,8 @@ static int __init acpi_pcc_probe(void)
 	acpi_size pcct_tbl_header_size;
 	struct acpi_table_header *pcct_tbl;
 	struct acpi_subtable_header *pcct_entry;
-	int count, i;
+	struct acpi_table_pcct *acpi_pcct_tbl;
+	int count, i, rc;
 	acpi_status status = AE_OK;
 
 	/* Search for PCCT */
@@ -335,21 +499,29 @@ static int __init acpi_pcc_probe(void)
 			parse_pcc_subspace, MAX_PCC_SUBSPACES);
 
 	if (count <= 0) {
+		count = acpi_table_parse_entries(ACPI_SIG_PCCT,
+				sizeof(struct acpi_table_pcct),
+				ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2,
+				parse_pcc_subspace, MAX_PCC_SUBSPACES);
+	}
+
+	if (count <= 0) {
 		pr_err("Error parsing PCC subspaces from PCCT\n");
 		return -EINVAL;
 	}
 
-	pcc_mbox_channels = kzalloc(sizeof(struct mbox_chan) *
-			count, GFP_KERNEL);
+	pcc_mbox_ctx.chans = kzalloc(sizeof(struct mbox_chan) *
+				     count, GFP_KERNEL);
 
-	if (!pcc_mbox_channels) {
+	if (!pcc_mbox_ctx.chans) {
 		pr_err("Could not allocate space for PCC mbox channels\n");
 		return -ENOMEM;
 	}
 
-	pcc_doorbell_vaddr = kcalloc(count, sizeof(void *), GFP_KERNEL);
-	if (!pcc_doorbell_vaddr) {
-		kfree(pcc_mbox_channels);
+	pcc_mbox_ctx.mbox_chans = kzalloc(sizeof(struct pcc_mbox_chan) *
+					  count, GFP_KERNEL);
+	if (!pcc_mbox_ctx.mbox_chans) {
+		pr_err("Could not allocate space for PCC mbox channel data\n");
 		return -ENOMEM;
 	}
 
@@ -357,24 +529,44 @@ static int __init acpi_pcc_probe(void)
 	pcct_entry = (struct acpi_subtable_header *) (
 		(unsigned long) pcct_tbl + sizeof(struct acpi_table_pcct));
 
+	acpi_pcct_tbl = (struct acpi_table_pcct *) pcct_tbl;
+	if (acpi_pcct_tbl->flags & ACPI_PCCT_DOORBELL)
+		pcc_mbox_ctx.mbox_ctrl.txdone_irq = true;
+
 	for (i = 0; i < count; i++) {
 		struct acpi_generic_address *db_reg;
 		struct acpi_pcct_hw_reduced *pcct_ss;
-		pcc_mbox_channels[i].con_priv = pcct_entry;
-		pcct_entry = (struct acpi_subtable_header *)
-			((unsigned long) pcct_entry + pcct_entry->length);
+
+		pcc_mbox_ctx.chans[i].con_priv = pcct_entry;
+		pcc_mbox_ctx.chans[i].mbox = &pcc_mbox_ctx.mbox_ctrl;
+
+		pcct_ss = (struct acpi_pcct_hw_reduced *) pcct_entry;
+
+		pcc_mbox_ctx.mbox_chans[i].chan = &pcc_mbox_ctx.chans[i];
+		if (pcc_mbox_ctx.mbox_ctrl.txdone_irq) {
+			rc = pcc_parse_subspace_irq(&pcc_mbox_ctx.mbox_chans[i],
+						    pcct_ss);
+			if (rc < 0)
+				return rc;
+		}
 
 		/* If doorbell is in system memory cache the virt address */
 		pcct_ss = (struct acpi_pcct_hw_reduced *)pcct_entry;
 		db_reg = &pcct_ss->doorbell_register;
-		if (db_reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
-			pcc_doorbell_vaddr[i] = acpi_os_ioremap(db_reg->address,
+		if (db_reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+			pcc_mbox_ctx.mbox_chans[i].pcc_doorbell_vaddr =
+					acpi_os_ioremap(db_reg->address,
 							db_reg->bit_width/8);
+		}
+
+		pcct_entry = (struct acpi_subtable_header *)
+			((unsigned long) pcct_entry + pcct_entry->length);
 	}
 
-	pcc_mbox_ctrl.num_chans = count;
+	pcc_mbox_ctx.mbox_ctrl.num_chans = count;
 
-	pr_info("Detected %d PCC Subspaces\n", pcc_mbox_ctrl.num_chans);
+	pr_info("Detected %d PCC Subspaces\n",
+		pcc_mbox_ctx.mbox_ctrl.num_chans);
 
 	return 0;
 }
@@ -394,12 +586,12 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 {
 	int ret = 0;
 
-	pcc_mbox_ctrl.chans = pcc_mbox_channels;
-	pcc_mbox_ctrl.ops = &pcc_chan_ops;
-	pcc_mbox_ctrl.dev = &pdev->dev;
+	pcc_mbox_ctx.mbox_ctrl.chans = pcc_mbox_ctx.chans;
+	pcc_mbox_ctx.mbox_ctrl.ops = &pcc_chan_ops;
+	pcc_mbox_ctx.mbox_ctrl.dev = &pdev->dev;
 
 	pr_info("Registering PCC driver as Mailbox controller\n");
-	ret = mbox_controller_register(&pcc_mbox_ctrl);
+	ret = mbox_controller_register(&pcc_mbox_ctx.mbox_ctrl);
 
 	if (ret) {
 		pr_err("Err registering PCC as Mailbox controller: %d\n", ret);
diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index ddf5e66..5937075 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -476,7 +476,8 @@ struct acpi_table_pcct {
 enum acpi_pcct_type {
 	ACPI_PCCT_TYPE_GENERIC_SUBSPACE = 0,
 	ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE = 1,
-	ACPI_PCCT_TYPE_RESERVED = 2	/* 2 and greater are reserved */
+	ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2 = 2,
+	ACPI_PCCT_TYPE_RESERVED = 3	/* 3 and greater are reserved */
 };
 
 /*
@@ -498,7 +499,7 @@ struct acpi_pcct_subspace {
 	u16 min_turnaround_time;
 };
 
-/* 1: HW-reduced Communications Subspace (ACPI 5.1) */
+/* 1 or 2: HW-reduced Communications Subspace (ACPI 6.1) */
 
 struct acpi_pcct_hw_reduced {
 	struct acpi_subtable_header header;
@@ -513,6 +514,9 @@ struct acpi_pcct_hw_reduced {
 	u32 latency;
 	u32 max_access_rate;
 	u16 min_turnaround_time;
+	struct acpi_generic_address doorbell_ack_register;
+	u64 ack_preserve_mask;
+	u64 ack_write_mask;
 };
 
 /* Values for doorbell flags above */
-- 
1.9.1


-- 
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and contains information that 
is confidential and proprietary to Applied Micro Circuits Corporation or 
its subsidiaries. It is to be used solely for the purpose of furthering the 
parties' business relationship. All unauthorized review, use, disclosure or 
distribution is prohibited. If you are not the intended recipient, please 
contact the sender by reply e-mail and destroy all copies of the original 
message.
