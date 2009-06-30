From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [RESEND] [PATCH 2/3] ACPI: battery drivers should call power_supply_changed()
Date: Tue, 30 Jun 2009 15:36:16 +0100
Message-ID: <4A4A22E0.6050400@tuffmail.co.uk>
References: <4A4A219C.2020802@tuffmail.co.uk> <4A4A2299.8060401@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-1920.google.com ([74.125.78.150]:2515 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986AbZF3OgS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Jun 2009 10:36:18 -0400
Received: by ey-out-1920.google.com with SMTP id 3so45838eyh.36
        for <linux-acpi@vger.kernel.org>; Tue, 30 Jun 2009 07:36:20 -0700 (PDT)
In-Reply-To: <4A4A2299.8060401@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>

Calling kobject_uevent() directly is a layering violation.  In
particular, it means we'll miss updating the generic LED trigger.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
CC: Alexey Starikovskiy <astarikovskiy@suse.de>
---
 drivers/acpi/battery.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 908edce..7d31a23 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -811,7 +811,7 @@ static void acpi_battery_notify(struct acpi_device *device, u32 event)
 #ifdef CONFIG_ACPI_SYSFS_POWER
 	/* acpi_batter_update could remove power_supply object */
 	if (battery->bat.dev)
-		kobject_uevent(&battery->bat.dev->kobj, KOBJ_CHANGE);
+		power_supply_changed(&battery->bat);
 #endif
 }
 
-- 
1.6.3.2



