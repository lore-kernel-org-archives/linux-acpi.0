From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/12] ACPI dock: support multiple ACPI dock devices
Date: Tue, 06 Apr 2010 03:06:14 -0400
Message-ID: <1ee4d61fd9822fb89e63b88a66848477087cd82e.1270537380.git.len.brown@intel.com>
References: <1270537583-8756-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:28136 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757357Ab0DFHGn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Apr 2010 03:06:43 -0400
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L0G00HA212RQUD1@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 06 Apr 2010 02:06:32 -0500 (CDT)
In-reply-to: <1270537583-8756-1-git-send-email-lenb@kernel.org>
In-reply-to: <dadf28a10c3eb29421837a2e413ab869ebd9e168.1270537380.git.len.brown@intel.com>
References: <dadf28a10c3eb29421837a2e413ab869ebd9e168.1270537380.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Li Shaohua <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

There may be multiple ACPI dock devices exist in ACPI namespace
and we should probe all of them.
http://bugzilla.kernel.org/show_bug.cgi?id=15521

CC: Li Shaohua <shaohua.li@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dock.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index d9a85f1..9d67bc6 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -1025,13 +1025,10 @@ static int dock_remove(struct dock_station *ds)
 static acpi_status
 find_dock(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
-	acpi_status status = AE_OK;
-
 	if (is_dock(handle))
-		if (dock_add(handle) >= 0)
-			status = AE_CTRL_TERMINATE;
+		dock_add(handle);
 
-	return status;
+	return AE_OK;
 }
 
 static acpi_status
-- 
1.6.0.6

