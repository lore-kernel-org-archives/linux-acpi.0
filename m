From: Len Brown <lenb@kernel.org>
Subject: [PATCH 30/48] ACPI: delete CONFIG_ACPI_PROCFS_POWER and power procfs
 I/F in 2.6.39
Date: Wed, 12 Jan 2011 05:19:24 -0500
Message-ID: <6d855fcdd24d2491455527c4999b4d04363f1980.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:49262 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755434Ab1ALSAZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 13:00:25 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEX007SA8OAUAI1@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 12:00:25 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

sysfs I/F for ACPI power devices, including AC and Battery,
has been working in upstream kenrel since 2.6.24, Sep 2007.
In 2.6.37, we made the sysfs I/F always built in and this option
disabled by default.
Now, we plan to remove this option and the ACPI power procfs
interface in 2.6.39.

First, update the feature-removal-schedule to announce this change.
Second, add runtime warnings in ACPI AC/Battery/SBS driver, so that
users will notice this change even if "make oldconfig" is used.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/feature-removal-schedule.txt |   11 +++++++++++
 drivers/acpi/Kconfig                       |    2 ++
 drivers/acpi/ac.c                          |    3 ++-
 drivers/acpi/battery.c                     |    2 ++
 drivers/acpi/sbs.c                         |    2 ++
 5 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 6c2f55e..f281532 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -232,6 +232,17 @@ Who:	Zhang Rui <rui.zhang@intel.com>
 
 ---------------------------
 
+What:	CONFIG_ACPI_PROCFS_POWER
+When:	2.6.39
+Why:	sysfs I/F for ACPI power devices, including AC and Battery,
+        has been working in upstream kenrel since 2.6.24, Sep 2007.
+	In 2.6.37, we make the sysfs I/F always built in and this option
+	disabled by default.
+	Remove this option and the ACPI power procfs interface in 2.6.39.
+Who:	Zhang Rui <rui.zhang@intel.com>
+
+---------------------------
+
 What:	/proc/acpi/button
 When:	August 2007
 Why:	/proc/acpi/button has been replaced by events to the input layer
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 5959077..788e88e 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -70,6 +70,8 @@ config ACPI_PROCFS_POWER
 	  /proc/acpi/ac_adapter/* (sys/class/power_supply/*)
 	  This option has no effect on /proc/acpi/ directories
 	  and functions, which do not yet exist in /sys
+	  This option, together with the proc directories, will be
+	  deleted in 2.6.39.
 
 	  Say N to delete power /proc/acpi/ directories that have moved to /sys/
 
diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index ba9afea..f441e92 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -185,7 +185,8 @@ static int acpi_ac_add_fs(struct acpi_device *device)
 {
 	struct proc_dir_entry *entry = NULL;
 
-
+	printk(KERN_WARNING PREFIX "Deprecated procfs I/F for AC is loaded,"
+			" please retry with CONFIG_ACPI_PROCFS_POWER cleared\n");
 	if (!acpi_device_dir(device)) {
 		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
 						     acpi_ac_dir);
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 95649d3..2a31421 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -868,6 +868,8 @@ static int acpi_battery_add_fs(struct acpi_device *device)
 	struct proc_dir_entry *entry = NULL;
 	int i;
 
+	printk(KERN_WARNING PREFIX "Deprecated procfs I/F for battery is loaded,"
+			" please retry with CONFIG_ACPI_PROCFS_POWER cleared\n");
 	if (!acpi_device_dir(device)) {
 		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
 						     acpi_battery_dir);
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index e5dbedb..51ae379 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -484,6 +484,8 @@ acpi_sbs_add_fs(struct proc_dir_entry **dir,
 		const struct file_operations *state_fops,
 		const struct file_operations *alarm_fops, void *data)
 {
+	printk(KERN_WARNING PREFIX "Deprecated procfs I/F for SBS is loaded,"
+			" please retry with CONFIG_ACPI_PROCFS_POWER cleared\n");
 	if (!*dir) {
 		*dir = proc_mkdir(dir_name, parent_dir);
 		if (!*dir) {
-- 
1.7.4.rc1.7.g2cf08

