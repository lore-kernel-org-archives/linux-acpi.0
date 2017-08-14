From: "Luck, Tony" <tony.luck@intel.com>
Subject: [PATCH] ACPI/APEI: Add BERT data driver
Date: Mon, 14 Aug 2017 09:56:13 -0700
Message-ID: <20170814165613.25561-1-tony.luck@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:36078 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751517AbdHNQ4S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 14 Aug 2017 12:56:18 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tony Luck <tony.luck@intel.com>, Len Brown <lenb@kernel.org>, Boris Petkov <bp@suse.de>, Tyler Baicar <tbaicar@codeaurora.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

From: Tony Luck <tony.luck@intel.com>

The ACPI Boot Error Record Table provides a method for platform
firmware to give information to the operating system about error
that occurred prior to boot (of particular interest are problems
that caused the previous OS instance to crash).

The BERT table simply provides the size and address of the error
record in BIOS reserved memory. In an earlier age we might have
used /dev/mem to retrieve this error record, but many systems
disable /dev/mem for security reasons.

This driver provides read-only access to the data via a character
special device "/dev/bert-data".

Cc: Len Brown <lenb@kernel.org>
Cc: Boris Petkov <bp@suse.de>
Cc: Tyler Baicar <tbaicar@codeaurora.org>
Cc: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/acpi/apei/Kconfig     |   7 +++
 drivers/acpi/apei/Makefile    |   1 +
 drivers/acpi/apei/bert-data.c | 107 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 drivers/acpi/apei/bert-data.c

diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index de14d49a5c90..a785bfbf7e8c 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -77,3 +77,10 @@ config ACPI_APEI_ERST_DEBUG
 	  error information to and from a persistent store. Enable this
 	  if you want to debugging and testing the ERST kernel support
 	  and firmware implementation.
+
+config ACPI_APEI_BERT_DATA
+	tristate "APEI BERT data driver"
+	depends on ACPI_APEI
+	help
+	  This driver provides read access to the error record that
+	  the ACPI/APEI/BERT table points at.
diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
index e50573de25f1..f092c1bc60b8 100644
--- a/drivers/acpi/apei/Makefile
+++ b/drivers/acpi/apei/Makefile
@@ -2,5 +2,6 @@ obj-$(CONFIG_ACPI_APEI)		+= apei.o
 obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o
 obj-$(CONFIG_ACPI_APEI_EINJ)	+= einj.o
 obj-$(CONFIG_ACPI_APEI_ERST_DEBUG) += erst-dbg.o
+obj-$(CONFIG_ACPI_APEI_BERT_DATA) += bert-data.o
 
 apei-y := apei-base.o hest.o erst.o bert.o
diff --git a/drivers/acpi/apei/bert-data.c b/drivers/acpi/apei/bert-data.c
new file mode 100644
index 000000000000..1590bd82ef63
--- /dev/null
+++ b/drivers/acpi/apei/bert-data.c
@@ -0,0 +1,107 @@
+/*
+ * bert-data: driver to provide read access to the error record(s)
+ * provided by the ACPI BERT table.
+ * See ACPI specification section 18.3.1 "Boot Error Source"
+ *
+ * Copyright (C) 2017 Intel Corporation
+ *
+ * Author:
+ *    Tony Luck <tony.luck@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#define pr_fmt(fmt) "bert-data: " fmt
+
+#include <linux/module.h>
+#include <linux/acpi.h>
+#include <acpi/acpiosxf.h>
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/mm.h>
+#include <linux/uaccess.h>
+
+static u32 bert_size;
+static __iomem void *bert_data;
+
+static int bert_chrdev_open(struct inode *inode, struct file *file)
+{
+	if (file->f_flags & (O_WRONLY | O_RDWR))
+		return -EPERM;
+	inode->i_size = bert_size;
+	return 0;
+}
+
+static ssize_t bert_chrdev_read(struct file *filp, char __user *ubuf,
+				size_t usize, loff_t *off)
+{
+	if (*off > bert_size)
+		return -EINVAL;
+	if (*off + usize > bert_size)
+		usize = bert_size - *off;
+	if (copy_to_user(ubuf, bert_data + *off, usize))
+		return -EFAULT;
+	*off += usize;
+	return usize;
+}
+
+static const struct file_operations bert_chrdev_ops = {
+	.open		= bert_chrdev_open,
+	.read		= bert_chrdev_read,
+	.llseek		= default_llseek,
+};
+
+static struct miscdevice bert_chrdev_device = {
+	.minor		= MISC_DYNAMIC_MINOR,
+	.name		= "bert-data",
+	.fops		= &bert_chrdev_ops,
+	.mode		= 0444,
+};
+
+static __init int bert_init(void)
+{
+	struct acpi_table_bert *bert;
+	acpi_status stat;
+	int err;
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	stat = acpi_get_table(ACPI_SIG_BERT, 0,
+			      (struct acpi_table_header **)&bert);
+	if (stat == AE_NOT_FOUND)
+		return -ENODEV;
+	if (ACPI_FAILURE(stat)) {
+		pr_err("get table failed, %s.\n", acpi_format_exception(stat));
+		return -EINVAL;
+	}
+
+	bert_size = bert->region_length;
+	bert_data = acpi_os_map_memory(bert->address, bert->region_length);
+	acpi_put_table((struct acpi_table_header *)bert);
+	if (!bert_data)
+		return -ENOMEM;
+	err = misc_register(&bert_chrdev_device);
+	if (err)
+		acpi_os_unmap_memory(bert_data, bert_size);
+
+	return err;
+}
+module_init(bert_init);
+
+static __exit void bert_exit(void)
+{
+	acpi_os_unmap_memory(bert_data, bert_size);
+	misc_deregister(&bert_chrdev_device);
+}
+module_exit(bert_exit);
+
+MODULE_DESCRIPTION("ACPI Boot Error Data");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0

