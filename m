From: Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH] ACPI: APD: Fix HID for Hisilicon Hip07/08
Date: Fri, 28 Jul 2017 17:42:35 +0800
Message-ID: <1501234955-20921-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([45.249.212.189]:9870 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751656AbdG1JtX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Jul 2017 05:49:23 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, linuxarm@huawei.com, Tao Tian <tiantao6@huawei.com>, Hanjun Guo <hanjun.guo@linaro.org>

From: Hanjun Guo <hanjun.guo@linaro.org>

ACPI HID for Hisilicon Hip07/08 should be HISI02A1/2,
not HISI0A21/2, HISI02A1/2 was tested ok but was modified
by the stupid typo when upstream the patches (by me),
correct them to the right IDs (matching the IDs in
drivers/i2c/busses/i2c-designware-platdrv.c).

Fixes: 6e14cf361a0c <"ACPI / APD: Add clock frequency for Hisilicon Hip07/08 I2C controller">
Reported-by: Tao Tian <tiantao6@huawei.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/acpi_apd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index fc6c416..d5999eb 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -180,8 +180,8 @@ static int acpi_apd_create_device(struct acpi_device *adev,
 	{ "APMC0D0F", APD_ADDR(xgene_i2c_desc) },
 	{ "BRCM900D", APD_ADDR(vulcan_spi_desc) },
 	{ "CAV900D",  APD_ADDR(vulcan_spi_desc) },
-	{ "HISI0A21", APD_ADDR(hip07_i2c_desc) },
-	{ "HISI0A22", APD_ADDR(hip08_i2c_desc) },
+	{ "HISI02A1", APD_ADDR(hip07_i2c_desc) },
+	{ "HISI02A2", APD_ADDR(hip08_i2c_desc) },
 #endif
 	{ }
 };
-- 
1.7.12.4

