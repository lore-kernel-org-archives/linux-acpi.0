From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 2/2] ACPI / PMIC: xpower: Add support for the GPI1 regulator to the OpRegion handler
Date: Fri, 21 Apr 2017 13:48:09 +0200
Message-ID: <20170421114809.17468-2-hdegoede@redhat.com>
References: <20170421114809.17468-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S971278AbdDULsT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Apr 2017 07:48:19 -0400
In-Reply-To: <20170421114809.17468-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-acpi@vger.kernel.org, russianneuromancer@ya.ru

Some Bay Trail devices use a GPI1 regulator field (address 0x4c) in
their 0x8d power OpRegion, add support for this.

This fixes AE_BAD_PARAMETER errors getting thrown on these devices and
fixes these errors causing these devices to not suspend.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Simplify reg == 0x92 handling (suggested by Andy Shevchenko)
-Add special handling for reg == 0x92 to intel_xpower_pmic_get_power() too
---
 drivers/acpi/pmic/intel_pmic_xpower.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
index 1a76c78..c9be430 100644
--- a/drivers/acpi/pmic/intel_pmic_xpower.c
+++ b/drivers/acpi/pmic/intel_pmic_xpower.c
@@ -118,6 +118,10 @@ static struct pmic_table power_table[] = {
 		.reg = 0x10,
 		.bit = 0x00
 	}, /* BUC6 */
+	{
+		.address = 0x4c,
+		.reg = 0x92,
+	}, /* GPI1 */
 };
 
 /* TMP0 - TMP5 are the same, all from GPADC */
@@ -156,7 +160,12 @@ static int intel_xpower_pmic_get_power(struct regmap *regmap, int reg,
 	if (regmap_read(regmap, reg, &data))
 		return -EIO;
 
-	*value = (data & BIT(bit)) ? 1 : 0;
+	/* GPIO1 LDO regulator needs special handling */
+	if (reg == 0x92)
+		*value = ((data & 0x07) == 0x03);
+	else
+		*value = (data & BIT(bit)) ? 1 : 0;
+
 	return 0;
 }
 
@@ -165,6 +174,10 @@ static int intel_xpower_pmic_update_power(struct regmap *regmap, int reg,
 {
 	int data;
 
+	/* GPIO1 LDO regulator needs special handling */
+	if (reg == 0x92)
+		return regmap_update_bits(regmap, reg, 0x07, on ? 0x03 : 0x04);
+
 	if (regmap_read(regmap, reg, &data))
 		return -EIO;
 
-- 
2.9.3

