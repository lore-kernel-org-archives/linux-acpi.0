From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/2] ACPI: delete CONFIG_ACPI_PROCFS_POWER and power procfs
 I/F in 2.6.39
Date: Mon, 10 Jan 2011 11:16:30 +0800
Message-ID: <1294629390.1866.51.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:63101 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752474Ab1AJDSH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 9 Jan 2011 22:18:07 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>


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
---
 Documentation/feature-removal-schedule.txt |   11 +++++++++++
 drivers/acpi/Kconfig                       |    2 ++
 drivers/acpi/ac.c                          |    3 ++-
 drivers/acpi/battery.c                     |    2 ++
 drivers/acpi/sbs.c                         |    2 ++
 5 files changed, 19 insertions(+), 1 deletion(-)

Index: linux-2.6/Documentation/feature-removal-schedule.txt
===================================================================
--- linux-2.6.orig/Documentation/feature-removal-schedule.txt
+++ linux-2.6/Documentation/feature-removal-schedule.txt
@@ -234,6 +234,17 @@ Who:	Zhang Rui <rui.zhang@intel.com>
 
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
Index: linux-2.6/drivers/acpi/ac.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ac.c
+++ linux-2.6/drivers/acpi/ac.c
@@ -197,7 +197,8 @@ static int acpi_ac_add_fs(struct acpi_de
 {
 	struct proc_dir_entry *entry = NULL;
 
-
+	printk(KERN_WARNING PREFIX "Deprecated procfs I/F for AC is loaded,"
+			" please retry with CONFIG_ACPI_PROCFS_POWER cleared\n");
 	if (!acpi_device_dir(device)) {
 		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
 						     acpi_ac_dir);
Index: linux-2.6/drivers/acpi/battery.c
===================================================================
--- linux-2.6.orig/drivers/acpi/battery.c
+++ linux-2.6/drivers/acpi/battery.c
@@ -868,6 +868,8 @@ static int acpi_battery_add_fs(struct ac
 	struct proc_dir_entry *entry = NULL;
 	int i;
 
+	printk(KERN_WARNING PREFIX "Deprecated procfs I/F for battery is loaded,"
+			" please retry with CONFIG_ACPI_PROCFS_POWER cleared\n");
 	if (!acpi_device_dir(device)) {
 		acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device),
 						     acpi_battery_dir);
Index: linux-2.6/drivers/acpi/sbs.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sbs.c
+++ linux-2.6/drivers/acpi/sbs.c
@@ -484,6 +484,8 @@ acpi_sbs_add_fs(struct proc_dir_entry **
 		const struct file_operations *state_fops,
 		const struct file_operations *alarm_fops, void *data)
 {
+	printk(KERN_WARNING PREFIX "Deprecated procfs I/F for SBS is loaded,"
+			" please retry with CONFIG_ACPI_PROCFS_POWER cleared\n");
 	if (!*dir) {
 		*dir = proc_mkdir(dir_name, parent_dir);
 		if (!*dir) {
Index: linux-2.6/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.orig/drivers/acpi/Kconfig
+++ linux-2.6/drivers/acpi/Kconfig
@@ -69,6 +69,8 @@ config ACPI_PROCFS_POWER
 	  /proc/acpi/ac_adapter/* (sys/class/power_supply/*)
 	  This option has no effect on /proc/acpi/ directories
 	  and functions, which do not yet exist in /sys
+	  This option, together with the proc directories, will be
+	  deleted in 2.6.39.
 
 	  Say N to delete power /proc/acpi/ directories that have moved to /sys/
 


