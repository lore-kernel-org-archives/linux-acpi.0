From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/27] ACPI / Battery: Add the hibernation process in the
 battery_notify()
Date: Tue, 02 Aug 2011 16:53:14 -0400
Message-ID: <d5a5911b3278bad6515a9958f7318f74d534ef64.1312318300.git.len.brown@intel.com>
References: <1312318409-29363-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:41222 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755491Ab1HBVwB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Aug 2011 17:52:01 -0400
Received: from localhost.localdomain ([unknown] [65.175.195.226])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LPB00IROM2GJRGL@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 02 Aug 2011 16:51:59 -0500 (CDT)
In-reply-to: <1312318409-29363-1-git-send-email-lenb@kernel.org>
In-reply-to: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
References: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, Len Brown <len.brown@intel.com>

From: Lan Tianyu <tianyu.lan@intel.com>

The Commit 25be58215 has added a PM notifier to refresh the sys in order
to deal with the unit change of the Battery Present Rate. But it just
consided the suspend situation. The problem also will happen during the
hibernation according the bug 28192.

    https://bugzilla.kernel.org/show_bug.cgi?id=28192

This patch adds the hibernation process and fix the bug.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index ba7926f..2fe7cfd 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -947,6 +947,7 @@ static int battery_notify(struct notifier_block *nb,
 	struct acpi_battery *battery = container_of(nb, struct acpi_battery,
 						    pm_nb);
 	switch (mode) {
+	case PM_POST_HIBERNATION:
 	case PM_POST_SUSPEND:
 		sysfs_remove_battery(battery);
 		sysfs_add_battery(battery);
-- 
1.7.6.396.ge0613

