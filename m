From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/5] mfd: intel_soc_pmic: Select designware i2c-bus driver
Date: Wed, 22 Mar 2017 12:29:20 +0100
Message-ID: <20170322112923.20200-3-hdegoede@redhat.com>
References: <20170322112923.20200-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170322112923.20200-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The Crystal Cove PMIC provides an ACPI OPRegion handler, which must be
available before other drivers using it are loaded, which is why
INTEL_SOC_PMIC is a bool.

Just having the driver is not enough, the driver for the i2c-bus must
also be built in, to ensure this, this patch adds a select for it.

While at it this patch also changes the human readable name of the Kconfig
option to make clear the INTEL_SOC_PMIC option selects support for the
Intel Crystal Cove PMIC and documents why this is a bool.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Note this patch will partially conflicts with (contains the same changes as)
a patch in Andy Shevchenko's tree.
---
 drivers/mfd/Kconfig | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index d427a10..0c6a967 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -425,14 +425,17 @@ config LPC_SCH
 	  System Management Bus and General Purpose I/O.
 
 config INTEL_SOC_PMIC
-	bool "Support for Intel Atom SoC PMIC"
+	# This is a bool as it provides an ACPI Opregion which must be
+	# available as soon as possible
+	bool "Support for Intel Crystal Cove PMIC"
 	depends on GPIOLIB
 	depends on I2C=y
 	select MFD_CORE
 	select REGMAP_I2C
 	select REGMAP_IRQ
+	select I2C_DESIGNWARE_PLATFORM
 	help
-	  Select this option to enable support for the PMIC device
+	  Select this option to enable support for the Crystal Cove PMIC
 	  on some Intel SoC systems. The PMIC provides ADC, GPIO,
 	  thermal, charger and related power management functions
 	  on these systems.
-- 
2.9.3
