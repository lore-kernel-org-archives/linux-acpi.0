From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/2] ACPI / thermal: reuse module_acpi_driver
Date: Thu,  3 Oct 2013 11:04:54 +0300
Message-ID: <1380787494-14385-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1380787494-14385-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32943 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282Ab3JCIGF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Oct 2013 04:06:05 -0400
In-Reply-To: <1380787494-14385-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, "Rafael J . Wysocki" <rjw@sisk.pl>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There is a macro to register and unregister modules in simple cases, Let's use
it and clean up the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Changes to v1:
 - fix compilation error

 drivers/acpi/thermal.c | 190 ++++++++++++++++++++++---------------------------
 1 file changed, 86 insertions(+), 104 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index e600b5d..9230c36 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -978,6 +978,84 @@ static void acpi_thermal_notify(struct acpi_device *device, u32 event)
 	}
 }
 
+static int thermal_act(const struct dmi_system_id *d) {
+
+	if (act == 0) {
+		pr_notice(PREFIX "%s detected: "
+			  "disabling all active thermal trip points\n", d->ident);
+		act = -1;
+	}
+	return 0;
+}
+
+static int thermal_nocrt(const struct dmi_system_id *d) {
+
+	pr_notice(PREFIX "%s detected: "
+		  "disabling all critical thermal trip point actions.\n", d->ident);
+	nocrt = 1;
+	return 0;
+}
+
+static int thermal_tzp(const struct dmi_system_id *d) {
+
+	if (tzp == 0) {
+		pr_notice(PREFIX "%s detected: "
+			  "enabling thermal zone polling\n", d->ident);
+		tzp = 300;	/* 300 dS = 30 Seconds */
+	}
+	return 0;
+}
+
+static int thermal_psv(const struct dmi_system_id *d) {
+
+	if (psv == 0) {
+		pr_notice(PREFIX "%s detected: "
+			  "disabling all passive thermal trip points\n", d->ident);
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
+	{
+	 .callback = thermal_nocrt,
+	 .ident = "Gigabyte GA-7ZX",
+	 .matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
+		DMI_MATCH(DMI_BOARD_NAME, "7ZX"),
+		},
+	},
+	{}
+};
+
 /*
  * On some platforms, the AML code has dependency about
  * the evaluating order of _TMP and _CRT/_HOT/_PSV/_ACx.
@@ -1068,10 +1146,16 @@ static int acpi_thermal_add(struct acpi_device *device)
 	int result = 0;
 	struct acpi_thermal *tz = NULL;
 
-
 	if (!device)
 		return -EINVAL;
 
+	dmi_check_system(thermal_dmi_table);
+
+	if (off) {
+		pr_notice(PREFIX "thermal control disabled\n");
+		return -ENODEV;
+	}
+
 	tz = kzalloc(sizeof(struct acpi_thermal), GFP_KERNEL);
 	if (!tz)
 		return -ENOMEM;
@@ -1153,106 +1237,4 @@ static int acpi_thermal_resume(struct device *dev)
 }
 #endif
 
-static int thermal_act(const struct dmi_system_id *d) {
-
-	if (act == 0) {
-		pr_notice(PREFIX "%s detected: "
-			  "disabling all active thermal trip points\n", d->ident);
-		act = -1;
-	}
-	return 0;
-}
-static int thermal_nocrt(const struct dmi_system_id *d) {
-
-	pr_notice(PREFIX "%s detected: "
-		  "disabling all critical thermal trip point actions.\n", d->ident);
-	nocrt = 1;
-	return 0;
-}
-static int thermal_tzp(const struct dmi_system_id *d) {
-
-	if (tzp == 0) {
-		pr_notice(PREFIX "%s detected: "
-			  "enabling thermal zone polling\n", d->ident);
-		tzp = 300;	/* 300 dS = 30 Seconds */
-	}
-	return 0;
-}
-static int thermal_psv(const struct dmi_system_id *d) {
-
-	if (psv == 0) {
-		pr_notice(PREFIX "%s detected: "
-			  "disabling all passive thermal trip points\n", d->ident);
-		psv = -1;
-	}
-	return 0;
-}
-
-static struct dmi_system_id thermal_dmi_table[] __initdata = {
-	/*
-	 * Award BIOS on this AOpen makes thermal control almost worthless.
-	 * http://bugzilla.kernel.org/show_bug.cgi?id=8842
-	 */
-	{
-	 .callback = thermal_act,
-	 .ident = "AOpen i915GMm-HFS",
-	 .matches = {
-		DMI_MATCH(DMI_BOARD_VENDOR, "AOpen"),
-		DMI_MATCH(DMI_BOARD_NAME, "i915GMm-HFS"),
-		},
-	},
-	{
-	 .callback = thermal_psv,
-	 .ident = "AOpen i915GMm-HFS",
-	 .matches = {
-		DMI_MATCH(DMI_BOARD_VENDOR, "AOpen"),
-		DMI_MATCH(DMI_BOARD_NAME, "i915GMm-HFS"),
-		},
-	},
-	{
-	 .callback = thermal_tzp,
-	 .ident = "AOpen i915GMm-HFS",
-	 .matches = {
-		DMI_MATCH(DMI_BOARD_VENDOR, "AOpen"),
-		DMI_MATCH(DMI_BOARD_NAME, "i915GMm-HFS"),
-		},
-	},
-	{
-	 .callback = thermal_nocrt,
-	 .ident = "Gigabyte GA-7ZX",
-	 .matches = {
-		DMI_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
-		DMI_MATCH(DMI_BOARD_NAME, "7ZX"),
-		},
-	},
-	{}
-};
-
-static int __init acpi_thermal_init(void)
-{
-	int result = 0;
-
-	dmi_check_system(thermal_dmi_table);
-
-	if (off) {
-		pr_notice(PREFIX "thermal control disabled\n");
-		return -ENODEV;
-	}
-
-	result = acpi_bus_register_driver(&acpi_thermal_driver);
-	if (result < 0)
-		return -ENODEV;
-
-	return 0;
-}
-
-static void __exit acpi_thermal_exit(void)
-{
-
-	acpi_bus_unregister_driver(&acpi_thermal_driver);
-
-	return;
-}
-
-module_init(acpi_thermal_init);
-module_exit(acpi_thermal_exit);
+module_acpi_driver(acpi_thermal_driver);
-- 
1.8.4.rc3

