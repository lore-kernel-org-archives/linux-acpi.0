From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/2] ACPI: Fix the issue that the DSDT local copy is conflict with the customized DSDT.
Date: Tue,  8 Apr 2014 10:49:12 +0800
Message-ID: <ca34942a48b4d7414b9524c7df84fe110b07c4f8.1396925060.git.lv.zheng@intel.com>
References: <cover.1396925060.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:9445 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754690AbaDHCtX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Apr 2014 22:49:23 -0400
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
 drivers/acpi/bus.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index e7e5844..c113e82 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -52,13 +52,20 @@ struct proc_dir_entry *acpi_root_dir;
 EXPORT_SYMBOL(acpi_root_dir);
 
 #ifdef CONFIG_X86
+#ifndef CONFIG_ACPI_CUSTOM_DSDT
 static int set_copy_dsdt(const struct dmi_system_id *id)
 {
-	printk(KERN_NOTICE "%s detected - "
+	pr_info("ACPI: %s detected - "
 		"force copy of DSDT to local memory\n", id->ident);
 	acpi_gbl_copy_dsdt_locally = 1;
 	return 0;
 }
+#else
+static inline int set_copy_dsdt(const struct dmi_system_id *id)
+{
+	return 0;
+}
+#endif
 
 static struct dmi_system_id dsdt_dmi_table[] __initdata = {
 	/*
-- 
1.7.10

