From: Len Brown <lenb@kernel.org>
Subject: [PATCH 13/27] ACPI / Battery: Add the check before refresh sysfs in
 the battery_notify()
Date: Tue, 02 Aug 2011 16:53:15 -0400
Message-ID: <6e17fb6aa1a67afa1827ae317c3594040f055730.1312318300.git.len.brown@intel.com>
References: <1312318409-29363-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:41222 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755421Ab1HBVwB (ORCPT
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

In the commit 25be5821, add the refresh sysfs when system resumes
from suspending. But it didn't check that the battery exists. This
will cause battery sysfs files added when the battery doesn't exist.
This patch add the check before refreshing.

	https://bugzilla.kernel.org/show_bug.cgi?id=35642

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 2fe7cfd..4ba339d 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -949,8 +949,10 @@ static int battery_notify(struct notifier_block *nb,
 	switch (mode) {
 	case PM_POST_HIBERNATION:
 	case PM_POST_SUSPEND:
-		sysfs_remove_battery(battery);
-		sysfs_add_battery(battery);
+		if (battery->bat.dev) {
+			sysfs_remove_battery(battery);
+			sysfs_add_battery(battery);
+		}
 		break;
 	}
 
-- 
1.7.6.396.ge0613

