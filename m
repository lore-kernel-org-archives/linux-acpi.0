From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH] acpica events: Call acpi_os_hotplug_execute on Ejection Requests
Date: Thu, 22 Sep 2011 19:16:57 -0400
Message-ID: <1316733417-22528-1-git-send-email-prarit@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54795 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754218Ab1IVXRA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Sep 2011 19:17:00 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p8MNH0lG016073
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-acpi@vger.kernel.org>; Thu, 22 Sep 2011 19:17:00 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, mjg@redhat.com

This patch resolves a process hang in which a PCI card with a PCI-to-PCI
bridge is removed via the acpiphp driver.

The issue is that during the remove of the card an ACPI event occurs
which is erroneously added the kacpi_notify_wq queue.  This add is done in
acpi_ev_queue_notify_request() via a call to acpi_os_execute().

Eventually, the event runs on the kacpi_notify_wq and the code attempts to
remove the card.  During the hotplug remove of the device, the following
call sequence happens

cleanup_p2p_bridge()
	-> cleanup_bridge()
		-> acpi_remove_notify_handler()
			-> acpi_os_wait_events_complete()
				-> flush_workqueue(kacpi_notify_wq)

which is the queue we are currently executing on and the process will hang.

The problem is that the event is placed on the wrong queue.  The code already
contains a kacpi_hotplug_wq queue for hotplug events to be added to in order
to prevent hangs like this.

In acpi_ev_queue_notify_request() the code should check to see if this is a
Ejection Request and if it is, add it the kacpi_hotplug_wq via a call to
acpi_os_hotplug_execute().

Cc: mjg@redhat.com
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 drivers/acpi/acpica/evmisc.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index d0b3318..a78aecc 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -181,9 +181,16 @@ acpi_ev_queue_notify_request(struct acpi_namespace_node * node,
 		notify_info->notify.value = (u16) notify_value;
 		notify_info->notify.handler_obj = handler_obj;
 
-		status =
-		    acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_ev_notify_dispatch,
-				    notify_info);
+		/* Is this an Ejection Request? */
+		if (notify_value == 0x03)
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

