From: Darren Hart <dvhart@infradead.org>
Subject: [PATCH 15/16] platform/x86: wmi-mof: New driver to expose embedded WMI MOF metadata
Date: Fri, 26 May 2017 22:31:29 -0700
Message-ID: <27758381c6cb77efab75a266e21243a964cce0ba.1495862272.git.dvhart@infradead.org>
References: <cover.1495862272.git.dvhart@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1495862272.git.dvhart@infradead.org>
In-Reply-To: <cover.1495862272.git.dvhart@infradead.org>
References: <cover.1495862272.git.dvhart@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: platform-driver-x86@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-acpi@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

Quite a few laptops (and maybe servers?) have embedded WMI MOF
metadata. I think that Samba has tools to interpret it, but there is
currently no interface to get the data in the first place.

In most cases, the MOF can be read out of the DSDT, but that is
non-compliant and messy.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Mario Limonciello <mario_limonciello@dell.com>
Cc: Pali Rohár <pali.rohar@gmail.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
[dvhart: make sysfs mof binary read only, fixup comment block format]
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
---
 drivers/platform/x86/Kconfig   |  12 ++++
 drivers/platform/x86/Makefile  |   1 +
 drivers/platform/x86/wmi-mof.c | 125 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+)
 create mode 100644 drivers/platform/x86/wmi-mof.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 49a1d01..1f27600 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -656,6 +656,18 @@ config ACPI_WMI
 	  It is safe to enable this driver even if your DSDT doesn't define
 	  any ACPI-WMI devices.
 
+config WMI_MOF
+	tristate "WMI embedded MOF driver"
+	depends on ACPI_WMI
+	default y
+	---help---
+	  Say Y here if you want to be able to read a firmware-embedded
+	  WMI MOF schema.  Using this requires userspace tools and may be
+	  rather tedious.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called wmi-mof.
+
 config MSI_WMI
 	tristate "MSI WMI extras"
 	depends on ACPI_WMI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 652d7c8..1147212 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_MSI_WMI)		+= msi-wmi.o
 obj-$(CONFIG_PEAQ_WMI)		+= peaq-wmi.o
 obj-$(CONFIG_SURFACE3_WMI)	+= surface3-wmi.o
 obj-$(CONFIG_TOPSTAR_LAPTOP)	+= topstar-laptop.o
+obj-$(CONFIG_WMI_MOF)		+= wmi-mof.o
 
 # toshiba_acpi must link after wmi to ensure that wmi devices are found
 # before toshiba_acpi initializes
diff --git a/drivers/platform/x86/wmi-mof.c b/drivers/platform/x86/wmi-mof.c
new file mode 100644
index 0000000..464ceca
--- /dev/null
+++ b/drivers/platform/x86/wmi-mof.c
@@ -0,0 +1,125 @@
+/*
+ * WMI embedded MOF driver
+ *
+ * Copyright (c) 2015 Andrew Lutomirski
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
+#include <linux/acpi.h>
+#include <linux/string.h>
+#include <linux/dmi.h>
+#include <linux/wmi.h>
+#include <acpi/video.h>
+
+#define WMI_MOF_GUID "05901221-D566-11D1-B2F0-00A0C9062910"
+MODULE_ALIAS("wmi:" WMI_MOF_GUID);
+
+struct mof_priv {
+	union acpi_object *mofdata;
+	struct bin_attribute mof_bin_attr;
+};
+
+static ssize_t
+read_mof(struct file *filp, struct kobject *kobj,
+	 struct bin_attribute *attr,
+	 char *buf, loff_t off, size_t count)
+{
+	struct mof_priv *priv =
+		container_of(attr, struct mof_priv, mof_bin_attr);
+
+	if (off >= priv->mofdata->buffer.length)
+		return 0;
+
+	if (count > priv->mofdata->buffer.length - off)
+		count = priv->mofdata->buffer.length - off;
+
+	memcpy(buf, priv->mofdata->buffer.pointer + off, count);
+	return count;
+}
+
+static int wmi_mof_probe(struct wmi_device *wdev)
+{
+	int ret;
+
+	struct mof_priv *priv =
+		devm_kzalloc(&wdev->dev, sizeof(struct mof_priv), GFP_KERNEL);
+
+	if (!priv)
+		return -ENOMEM;
+
+	dev_set_drvdata(&wdev->dev, priv);
+
+	priv->mofdata = wmidev_block_query(wdev, 0);
+	if (!priv->mofdata) {
+		dev_warn(&wdev->dev, "failed to read MOF\n");
+		return -EIO;
+	}
+
+	if (priv->mofdata->type != ACPI_TYPE_BUFFER) {
+		dev_warn(&wdev->dev, "MOF is not a buffer\n");
+		ret = -EIO;
+		goto err_free;
+	}
+
+	sysfs_bin_attr_init(&priv->mof_bin_attr);
+	priv->mof_bin_attr.attr.name = "mof";
+	priv->mof_bin_attr.attr.mode = 0400;
+	priv->mof_bin_attr.read = read_mof;
+	priv->mof_bin_attr.size = priv->mofdata->buffer.length;
+
+	ret = sysfs_create_bin_file(&wdev->dev.kobj, &priv->mof_bin_attr);
+	if (ret)
+		goto err_free;
+
+	return 0;
+
+err_free:
+	kfree(priv->mofdata);
+	return ret;
+}
+
+static int wmi_mof_remove(struct wmi_device *wdev)
+{
+	struct mof_priv *priv = dev_get_drvdata(&wdev->dev);
+
+	sysfs_remove_bin_file(&wdev->dev.kobj, &priv->mof_bin_attr);
+	kfree(priv->mofdata);
+	return 0;
+}
+
+static const struct wmi_device_id wmi_mof_id_table[] = {
+	{ .guid_string = WMI_MOF_GUID },
+	{ },
+};
+
+static struct wmi_driver wmi_mof_driver = {
+	.driver = {
+		.name = "wmi-mof",
+	},
+	.probe = wmi_mof_probe,
+	.remove = wmi_mof_remove,
+	.id_table = wmi_mof_id_table,
+};
+
+module_wmi_driver(wmi_mof_driver);
+
+MODULE_AUTHOR("Andrew Lutomirski <luto@kernel.org>");
+MODULE_DESCRIPTION("WMI embedded MOF driver");
+MODULE_LICENSE("GPL");
-- 
2.9.4
