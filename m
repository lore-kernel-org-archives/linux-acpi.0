From: Wang Hongcheng <annie.wang@amd.com>
Subject: [PATCH V2] ACPI: APD: Add device HID for future AMD UART controller
Date: Fri, 11 Mar 2016 17:28:23 +0800
Message-ID: <1457688503-2377-1-git-send-email-annie.wang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bl2on0071.outbound.protection.outlook.com ([65.55.169.71]:12512
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750742AbcCKJ3b (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Mar 2016 04:29:31 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, SPG_Linux_Kernel <SPG_Linux_Kernel@amd.com>
Cc: Wang Hongcheng <annie.wang@amd.com>

Add device HID AMDI0020 to match the AMD ACPI Vendor ID (AMDI) as
registered in http://www.uefi.org/acpi_id_list, and the UART
controller on future AMD paltform will use the HID instead of AMD0020.

Signed-off-by: Wang Hongcheng <annie.wang@amd.com>
---
 drivers/acpi/acpi_apd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index a450e7a..dc2d8a5 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -134,6 +134,7 @@ static const struct acpi_device_id acpi_apd_device_ids[] = {
 	/* Generic apd devices */
 	{ "AMD0010", APD_ADDR(cz_i2c_desc) },
 	{ "AMD0020", APD_ADDR(cz_uart_desc) },
+	{ "AMDI0020", APD_ADDR(cz_uart_desc) },
 	{ "AMD0030", },
 	{ }
 };
-- 
1.9.1

