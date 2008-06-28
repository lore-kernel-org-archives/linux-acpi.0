From: Len Brown <lenb@kernel.org>
Subject: [PATCH 52/84] ACPI: Disable MWAIT via DMI on broken Compal board
Date: Sat, 28 Jun 2008 01:43:56 -0400
Message-ID: <631f4f9efe7a1ba6d980a74ac953473f18e04263.1214631214.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:62972 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576AbYF1Fpf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:45:35 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K3500B5URZIMXD1@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:45:19 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Li Shaohua <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

If a system matches in this DMI table,
Linux will disable MWAIT support for idle.
ie. "idle=nomwait" is automatically invoked
and C1_FFH and C2C3_FFH access mode are disabled.

http://bugzilla.kernel.org/show_bug.cgi?id=10807
http://bugzilla.kernel.org/show_bug.cgi?id=10914

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Li Shaohua <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_core.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index eb99e18..b460bab 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -120,6 +120,29 @@ static const struct file_operations acpi_processor_info_fops = {
 
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
@@ -1096,6 +1119,11 @@ static int __init acpi_processor_init(void)
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
-- 
1.5.6.1.89.gd544

