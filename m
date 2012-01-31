From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 2/2] ACPI: Add support for exposing BGRT data
Date: Tue, 31 Jan 2012 11:39:50 -0500
Message-ID: <1328027990-3437-2-git-send-email-mjg@redhat.com>
References: <1328027990-3437-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:64284 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754347Ab2AaQk0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 31 Jan 2012 11:40:26 -0500
In-Reply-To: <1328027990-3437-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, Matthew Garrett <mjg@redhat.com>

ACPI 5.0 adds the BGRT, a table that contains a pointer to the firmware
boot splash and associated metadata. This simple driver exposes it via
/sys/firmware/acpi in order to allow bootsplash applications to draw their
splash around the firmware image and reduce the number of jarring graphical
transitions during boot.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 Documentation/ABI/testing/sysfs-firmware-acpi |   20 +++
 drivers/acpi/Kconfig                          |    9 ++
 drivers/acpi/Makefile                         |    1 +
 drivers/acpi/bgrt.c                           |  175 +++++++++++++++++++++++++
 include/acpi/actbl1.h                         |   18 +++
 5 files changed, 223 insertions(+), 0 deletions(-)
 create mode 100644 drivers/acpi/bgrt.c

diff --git a/Documentation/ABI/testing/sysfs-firmware-acpi b/Documentation/ABI/testing/sysfs-firmware-acpi
index 4f9ba3c..dd930c8 100644
--- a/Documentation/ABI/testing/sysfs-firmware-acpi
+++ b/Documentation/ABI/testing/sysfs-firmware-acpi
@@ -1,3 +1,23 @@
+What:		/sys/firmware/acpi/bgrt/
+Date:		January 2012
+Contact:	Matthew Garrett <mjg@redhat.com>
+Description:
+		The BGRT is an ACPI 5.0 feature that allows the OS
+		to obtain a copy of the firmware boot splash and
+		some associated metadata. This is intended to be used
+		by boot splash applications in order to interact with
+		the firmware boot splash in order to avoid jarring
+		transitions.
+
+		image: The image bitmap. Currently a 32-bit BMP.
+		status: 1 if the image is valid, 0 if firmware invalidated it.
+		type: 0 indicates image is in BMP format.
+		version: The version of the BGRT. Currently 1.
+		xoffset: The number of pixels between the left of the screen
+			 and the left edge of the image.
+		yoffset: The number of pixels between the top of the screen
+			 and the top edge of the image.
+
 What:		/sys/firmware/acpi/interrupts/
 Date:		February 2008
 Contact:	Len Brown <lenb@kernel.org>
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index de0e3df..4eefcb2 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -384,6 +384,15 @@ config ACPI_CUSTOM_METHOD
 	  load additional kernel modules after boot, this feature may be used
 	  to override that restriction).
 
+config ACPI_BGRT
+        tristate "Boottime Graphics Resource Table support"
+        default n
+        help
+	  This driver adds support for exposing the ACPI Boottime Graphics
+	  Resource Table, which allows the operating system to obtain
+	  data from the firmware boot splash. It will appear under
+	  /sys/firmware/acpi/bgrt/ .
+
 source "drivers/acpi/apei/Kconfig"
 
 endif	# ACPI
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index ecb26b4..3409208 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_ACPI_SBS)		+= sbs.o
 obj-$(CONFIG_ACPI_HED)		+= hed.o
 obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
 obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
+obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 
 # processor has its own "processor." module_param namespace
 processor-y			:= processor_driver.o processor_throttling.o
diff --git a/drivers/acpi/bgrt.c b/drivers/acpi/bgrt.c
new file mode 100644
index 0000000..15dff29
--- /dev/null
+++ b/drivers/acpi/bgrt.c
@@ -0,0 +1,175 @@
+/*
+ * Copyright 2012 Red Hat, Inc <mjg@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/sysfs.h>
+#include <acpi/acpi.h>
+#include <acpi/acpi_bus.h>
+
+static struct acpi_table_bgrt *bgrt_tab;
+static struct kobject *bgrt_kobj;
+
+struct bmp_header {
+	u16 id;
+	u32 size;
+} __attribute ((packed));
+
+static struct bmp_header bmp_header;
+
+static ssize_t show_version(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", bgrt_tab->version);
+}
+static DEVICE_ATTR(version, S_IRUGO, show_version, NULL);
+
+static ssize_t show_status(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", bgrt_tab->status);
+}
+static DEVICE_ATTR(status, S_IRUGO, show_status, NULL);
+
+static ssize_t show_type(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", bgrt_tab->type);
+}
+static DEVICE_ATTR(type, S_IRUGO, show_type, NULL);
+
+static ssize_t show_xoffset(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", bgrt_tab->xoffset);
+}
+static DEVICE_ATTR(xoffset, S_IRUGO, show_xoffset, NULL);
+
+static ssize_t show_yoffset(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", bgrt_tab->yoffset);
+}
+static DEVICE_ATTR(yoffset, S_IRUGO, show_yoffset, NULL);
+
+static ssize_t show_image(struct file *file, struct kobject *kobj,
+	       struct bin_attribute *attr, char *buf, loff_t off, size_t count)
+{
+	int size = attr->size;
+	void __iomem *image = attr->private;
+
+	if (off >= size) {
+		count = 0;
+	} else {
+		if (off + count > size)
+			count = size - off;
+
+		memcpy_fromio(buf, image+off, count);
+	}
+
+	return count;
+}
+
+static struct bin_attribute image_attr = {
+	.attr = {
+		.name = "image",
+		.mode = S_IRUGO,
+	},
+	.read = show_image,
+};
+
+static struct attribute *bgrt_attributes[] = {
+	&dev_attr_version.attr,
+	&dev_attr_status.attr,
+	&dev_attr_type.attr,
+	&dev_attr_xoffset.attr,
+	&dev_attr_yoffset.attr,
+	NULL,
+};
+
+static struct attribute_group bgrt_attribute_group = {
+	.attrs = bgrt_attributes,
+};
+
+static int __init bgrt_init(void)
+{
+	acpi_status status;
+	int ret;
+	void __iomem *bgrt;
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	status = acpi_get_table("BGRT", 0,
+				(struct acpi_table_header **)&bgrt_tab);
+
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	sysfs_bin_attr_init(&image_attr);
+
+	bgrt = ioremap(bgrt_tab->address, sizeof(struct bmp_header));
+
+	if (!bgrt) {
+		ret = -EINVAL;
+		goto out_err;
+	}
+
+	memcpy_fromio(&bmp_header, bgrt, sizeof(bmp_header));
+	image_attr.size = bmp_header.size;
+	iounmap(bgrt);
+
+	image_attr.private = ioremap(bgrt_tab->address, image_attr.size);
+
+	if (!image_attr.private) {
+		ret = -EINVAL;
+		goto out_err;
+	}
+
+
+	bgrt_kobj = kobject_create_and_add("bgrt", acpi_kobj);
+	if (!bgrt_kobj) {
+		ret = -EINVAL;
+		goto out_iounmap;
+	}
+
+	ret = sysfs_create_group(bgrt_kobj, &bgrt_attribute_group);
+	if (ret)
+		goto out_kobject;
+
+	ret = sysfs_create_bin_file(bgrt_kobj, &image_attr);
+	if (ret)
+		goto out_group;
+
+	return 0;
+
+out_group:
+	sysfs_remove_group(bgrt_kobj, &bgrt_attribute_group);
+out_kobject:
+	kobject_put(bgrt_kobj);
+out_iounmap:
+	iounmap(image_attr.private);
+out_err:
+	return ret;
+}
+
+static void __exit bgrt_exit(void)
+{
+	iounmap(image_attr.private);
+	sysfs_remove_group(bgrt_kobj, &bgrt_attribute_group);
+	sysfs_remove_bin_file(bgrt_kobj, &image_attr);
+}
+
+module_init(bgrt_init);
+module_exit(bgrt_exit);
+
+MODULE_AUTHOR("Matthew Garrett");
+MODULE_DESCRIPTION("BGRT boot graphic support");
+MODULE_LICENSE("GPL");
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 7504bc9..1b22528 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -61,6 +61,7 @@
  * the wrong signature.
  */
 #define ACPI_SIG_BERT           "BERT"	/* Boot Error Record Table */
+#define ACPI_SIG_BGRT		"BGRT"	/* Boot Graphics Resource Table */
 #define ACPI_SIG_CPEP           "CPEP"	/* Corrected Platform Error Polling table */
 #define ACPI_SIG_ECDT           "ECDT"	/* Embedded Controller Boot Resources Table */
 #define ACPI_SIG_EINJ           "EINJ"	/* Error Injection table */
@@ -157,6 +158,23 @@ enum acpi_bert_error_severity {
 
 /*******************************************************************************
  *
+ * BGRT - Boot Graphics Resource Table
+ *        Version 1
+ *
+ ******************************************************************************/
+
+struct acpi_table_bgrt {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u16 version;
+	u8 status;
+	u8 type;
+	u64 address;
+	u32 xoffset;
+	u32 yoffset;
+};
+
+/*******************************************************************************
+ *
  * CPEP - Corrected Platform Error Polling table (ACPI 4.0)
  *        Version 1
  *
-- 
1.7.1

