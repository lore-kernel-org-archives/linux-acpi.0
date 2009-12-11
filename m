From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [PATCH 2/2] ACPI: battery drivers should call power_supply_changed()
Date: Fri, 11 Dec 2009 11:05:55 +0000
Message-ID: <4B222793.3020902@tuffmail.co.uk>
References: <4B22274A.1000003@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:52022 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756945AbZLKLFw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Dec 2009 06:05:52 -0500
Received: by fxm21 with SMTP id 21so852972fxm.1
        for <linux-acpi@vger.kernel.org>; Fri, 11 Dec 2009 03:05:58 -0800 (PST)
In-Reply-To: <4B22274A.1000003@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>

Calling kobject_uevent() directly is a layering violation.  In
particular, it means we'll miss updating the generic LED trigger.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
CC: Alexey Starikovskiy <astarikovskiy@suse.de>
---
 drivers/acpi/battery.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index ed4aeab..ec3138c 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -833,7 +833,7 @@ static void acpi_battery_notify(struct acpi_device *device, u32 event)
 #ifdef CONFIG_ACPI_SYSFS_POWER
 	/* acpi_batter_update could remove power_supply object */
 	if (battery->bat.dev)
-		kobject_uevent(&battery->bat.dev->kobj, KOBJ_CHANGE);
+		power_supply_changed(&battery->bat);
 #endif
 }
 
-- 
1.6.3.3



