From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH2/2] ACPI : Add DMI check to disable mwait for CPU C-states
Date: Fri, 13 Jun 2008 13:33:29 +0800
Message-ID: <1213335209.13591.16.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:64530 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386AbYFMFXB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Jun 2008 01:23:01 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Subject:[ACPI]:Add DMI check to disable mwait for CPU C-states
From: Zhao Yakui <yakui.zhao@intel.com>

Add the DMI check to disable mwait for CPU C-states.
If the board is matched with DMI table, OSPM should not use mwait for CPU 
C-states even when mwait is supported. In such case the C2C3_FFH access mode 
will be disabled.

http://bugzilla.kernel.org/show_bug.cgi?id=10807

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Li Shaohua <shaohua.li@intel.com>

---
 drivers/acpi/processor_core.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

Index: linux-2.6/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_core.c
+++ linux-2.6/drivers/acpi/processor_core.c
@@ -83,6 +83,23 @@ static int idle_nomwait;
 module_param_named(idle, idle_nomwait, int, 0);
 MODULE_PARM_DESC(idle, "Disable the mwait for CPU idle");
 
+static int set_no_mwait(const struct dmi_system_id *id)
+{
+	printk(KERN_NOTICE PREFIX "%s detected - "
+		"disable mwait for CPU C-stetes", id->ident);
+	idle_nomwait = 1;
+	return 0;
+}
+static struct dmi_system_id __cpuinitdata processor_idle_dmi_table[] = {
+	{
+	set_no_mwait, "IFL91 board", {
+	DMI_MATCH(DMI_BIOS_VENDOR, "COMPAL"),
+	DMI_MATCH(DMI_SYS_VENDOR, "ZEPTO"),
+	DMI_MATCH(DMI_PRODUCT_VERSION, "3215W"),
+	DMI_MATCH(DMI_BOARD_NAME, "IFL91") }, NULL},
+	{},
+};
+
 static int acpi_processor_add(struct acpi_device *device);
 static int acpi_processor_start(struct acpi_device *device);
 static int acpi_processor_remove(struct acpi_device *device, int type);
@@ -1097,6 +1114,11 @@ static int __init acpi_processor_init(vo
 		return -ENOMEM;
 	acpi_processor_dir->owner = THIS_MODULE;
 
+	/*
+	 * Check whether the system is DMI table. If yes, OSPM
+	 * should not use mwait for CPU-states.
+	 */
+	dmi_check_system(processor_idle_dmi_table);
 	result = cpuidle_register_driver(&acpi_idle_driver);
 	if (result < 0)
 		goto out_proc;


