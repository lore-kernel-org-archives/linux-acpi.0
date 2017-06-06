From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2] platform/x86: wmi-bmof: New driver to expose embedded
 Binary WMI MOF metadata
Date: Mon, 5 Jun 2017 20:16:44 -0700
Message-ID: <cd020900567e5c26af29e0735a3945a855d26a30.1496718529.git.dvhart@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
Sender: platform-driver-x86-owner@vger.kernel.org
To: pali.rohar@gmail.com
Cc: platform-driver-x86@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Mario Limonciello <mario_limonciello@dell.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Many laptops (and maybe servers?) have embedded WMI Binary MOF metadata.
We do not yet have open-source tools for processing the data, although
one is in the works thanks to Pali:

	https://github.com/pali/bmfdec

There is currently no interface to get the data in the first place. By
exposing it, we facilitate the development of new tools.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Mario Limonciello <mario_limonciello@dell.com>
Cc: Pali Rohár <pali.rohar@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
[dvhart: make sysfs mof binary read only, fixup comment block format]
[dvhart: use bmof terminology and dev_err instead of dev_warn]
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
---
since-v1:
 * address Pali's comments:
   * update the cover letter for clarity and accuracy
   * update mof->bmof and MOF to Binary MOF throughout the patch
   * use dev_err instead of dev_warn in wmi_bmof_probe


 drivers/platform/x86/Kconfig    |  12 ++++
 drivers/platform/x86/Makefile   |   1 +
 drivers/platform/x86/wmi-bmof.c | 125 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+)
 create mode 100644 drivers/platform/x86/wmi-bmof.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 49a1d01..6ebe393 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -656,6 +656,18 @@ config ACPI_WMI
 	  It is safe to enable this driver even if your DSDT doesn't define
 	  any ACPI-WMI devices.
 
+config WMI_BMOF
+	tristate "WMI embedded Binary MOF driver"
+	depends on ACPI_WMI
+	default y
+	---help---
+	  Say Y here if you want to be able to read a firmware-embedded
+	  WMI Binary MOF data. Using this requires userspace tools and may be
+	  rather tedious.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called wmi-bmof.
+
 config MSI_WMI
 	tristate "MSI WMI extras"
 	depends on ACPI_WMI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 652d7c8..6a1063e 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_MSI_WMI)		+= msi-wmi.o
 obj-$(CONFIG_PEAQ_WMI)		+= peaq-wmi.o
 obj-$(CONFIG_SURFACE3_WMI)	+= surface3-wmi.o
 obj-$(CONFIG_TOPSTAR_LAPTOP)	+= topstar-laptop.o
+obj-$(CONFIG_WMI_BMOF)		+= wmi-bmof.o
 
 # toshiba_acpi must link after wmi to ensure that wmi devices are found
 # before toshiba_acpi initializes
diff --git a/drivers/platform/x86/wmi-bmof.c b/drivers/platform/x86/wmi-bmof.c
new file mode 100644
index 0000000..e1c0963
--- /dev/null
+++ b/drivers/platform/x86/wmi-bmof.c
@@ -0,0 +1,125 @@
+/*
+ * WMI embedded Binary MOF driver
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
+#define WMI_BMOF_GUID "05901221-D566-11D1-B2F0-00A0C9062910"
+MODULE_ALIAS("wmi:" WMI_BMOF_GUID);
+
+struct bmof_priv {
+	union acpi_object *bmofdata;
+	struct bin_attribute bmof_bin_attr;
+};
+
+static ssize_t
+read_bmof(struct file *filp, struct kobject *kobj,
+	 struct bin_attribute *attr,
+	 char *buf, loff_t off, size_t count)
+{
+	struct bmof_priv *priv =
+		container_of(attr, struct bmof_priv, bmof_bin_attr);
+
+	if (off >= priv->bmofdata->buffer.length)
+		return 0;
+
+	if (count > priv->bmofdata->buffer.length - off)
+		count = priv->bmofdata->buffer.length - off;
+
+	memcpy(buf, priv->bmofdata->buffer.pointer + off, count);
+	return count;
+}
+
+static int wmi_bmof_probe(struct wmi_device *wdev)
+{
+	int ret;
+
+	struct bmof_priv *priv =
+		devm_kzalloc(&wdev->dev, sizeof(struct bmof_priv), GFP_KERNEL);
+
+	if (!priv)
+		return -ENOMEM;
+
+	dev_set_drvdata(&wdev->dev, priv);
+
+	priv->bmofdata = wmidev_block_query(wdev, 0);
+	if (!priv->bmofdata) {
+		dev_err(&wdev->dev, "failed to read Binary MOF\n");
+		return -EIO;
+	}
+
+	if (priv->bmofdata->type != ACPI_TYPE_BUFFER) {
+		dev_err(&wdev->dev, "Binary MOF is not a buffer\n");
+		ret = -EIO;
+		goto err_free;
+	}
+
+	sysfs_bin_attr_init(&priv->bmof_bin_attr);
+	priv->bmof_bin_attr.attr.name = "bmof";
+	priv->bmof_bin_attr.attr.mode = 0400;
+	priv->bmof_bin_attr.read = read_bmof;
+	priv->bmof_bin_attr.size = priv->bmofdata->buffer.length;
+
+	ret = sysfs_create_bin_file(&wdev->dev.kobj, &priv->bmof_bin_attr);
+	if (ret)
+		goto err_free;
+
+	return 0;
+
+ err_free:
+	kfree(priv->bmofdata);
+	return ret;
+}
+
+static int wmi_bmof_remove(struct wmi_device *wdev)
+{
+	struct bmof_priv *priv = dev_get_drvdata(&wdev->dev);
+
+	sysfs_remove_bin_file(&wdev->dev.kobj, &priv->bmof_bin_attr);
+	kfree(priv->bmofdata);
+	return 0;
+}
+
+static const struct wmi_device_id wmi_bmof_id_table[] = {
+	{ .guid_string = WMI_BMOF_GUID },
+	{ },
+};
+
+static struct wmi_driver wmi_bmof_driver = {
+	.driver = {
+		.name = "wmi-bmof",
+	},
+	.probe = wmi_bmof_probe,
+	.remove = wmi_bmof_remove,
+	.id_table = wmi_bmof_id_table,
+};
+
+module_wmi_driver(wmi_bmof_driver);
+
+MODULE_AUTHOR("Andrew Lutomirski <luto@kernel.org>");
+MODULE_DESCRIPTION("WMI embedded Binary MOF driver");
+MODULE_LICENSE("GPL");
-- 
2.9.4


-- 
Darren Hart
VMware Open Source Technology Center
