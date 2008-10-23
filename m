From: Len Brown <lenb@kernel.org>
Subject: [PATCH 005/122] dock: fix eject request process (2.6.27-rc1 regression)
Date: Thu, 23 Oct 2008 02:37:39 -0400
Message-ID: <82545394e0690aaef446cb262aa5dac0f9c7156e.1224743916.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms172071pub.verizon.net ([206.46.172.71]:62846 "EHLO
	vms172071pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345AbYJWGjq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:39:46 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms172071.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K96007CAII68MB1@vms172071.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:39:43 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Shaohua Li <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>

From: Shaohua Li <shaohua.li@intel.com>

commit 2a7feab28d3fc060d320eaba192e49dad1079b7e introduces a bug.
My thinkpad actually will send an eject_request and we should follow the
eject process to finish the eject, otherwise system still thinks the bay
is present.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dock.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 25d2161..78d27ce 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -575,11 +575,6 @@ static int handle_eject_request(struct dock_station *ds, u32 event)
 	 */
 	dock_event(ds, event, UNDOCK_EVENT);
 
-	if (!dock_present(ds)) {
-		complete_undock(ds);
-		return -ENODEV;
-	}
-
 	hotplug_dock_devices(ds, ACPI_NOTIFY_EJECT_REQUEST);
 	undock(ds);
 	eject_dock(ds);
-- 
1.5.5.1

