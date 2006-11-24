From: Len Brown <len.brown@intel.com>
Subject: [PATCH 2/13] ACPI: rename some functions
Date: Fri, 24 Nov 2006 00:17:30 -0500
Message-ID: <11643454641312-git-send-email-len.brown@intel.com>
References: <11643454612902-git-send-email-len.brown@intel.com> <1164345463205-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:21603 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934267AbWKXFNy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 00:13:54 -0500
In-Reply-To: <1164345463205-git-send-email-len.brown@intel.com>
Message-Id: <1b3d821f47ae0d8393851c4ff82f6dd667868ead.1164343921.git.len.brown@intel.com>
In-Reply-To: <bd119392c453771fdb994728a2568c2e3f17705d.1164343921.git.len.brown@intel.com>
References: <bd119392c453771fdb994728a2568c2e3f17705d.1164343921.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

We want the name 'to_acpi_device'.
And the current macro 'to_acpi_device' will be removed
after device model is setup.
So just simply rename them.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index e0255cb..1f75ba6 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -49,13 +49,13 @@ static void setup_sys_fs_device_files(st
 #define remove_sysfs_device_files(dev)	\
 	setup_sys_fs_device_files(dev, (acpi_device_sysfs_files *)&sysfs_remove_file)
 
-#define to_acpi_device(n) container_of(n, struct acpi_device, kobj)
+#define to_acpi_dev(n) container_of(n, struct acpi_device, kobj)
 #define to_handle_attr(n) container_of(n, struct acpi_device_attribute, attr);
 
 static ssize_t acpi_device_attr_show(struct kobject *kobj,
 				     struct attribute *attr, char *buf)
 {
-	struct acpi_device *device = to_acpi_device(kobj);
+	struct acpi_device *device = to_acpi_dev(kobj);
 	struct acpi_device_attribute *attribute = to_handle_attr(attr);
 	return attribute->show ? attribute->show(device, buf) : -EIO;
 }
@@ -63,7 +63,7 @@ static ssize_t acpi_device_attr_store(st
 				      struct attribute *attr, const char *buf,
 				      size_t len)
 {
-	struct acpi_device *device = to_acpi_device(kobj);
+	struct acpi_device *device = to_acpi_dev(kobj);
 	struct acpi_device_attribute *attribute = to_handle_attr(attr);
 	return attribute->store ? attribute->store(device, buf, len) : -EIO;
 }
@@ -82,7 +82,7 @@ static int namespace_uevent(struct kset
 			     char **envp, int num_envp, char *buffer,
 			     int buffer_size)
 {
-	struct acpi_device *dev = to_acpi_device(kobj);
+	struct acpi_device *dev = to_acpi_dev(kobj);
 	int i = 0;
 	int len = 0;
 
@@ -222,7 +222,7 @@ acpi_eject_store(struct acpi_device *dev
 /* --------------------------------------------------------------------------
 			ACPI Bus operations
    -------------------------------------------------------------------------- */
-static inline struct acpi_device * to_acpi_dev(struct device * dev)
+static inline struct acpi_device * to_acpi_device(struct device * dev)
 {
 	return container_of(dev, struct acpi_device, dev);
 }
@@ -251,7 +251,7 @@ static int root_suspend(struct acpi_devi
 
 static int acpi_device_suspend(struct device * dev, pm_message_t state)
 {
-	struct acpi_device * acpi_dev = to_acpi_dev(dev);
+	struct acpi_device * acpi_dev = to_acpi_device(dev);
 
 	/*
 	 * For now, we should only register 1 generic device -
@@ -288,7 +288,7 @@ static int root_resume(struct acpi_devic
 
 static int acpi_device_resume(struct device * dev)
 {
-	struct acpi_device * acpi_dev = to_acpi_dev(dev);
+	struct acpi_device * acpi_dev = to_acpi_device(dev);
 
 	/*
 	 * For now, we should only register 1 generic device -
-- 
1.4.4.g59427
