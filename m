From: Len Brown <lenb@kernel.org>
Subject: [PATCH 20/27] ACPI / Battery: propagate sysfs error in
 acpi_battery_add()
Date: Tue, 02 Aug 2011 16:53:22 -0400
Message-ID: <eb03cb02b74df6dd0b653d5f6d976f16a434dfaf.1312318300.git.len.brown@intel.com>
References: <1312318409-29363-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:41222 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755491Ab1HBVwE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Aug 2011 17:52:04 -0400
Received: from localhost.localdomain ([unknown] [65.175.195.226])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LPB00IROM2GJRGL@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 02 Aug 2011 16:52:02 -0500 (CDT)
In-reply-to: <1312318409-29363-1-git-send-email-lenb@kernel.org>
In-reply-to: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
References: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, Len Brown <len.brown@intel.com>

From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>

Make sure the error return from sysfs_add_battery() is checked and
propagated out from acpi_battery_add().

Signed-off-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index c771768..ffce2f0 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -630,8 +630,11 @@ static int acpi_battery_update(struct acpi_battery *battery)
 			return result;
 		acpi_battery_init_alarm(battery);
 	}
-	if (!battery->bat.dev)
-		sysfs_add_battery(battery);
+	if (!battery->bat.dev) {
+		result = sysfs_add_battery(battery);
+		if (result)
+			return result;
+	}
 	result = acpi_battery_get_state(battery);
 	acpi_battery_quirks(battery);
 	return result;
@@ -982,7 +985,9 @@ static int acpi_battery_add(struct acpi_device *device)
 	if (ACPI_SUCCESS(acpi_get_handle(battery->device->handle,
 			"_BIX", &handle)))
 		set_bit(ACPI_BATTERY_XINFO_PRESENT, &battery->flags);
-	acpi_battery_update(battery);
+	result = acpi_battery_update(battery);
+	if (result)
+		goto fail;
 #ifdef CONFIG_ACPI_PROCFS_POWER
 	result = acpi_battery_add_fs(device);
 #endif
-- 
1.7.6.396.ge0613

