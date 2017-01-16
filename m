From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI: save NVS memory for Lenovo G50-45
Date: Mon, 16 Jan 2017 10:55:45 +0800
Message-ID: <1484535345-5126-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:61485 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751603AbdAPCzx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 15 Jan 2017 21:55:53 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

In commit 821d6f0359b0 ("ACPI / sleep: Do not save NVS for new machines to
accelerate S3"), to optimize S3 suspend/resume speed, code is introduced
to ignore NVS memory saving during S3 for all the platforms later than
2012.

But, Lenovo G50-45, a platform released in 2015, still needs NVS memory
saving during S3. A quirk is introduced for this platform.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=189431
Tested-by: Przemek <soprwa@gmail.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/sleep.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 9b6cebe227a0..0804e63863b6 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -130,6 +130,17 @@ void __init acpi_nvs_nosave_s3(void)
 	nvs_nosave_s3 = true;
 }
 
+void __init acpi_nvs_save_s3(void)
+{
+	nvs_nosave_s3 = false;
+}
+
+static int __init init_nvs_save_s3(const struct dmi_system_id *d)
+{
+	acpi_nvs_save_s3();
+	return 0;
+}
+
 /*
  * ACPI 1.0 wants us to execute _PTS before suspending devices, so we allow the
  * user to request that behavior by using the 'acpi_old_suspend_ordering'
@@ -324,6 +335,19 @@ static struct dmi_system_id acpisleep_dmi_table[] __initdata = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "K54HR"),
 		},
 	},
+	/*
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=189431
+	 * Lenovo G50-45 is a platform later than 2012, but needs nvs memory
+	 * saving during S3.
+	 */
+	{
+	.callback = init_nvs_save_s3,
+	.ident = "Lenovo G50-45",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "80E3"),
+		},
+	},
 	{},
 };
 
-- 
2.7.4

