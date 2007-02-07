From: Len Brown <lenb@kernel.org>
Subject: [PATCH 135/140] ACPI: bay: make bay a platform driver
Date: Wed,  7 Feb 2007 13:52:29 -0500
Message-ID: <11708745533065-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org> <11708744813011-git-send-email-lenb@kernel.org> <11708744852095-git-send-email-lenb@kernel.org> <117
 08744874154-git-send-email-lenb@kernel.org> <11708744878-git-send-email-lenb@kernel.org> <1170874488430-git-send-email-lenb@kernel.org> <11708744903381-git-send-email-lenb@kernel.org> <11708744911989-git-send-email-lenb@kernel.org> <11708744922677-git-send-email-lenb@kernel.org> <11708744934033-git-send-email-lenb@kernel.org> <1170874494939-git-send-email-lenb@kernel.org> <11708744951308-git-send-emailMessage-Id: <2b167c01190b647c976e7fab312f2e3d3b3a785f.1170873819.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:37036 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422883AbXBGSzz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:55:55 -0500
In-Reply-To: <11708745522982-git-send-email-lenb@kernel.org>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Len Brown <len.brown@intel.com>

From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Convert the bay driver to be a platform driver, so that we can have
sysfs entries.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bay.c |   87 +++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 76 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/bay.c b/drivers/acpi/bay.c
index 0c0a620..3f0ae7d 100644
--- a/drivers/acpi/bay.c
+++ b/drivers/acpi/bay.c
@@ -30,6 +30,7 @@
 #include <acpi/acpi_drivers.h>
 #include <linux/seq_file.h>
 #include <asm/uaccess.h>
+#include <linux/platform_device.h>
 
 #define ACPI_BAY_DRIVER_NAME "ACPI Removable Drive Bay Driver"
 
@@ -45,7 +46,6 @@ MODULE_LICENSE("GPL");
 	struct acpi_buffer buffer = {sizeof(prefix), prefix};\
 	acpi_get_name(h, ACPI_FULL_PATHNAME, &buffer);\
 	printk(KERN_DEBUG PREFIX "%s: %s\n", prefix, s); }
-
 static void bay_notify(acpi_handle handle, u32 event, void *data);
 static int acpi_bay_add(struct acpi_device *device);
 static int acpi_bay_remove(struct acpi_device *device, int type);
@@ -66,6 +66,7 @@ struct bay {
 	acpi_handle handle;
 	char *name;
 	struct list_head list;
+	struct platform_device *pdev;
 };
 
 LIST_HEAD(drive_bays);
@@ -133,6 +134,33 @@ static void eject_device(acpi_handle handle)
 		pr_debug("Failed to evaluate _EJ0!\n");
 }
 
+/*
+ * show_present - read method for "present" file in sysfs
+ */
+static ssize_t show_present(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct bay *bay = dev_get_drvdata(dev);
+	return snprintf(buf, PAGE_SIZE, "%d\n", bay_present(bay));
+
+}
+DEVICE_ATTR(present, S_IRUGO, show_present, NULL);
+
+/*
+ * write_eject - write method for "eject" file in sysfs
+ */
+static ssize_t write_eject(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct bay *bay = dev_get_drvdata(dev);
+
+	if (!count)
+		return -EINVAL;
+
+	eject_device(bay->handle);
+	return count;
+}
+DEVICE_ATTR(eject, S_IWUSR, NULL, write_eject);
 
 /**
  * is_ata - see if a device is an ata device
@@ -218,14 +246,31 @@ static int acpi_bay_add(struct acpi_device *device)
 
 static int acpi_bay_add_fs(struct bay *bay)
 {
-	if (!bay)
-		return -EINVAL;
+	int ret;
+	struct device *dev = &bay->pdev->dev;
+
+	ret = device_create_file(dev, &dev_attr_present);
+	if (ret)
+		goto add_fs_err;
+	ret = device_create_file(dev, &dev_attr_eject);
+	if (ret) {
+		device_remove_file(dev, &dev_attr_present);
+		goto add_fs_err;
+	}
+	return 0;
+
+ add_fs_err:
+	bay_dprintk(bay->handle, "Error adding sysfs files\n");
+	return ret;
 }
 
 static void acpi_bay_remove_fs(struct bay *bay)
 {
-	if (!bay)
-		return;
+	struct device *dev = &bay->pdev->dev;
+
+	/* cleanup sysfs */
+	device_remove_file(dev, &dev_attr_present);
+	device_remove_file(dev, &dev_attr_eject);
 }
 
 static int bay_is_dock_device(acpi_handle handle)
@@ -240,10 +285,11 @@ static int bay_is_dock_device(acpi_handle handle)
 	return (is_dock_device(handle) || is_dock_device(parent));
 }
 
-static int bay_add(acpi_handle handle)
+static int bay_add(acpi_handle handle, int id)
 {
 	acpi_status status;
 	struct bay *new_bay;
+	struct platform_device *pdev;
 	struct acpi_buffer nbuffer = {ACPI_ALLOCATE_BUFFER, NULL};
 	acpi_get_name(handle, ACPI_FULL_PATHNAME, &nbuffer);
 
@@ -252,12 +298,24 @@ static int bay_add(acpi_handle handle)
 	/*
 	 * Initialize bay device structure
 	 */
-	new_bay = kmalloc(GFP_ATOMIC, sizeof(*new_bay));
+	new_bay = kzalloc(GFP_ATOMIC, sizeof(*new_bay));
 	INIT_LIST_HEAD(&new_bay->list);
 	new_bay->handle = handle;
 	new_bay->name = (char *)nbuffer.pointer;
-	list_add(&new_bay->list, &drive_bays);
-	acpi_bay_add_fs(new_bay);
+
+	/* initialize platform device stuff */
+	pdev = platform_device_register_simple(ACPI_BAY_CLASS, id, NULL, 0);
+	if (pdev == NULL) {
+		printk(KERN_ERR PREFIX "Error registering bay device\n");
+		goto bay_add_err;
+	}
+	new_bay->pdev = pdev;
+	platform_set_drvdata(pdev, new_bay);
+
+	if (acpi_bay_add_fs(new_bay)) {
+		platform_device_unregister(new_bay->pdev);
+		goto bay_add_err;
+	}
 
 	/* register for events on this device */
 	status = acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
@@ -273,8 +331,14 @@ static int bay_add(acpi_handle handle)
 		bay_dprintk(handle, "Is dependent on dock\n");
 		register_hotplug_dock_device(handle, bay_notify, new_bay);
 	}
+	list_add(&new_bay->list, &drive_bays);
 	printk(KERN_INFO PREFIX "Bay [%s] Added\n", new_bay->name);
 	return 0;
+
+bay_add_err:
+	kfree(new_bay->name);
+	kfree(new_bay);
+	return -ENODEV;
 }
 
 static int acpi_bay_remove(struct acpi_device *device, int type)
@@ -393,8 +457,8 @@ find_bay(acpi_handle handle, u32 lvl, void *context, void **rv)
 	 */
 	if (is_ejectable_bay(handle)) {
 		bay_dprintk(handle, "found ejectable bay");
-		bay_add(handle);
-		(*count)++;
+		if (!bay_add(handle, *count))
+			(*count)++;
 	}
 	return AE_OK;
 }
@@ -429,6 +493,7 @@ static void __exit bay_exit(void)
 		acpi_bay_remove_fs(bay);
 		acpi_remove_notify_handler(bay->handle, ACPI_SYSTEM_NOTIFY,
 			bay_notify);
+		platform_device_unregister(bay->pdev);
 		kfree(bay->name);
 		kfree(bay);
 	}
-- 
1.5.0.rc3.39.gec804
