From: Len Brown <lenb@kernel.org>
Subject: [PATCH 004/122] ACPI: dock: avoid check _STA method
Date: Thu, 23 Oct 2008 02:37:38 -0400
Message-ID: <8b59560a3baf2e7c24e0fb92ea5d09eca92805db.1224743916.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:40846 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753196AbYJWGjn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:39:43 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K960000LII6XRL2@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:39:43 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Shaohua Li <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>

From: Shaohua Li <shaohua.li@intel.com>

In some BIOSes, every _STA method call will send a notification again,
this cause freeze. And in some BIOSes, it appears _STA should be called
after _DCK. This tries to avoid calls _STA, and still keep the device
present check.

http://bugzilla.kernel.org/show_bug.cgi?id=10431

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dock.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 7d2edf1..25d2161 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -604,14 +604,17 @@ static int handle_eject_request(struct dock_station *ds, u32 event)
 static void dock_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct dock_station *ds = data;
+	struct acpi_device *tmp;
 
 	switch (event) {
 	case ACPI_NOTIFY_BUS_CHECK:
-		if (!dock_in_progress(ds) && dock_present(ds)) {
+		if (!dock_in_progress(ds) && acpi_bus_get_device(ds->handle,
+		   &tmp)) {
 			begin_dock(ds);
 			dock(ds);
 			if (!dock_present(ds)) {
 				printk(KERN_ERR PREFIX "Unable to dock!\n");
+				complete_dock(ds);
 				break;
 			}
 			atomic_notifier_call_chain(&dock_notifier_list,
-- 
1.5.5.1

