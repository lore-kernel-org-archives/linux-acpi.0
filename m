From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/5] mfd: axp20c-i2c: Select designware i2c-bus driver on x86
Date: Wed, 22 Mar 2017 12:29:21 +0100
Message-ID: <20170322112923.20200-4-hdegoede@redhat.com>
References: <20170322112923.20200-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759380AbdCVL3c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 22 Mar 2017 07:29:32 -0400
In-Reply-To: <20170322112923.20200-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On x86 the axp288 PMIC provides an ACPI OPRegion handler, which must be
available before other drivers using it are loaded, which can only be
ensured if the mfd, opregion driver and i2c-bus drivers are built in.

The opregion driver is a bool depending on MFD_AXP20X_I2C ensuring that
it will be builtin if the opregion driver is to be enabled, add a
select for the designware-options to ensure those get built in too.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 0c6a967..08f8dcb 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -148,6 +148,8 @@ config MFD_AXP20X_I2C
 	tristate "X-Powers AXP series PMICs with I2C"
 	select MFD_AXP20X
 	select REGMAP_I2C
+	select I2C_DESIGNWARE_PLATFORM if X86
+	select I2C_DESIGNWARE_BAYTRAIL if X86
 	depends on I2C
 	help
 	  If you say Y here you get support for the X-Powers AXP series power
-- 
2.9.3

