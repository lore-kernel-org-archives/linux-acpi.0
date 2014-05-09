From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 2/2] ACPI: Fix the issue that the DSDT local copy is conflict with the customized DSDT.
Date: Fri,  9 May 2014 16:44:19 +0800
Message-ID: <93e6bbbfb41fd514dc207b10b422fbc8afdfa432.1399624932.git.lv.zheng@intel.com>
References: <cover.1396925060.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:7595 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756431AbaEIIoX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 May 2014 04:44:23 -0400
In-Reply-To: <cover.1396925060.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Enrico Etxe Arte <goitizena.generoa@gmail.com>

This patch fixes the following issue:
If DSDT is customized, no local DSDT copy is needed.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=69711
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Enrico Etxe Arte <goitizena.generoa@gmail.com>
---
 drivers/acpi/bus.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 610261a..cfd2318 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -52,6 +52,12 @@ struct proc_dir_entry *acpi_root_dir;
 EXPORT_SYMBOL(acpi_root_dir);
 
 #ifdef CONFIG_X86
+#ifdef CONFIG_ACPI_CUSTOM_DSDT
+static inline int set_copy_dsdt(const struct dmi_system_id *id)
+{
+	return 0;
+}
+#else
 static int set_copy_dsdt(const struct dmi_system_id *id)
 {
 	printk(KERN_NOTICE "%s detected - "
@@ -59,6 +65,7 @@ static int set_copy_dsdt(const struct dmi_system_id *id)
 	acpi_gbl_copy_dsdt_locally = 1;
 	return 0;
 }
+#endif
 
 static struct dmi_system_id dsdt_dmi_table[] __initdata = {
 	/*
-- 
1.7.10

