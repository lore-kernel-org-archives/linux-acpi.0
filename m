From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] spi: Fix modalias for ACPI enumerated SPI devices
Date: Thu, 10 Oct 2013 17:19:17 +0300
Message-ID: <1381414757-26173-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:43865 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751641Ab3JJOWA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Oct 2013 10:22:00 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-spi@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

There is a minor fault about ACPI enumerated SPI devices with their modalias
attribute. Now modalias is set by device instance not by hardware ID.
For example "spi:INTABCD:00", "spi:INTABCD:01" etc.

This means each device instance gets different modalias which does match
with generated modules.alias. Currently this is not problem as matching can
happen also with "acpi:INTABCD" modalias.

Fix this by using ACPI hardware ID.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Generated on top of v3.12-rc4-29-g0e7a3ed.
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9e039c6..e57e9ac 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1025,7 +1025,7 @@ static acpi_status acpi_spi_add_device(acpi_handle handle, u32 level,
 		return AE_OK;
 	}
 
-	strlcpy(spi->modalias, dev_name(&adev->dev), sizeof(spi->modalias));
+	strlcpy(spi->modalias, acpi_device_hid(adev), sizeof(spi->modalias));
 	if (spi_add_device(spi)) {
 		dev_err(&master->dev, "failed to add SPI device %s from ACPI\n",
 			dev_name(&adev->dev));
-- 
1.8.4.rc3

