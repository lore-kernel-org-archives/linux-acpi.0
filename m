From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4/5] mfd: intel_soc_pmic_chtwc: This driver must always be builtin when enabled
Date: Wed, 22 Mar 2017 12:29:22 +0100
Message-ID: <20170322112923.20200-5-hdegoede@redhat.com>
References: <20170322112923.20200-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759386AbdCVL3e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 22 Mar 2017 07:29:34 -0400
In-Reply-To: <20170322112923.20200-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

The chtwc PMIC provides an ACPI OPRegion handler, which must be available
before other drivers using it are loaded, which can only be ensured if
the mfd, opregion and i2c-bus drivers are built in.

This commit changes the option for the mfd driver to bool and adds
a select for the i2c-bus driver, ensuring both are built-in if enabled.

This fixes errors like these during boot:

mmc0: SDHCI controller on ACPI [80860F14:00] using ADMA
ACPI Error: No handler for Region [REGS] (ffff93543b0cc3a8) [UserDefinedRegion] (20170119/evregion-166)
ACPI Error: Region UserDefinedRegion (ID=143) has no handler (20170119/exfldio-299)
ACPI Error: Method parse/execution failed [\_SB.PCI0.I2C7.PMI5.GET] (Node ffff93543b0cde10), AE_NOT_EXIST (20170119/psparse-543)
ACPI Error: Method parse/execution failed [\_SB.PCI0.SHC1._PS0] (Node ffff93543b0b5cd0), AE_NOT_EXIST (20170119/psparse-543)
acpi 80860F14:02: Failed to change power state to D0

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 08f8dcb..396245d 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -443,12 +443,15 @@ config INTEL_SOC_PMIC
 	  on these systems.
 
 config INTEL_SOC_PMIC_CHTWC
-	tristate "Support for Intel Cherry Trail Whiskey Cove PMIC"
+	# This is a bool as it provides an ACPI Opregion which must be
+	# available as soon as possible
+	bool "Support for Intel Cherry Trail Whiskey Cove PMIC"
 	depends on ACPI
 	depends on I2C
 	select MFD_CORE
 	select REGMAP_I2C
 	select REGMAP_IRQ
+	select I2C_DESIGNWARE_PLATFORM
 	help
 	  Select this option to enable support for the Intel Cherry Trail
 	  Whiskey Cove PMIC found on some Intel Cherry Trail systems.
-- 
2.9.3

