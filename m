From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/140] ACPI: rename some functions
Date: Wed,  7 Feb 2007 13:50:16 -0500
Message-ID: <11708743611662-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:17538 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422700AbXBGSwq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:52:46 -0500
In-Reply-To: <11708743582090-git-send-email-lenb@kernel.org>
Message-Id: <1d268b0a0f5407138caf0dec9559d68e657a3a74.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
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
@@ -49,13 +49,13 @@ static void setup_sys_fs_device_files(struct acpi_device *dev,
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
@@ -63,7 +63,7 @@ static ssize_t acpi_device_attr_store(struct kobject *kobj,
 				      struct attribute *attr, const char *buf,
 				      size_t len)
 {
-	struct acpi_device *device = to_acpi_device(kobj);
+	struct acpi_device *device = to_acpi_dev(kobj);
 	struct acpi_device_attribute *attribute = to_handle_attr(attr);
 	return attribute->store ? attribute->store(device, buf, len) : -EIO;
 }
@@ -82,7 +82,7 @@ static int namespace_uevent(struct kset *kset, struct kobject *kobj,
 			     char **envp, int num_envp, char *buffer,
 			     int buffer_size)
 {
-	struct acpi_device *dev = to_acpi_device(kobj);
+	struct acpi_device *dev = to_acpi_dev(kobj);
 	int i = 0;
 	int len = 0;
 
@@ -222,7 +222,7 @@ acpi_eject_store(struct acpi_device *device, const char *buf, size_t count)
 /* --------------------------------------------------------------------------
 			ACPI Bus operations
    -------------------------------------------------------------------------- */
-static inline struct acpi_device * to_acpi_dev(struct device * dev)
+static inline struct acpi_device * to_acpi_device(struct device * dev)
 {
 	return container_of(dev, struct acpi_device, dev);
 }
@@ -251,7 +251,7 @@ static int root_suspend(struct acpi_device * acpi_dev, pm_message_t state)
 
 static int acpi_device_suspend(struct device * dev, pm_message_t state)
 {
-	struct acpi_device * acpi_dev = to_acpi_dev(dev);
+	struct acpi_device * acpi_dev = to_acpi_device(dev);
 
 	/*
 	 * For now, we should only register 1 generic device -
@@ -288,7 +288,7 @@ static int root_resume(struct acpi_device * acpi_dev)
 
 static int acpi_device_resume(struct device * dev)
 {
-	struct acpi_device * acpi_dev = to_acpi_dev(dev);
+	struct acpi_device * acpi_dev = to_acpi_device(dev);
 
 	/*
 	 * For now, we should only register 1 generic device -
-- 
1.5.0.rc3.39.gec804
