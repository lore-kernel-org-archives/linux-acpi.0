From: Len Brown <lenb@kernel.org>
Subject: [PATCH 24/30] ACPI: dock: Don't eval _STA on every show_docked sysfs
 read
Date: Sat, 07 Feb 2009 01:41:32 -0500
Message-ID: <fc5a9f8841ee87d93376ada5d73117d4d6a373ea.1233988826.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:50614 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805AbZBGGmD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Feb 2009 01:42:03 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-2.01 (built Jun 13 2007; 32bit))
 with ESMTPA id <0KEO001WVNVDW6J2@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Feb 2009 00:40:26 -0600 (CST)
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Holger Macht <hmacht@suse.de>, Len Brown <len.brown@intel.com>

From: Holger Macht <hmacht@suse.de>

Some devices trigger a DEVICE_CHECK on every evalutation of _STA. This
can also be seen in commit 8b59560a3baf2e7c24e0fb92ea5d09eca92805db
(ACPI: dock: avoid check _STA method).  If an undock is processed, the
dock driver sends a uevent and userspace might read the show_docked
property in sysfs. This causes an evaluation of _STA of the particular
device which causes the dock driver to immediately dock again.

In any case, evaluation of _STA (show_docked) does not necessarily mean
that we are docked, so check with the internal device structure.

http://bugzilla.kernel.org/show_bug.cgi?id=12360

Signed-off-by: Holger Macht <hmacht@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dock.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 5b30b8d..afd5db3 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -855,10 +855,14 @@ fdd_out:
 static ssize_t show_docked(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
+	struct acpi_device *tmp;
+
 	struct dock_station *dock_station = *((struct dock_station **)
 		dev->platform_data);
-	return snprintf(buf, PAGE_SIZE, "%d\n", dock_present(dock_station));
 
+	if (ACPI_SUCCESS(acpi_bus_get_device(dock_station->handle, &tmp)))
+		return snprintf(buf, PAGE_SIZE, "1\n");
+	return snprintf(buf, PAGE_SIZE, "0\n");
 }
 static DEVICE_ATTR(docked, S_IRUGO, show_docked, NULL);
 
-- 
1.5.6.6

