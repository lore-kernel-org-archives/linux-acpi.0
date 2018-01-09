From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] ACPI / PMIC: Convert to use builtin_platform_driver() macro
Date: Tue,  9 Jan 2018 22:26:58 +0200
Message-ID: <20180109202658.85313-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14135 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752241AbeAIU1C (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 9 Jan 2018 15:27:02 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

All of PMIC OpRegion drivers can't be modules, thus, convert them to use
builtin_platform_driver() macro and remove redundant MODULE_*() macros.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/pmic/intel_pmic_bxtwc.c    | 7 +------
 drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 5 +----
 drivers/acpi/pmic/intel_pmic_chtwc.c    | 7 +------
 drivers/acpi/pmic/intel_pmic_crc.c      | 7 +------
 drivers/acpi/pmic/intel_pmic_xpower.c   | 7 +------
 5 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic_bxtwc.c b/drivers/acpi/pmic/intel_pmic_bxtwc.c
index 2012d1d87dc3..886ac8b93cd0 100644
--- a/drivers/acpi/pmic/intel_pmic_bxtwc.c
+++ b/drivers/acpi/pmic/intel_pmic_bxtwc.c
@@ -412,9 +412,4 @@ static struct platform_driver intel_bxtwc_pmic_opregion_driver = {
 	},
 	.id_table = bxt_wc_opregion_id_table,
 };
-
-static int __init intel_bxtwc_pmic_opregion_driver_init(void)
-{
-	return platform_driver_register(&intel_bxtwc_pmic_opregion_driver);
-}
-device_initcall(intel_bxtwc_pmic_opregion_driver_init);
+builtin_platform_driver(intel_bxtwc_pmic_opregion_driver);
diff --git a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
index 109c1e9c9c7a..f6d73a243d80 100644
--- a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
+++ b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
@@ -131,7 +131,4 @@ static struct platform_driver chtdc_ti_pmic_opregion_driver = {
 	},
 	.id_table = chtdc_ti_pmic_opregion_id_table,
 };
-module_platform_driver(chtdc_ti_pmic_opregion_driver);
-
-MODULE_DESCRIPTION("Dollar Cove TI PMIC opregion driver");
-MODULE_LICENSE("GPL v2");
+builtin_platform_driver(chtdc_ti_pmic_opregion_driver);
diff --git a/drivers/acpi/pmic/intel_pmic_chtwc.c b/drivers/acpi/pmic/intel_pmic_chtwc.c
index 813b829e1c24..9912422c8185 100644
--- a/drivers/acpi/pmic/intel_pmic_chtwc.c
+++ b/drivers/acpi/pmic/intel_pmic_chtwc.c
@@ -264,7 +264,6 @@ static const struct platform_device_id cht_wc_opregion_id_table[] = {
 	{ .name = "cht_wcove_region" },
 	{},
 };
-MODULE_DEVICE_TABLE(platform, cht_wc_opregion_id_table);
 
 static struct platform_driver intel_cht_wc_pmic_opregion_driver = {
 	.probe = intel_cht_wc_pmic_opregion_probe,
@@ -273,8 +272,4 @@ static struct platform_driver intel_cht_wc_pmic_opregion_driver = {
 	},
 	.id_table = cht_wc_opregion_id_table,
 };
-module_platform_driver(intel_cht_wc_pmic_opregion_driver);
-
-MODULE_DESCRIPTION("Intel CHT Whiskey Cove PMIC operation region driver");
-MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
-MODULE_LICENSE("GPL");
+builtin_platform_driver(intel_cht_wc_pmic_opregion_driver);
diff --git a/drivers/acpi/pmic/intel_pmic_crc.c b/drivers/acpi/pmic/intel_pmic_crc.c
index d7f1761ab1bc..7ffa74048107 100644
--- a/drivers/acpi/pmic/intel_pmic_crc.c
+++ b/drivers/acpi/pmic/intel_pmic_crc.c
@@ -201,9 +201,4 @@ static struct platform_driver intel_crc_pmic_opregion_driver = {
 		.name = "crystal_cove_pmic",
 	},
 };
-
-static int __init intel_crc_pmic_opregion_driver_init(void)
-{
-	return platform_driver_register(&intel_crc_pmic_opregion_driver);
-}
-device_initcall(intel_crc_pmic_opregion_driver_init);
+builtin_platform_driver(intel_crc_pmic_opregion_driver);
diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
index 6c99d3f81095..316e55174aa9 100644
--- a/drivers/acpi/pmic/intel_pmic_xpower.c
+++ b/drivers/acpi/pmic/intel_pmic_xpower.c
@@ -278,9 +278,4 @@ static struct platform_driver intel_xpower_pmic_opregion_driver = {
 		.name = "axp288_pmic_acpi",
 	},
 };
-
-static int __init intel_xpower_pmic_opregion_driver_init(void)
-{
-	return platform_driver_register(&intel_xpower_pmic_opregion_driver);
-}
-device_initcall(intel_xpower_pmic_opregion_driver_init);
+builtin_platform_driver(intel_xpower_pmic_opregion_driver);
-- 
2.15.1

