From: Hoan Tran <hotran@apm.com>
Subject: [PATCH v2] mailbox: pcc: Support HW-Reduced Communication Subspace Type 2
Date: Fri,  6 May 2016 11:38:34 -0700
Message-ID: <1462559914-28363-1-git-send-email-hotran@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34267 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758504AbcEFSjG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 May 2016 14:39:06 -0400
Received: by mail-pa0-f51.google.com with SMTP id r5so51341348pag.1
        for <linux-acpi@vger.kernel.org>; Fri, 06 May 2016 11:39:05 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, alexey.klimov@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: lho@apm.com, dhdang@apm.com, hotran <hotran@apm.com>

From: hotran <hotran@apm.com>

ACPI 6.1 has a PCC HW-Reduced Communication Subspace Type 2 intended for
use on HW-Reduce ACPI Platform, which requires read-modify-write sequence
to acknowledge doorbell interrupt. This patch provides the implementation
for the Communication Subspace Type 2.

This patch depends on patch [1] which supports PCC subspace type 2 header
[1] https://lkml.org/lkml/2016/5/5/14
 - [PATCH v2 03/13] ACPICA: ACPI 6.1: Support for new PCCT subtable

v2
 * Remove changes inside "actbl3.h". This file is taken care by ACPICA.
 * Parse both subspace type 1 and subspace type 2
 * Remove unnecessary variable initialization
 * ISR returns IRQ_NONE in case of error

v1
 * Initial

Signed-off-by: Hoan Tran <hotran@apm.com>
---
 drivers/mailbox/pcc.c | 395 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 296 insertions(+), 99 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 043828d..58c9a67 100644
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
@@ -68,27 +69,179 @@
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
+	int ret;
+
+	chan = pcc_chan->chan;
+	pcct_ss = chan->con_priv;
+
+	mbox_chan_received_data(chan, NULL);
+
+	if (pcct_ss->header.type == ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
+		struct acpi_pcct_hw_reduced_type2 *pcct2_ss = chan->con_priv;
+
+		doorbell_ack = &pcct2_ss->doorbell_ack_register;
+		doorbell_ack_preserve = pcct2_ss->ack_preserve_mask;
+		doorbell_ack_write = pcct2_ss->ack_write_mask;
+
+		ret = read_register(pcc_chan->pcc_doorbell_ack_vaddr,
+				    &doorbell_ack_val,
+				    doorbell_ack->bit_width);
+		if (ret)
+			return IRQ_NONE;
+
+		ret = write_register(pcc_chan->pcc_doorbell_ack_vaddr,
+				     (doorbell_ack_val & doorbell_ack_preserve)
+					| doorbell_ack_write,
+				     doorbell_ack->bit_width);
+		if (ret)
+			return IRQ_NONE;
+	}
+
+	return IRQ_HANDLED;
 }
 
 /**
@@ -107,7 +260,8 @@ static struct mbox_chan *get_pcc_channel(int id)
 struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *cl,
 		int subspace_id)
 {
-	struct device *dev = pcc_mbox_ctrl.dev;
+	struct device *dev = pcc_mbox_ctx.mbox_ctrl.dev;
+	struct pcc_mbox_chan *pcc_chan;
 	struct mbox_chan *chan;
 	unsigned long flags;
 
@@ -118,8 +272,13 @@ struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *cl,
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
@@ -135,6 +294,18 @@ struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *cl,
 	if (chan->txdone_method == TXDONE_BY_POLL && cl->knows_txdone)
 		chan->txdone_method |= TXDONE_BY_ACK;
 
+	if (pcc_chan->irq > 0) {
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
@@ -149,7 +320,9 @@ EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
  */
 void pcc_mbox_free_channel(struct mbox_chan *chan)
 {
+	struct pcc_mbox_chan *pcc_chan;
 	unsigned long flags;
+	u32 id;
 
 	if (!chan || !chan->cl)
 		return;
@@ -160,69 +333,19 @@ void pcc_mbox_free_channel(struct mbox_chan *chan)
 	if (chan->txdone_method == (TXDONE_BY_POLL | TXDONE_BY_ACK))
 		chan->txdone_method = TXDONE_BY_POLL;
 
+	id = chan - pcc_mbox_ctx.chans;
+	pcc_chan = get_pcc_channel(id);
+	if (IS_ERR(pcc_chan)) {
+		pr_debug("PCC Channel not found for idx: %d\n", id);
+	} else {
+		if (pcc_chan->irq > 0)
+			devm_free_irq(chan->mbox->dev, pcc_chan->irq, chan);
+	}
+
 	spin_unlock_irqrestore(&chan->lock, flags);
 }
 EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
 
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
-	}
-	return ret_val;
-}
-
-static int write_register(void __iomem *vaddr, u64 val, unsigned int bit_width)
-{
-	int ret_val = 0;
-
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
-}
 
 /**
  * pcc_send_data - Called from Mailbox Controller code. Used
@@ -240,36 +363,44 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
 {
 	struct acpi_pcct_hw_reduced *pcct_ss = chan->con_priv;
 	struct acpi_generic_address *doorbell;
+	struct pcc_mbox_chan *pcc_chan;
 	u64 doorbell_preserve;
 	u64 doorbell_val;
 	u64 doorbell_write;
-	u32 id = chan - pcc_mbox_channels;
-	int ret = 0;
+	u32 id = chan - pcc_mbox_ctx.chans;
+	int ret;
 
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
-			doorbell->bit_width);
+	if (pcc_chan->pcc_doorbell_vaddr) {
+		ret = read_register(pcc_chan->pcc_doorbell_vaddr, &doorbell_val,
+				    doorbell->bit_width);
 		if (ret)
 			return ret;
-		ret = write_register(pcc_doorbell_vaddr[id],
-			(doorbell_val & doorbell_preserve) | doorbell_write,
-			doorbell->bit_width);
+		ret = write_register(pcc_chan->pcc_doorbell_vaddr,
+				     (doorbell_val & doorbell_preserve)
+					| doorbell_write,
+				     doorbell->bit_width);
 	} else {
 		ret = acpi_read(&doorbell_val, doorbell);
 		if (ret)
 			return ret;
 		ret = acpi_write((doorbell_val & doorbell_preserve) | doorbell_write,
-			doorbell);
+				 doorbell);
 	}
 	return ret;
 }
@@ -293,11 +424,13 @@ static int parse_pcc_subspace(struct acpi_subtable_header *header,
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
@@ -307,6 +440,43 @@ static int parse_pcc_subspace(struct acpi_subtable_header *header,
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
+		struct acpi_pcct_hw_reduced_type2 *pcct2_ss = (void *)pcct_ss;
+
+		mbox_chans->pcc_doorbell_ack_vaddr = acpi_os_ioremap(
+				pcct2_ss->doorbell_ack_register.address,
+				pcct2_ss->doorbell_ack_register.bit_width / 8);
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
@@ -316,7 +486,8 @@ static int __init acpi_pcc_probe(void)
 	acpi_size pcct_tbl_header_size;
 	struct acpi_table_header *pcct_tbl;
 	struct acpi_subtable_header *pcct_entry;
-	int count, i;
+	struct acpi_table_pcct *acpi_pcct_tbl;
+	int count, i, rc;
 	acpi_status status = AE_OK;
 
 	/* Search for PCCT */
@@ -334,22 +505,28 @@ static int __init acpi_pcc_probe(void)
 			ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE,
 			parse_pcc_subspace, MAX_PCC_SUBSPACES);
 
+	count += acpi_table_parse_entries(ACPI_SIG_PCCT,
+			sizeof(struct acpi_table_pcct),
+			ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2,
+			parse_pcc_subspace, MAX_PCC_SUBSPACES);
+
 	if (count <= 0) {
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
 
@@ -357,24 +534,44 @@ static int __init acpi_pcc_probe(void)
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
 		pcct_entry = (struct acpi_subtable_header *)
 			((unsigned long) pcct_entry + pcct_entry->length);
 	}
 
-	pcc_mbox_ctrl.num_chans = count;
+	pcc_mbox_ctx.mbox_ctrl.num_chans = count;
 
-	pr_info("Detected %d PCC Subspaces\n", pcc_mbox_ctrl.num_chans);
+	pr_info("Detected %d PCC Subspaces\n",
+		pcc_mbox_ctx.mbox_ctrl.num_chans);
 
 	return 0;
 }
@@ -394,12 +591,12 @@ static int pcc_mbox_probe(struct platform_device *pdev)
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
