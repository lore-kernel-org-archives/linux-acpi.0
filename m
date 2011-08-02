From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/27] ACPI / Battery: Resolve the race condition in the
 sysfs_remove_battery()
Date: Tue, 02 Aug 2011 16:53:16 -0400
Message-ID: <9c921c22a7f33397a6774d7fa076db9b6a0fd669.1312318300.git.len.brown@intel.com>
References: <1312318409-29363-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:41222 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755442Ab1HBVwC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Aug 2011 17:52:02 -0400
Received: from localhost.localdomain ([unknown] [65.175.195.226])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LPB00IROM2GJRGL@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 02 Aug 2011 16:52:00 -0500 (CDT)
In-reply-to: <1312318409-29363-1-git-send-email-lenb@kernel.org>
In-reply-to: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
References: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, Len Brown <len.brown@intel.com>

From: Lan Tianyu <tianyu.lan@intel.com>

Use battery->lock in sysfs_remove_battery() to make
checking, removing, and clearing bat.dev atomic.
This is necessary because sysfs_remove_battery() may
be invoked concurrently from different paths.

    https://bugzilla.kernel.org/show_bug.cgi?id=35642

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 4ba339d..40bf01d 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -573,11 +573,16 @@ static int sysfs_add_battery(struct acpi_battery *battery)
 
 static void sysfs_remove_battery(struct acpi_battery *battery)
 {
-	if (!battery->bat.dev)
+	mutex_lock(&battery->lock);
+	if (!battery->bat.dev) {
+		mutex_unlock(&battery->lock);
 		return;
+	}
+
 	device_remove_file(battery->bat.dev, &alarm_attr);
 	power_supply_unregister(&battery->bat);
 	battery->bat.dev = NULL;
+	mutex_unlock(&battery->lock);
 }
 
 /*
-- 
1.7.6.396.ge0613

