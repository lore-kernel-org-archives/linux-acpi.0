From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH 2/8] add _LCK support for dock
Date: Thu, 22 May 2008 14:33:08 +0800
Message-ID: <1211437988.25221.36.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10134 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756076AbYEVG2c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 May 2008 02:28:32 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>

support _LCK method.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---
 drivers/acpi/dock.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

Index: linux/drivers/acpi/dock.c
===================================================================
--- linux.orig/drivers/acpi/dock.c	2008-05-22 09:28:10.000000000 +0800
+++ linux/drivers/acpi/dock.c	2008-05-22 09:28:20.000000000 +0800
@@ -452,6 +452,22 @@ static inline void complete_undock(struc
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
+	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND)
+		printk(KERN_WARNING PREFIX "%s device failed\n",
+			lock ? "Locking" : "Unlocking");
+}
+
 /**
  * dock_in_progress - see if we are in the middle of handling a dock event
  * @ds: the dock station
@@ -616,6 +632,7 @@ static void dock_notify(acpi_handle hand
 			hotplug_dock_devices(ds, event);
 			complete_dock(ds);
 			dock_event(ds, event, DOCK_EVENT);
+			dock_lock(ds, 1);
 		}
 		break;
 	case ACPI_NOTIFY_DEVICE_CHECK:
@@ -628,6 +645,7 @@ static void dock_notify(acpi_handle hand
 	 * to the driver who wish to hotplug.
          */
 	case ACPI_NOTIFY_EJECT_REQUEST:
+		dock_lock(ds, 0);
 		begin_undock(ds);
 		if (immediate_undock)
 			handle_eject_request(ds, event);
@@ -712,6 +730,7 @@ static ssize_t write_undock(struct devic
 	if (!count)
 		return -EINVAL;
 
+	dock_lock(dock_station, 0);
 	begin_undock(dock_station);
 	ret = handle_eject_request(dock_station, ACPI_NOTIFY_EJECT_REQUEST);
 	return ret ? ret: count;


