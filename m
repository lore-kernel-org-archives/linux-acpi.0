From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 5/5] ACPI / PMIC: mfd: intel_pmic_chtwc: This driver must always be builtin
Date: Wed, 22 Mar 2017 12:29:23 +0100
Message-ID: <20170322112923.20200-6-hdegoede@redhat.com>
References: <20170322112923.20200-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170322112923.20200-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The chtwc PMIC provides an ACPI OPRegion handler, which must be available
before other drivers using it are loaded, which can only be ensured if
both the mfd and opregion drivers are built in.

This fixes errors like these during boot:

mmc0: SDHCI controller on ACPI [80860F14:00] using ADMA
ACPI Error: No handler for Region [REGS] (ffff93543b0cc3a8) [UserDefinedRegion] (20170119/evregion-166)
ACPI Error: Region UserDefinedRegion (ID=143) has no handler (20170119/exfldio-299)
ACPI Error: Method parse/execution failed [\_SB.PCI0.I2C7.PMI5.GET] (Node ffff93543b0cde10), AE_NOT_EXIST (20170119/psparse-543)
ACPI Error: Method parse/execution failed [\_SB.PCI0.SHC1._PS0] (Node ffff93543b0b5cd0), AE_NOT_EXIST (20170119/psparse-543)
acpi 80860F14:02: Failed to change power state to D0

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ec09fa2..842530f 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -517,7 +517,7 @@ config BXT_WC_PMIC_OPREGION
 	  This config adds ACPI operation region support for BXT WhiskeyCove PMIC.
 
 config CHT_WC_PMIC_OPREGION
-	tristate "ACPI operation region support for CHT Whiskey Cove PMIC"
+	bool "ACPI operation region support for CHT Whiskey Cove PMIC"
 	depends on INTEL_SOC_PMIC_CHTWC
 	help
 	  This config adds ACPI operation region support for CHT Whiskey Cove PMIC.
-- 
2.9.3
