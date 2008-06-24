From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH4/4] ACPI :  Add DMI check to disable mwait for CPU C-states
Date: Tue, 24 Jun 2008 18:02:57 +0800
Message-ID: <1214301777.31069.11.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:32994 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754478AbYFXJwE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Jun 2008 05:52:04 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Subject:ACPI:Add DMI check to disable mwait for CPU C-states
From: Zhao Yakui <yakui.zhao@intel.com>

Add the DMI check to disable mwait for CPU C-states.
If the board is matched with DMI table, OSPM should not use mwait for CPU 
C-states even when mwait is supported. In such case the C2C3_FFH access mode 
will be disabled.C1_FFH access mode will also be disabled.

http://bugzilla.kernel.org/show_bug.cgi?id=10807
http://bugzilla.kernel.org/show_bug.cgi?id=10914

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Li Shaohua <shaohua.li@intel.com>

---
 drivers/acpi/processor_core.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

Index: linux-2.6/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_core.c
+++ linux-2.6/drivers/acpi/processor_core.c
@@ -120,6 +120,29 @@ static const struct file_operations acpi
 
 struct acpi_processor *processors[NR_CPUS];
 struct acpi_processor_errata errata __read_mostly;
+static int set_no_mwait(const struct dmi_system_id *id)
+{
+	printk(KERN_NOTICE PREFIX "%s detected - "
+		"disable mwait for CPU C-stetes\n", id->ident);
+	idle_nomwait = 1;
+	return 0;
+}
+
+static struct dmi_system_id __cpuinitdata processor_idle_dmi_table[] = {
+	{
+	set_no_mwait, "IFL91 board", {
+	DMI_MATCH(DMI_BIOS_VENDOR, "COMPAL"),
+	DMI_MATCH(DMI_SYS_VENDOR, "ZEPTO"),
+	DMI_MATCH(DMI_PRODUCT_VERSION, "3215W"),
+	DMI_MATCH(DMI_BOARD_NAME, "IFL91") }, NULL},
+	{
+	set_no_mwait, "Extensa 5220", {
+	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+	DMI_MATCH(DMI_SYS_VENDOR, "ACER"),
+	DMI_MATCH(DMI_PRODUCT_VERSION, "0100"),
+	DMI_MATCH(DMI_BOARD_NAME, "Columbia") }, NULL},
+	{},
+};
 
 /* --------------------------------------------------------------------------
                                 Errata Handling
@@ -1096,6 +1119,11 @@ static int __init acpi_processor_init(vo
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


