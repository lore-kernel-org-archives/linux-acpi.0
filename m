From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v3 2/3] Add support for Platform Communication Channel
Date: Tue, 26 Aug 2014 15:35:37 -0400
Message-ID: <1409081738-5602-3-git-send-email-ashwin.chaugule@linaro.org>
References: <1409081738-5602-1-git-send-email-ashwin.chaugule@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:39774 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339AbaHZTge (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Aug 2014 15:36:34 -0400
Received: by mail-qa0-f49.google.com with SMTP id dc16so13874664qab.8
        for <linux-acpi@vger.kernel.org>; Tue, 26 Aug 2014 12:36:33 -0700 (PDT)
In-Reply-To: <1409081738-5602-1-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: arnd@arndb.de
Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, rjw@rjwysocki.net, broonie@kernel.org

ACPI 5.0+ spec defines a generic mode of communication
between the OS and a platform such as the BMC. This medium
(PCC) is typically used by CPPC (ACPI CPU Performance management),
RAS (ACPI reliability protocol) and MPST (ACPI Memory power
states).

This patch adds PCC support as a Mailbox Controller.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/mailbox/Kconfig  |  12 +++
 drivers/mailbox/Makefile |   2 +
 drivers/mailbox/pcc.c    | 228 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 242 insertions(+)
 create mode 100644 drivers/mailbox/pcc.c

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index c8b5c13..af4a153 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -50,4 +50,16 @@ config OMAP_MBOX_KFIFO_SIZE
 	  Specify the default size of mailbox's kfifo buffers (bytes).
 	  This can also be changed at runtime (via the mbox_kfifo_size
 	  module parameter).
+
+config PCC
+	bool "Platform Communication Channel"
+	depends on ACPI
+	help
+		ACPI 5.0+ spec defines a generic mode of communication
+		between the OS and a platform such as the BMC. This medium
+		(PCC) is typically used by CPPC (ACPI CPU Performance management),
+		RAS (ACPI reliability protocol) and MPST (ACPI Memory power
+		states). Select this driver if your platform implements the
+		PCC clients mentioned above.
+
 endif
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 2fa343a..3f57ee9 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -9,3 +9,5 @@ obj-$(CONFIG_OMAP1_MBOX)	+= mailbox_omap1.o
 mailbox_omap1-objs		:= mailbox-omap1.o
 obj-$(CONFIG_OMAP2PLUS_MBOX)	+= mailbox_omap2.o
 mailbox_omap2-objs		:= mailbox-omap2.o
+
+obj-$(CONFIG_PCC)	+= pcc.o
diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
new file mode 100644
index 0000000..e925f65
--- /dev/null
+++ b/drivers/mailbox/pcc.c
@@ -0,0 +1,228 @@
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
+ */
+
+#include <linux/acpi.h>
+#include <linux/io.h>
+#include <linux/uaccess.h>
+#include <linux/init.h>
+#include <linux/cpufreq.h>
+#include <linux/delay.h>
+#include <linux/ioctl.h>
+#include <linux/vmalloc.h>
+#include <linux/mailbox_controller.h>
+
+#include <acpi/actbl.h>
+
+#define MAX_PCC_SUBSPACES	256
+#define PCCS_SS_SIG_MAGIC	0x50434300
+#define PCC_CMD_COMPLETE	0x1
+#define PCC_VERSION			"0.1"
+
+static struct mbox_chan pcc_mbox_chan[MAX_PCC_SUBSPACES];
+static struct mbox_controller pcc_mbox_ctrl = {};
+
+static bool pcc_tx_done(struct mbox_chan *chan)
+{
+	struct acpi_pcct_subspace *pcct_ss = chan->con_priv;
+	struct acpi_pcct_shared_memory *generic_comm_base =
+		(struct acpi_pcct_shared_memory *) pcct_ss->base_address;
+	u16 cmd_delay = pcct_ss->min_turnaround_time;
+
+	/* Wait for Platform to consume. */
+	while (!(ioread16(&generic_comm_base->status) & PCC_CMD_COMPLETE))
+		udelay(cmd_delay);
+
+	return true;
+}
+
+static int get_subspace_id(struct mbox_chan *chan)
+{
+	unsigned int i;
+	int ret = -ENOENT;
+
+	for (i = 0; i < pcc_mbox_ctrl.num_chans; i++) {
+		if (chan == &pcc_mbox_chan[i])
+			return i;
+	}
+
+	return ret;
+}
+
+/* Channel lock is already held by mbox controller code. */
+static int pcc_send_data(struct mbox_chan *chan, void *data)
+{
+	struct acpi_pcct_subspace *pcct_ss = chan->con_priv;
+	struct acpi_pcct_shared_memory *generic_comm_base =
+		(struct acpi_pcct_shared_memory *) pcct_ss->base_address;
+	struct acpi_generic_address doorbell;
+	u64 doorbell_preserve;
+	u64 doorbell_val;
+	u64 doorbell_write;
+	u16 cmd = 0;
+	u16 ss_idx = -1;
+	int ret = 0;
+
+	/*
+	 * Min time in usec that OS is expected to wait
+	 * before sending the next PCC cmd.
+	 */
+	u16 cmd_delay = pcct_ss->min_turnaround_time;
+
+	/* Get PCC CMD */
+	ret = kstrtou16((char*)data, 0, &cmd);
+	if (ret < 0) {
+		pr_err("Err while converting PCC CMD to u16: %d\n", ret);
+		goto out_err;
+	}
+
+	ss_idx = get_subspace_id(chan);
+
+	if (ss_idx < 0) {
+		pr_err("Invalid Subspace ID from PCC client\n");
+		ret = ss_idx;
+		goto out_err;
+	}
+
+	doorbell = pcct_ss->doorbell_register;
+	doorbell_preserve = pcct_ss->preserve_mask;
+	doorbell_write = pcct_ss->write_mask;
+
+	/* Write to the shared comm region. */
+	iowrite16(cmd, &generic_comm_base->command);
+
+	/* Write Subspace MAGIC value so platform can identify destination. */
+	iowrite32((PCCS_SS_SIG_MAGIC | ss_idx), &generic_comm_base->signature);
+
+	/* Flip CMD COMPLETE bit */
+	iowrite16(0, &generic_comm_base->status);
+
+	/* Sync notification from OSPM to Platform. */
+	acpi_read(&doorbell_val, &doorbell);
+	acpi_write((doorbell_val & doorbell_preserve) | doorbell_write,
+			&doorbell);
+
+out_err:
+	return ret;
+}
+
+static int pcc_chan_startup(struct mbox_chan *chan)
+{
+	return 0;
+}
+
+static void pcc_chan_shutdown(struct mbox_chan *chan)
+{
+	return;
+}
+
+static struct mbox_chan_ops pcc_chan_ops = {
+	.send_data	=	pcc_send_data,
+	.startup	=	pcc_chan_startup,
+	.shutdown	=	pcc_chan_shutdown,
+	.last_tx_done	=	pcc_tx_done,
+};
+
+static int parse_pcc_subspace(struct acpi_subtable_header *header,
+		const unsigned long end)
+{
+	struct acpi_pcct_subspace *pcct_ss;
+
+	if (pcc_mbox_ctrl.num_chans <= MAX_PCC_SUBSPACES) {
+		pcct_ss = (struct acpi_pcct_subspace *) header;
+
+		if (pcct_ss->header.type != ACPI_PCCT_TYPE_GENERIC_SUBSPACE) {
+			pr_err("Incorrect PCC Subspace type detected\n");
+			return -EINVAL;
+		}
+
+		/* New mbox channel entry for each PCC subspace detected. */
+		pcc_mbox_chan[pcc_mbox_ctrl.num_chans].con_priv = pcct_ss;
+
+		pcc_mbox_ctrl.num_chans++;
+
+	} else {
+		pr_err("No more space for PCC subspaces.\n");
+		return -ENOSPC;
+	}
+
+	return 0;
+}
+
+static int __init pcc_probe(void)
+{
+	acpi_status status = AE_OK;
+	acpi_size pcct_tbl_header_size;
+	struct acpi_table_pcct *pcct_tbl;
+	int ret;
+
+	/* Search for PCCT */
+	status = acpi_get_table_with_size(ACPI_SIG_PCCT, 0,
+			(struct acpi_table_header **)&pcct_tbl,
+			&pcct_tbl_header_size);
+
+	if (ACPI_SUCCESS(status) && !pcct_tbl) {
+		pr_warn("PCCT header not found.\n");
+		status = AE_NOT_FOUND;
+		goto out_err;
+	}
+
+	status = acpi_table_parse_entries(ACPI_SIG_PCCT,
+			sizeof(struct acpi_table_pcct),
+			ACPI_PCCT_TYPE_GENERIC_SUBSPACE,
+			parse_pcc_subspace, MAX_PCC_SUBSPACES);
+
+	if (ACPI_SUCCESS(status))
+		pr_err("Error parsing PCC subspaces from PCCT\n");
+
+	pr_info("Detected %d PCC Subspaces\n", pcc_mbox_ctrl.num_chans);
+
+	pcc_mbox_ctrl.chans = pcc_mbox_chan;
+	pcc_mbox_ctrl.ops = &pcc_chan_ops;
+	pcc_mbox_ctrl.name = "PCCT";
+	pcc_mbox_ctrl.txdone_poll = true;
+	pcc_mbox_ctrl.txpoll_period = 1;
+
+	pr_info("Registering PCC driver as Mailbox controller\n");
+	ret = mbox_controller_register(&pcc_mbox_ctrl);
+
+	if (ret) {
+		pr_err("Err registering PCC as Mailbox controller\n");
+		return -ENODEV;
+	}
+
+out_err:
+	return ACPI_SUCCESS(status) ? 1 : 0;
+}
+
+static int __init pcc_init(void)
+{
+	int ret;
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	/* Check if PCC support is available. */
+	ret = pcc_probe();
+
+	if (ret) {
+		pr_debug("PCC probe failed.\n");
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+device_initcall(pcc_init);
-- 
1.9.1

