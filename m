From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 3/3] drivers/acpi: make pmic/intel_pmic_crc.c explicitly non-modular
Date: Mon, 15 Feb 2016 00:27:51 -0500
Message-ID: <1455514071-26368-4-git-send-email-paul.gortmaker@windriver.com>
References: <1455514071-26368-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455514071-26368-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/acpi/Kconfig:config CRC_PMIC_OPREGION
drivers/acpi/Kconfig:   bool "ACPI operation region support for CrystalCove PMIC"

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple modular references, so that when reading
the driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Aaron Lu <aaron.lu@intel.com>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/acpi/pmic/intel_pmic_crc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic_crc.c b/drivers/acpi/pmic/intel_pmic_crc.c
index 42df46a86c25..fcd1852dcdee 100644
--- a/drivers/acpi/pmic/intel_pmic_crc.c
+++ b/drivers/acpi/pmic/intel_pmic_crc.c
@@ -13,7 +13,7 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/acpi.h>
 #include <linux/mfd/intel_soc_pmic.h>
 #include <linux/regmap.h>
@@ -205,7 +205,4 @@ static int __init intel_crc_pmic_opregion_driver_init(void)
 {
 	return platform_driver_register(&intel_crc_pmic_opregion_driver);
 }
-module_init(intel_crc_pmic_opregion_driver_init);
-
-MODULE_DESCRIPTION("CrystalCove ACPI operation region driver");
-MODULE_LICENSE("GPL");
+device_initcall(intel_crc_pmic_opregion_driver_init);
-- 
2.6.1
