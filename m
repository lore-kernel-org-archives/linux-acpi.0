From: Nehal Shah <Nehal-Bakulchandra.Shah@amd.com>
Subject: [PATCH] i2c: designware: Add clock frequency for future AMD I2C
 controller
Date: Wed, 19 Oct 2016 14:30:32 +0530
Message-ID: <0e262a14-4483-7983-7341-703c8b4d7fd6@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-cys01nam02on0048.outbound.protection.outlook.com ([104.47.37.48]:27264
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756348AbcJSQeK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 Oct 2016 12:34:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Shyam-sundar.S-k@amd.com

This patch supports 150 Mhz i2c clock frequency for Designware ip of future AMD I2C controller.

Reviewed-by: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>
Signed-off-by: Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com>
---
 drivers/acpi/acpi_apd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index d58fbf7..5ec7f3a 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -77,6 +77,11 @@ static const struct apd_device_desc cz_i2c_desc = {
     .fixed_clk_rate = 133000000,
 };
 
+static const struct apd_device_desc wt_i2c_desc = {
+    .setup = acpi_apd_setup,
+    .fixed_clk_rate = 150000000,
+};
+
 static struct property_entry uart_properties[] = {
     PROPERTY_ENTRY_U32("reg-io-width", 4),
     PROPERTY_ENTRY_U32("reg-shift", 2),
@@ -162,7 +167,7 @@ static const struct acpi_device_id acpi_apd_device_ids[] = {
     /* Generic apd devices */
 #ifdef CONFIG_X86_AMD_PLATFORM_DEVICE
     { "AMD0010", APD_ADDR(cz_i2c_desc) },
-    { "AMDI0010", APD_ADDR(cz_i2c_desc) },
+    { "AMDI0010", APD_ADDR(wt_i2c_desc) },
     { "AMD0020", APD_ADDR(cz_uart_desc) },
     { "AMDI0020", APD_ADDR(cz_uart_desc) },
     { "AMD0030", },
-- 
1.9.1


