From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH] acpica events: Call acpi_os_hotplug_execute on Ejection Request and Device Check
Date: Fri, 23 Sep 2011 08:58:21 -0400
Message-ID: <1316782701-25630-1-git-send-email-prarit@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36715 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753862Ab1IWM62 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Sep 2011 08:58:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, bhelgaas@google.com, mjg@redhat.com

This patch works around a process hang in which a PCI card with a PCI-to-PCI
bridge is removed via the acpiphp driver.

The issue is that during the remove of the card an ACPI event occurs
which is erroneously added the kacpi_notify_wq queue.  This add is done in
acpi_ev_queue_notify_request().

Eventually, the event runs on the kacpi_notify_wq and the code attempts to
remove the card.  During the hotplug remove of the device, the following
call sequence happens

cleanup_p2p_bridge()
	-> cleanup_bridge()
		-> acpi_remove_notify_handler()
			-> acpi_os_wait_events_complete()
				-> flush_workqueue(kacpi_notify_wq)

which is the queue we are currently executing on and the process will hang.

The issue is that the event is placed on the wrong queue.  In
acpi_ev_queue_notify_request() the code should check to see if this is a
Ejection Request and if it is, add it the kacpi_hotplug_wq via a call to
acpi_os_hotplug_execute().

[v2]: Use proper #defines and also add Device Check events to the hotplug queue.

Cc: bhelgaas@google.com
Cc: mjg@redhat.com
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 drivers/acpi/acpica/evmisc.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index d0b3318..72bc740 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -181,9 +181,17 @@ acpi_ev_queue_notify_request(struct acpi_namespace_node * node,
 		notify_info->notify.value = (u16) notify_value;
 		notify_info->notify.handler_obj = handler_obj;
 
-		status =
-		    acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_ev_notify_dispatch,
-				    notify_info);
+		/* Ejection Request and Device Check are on the hotplug queue */
+		if ((notify_value == ACPI_NOTIFY_EJECT_REQUEST) ||
+		    (notify_value == ACPI_NOTIFY_DEVICE_CHECK))
+			status =
+				acpi_os_hotplug_execute(acpi_ev_notify_dispatch,
+							notify_info);
+		else
+			status = acpi_os_execute(OSL_NOTIFY_HANDLER,
+						 acpi_ev_notify_dispatch,
+						 notify_info);
+
 		if (ACPI_FAILURE(status)) {
 			acpi_ut_delete_generic_state(notify_info);
 		}
-- 
1.6.5.2

