From: Len Brown <len.brown@intel.com>
Subject: [PATCH 6/6] ACPI: thermal: work around broken AOpen Award BIOS
Date: Thu,  9 Aug 2007 01:58:56 -0400
Message-ID: <11866391413674-git-send-email-len.brown@intel.com>
References: 11866388361593-git-send-email-len.brown@intel.com
 <11866391363162-git-send-email-len.brown@intel.com>
 <11866391373567-git-send-email-len.brown@intel.com>
 <11866391381018-git-send-email-len.brown@intel.com>
 <11866391391260-git-send-email-len.brown@intel.com>
 <11866391393475-git-send-email-len.brown@intel.com>
 <11866391402883-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:23501 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755352AbXHIF7C (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Aug 2007 01:59:02 -0400
In-Reply-To: <11866391402883-git-send-email-len.brown@intel.com>
Message-Id: <e4c19636e4a65815b54691c031410b15194b68b4.1186638234.git.len.brown@intel.com>
In-Reply-To: <c405f58ecf5ebf0ba3752cb24a7cd0cc5075646d.1186638234.git.len.brown@intel.com>
References: <c405f58ecf5ebf0ba3752cb24a7cd0cc5075646d.1186638234.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

Use DMI to:
1. enable polling (BIOS thermal events are broken)
2. disable active trip points (BIOS fan control is broken)
3. disable passive trip point (BIOS hard-codes it too low)

The actual temperature reading does work,
and with the aid of polling, the critical
trip point should work too.

http://bugzilla.kernel.org/show_bug.cgi?id=8842

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/thermal.c |   65 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 2b48ab9..d105d65 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -33,6 +33,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
@@ -1314,10 +1315,74 @@ static int acpi_thermal_resume(struct acpi_device *device)
 	return AE_OK;
 }
 
+#ifdef CONFIG_DMI
+static int thermal_act(struct dmi_system_id *d) {
+
+	if (act == 0) {
+		printk(KERN_NOTICE "ACPI: %s detected: "
+			"disabling all active thermal trip points\n", d->ident);
+		act = -1;
+	}
+	return 0;
+}
+static int thermal_tzp(struct dmi_system_id *d) {
+
+	if (tzp == 0) {
+		printk(KERN_NOTICE "ACPI: %s detected: "
+			"enabling thermal zone polling\n", d->ident);
+		tzp = 300;	/* 300 dS = 30 Seconds */
+	}
+	return 0;
+}
+static int thermal_psv(struct dmi_system_id *d) {
+
+	if (psv == 0) {
+		printk(KERN_NOTICE "ACPI: %s detected: "
+			"disabling all passive thermal trip points\n", d->ident);
+		psv = -1;
+	}
+	return 0;
+}
+
+static struct dmi_system_id thermal_dmi_table[] __initdata = {
+	/*
+	 * Award BIOS on this AOpen makes thermal control almost worthless.
+	 * http://bugzilla.kernel.org/show_bug.cgi?id=8842
+	 */
+	{
+	 .callback = thermal_act,
+	 .ident = "AOpen i915GMm-HFS",
+	 .matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR, "AOpen"),
+		DMI_MATCH(DMI_BOARD_NAME, "i915GMm-HFS"),
+		},
+	},
+	{
+	 .callback = thermal_psv,
+	 .ident = "AOpen i915GMm-HFS",
+	 .matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR, "AOpen"),
+		DMI_MATCH(DMI_BOARD_NAME, "i915GMm-HFS"),
+		},
+	},
+	{
+	 .callback = thermal_tzp,
+	 .ident = "AOpen i915GMm-HFS",
+	 .matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR, "AOpen"),
+		DMI_MATCH(DMI_BOARD_NAME, "i915GMm-HFS"),
+		},
+	},
+	{}
+};
+#endif /* CONFIG_DMI */
+
 static int __init acpi_thermal_init(void)
 {
 	int result = 0;
 
+	dmi_check_system(thermal_dmi_table);
+
 	if (off) {
 		printk(KERN_NOTICE "ACPI: thermal control disabled\n");
 		return -ENODEV;
-- 
1.5.3.rc4.29.g74276
