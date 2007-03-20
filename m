From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 6/8] [-mm] ACPI: add ACPI Processor_throttling sysfs
	interface
Date: Tue, 20 Mar 2007 17:21:33 +0800
Message-ID: <1174382493.8833.85.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5539 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932760AbXCTJWU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Mar 2007 05:22:20 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

From: Zhang Rui <rui.zhang@intel.com>

Add ACPI Processor throttling control sysfs interface.

Attribute	Mode	Description
state_count	RO	Maximum throttling state supported by this
			processor.
active_state	RW	the current throttling state.


Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/processor_core.c       |   11 ++++++
 drivers/acpi/processor_throttling.c |   59 ++++++++++++++++++++++++++++++++++++
 include/acpi/processor.h            |    3 +
 3 files changed, 73 insertions(+)

Index: linux-2.6.21-rc3-mm2/drivers/acpi/processor_throttling.c
===================================================================
--- linux-2.6.21-rc3-mm2.orig/drivers/acpi/processor_throttling.c	2007-03-14 18:47:42.000000000 +0800
+++ linux-2.6.21-rc3-mm2/drivers/acpi/processor_throttling.c	2007-03-14 18:58:59.000000000 +0800
@@ -37,6 +37,7 @@
 #include <asm/uaccess.h>
 
 #include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
 #include <acpi/processor.h>
 
 #define ACPI_PROCESSOR_COMPONENT        0x01000000
@@ -253,6 +254,62 @@ int acpi_processor_get_throttling_info(s
 	return result;
 }
 
+/* sys interface */
+static ssize_t
+acpi_processor_throttling_state_count_show(struct acpi_device *dev, char *buf)
+{
+	struct acpi_processor *pr = acpi_driver_data(dev);
+
+	if (!pr || !pr->flags.throttling)
+		return -EINVAL;
+
+	return sprintf(buf, "%d\n",  pr->throttling.state_count);
+}
+static ACPI_DEVICE_ATTR(state_count, 0444, acpi_processor_throttling_state_count_show, NULL);
+
+static ssize_t
+acpi_processor_throttling_active_state_show(struct acpi_device *dev, char *buf)
+{
+	struct acpi_processor *pr = acpi_driver_data(dev);
+	int result;
+
+	result = acpi_processor_get_throttling(pr);
+	if (result)
+		return result;
+	else
+		return sprintf(buf, "%d\n",  pr->throttling.state);
+}
+static ssize_t
+acpi_processor_throttling_active_state_store(struct acpi_device *dev, const char *buf, size_t count)
+{
+	struct acpi_processor *pr = acpi_driver_data(dev);
+	int state, result;
+	char* endp;
+
+	state = simple_strtol(buf, &endp, 0);
+	if (*endp == '\0')
+		return -EINVAL;
+
+	result = acpi_processor_set_throttling(pr, state);
+	if (!result)
+		result = count;
+
+	return result;
+}
+static ACPI_DEVICE_ATTR(active_state, 0644, acpi_processor_throttling_active_state_show, acpi_processor_throttling_active_state_store);
+
+static struct attribute * processor_throttling_attr[] = {
+	GET_ATTR(state_count),
+	GET_ATTR(active_state),
+	NULL,
+};
+
+struct attribute_group processor_throttling_group = {
+	.name	= "throttling",
+	.attrs	= processor_throttling_attr,
+};
+
+#ifdef CONFIG_ACPI_PROCFS
 /* proc interface */
 
 static int acpi_processor_throttling_seq_show(struct seq_file *seq,
@@ -335,3 +392,5 @@ struct file_operations acpi_processor_th
 	.llseek = seq_lseek,
 	.release = single_release,
 };
+#endif
+
Index: linux-2.6.21-rc3-mm2/include/acpi/processor.h
===================================================================
--- linux-2.6.21-rc3-mm2.orig/include/acpi/processor.h	2007-03-14 18:47:42.000000000 +0800
+++ linux-2.6.21-rc3-mm2/include/acpi/processor.h	2007-03-14 18:58:59.000000000 +0800
@@ -268,7 +268,10 @@ static inline int acpi_processor_ppc_has
 /* in processor_throttling.c */
 int acpi_processor_get_throttling_info(struct acpi_processor *pr);
 int acpi_processor_set_throttling(struct acpi_processor *pr, int state);
+#ifdef CONFIG_ACPI_PROCFS
 extern struct file_operations acpi_processor_throttling_fops;
+#endif
+extern struct attribute_group processor_throttling_group;
 
 /* in processor_idle.c */
 int acpi_processor_power_init(struct acpi_processor *pr,
Index: linux-2.6.21-rc3-mm2/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.21-rc3-mm2.orig/drivers/acpi/processor_core.c	2007-03-14 18:58:51.000000000 +0800
+++ linux-2.6.21-rc3-mm2/drivers/acpi/processor_core.c	2007-03-14 19:00:36.000000000 +0800
@@ -735,6 +735,12 @@ static int __cpuinit acpi_processor_star
 	if (result)
 		goto end;
 
+	if (pr->flags.throttling) {
+		result =sysfs_create_group(&device->dev.kobj, &processor_throttling_group);
+		if (result)
+			goto throttling_attr_error;
+	}
+
 	result = acpi_processor_add_procfs(device);
 	if (result)
 		goto procfs_error;
@@ -757,6 +763,8 @@ static int __cpuinit acpi_processor_star
 	goto end;
 
       procfs_error:
+	sysfs_remove_group(&device->dev.kobj, &processor_throttling_group);
+      throttling_attr_error:
 	acpi_device_remove_sysfs(device, processor_info_attr);
       end:
 	return result;
@@ -841,6 +849,9 @@ static int acpi_processor_remove(struct 
 
 	acpi_processor_remove_procfs(device);
 
+	if (pr->flags.throttling)
+		sysfs_remove_group(&device->dev.kobj, &processor_throttling_group);
+
 	acpi_device_remove_sysfs(device, processor_info_attr);
 
 	processors[pr->id] = NULL;
