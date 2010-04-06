From: Len Brown <lenb@kernel.org>
Subject: [PATCH 11/12] ACPI: battery drivers should call power_supply_changed()
Date: Tue, 06 Apr 2010 03:06:22 -0400
Message-ID: <f79e1cec8c8aa64895fd7b595dc7b48157df0754.1270537380.git.len.brown@intel.com>
References: <1270537583-8756-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:53006 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756918Ab0DFVcF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Apr 2010 17:32:05 -0400
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L0H00D7A551QQ84@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 06 Apr 2010 16:31:55 -0500 (CDT)
In-reply-to: <1270537583-8756-1-git-send-email-lenb@kernel.org>
In-reply-to: <dadf28a10c3eb29421837a2e413ab869ebd9e168.1270537380.git.len.brown@intel.com>
References: <dadf28a10c3eb29421837a2e413ab869ebd9e168.1270537380.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Len Brown <len.brown@intel.com>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

Calling kobject_uevent() directly is a layering violation.  In
particular, it means we'll miss updating the generic LED trigger.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Acked-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 52df994..db78b6e 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -879,7 +879,7 @@ static void acpi_battery_notify(struct acpi_device *device, u32 event)
 #ifdef CONFIG_ACPI_SYSFS_POWER
 	/* acpi_battery_update could remove power_supply object */
 	if (battery->bat.dev)
-		kobject_uevent(&battery->bat.dev->kobj, KOBJ_CHANGE);
+		power_supply_changed(&battery->bat);
 #endif
 }
 
-- 
1.6.0.6

