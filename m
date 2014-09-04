From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v6 2/2] PCC test
Date: Thu,  4 Sep 2014 14:49:21 -0400
Message-ID: <1409856561-3945-3-git-send-email-ashwin.chaugule@linaro.org>
References: <1409856561-3945-1-git-send-email-ashwin.chaugule@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:40036 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755252AbaIDStg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Sep 2014 14:49:36 -0400
Received: by mail-pd0-f171.google.com with SMTP id y13so14190267pdi.30
        for <linux-acpi@vger.kernel.org>; Thu, 04 Sep 2014 11:49:35 -0700 (PDT)
In-Reply-To: <1409856561-3945-1-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: arnd@arndb.de
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, rjw@rjwysocki.net, broonie@kernel.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>

Not for upstreaming. This is only to show how the PCC driver was
tested.

echo 2 > /proc/pcc_test [ to get the PCC base address from the PCCT ]

echo 1 > /proc/pcc_test [ to trigger a PCC write ]

echo 0 > /proc/pcc_test [ to trigger a PCC read ]

dmesg shows the output.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/mailbox/Makefile   |   2 +-
 drivers/mailbox/pcc-test.c | 203 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 204 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mailbox/pcc-test.c

diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 0b09d6f..028b8b1 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -10,4 +10,4 @@ mailbox_omap1-objs		:= mailbox-omap1.o
 obj-$(CONFIG_OMAP2PLUS_MBOX)	+= mailbox_omap2.o
 mailbox_omap2-objs		:= mailbox-omap2.o
 
-obj-$(CONFIG_PCC)			+= pcc.o
+obj-$(CONFIG_PCC)			+= pcc.o pcc-test.o
diff --git a/drivers/mailbox/pcc-test.c b/drivers/mailbox/pcc-test.c
new file mode 100644
index 0000000..9412a7a
--- /dev/null
+++ b/drivers/mailbox/pcc-test.c
@@ -0,0 +1,203 @@
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
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/mailbox_client.h>
+#include <linux/mailbox_controller.h>
+#include <linux/platform_device.h>
+#include <asm/uaccess.h>
+
+#include <acpi/actbl.h>
+
+static void __iomem *comm_base_addr; 	/* For use after ioremap */
+
+extern struct mbox_chan *pcc_mbox_request_channel(struct mbox_client *, unsigned int);
+extern int mbox_send_message(struct mbox_chan *chan, void *mssg);
+
+
+/* XXX: The PCC Subspace id is hard coded here only for test purposes.
+ * In reality it should be parsed from the PCC package as described
+ * in the PCC client table. e.g. CPC for CPPC 
+ */
+#define PCC_SUBSPACE_IDX 0
+#define CMD_COMPLETE    1
+
+struct mbox_chan *pcc_test_chan;
+enum ppc_cmds {
+	CMD_READ,
+	CMD_WRITE,
+	RESERVED,
+};
+
+static u64 reg1, reg2;
+
+static void run_pcc_test_read(void)
+{
+	u64 reg1_addr = (u64)comm_base_addr + 0x100;
+	u64 reg2_addr = (u64)comm_base_addr + 0x110;
+	u16 cmd = CMD_READ;
+	int ret;
+
+	/* READ part of the test */
+	pr_info("Sending PCC read req from Channel base addr: %llx\n", (u64)comm_base_addr);
+	ret = mbox_send_message(pcc_test_chan, &cmd);
+	if (ret >= 0) {
+		pr_info("Read updated values from Platform.\n");
+		reg1 = readq((void*)reg1_addr);
+		reg2 = readq((void*)reg2_addr);
+		pr_info("updated value of reg1:%llx\n", reg1);
+		pr_info("updated value of reg2:%llx\n", reg2);
+	} else
+		pr_err("Failed to read PCC parameters: ret=%d\n", ret);
+}
+
+static void run_pcc_test_write(void)
+{
+	u64 reg1_addr = (u64)comm_base_addr + 0x100;
+	u64 reg2_addr = (u64)comm_base_addr + 0x110;
+	u16 cmd = CMD_WRITE;
+	int ret;
+
+	/* WRITE part of the test */
+	reg1++;
+	reg2++;
+
+	writeq(reg1, (void *)reg1_addr);
+	writeq(reg2, (void *)reg2_addr);
+
+	pr_info("Sending PCC write req from Channel base addr: %llx\n", (u64)comm_base_addr);
+	ret = mbox_send_message(pcc_test_chan, &cmd);
+
+	if (ret >= 0)
+		pr_info("OSPM successfully sent PCC write cmd to platform\n");
+	else
+		pr_err("Failed to write PCC parameters. ret= %d\n", ret);
+}
+
+static void pcc_chan_tx_done(struct mbox_client *cl, void *mssg, int ret)
+{
+	if (!ret)
+		pr_info("PCC channel TX successfully completed. CMD sent = %x\n", *(u16*)mssg);
+	else
+		pr_warn("PCC channel TX did not complete: CMD sent = %x\n", *(u16*)mssg);
+}
+
+struct mbox_client pcc_mbox_cl = {
+	.tx_done	=	pcc_chan_tx_done,
+};
+
+void get_pcc_comm(void)
+{
+	u64 base_addr;
+	u32 len;
+	struct acpi_pcct_subspace *pcc_ss;
+
+	pcc_test_chan = pcc_mbox_request_channel(&pcc_mbox_cl, PCC_SUBSPACE_IDX);
+
+	if (!pcc_test_chan) {
+		pr_err("PCC Channel not found!\n");
+		return;
+	}
+
+	pcc_ss = pcc_test_chan->con_priv;
+
+	base_addr = pcc_ss->base_address;
+	len = pcc_ss->length;
+
+	pr_info("ioremapping: %llx, len: %x\n", base_addr, len);
+
+//	comm_base_addr = ioremap_nocache(base_addr, len);
+	/* HACK to test PCC commands */
+	comm_base_addr = kzalloc(PAGE_SIZE, GFP_KERNEL);
+
+	if (!comm_base_addr) {
+		pr_err("Could not ioremap channel\n");
+		return;
+	}
+
+	pcc_ss->base_address = (u64)comm_base_addr;
+
+	pr_info("Comm_base_addr: %llx\n", (u64)comm_base_addr);
+}
+
+static ssize_t pcc_test_write(struct file *file, const char __user *buf,
+		size_t count, loff_t *offs)
+{
+	char ctl[2];
+
+	if (count != 2 || *offs)
+		return -EINVAL;
+
+	if (copy_from_user(ctl, buf, count))
+		return -EFAULT;
+
+	switch (ctl[0]) {
+		case '0':
+			/* PCC read */
+			run_pcc_test_read();
+			break;
+		case '1':
+			/* PCC write */
+			run_pcc_test_write();
+			break;
+		case '2':
+			/* Get PCC channel */
+			get_pcc_comm();
+			break;
+		default:
+			pr_err("Unknown val\n");
+			break;
+	}
+
+	return count;
+}
+
+static int pcc_test_open(struct inode *inode, struct file *filp)
+{
+	return 0;
+}
+
+static int pcc_test_release(struct inode *inode, struct file *filp)
+{
+	return 0;
+}
+
+static const struct file_operations pcc_test_fops = {
+	.open		= pcc_test_open,
+//	.read		= seq_read,
+	.write		= pcc_test_write,
+	.release	= pcc_test_release,
+};
+
+static int __init pcc_test(void)
+{
+	struct proc_dir_entry *pe;
+
+	pe = proc_create("pcc_test", 0644, NULL, &pcc_test_fops);
+
+	if (!pe)
+		return -ENOMEM;
+
+	return 0;
+}
+
+late_initcall(pcc_test);
-- 
1.9.1

