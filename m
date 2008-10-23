From: Len Brown <lenb@kernel.org>
Subject: [PATCH 013/122] dock: fix for ATA bay in a dock station
Date: Thu, 23 Oct 2008 02:37:47 -0400
Message-ID: <61b836958371c717d1e6d4fea1d2c512969ad20b.1224743916.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms172071pub.verizon.net ([206.46.172.71]:62846 "EHLO
	vms172071pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753533AbYJWGjr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:39:47 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms172071.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9600KRXII8Y913@vms172071.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:39:45 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Shaohua Li <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>

From: Shaohua Li <shaohua.li@intel.com>

an ATA bay can be in a dock and itself can be ejected separately.
This patch handles such eject bay. Found by Holger.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dock.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index ac7dfef..c877cc5 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -609,6 +609,7 @@ register_hotplug_dock_device(acpi_handle handle, struct acpi_dock_ops *ops,
 {
 	struct dock_dependent_device *dd;
 	struct dock_station *dock_station;
+	int ret = -EINVAL;
 
 	if (!dock_station_count)
 		return -ENODEV;
@@ -618,16 +619,21 @@ register_hotplug_dock_device(acpi_handle handle, struct acpi_dock_ops *ops,
 	 * this would include the dock station itself
 	 */
 	list_for_each_entry(dock_station, &dock_stations, sibiling) {
+		/*
+		 * An ATA bay can be in a dock and itself can be ejected
+		 * seperately, so there are two 'dock stations' which need the
+		 * ops
+		 */
 		dd = find_dock_dependent_device(dock_station, handle);
 		if (dd) {
 			dd->ops = ops;
 			dd->context = context;
 			dock_add_hotplug_device(dock_station, dd);
-			return 0;
+			ret = 0;
 		}
 	}
 
-	return -EINVAL;
+	return ret;
 }
 
 EXPORT_SYMBOL_GPL(register_hotplug_dock_device);
@@ -1078,8 +1084,8 @@ find_dock(acpi_handle handle, u32 lvl, void *context, void **rv)
 static acpi_status
 find_bay(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
-	/* If bay is in a dock, it's already handled */
-	if (is_ejectable_bay(handle) && !is_dock_device(handle))
+	/* If bay is a dock, it's already handled */
+	if (is_ejectable_bay(handle) && !is_dock(handle))
 		dock_add(handle);
 	return AE_OK;
 }
-- 
1.5.5.1

