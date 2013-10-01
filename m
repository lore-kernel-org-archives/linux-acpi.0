From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] ACPI / thermal: fix trivial compilation error
Date: Tue,  1 Oct 2013 12:15:56 +0300
Message-ID: <1380618956-32051-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:47376 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752875Ab3JAJQS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Oct 2013 05:16:18 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Previous patch didn't move callback function definitions before usage, thus we
end up with ea compilation error. This patch fixes it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/thermal.c | 73 ++++++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 35 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 4c6e0a4..9230c36 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -978,6 +978,44 @@ static void acpi_thermal_notify(struct acpi_device *device, u32 event)
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
 static struct dmi_system_id thermal_dmi_table[] __initdata = {
 	/*
 	 * Award BIOS on this AOpen makes thermal control almost worthless.
@@ -1199,39 +1237,4 @@ static int acpi_thermal_resume(struct device *dev)
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
 module_acpi_driver(acpi_thermal_driver);
-- 
1.8.4.rc3

