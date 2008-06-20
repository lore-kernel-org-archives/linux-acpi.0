From: Len Brown <lenb@kernel.org>
Subject: [PATCH 70/70] ACPI : Add DMI check to disable mwait on broken Compal
Date: Fri, 20 Jun 2008 03:44:12 -0400
Message-ID: <270597594e25cfb1ecdce1fee7c85bb6236cdb9f.1213947350.git.len.brown@intel.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:63387 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbYFTHsD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:48:03 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2R00A2W4C29ZO2@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:48:02 -0500 (CDT)
In-reply-to: <1213947852-10924-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Li Shaohua <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

Add the DMI check to disable mwait for CPU C-states.
If the board is matched with DMI table, OSPM should not use mwait for CPU
C-states even when mwait is supported. In such case the C2C3_FFH access mode
will be disabled.

http://bugzilla.kernel.org/show_bug.cgi?id=10807

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Li Shaohua <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_core.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 9e3c168..67455ad 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -120,6 +120,23 @@ static const struct file_operations acpi_processor_info_fops = {
 
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
+	{},
+};
 
 /* --------------------------------------------------------------------------
                                 Errata Handling
@@ -1095,6 +1112,11 @@ static int __init acpi_processor_init(void)
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
1.5.6

