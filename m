From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ACPI / SBS: fix inconsistent indenting inside if statement
Date: Fri,  1 Jan 2016 23:53:45 +0000
Message-ID: <1451692425-4667-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:52600 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbcAAXxt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Jan 2016 18:53:49 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The indenting in acpi_battery_set_alarm is inconsistent and has been
so since 2007; commit 94f6c0860139da9219255b8ff45ad42117dda859
("ACPI: SBS: Add support for power_supply class (and sysfs)"). Minor
fix for this, no code functionality change.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/acpi/sbs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index cb3dedb..ad0b13a 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -417,11 +417,11 @@ static int acpi_battery_set_alarm(struct acpi_battery *battery)
 		if ((value & 0xf000) != sel) {
 			value &= 0x0fff;
 			value |= sel;
-		ret = acpi_smbus_write(sbs->hc, SMBUS_WRITE_WORD,
+			ret = acpi_smbus_write(sbs->hc, SMBUS_WRITE_WORD,
 					 ACPI_SBS_MANAGER,
 					 0x01, (u8 *)&value, 2);
-		if (ret)
-			goto end;
+			if (ret)
+				goto end;
 		}
 	}
 	ret = acpi_smbus_write(sbs->hc, SMBUS_WRITE_WORD, ACPI_SBS_BATTERY,
-- 
2.6.4

