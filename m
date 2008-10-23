From: Len Brown <lenb@kernel.org>
Subject: [PATCH 006/122] dock: add _LCK support
Date: Thu, 23 Oct 2008 02:37:40 -0400
Message-ID: <406f692d0803d73acd3984c1e11719d3a913fd5e.1224743916.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:37841 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139AbYJWGjo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:39:44 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9600KOKII63KY1@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:39:43 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Shaohua Li <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>

From: Shaohua Li <shaohua.li@intel.com>

support _LCK method, which is a optional method for hotplug

lenb: we have not seen _LCK used in the field yet

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dock.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 78d27ce..7bdf93b 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -452,6 +452,25 @@ static inline void complete_undock(struct dock_station *ds)
 	ds->flags &= ~(DOCK_UNDOCKING);
 }
 
+static void dock_lock(struct dock_station *ds, int lock)
+{
+	struct acpi_object_list arg_list;
+	union acpi_object arg;
+	acpi_status status;
+
+	arg_list.count = 1;
+	arg_list.pointer = &arg;
+	arg.type = ACPI_TYPE_INTEGER;
+	arg.integer.value = !!lock;
+	status = acpi_evaluate_object(ds->handle, "_LCK", &arg_list, NULL);
+	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
+		if (lock)
+			printk(KERN_WARNING PREFIX "Locking device failed\n");
+		else
+			printk(KERN_WARNING PREFIX "Unlocking device failed\n");
+	}
+}
+
 /**
  * dock_in_progress - see if we are in the middle of handling a dock event
  * @ds: the dock station
@@ -577,6 +596,7 @@ static int handle_eject_request(struct dock_station *ds, u32 event)
 
 	hotplug_dock_devices(ds, ACPI_NOTIFY_EJECT_REQUEST);
 	undock(ds);
+	dock_lock(ds, 0);
 	eject_dock(ds);
 	if (dock_present(ds)) {
 		printk(KERN_ERR PREFIX "Unable to undock!\n");
@@ -617,6 +637,7 @@ static void dock_notify(acpi_handle handle, u32 event, void *data)
 			hotplug_dock_devices(ds, event);
 			complete_dock(ds);
 			dock_event(ds, event, DOCK_EVENT);
+			dock_lock(ds, 1);
 		}
 		break;
 	case ACPI_NOTIFY_DEVICE_CHECK:
-- 
1.5.5.1

