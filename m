From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 7/8] [-mm] ACPI: add ACPI device sysfs interface
Date: Tue, 20 Mar 2007 17:21:36 +0800
Message-ID: <1174382496.8833.86.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5539 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932975AbXCTJWW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Mar 2007 05:22:22 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

From: Zhang Rui <rui.zhang@intel.com>

Add ACPI Processor passive cooling sysfs interface.

Attribute	Mode	Description
active		RO	the current throttling state limit
user		RW	throttling state limit set by user
thermal		RO	throttling state limit set by thermal

A value "n" means that only Tn ~ Tmax throttling states are allowed.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/processor_core.c    |   11 +++++
 drivers/acpi/processor_thermal.c |   78 ++++++++++++++++++++++++++++++++++++++-
 include/acpi/processor.h         |    3 +
 3 files changed, 91 insertions(+), 1 deletion(-)

Index: linux-2.6.21-rc3-mm2/drivers/acpi/processor_thermal.c
===================================================================
--- linux-2.6.21-rc3-mm2.orig/drivers/acpi/processor_thermal.c	2007-03-16 10:08:05.000000000 +0800
+++ linux-2.6.21-rc3-mm2/drivers/acpi/processor_thermal.c	2007-03-16 11:21:10.000000000 +0800
@@ -310,8 +310,82 @@ int acpi_processor_get_limit_info(struct
 	return 0;
 }
 
-/* /proc interface */
+/* sys interface */
+static ssize_t
+acpi_processor_active_limit_show(struct acpi_device *dev, char *buf)
+{
+	struct acpi_processor *pr = acpi_driver_data(dev);
+
+        if (!pr || !pr->flags.limit)
+		return -EINVAL;
+
+	return sprintf(buf, "%d\n", pr->limit.state.tx);
+}
+
+static ACPI_DEVICE_ATTR(active_limit, 0444, acpi_processor_active_limit_show, NULL);
+
+static ssize_t
+acpi_processor_user_limit_show(struct acpi_device *dev, char *buf)
+{
+	struct acpi_processor *pr = acpi_driver_data(dev);
+
+	if (!pr || !pr->flags.limit)
+		return -EINVAL;
+
+	return sprintf(buf, "%d\n", pr->limit.user.tx);
+}
+static ssize_t
+acpi_processor_user_limit_store(struct acpi_device *dev, const char *buf, size_t count)
+{
+	struct acpi_processor *pr = acpi_driver_data(dev);
+	int result;
+	char *endp;
+	int tx = 0;
 
+	tx = simple_strtol(buf, &endp, 0);
+	if (*endp == '\0')
+		return -EINVAL;
+
+	if (pr->flags.throttling) {
+		if ((tx < 0) || (tx > (pr->throttling.state_count - 1))) {
+			return -EINVAL;
+		}
+		pr->limit.user.tx = tx;
+	}
+
+	result = acpi_processor_apply_limit(pr);
+	if (!result)
+		result = count;
+	return result;
+}
+static ACPI_DEVICE_ATTR(user_limit, 0644, acpi_processor_user_limit_show, acpi_processor_user_limit_store);
+
+static ssize_t
+acpi_processor_thermal_limit_show(struct acpi_device *dev, char *buf)
+{
+	struct acpi_processor *pr = acpi_driver_data(dev);
+
+	if (!pr || !pr->flags.limit)
+		return -EINVAL;
+
+	return sprintf(buf, "%d\n", pr->limit.thermal.tx);
+}
+static ACPI_DEVICE_ATTR(thermal_limit, 0444, acpi_processor_thermal_limit_show, NULL);
+
+static struct attribute * processor_limit_attr[] = {
+	GET_ATTR(active_limit),
+	GET_ATTR(user_limit),
+	GET_ATTR(thermal_limit),
+	NULL,
+};
+
+struct attribute_group processor_limit_group = {
+	.name	= "limit",
+	.attrs	= processor_limit_attr,
+};
+
+/* /proc interface */
+#ifdef CONFIG_ACPI_PROCFS
 static int acpi_processor_limit_seq_show(struct seq_file *seq, void *offset)
 {
 	struct acpi_processor *pr = (struct acpi_processor *)seq->private;
@@ -389,3 +463,5 @@ struct file_operations acpi_processor_li
 	.llseek = seq_lseek,
 	.release = single_release,
 };
+#endif
+
Index: linux-2.6.21-rc3-mm2/include/acpi/processor.h
===================================================================
--- linux-2.6.21-rc3-mm2.orig/include/acpi/processor.h	2007-03-16 10:21:06.000000000 +0800
+++ linux-2.6.21-rc3-mm2/include/acpi/processor.h	2007-03-16 10:21:11.000000000 +0800
@@ -283,7 +283,10 @@ extern struct cpuidle_driver acpi_idle_d
 
 /* in processor_thermal.c */
 int acpi_processor_get_limit_info(struct acpi_processor *pr);
+#ifdef CONFIG_ACPI_PROCFS
 extern struct file_operations acpi_processor_limit_fops;
+#endif
+extern struct attribute_group processor_limit_group;
 
 #ifdef CONFIG_CPU_FREQ
 void acpi_thermal_cpufreq_init(void);
Index: linux-2.6.21-rc3-mm2/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.21-rc3-mm2.orig/drivers/acpi/processor_core.c	2007-03-16 10:21:06.000000000 +0800
+++ linux-2.6.21-rc3-mm2/drivers/acpi/processor_core.c	2007-03-16 10:21:11.000000000 +0800
@@ -741,6 +741,12 @@ static int __cpuinit acpi_processor_star
 			goto throttling_attr_error;
 	}
 
+	if (pr->flags.limit) {
+		result = sysfs_create_group(&device->dev.kobj, &processor_limit_group);
+		if (result)
+			goto limit_attr_error;
+		}
+
 	result = acpi_processor_add_procfs(device);
 	if (result)
 		goto procfs_error;
@@ -763,6 +769,8 @@ static int __cpuinit acpi_processor_star
 	goto end;
 
       procfs_error:
+	sysfs_remove_group(&device->dev.kobj, &processor_limit_group);
+      limit_attr_error:
 	sysfs_remove_group(&device->dev.kobj, &processor_throttling_group);
       throttling_attr_error:
 	acpi_device_remove_sysfs(device, processor_info_attr);
@@ -852,6 +860,9 @@ static int acpi_processor_remove(struct 
 	if (pr->flags.throttling)
 		sysfs_remove_group(&device->dev.kobj, &processor_throttling_group);
 
+	if (pr->flags.limit)
+		sysfs_remove_group(&device->dev.kobj, &processor_limit_group);
+
 	acpi_device_remove_sysfs(device, processor_info_attr);
 
 	processors[pr->id] = NULL;
