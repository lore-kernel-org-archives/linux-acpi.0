From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] ACPI / PMIC: remove modular references from non-modular code
Date: Mon, 11 Jul 2016 18:05:16 -0400
Message-ID: <20160711220516.3371-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail5.windriver.com ([192.103.53.11]:60919 "EHLO mail5.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932252AbcGKWFk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Jul 2016 18:05:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

The Kconfig currently controlling compilation of these files are:

drivers/acpi/Kconfig:menuconfig PMIC_OPREGION
drivers/acpi/Kconfig:   bool "PMIC (Power Management Integrated Circuit) operation region support"

drivers/acpi/Kconfig:config BXT_WC_PMIC_OPREGION
drivers/acpi/Kconfig:   bool "ACPI operation region support for BXT WhiskeyCove PMIC"

drivers/acpi/Kconfig:config XPOWER_PMIC_OPREGION
drivers/acpi/Kconfig:   bool "ACPI operation region support for XPower AXP288 PMIC"

...meaning they currently are not being built as a module by anyone.

Lets remove the couple traces of modular infrastructure use, so that
when reading the code there is no doubt it is builtin-only.

We delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

One file was using module_init.  Since module_init translates to
device_initcall in the non-modular case, the init ordering remains
unchanged with this commit.

In one case we replace the module.h with export.h since that file
is exporting some symbols, but does not use __init.  The other two
are using __init and so module.h gets replaced with init.h there.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/acpi/pmic/intel_pmic.c        | 4 +---
 drivers/acpi/pmic/intel_pmic_bxtwc.c  | 6 +-----
 drivers/acpi/pmic/intel_pmic_xpower.c | 7 ++-----
 3 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmic.c
index 6585affc3e26..ca18e0d23df9 100644
--- a/drivers/acpi/pmic/intel_pmic.c
+++ b/drivers/acpi/pmic/intel_pmic.c
@@ -13,7 +13,7 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/acpi.h>
 #include <linux/regmap.h>
 #include <acpi/acpi_lpat.h>
@@ -319,5 +319,3 @@ out_error:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(intel_pmic_install_opregion_handler);
-
-MODULE_LICENSE("GPL");
diff --git a/drivers/acpi/pmic/intel_pmic_bxtwc.c b/drivers/acpi/pmic/intel_pmic_bxtwc.c
index ebe6f09e6910..90011aad4d20 100644
--- a/drivers/acpi/pmic/intel_pmic_bxtwc.c
+++ b/drivers/acpi/pmic/intel_pmic_bxtwc.c
@@ -13,7 +13,7 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/acpi.h>
 #include <linux/mfd/intel_soc_pmic.h>
 #include <linux/regmap.h>
@@ -417,8 +417,4 @@ static int __init intel_bxtwc_pmic_opregion_driver_init(void)
 {
 	return platform_driver_register(&intel_bxtwc_pmic_opregion_driver);
 }
-
 device_initcall(intel_bxtwc_pmic_opregion_driver_init);
-
-MODULE_DESCRIPTION("BXT WhiskeyCove ACPI opregion driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
index 6a082d4de12c..e6e991ac20f3 100644
--- a/drivers/acpi/pmic/intel_pmic_xpower.c
+++ b/drivers/acpi/pmic/intel_pmic_xpower.c
@@ -13,7 +13,7 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/acpi.h>
 #include <linux/mfd/axp20x.h>
 #include <linux/regmap.h>
@@ -262,7 +262,4 @@ static int __init intel_xpower_pmic_opregion_driver_init(void)
 {
 	return platform_driver_register(&intel_xpower_pmic_opregion_driver);
 }
-module_init(intel_xpower_pmic_opregion_driver_init);
-
-MODULE_DESCRIPTION("XPower AXP288 ACPI operation region driver");
-MODULE_LICENSE("GPL");
+device_initcall(intel_xpower_pmic_opregion_driver_init);
-- 
2.8.4

