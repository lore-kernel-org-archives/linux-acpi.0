From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ACPI / PMIC: xpower: Do pinswitch magic when reading GPADC
Date: Sat,  8 Jul 2017 15:40:08 +0200
Message-ID: <20170708134008.13930-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:4841 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751706AbdGHNkL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 8 Jul 2017 09:40:11 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org

Testing has shown that the TS-pin's bias-current needs to be disabled
when reading the GPIO0 pin in GPADC mode.

It seems that there is only 1 bias current source and to be able to use it
for the GPIO0 pin in GPADC mode it must be temporarily turned off for the
TS pin, but the datasheet does not mention this.

This commit adds the necessary writes to turn the TS pin BIAS current
off before and back on after reading the GPADC. This fixes the GPADC
always returning a reading of 0.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/pmic/intel_pmic_xpower.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
index 3b7d5be5b7ed..6c99d3f81095 100644
--- a/drivers/acpi/pmic/intel_pmic_xpower.c
+++ b/drivers/acpi/pmic/intel_pmic_xpower.c
@@ -27,6 +27,9 @@
 #define GPI1_LDO_ON		(3 << 0)
 #define GPI1_LDO_OFF		(4 << 0)
 
+#define AXP288_ADC_TS_PIN_GPADC	0xf2
+#define AXP288_ADC_TS_PIN_ON	0xf3
+
 static struct pmic_table power_table[] = {
 	{
 		.address = 0x00,
@@ -209,11 +212,23 @@ static int intel_xpower_pmic_update_power(struct regmap *regmap, int reg,
 static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
 {
 	u8 buf[2];
+	int ret;
 
-	if (regmap_bulk_read(regmap, AXP288_GP_ADC_H, buf, 2))
-		return -EIO;
+	ret = regmap_write(regmap, AXP288_ADC_TS_PIN_CTRL,
+			   AXP288_ADC_TS_PIN_GPADC);
+	if (ret)
+		return ret;
+
+	/* After switching to the GPADC pin give things some time to settle */
+	usleep_range(6000, 10000);
+
+	ret = regmap_bulk_read(regmap, AXP288_GP_ADC_H, buf, 2);
+	if (ret == 0)
+		ret = (buf[0] << 4) + ((buf[1] >> 4) & 0x0f);
+
+	regmap_write(regmap, AXP288_ADC_TS_PIN_CTRL, AXP288_ADC_TS_PIN_ON);
 
-	return (buf[0] << 4) + ((buf[1] >> 4) & 0x0F);
+	return ret;
 }
 
 static struct intel_pmic_opregion_data intel_xpower_pmic_opregion_data = {
-- 
2.13.0

