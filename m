From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v11 1/1] Mailbox: Add support for Platform Communication Channel
Date: Wed, 12 Nov 2014 19:59:38 -0500
Message-ID: <1415840378-1973-2-git-send-email-ashwin.chaugule@linaro.org>
References: <1415840378-1973-1-git-send-email-ashwin.chaugule@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:57297 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbaKMA7t (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Nov 2014 19:59:49 -0500
Received: by mail-pa0-f51.google.com with SMTP id kq14so14210476pab.10
        for <linux-acpi@vger.kernel.org>; Wed, 12 Nov 2014 16:59:49 -0800 (PST)
In-Reply-To: <1415840378-1973-1-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: jaswinder.singh@linaro.org
Cc: broonie@kernel.org, lv.zheng@intel.com, linaro-acpi@lists.linaro.org, patches@linaro.org, linux-acpi@vger.kernel.org, rjw@rjwysocki.net, arnd@arndb.de, Ashwin Chaugule <ashwin.chaugule@linaro.org>

ACPI 5.0+ spec defines a generic mode of communication
between the OS and a platform such as the BMC. This medium
(PCC) is typically used by CPPC (ACPI CPU Performance management),
RAS (ACPI reliability protocol) and MPST (ACPI Memory power
states).

This patch adds PCC support as a Mailbox Controller. As of
ACPI v5.1 there is no provision for clients to lookup mailbox
controllers in a way that Linux expects. e.g. in DT the clients
can list the mailboxes they can associate with in the DT binding
and then provide a unique index to lookup a channel within a mailbox.
Since the ACPI spec doesn't have anything similar, we introduce a
mailbox controller specific API so that when the client calls it,
we know to lookup in the context of a specific controller. This
also helps in keeping a consistent interface across DT and ACPI
for such drivers.

This patch implements basic PCC support using the ACPI v5.1
structures. IRQ mode support will be provided as follow up patches.

Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/mailbox/Kconfig   |  12 ++
 drivers/mailbox/Makefile  |   2 +
 drivers/mailbox/mailbox.c |   4 +-
 drivers/mailbox/mailbox.h |  16 ++
 drivers/mailbox/pcc.c     | 403 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 434 insertions(+), 3 deletions(-)
 create mode 100644 drivers/mailbox/mailbox.h
 create mode 100644 drivers/mailbox/pcc.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 9fd9c67..c04fed9 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -33,4 +33,16 @@ config OMAP_MBOX_KFIFO_SIZE
 	  Specify the default size of mailbox's kfifo buffers (bytes).
 	  This can also be changed at runtime (via the mbox_kfifo_size
 	  module parameter).
+
+config PCC
+	bool "Platform Communication Channel Driver"
+	depends on ACPI
+	help
+	  ACPI 5.0+ spec defines a generic mode of communication
+	  between the OS and a platform such as the BMC. This medium
+	  (PCC) is typically used by CPPC (ACPI CPU Performance management),
+	  RAS (ACPI reliability protocol) and MPST (ACPI Memory power
+	  states). Select this driver if your platform implements the
+	  PCC clients mentioned above.
+
 endif
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 94ed7ce..dd412c2 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -5,3 +5,5 @@ obj-$(CONFIG_MAILBOX)		+= mailbox.o
 obj-$(CONFIG_PL320_MBOX)	+= pl320-ipc.o
 
 obj-$(CONFIG_OMAP2PLUS_MBOX)	+= omap-mailbox.o
+
+obj-$(CONFIG_PCC)		+= pcc.o
diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index afcb430..17e9e4a 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -21,9 +21,7 @@
 #include <linux/mailbox_client.h>
 #include <linux/mailbox_controller.h>
 
-#define TXDONE_BY_IRQ	BIT(0) /* controller has remote RTR irq */
-#define TXDONE_BY_POLL	BIT(1) /* controller can read status of last TX */
-#define TXDONE_BY_ACK	BIT(2) /* S/W ACK recevied by Client ticks the TX */
+#include "mailbox.h"
 
 static LIST_HEAD(mbox_cons);
 static DEFINE_MUTEX(con_mutex);
diff --git a/drivers/mailbox/mailbox.h b/drivers/mailbox/mailbox.h
new file mode 100644
index 0000000..5a15a25
--- /dev/null
+++ b/drivers/mailbox/mailbox.h
@@ -0,0 +1,16 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __MAILBOX_H
+#define __MAILBOX_H
+
+#define TXDONE_BY_IRQ	BIT(0) /* controller has remote RTR irq */
+#define TXDONE_BY_POLL	BIT(1) /* controller can read status of last TX */
+#define TXDONE_BY_ACK	BIT(2) /* S/W ACK recevied by Client ticks the TX */
+
+#endif /* __MAILBOX_H */
+
+
diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
new file mode 100644
index 0000000..6dbf6fc
--- /dev/null
+++ b/drivers/mailbox/pcc.c
@@ -0,0 +1,403 @@
+/*
+ *	Copyright (C) 2014 Linaro Ltd.
+ *	Author:	Ashwin Chaugule <ashwin.chaugule@linaro.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  PCC (Platform Communication Channel) is defined in the ACPI 5.0+
+ *  specification. It is a mailbox like mechanism to allow clients
+ *  such as CPPC (Collaborative Processor Performance Control), RAS
+ *  (Reliability, Availability and Serviceability) and MPST (Memory
+ *  Node Power State Table) to talk to the platform (e.g. BMC) through
+ *  shared memory regions as defined in the PCC table entries. The PCC
+ *  specification supports a Doorbell mechanism for the PCC clients
+ *  to notify the platform about new data. This Doorbell information
+ *  is also specified in each PCC table entry. See pcc_send_data()
+ *  and pcc_tx_done() for basic mode of operation.
+ *
+ *  For more details about PCC, please see the ACPI specification from
+ *  http://www.uefi.org/ACPIv5.1 Section 14.
+ *
+ *  This file implements PCC as a Mailbox controller and allows for PCC
+ *  clients to be implemented as its Mailbox Client Channels.
+ */
+
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/platform_device.h>
+#include <linux/mailbox_controller.h>
+#include <linux/mailbox_client.h>
+
+#include "mailbox.h"
+
+#define MAX_PCC_SUBSPACES	256
+#define PCCS_SS_SIG_MAGIC	0x50434300
+#define PCC_CMD_COMPLETE	0x1
+
+static struct mbox_chan *pcc_mbox_channels;
+
+static struct mbox_controller pcc_mbox_ctrl = {};
+/**
+ * get_pcc_channel - Given a PCC subspace idx, get
+ *	the respective mbox_channel.
+ * @id: PCC subspace index.
+ *
+ * Return: ERR_PTR(errno) if error, else pointer
+ *	to mbox channel.
+ */
+static struct mbox_chan *get_pcc_channel(int id)
+{
+	struct mbox_chan *pcc_chan;
+
+	if (id < 0 || id > pcc_mbox_ctrl.num_chans)
+		return ERR_PTR(-ENOENT);
+
+	pcc_chan = (struct mbox_chan *)
+		(unsigned long) pcc_mbox_channels +
+		(id * sizeof(*pcc_chan));
+
+	return pcc_chan;
+}
+
+/**
+ * get_subspace_id - Given a Mailbox channel, find out the
+ *		PCC subspace id.
+ * @chan: Pointer to Mailbox Channel from which we want
+ *		the index.
+ * Return: Errno if not found, else positive index number.
+ */
+static int get_subspace_id(struct mbox_chan *chan)
+{
+	unsigned int id = chan - pcc_mbox_channels;
+
+	if (id < 0 || id > pcc_mbox_ctrl.num_chans)
+		return -ENOENT;
+
+	return id;
+}
+
+/**
+ * pcc_mbox_request_channel - PCC clients call this function to
+ *		request a pointer to their PCC subspace, from which they
+ *		can get the details of communicating with the remote.
+ * @cl: Pointer to Mailbox client, so we know where to bind the
+ *		Channel.
+ * @subspace_id: The PCC Subspace index as parsed in the PCC client
+ *		ACPI package. This is used to lookup the array of PCC
+ *		subspaces as parsed by the PCC Mailbox controller.
+ *
+ * Return: Pointer to the Mailbox Channel if successful or
+ *		ERR_PTR.
+ */
+struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *cl,
+		int subspace_id)
+{
+	struct device *dev = pcc_mbox_ctrl.dev;
+	struct mbox_chan *chan;
+	unsigned long flags;
+
+	/*
+	 * Each PCC Subspace is a Mailbox Channel.
+	 * The PCC Clients get their PCC Subspace ID
+	 * from their own tables and pass it here.
+	 * This returns a pointer to the PCC subspace
+	 * for the Client to operate on.
+	 */
+	chan = get_pcc_channel(subspace_id);
+
+	if (!chan || chan->cl) {
+		dev_err(dev, "%s: PCC mailbox not free\n", __func__);
+		return ERR_PTR(-EBUSY);
+	}
+
+	spin_lock_irqsave(&chan->lock, flags);
+	chan->msg_free = 0;
+	chan->msg_count = 0;
+	chan->active_req = NULL;
+	chan->cl = cl;
+	init_completion(&chan->tx_complete);
+
+	if (chan->txdone_method == TXDONE_BY_POLL && cl->knows_txdone)
+		chan->txdone_method |= TXDONE_BY_ACK;
+
+	spin_unlock_irqrestore(&chan->lock, flags);
+
+	return chan;
+}
+EXPORT_SYMBOL_GPL(pcc_mbox_request_channel);
+
+/**
+ * pcc_mbox_free_channel - Clients call this to free their Channel.
+ *
+ * @chan: Pointer to the mailbox channel as returned by
+ *		pcc_mbox_request_channel()
+ */
+void pcc_mbox_free_channel(struct mbox_chan *chan)
+{
+	unsigned long flags;
+
+	if (!chan || !chan->cl)
+		return;
+
+	spin_lock_irqsave(&chan->lock, flags);
+	chan->cl = NULL;
+	chan->active_req = NULL;
+	if (chan->txdone_method == (TXDONE_BY_POLL | TXDONE_BY_ACK))
+		chan->txdone_method = TXDONE_BY_POLL;
+
+	spin_unlock_irqrestore(&chan->lock, flags);
+}
+EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
+
+/**
+ * pcc_tx_done - Callback from Mailbox controller code to
+ *		check if PCC message transmission completed.
+ * @chan: Pointer to Mailbox channel on which previous
+ *		transmission occurred.
+ *
+ * Return: TRUE if succeeded.
+ */
+static bool pcc_tx_done(struct mbox_chan *chan)
+{
+	struct acpi_pcct_hw_reduced *pcct_ss = chan->con_priv;
+	struct acpi_pcct_shared_memory *generic_comm_base =
+		(struct acpi_pcct_shared_memory *) pcct_ss->base_address;
+	u16 cmd_delay = pcct_ss->latency;
+	unsigned int retries = 0;
+
+	/* Try a few times while waiting for platform to consume */
+	while (!(readw_relaxed(&generic_comm_base->status)
+		    & PCC_CMD_COMPLETE)) {
+
+		if (retries++ < 5)
+			udelay(cmd_delay);
+		else {
+			/*
+			 * If the remote is dead, this will cause the Mbox
+			 * controller to timeout after mbox client.tx_tout
+			 * msecs.
+			 */
+			pr_err("PCC platform did not respond.\n");
+			return false;
+		}
+	}
+	return true;
+}
+
+/**
+ * pcc_send_data - Called from Mailbox Controller code to finally
+ *	transmit data over channel.
+ * @chan: Pointer to Mailbox channel over which to send data.
+ * @data: Actual data to be written over channel.
+ *
+ * Return: Err if something failed else 0 for success.
+ */
+static int pcc_send_data(struct mbox_chan *chan, void *data)
+{
+	struct acpi_pcct_hw_reduced *pcct_ss = chan->con_priv;
+	struct acpi_pcct_shared_memory *generic_comm_base =
+		(struct acpi_pcct_shared_memory *) pcct_ss->base_address;
+	struct acpi_generic_address doorbell;
+	u64 doorbell_preserve;
+	u64 doorbell_val;
+	u64 doorbell_write;
+	u16 cmd = *(u16 *) data;
+	u16 ss_idx = -1;
+
+	ss_idx = get_subspace_id(chan);
+
+	if (ss_idx < 0) {
+		pr_err("Invalid Subspace ID from PCC client\n");
+		return -EINVAL;
+	}
+
+	doorbell = pcct_ss->doorbell_register;
+	doorbell_preserve = pcct_ss->preserve_mask;
+	doorbell_write = pcct_ss->write_mask;
+
+	/* Write to the shared comm region. */
+	writew(cmd, &generic_comm_base->command);
+
+	/* Write Subspace MAGIC value so platform can identify destination. */
+	writel((PCCS_SS_SIG_MAGIC | ss_idx), &generic_comm_base->signature);
+
+	/* Flip CMD COMPLETE bit */
+	writew(0, &generic_comm_base->status);
+
+	/* Sync notification from OSPM to Platform. */
+	acpi_read(&doorbell_val, &doorbell);
+	acpi_write((doorbell_val & doorbell_preserve) | doorbell_write,
+			&doorbell);
+
+	return 0;
+}
+
+static struct mbox_chan_ops pcc_chan_ops = {
+	.send_data = pcc_send_data,
+	.last_tx_done = pcc_tx_done,
+};
+
+/**
+ * parse_pcc_subspace - Parse the PCC table and verify PCC subspace
+ *		entries. There should be one entry per PCC client.
+ * @header: Pointer to the ACPI subtable header under the PCCT.
+ * @end: End of subtable entry.
+ *
+ * Return: 0 for Success, else errno.
+ *
+ * This gets called for each entry in the PCC table.
+ */
+static int parse_pcc_subspace(struct acpi_subtable_header *header,
+		const unsigned long end)
+{
+	struct acpi_pcct_hw_reduced *pcct_ss;
+
+	if (pcc_mbox_ctrl.num_chans <= MAX_PCC_SUBSPACES) {
+		pcct_ss = (struct acpi_pcct_hw_reduced *) header;
+
+		if (pcct_ss->header.type !=
+				ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE) {
+			pr_err("Incorrect PCC Subspace type detected\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * acpi_pcc_probe - Parse the ACPI tree for the PCCT.
+ *
+ * Return: 0 for Success, else errno.
+ */
+static int __init acpi_pcc_probe(void)
+{
+	acpi_size pcct_tbl_header_size;
+	struct acpi_table_header *pcct_tbl;
+	struct acpi_subtable_header *pcct_entry;
+	int count, i;
+	acpi_status status = AE_OK;
+
+	/* Search for PCCT */
+	status = acpi_get_table_with_size(ACPI_SIG_PCCT, 0,
+			&pcct_tbl,
+			&pcct_tbl_header_size);
+
+	if (ACPI_FAILURE(status) || !pcct_tbl) {
+		pr_warn("PCCT header not found.\n");
+		return -ENODEV;
+	}
+
+	count = acpi_table_parse_entries(ACPI_SIG_PCCT,
+			sizeof(struct acpi_table_pcct),
+			ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE,
+			parse_pcc_subspace, MAX_PCC_SUBSPACES);
+
+	if (count <= 0) {
+		pr_err("Error parsing PCC subspaces from PCCT\n");
+		return -EINVAL;
+	}
+
+	pcc_mbox_channels = kzalloc(sizeof(struct mbox_chan) *
+			count, GFP_KERNEL);
+
+	if (!pcc_mbox_channels) {
+		pr_err("Could not allocate space for PCC mbox channels\n");
+		return -ENOMEM;
+	}
+
+	/* Point to the first PCC subspace entry */
+	pcct_entry = (struct acpi_subtable_header *) (
+		(unsigned long) pcct_tbl + sizeof(struct acpi_table_pcct));
+
+	for (i = 0; i < count; i++) {
+		pcc_mbox_channels[i].con_priv = pcct_entry;
+		pcct_entry = (struct acpi_subtable_header *)
+			((unsigned long) pcct_entry + pcct_entry->length);
+	}
+
+	pcc_mbox_ctrl.num_chans = count;
+
+	pr_info("Detected %d PCC Subspaces\n", pcc_mbox_ctrl.num_chans);
+
+	return 0;
+}
+
+/**
+ * pcc_mbox_probe - Called when we find a match for the
+ *	PCCT platform device. This is purely used to represent
+ *	the PCCT as a virtual device for registering with the
+ *	generic Mailbox framework.
+ *
+ * @pdev: Pointer to platform device returned when a match
+ *	is found.
+ *
+ *	Return: 0 for Success, else errno.
+ */
+static int pcc_mbox_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+
+	pcc_mbox_ctrl.chans = pcc_mbox_channels;
+	pcc_mbox_ctrl.ops = &pcc_chan_ops;
+	pcc_mbox_ctrl.txdone_poll = true;
+	pcc_mbox_ctrl.txpoll_period = 10;
+	pcc_mbox_ctrl.dev = &pdev->dev;
+
+	pr_info("Registering PCC driver as Mailbox controller\n");
+	ret = mbox_controller_register(&pcc_mbox_ctrl);
+
+	if (ret) {
+		pr_err("Err registering PCC as Mailbox controller: %d\n", ret);
+		ret = -ENODEV;
+	}
+
+	return ret;
+}
+
+struct platform_driver pcc_mbox_driver = {
+	.probe = pcc_mbox_probe,
+	.driver = {
+		.name = "PCCT",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init pcc_init(void)
+{
+	int ret;
+	struct platform_device *pcc_pdev;
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	/* Check if PCC support is available. */
+	ret = acpi_pcc_probe();
+
+	if (ret) {
+		pr_err("ACPI PCC probe failed.\n");
+		return -ENODEV;
+	}
+
+	pcc_pdev = platform_create_bundle(&pcc_mbox_driver,
+			pcc_mbox_probe, NULL, 0, NULL, 0);
+
+	if (!pcc_pdev) {
+		pr_err("Err creating PCC platform bundle\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+device_initcall(pcc_init);
-- 
1.9.1

