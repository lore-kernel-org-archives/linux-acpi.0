From: Shaohua Li <shaohua.li@intel.com>
Subject: [patch 3/11]add _LCK support for dock
Date: Thu, 28 Aug 2008 10:03:26 +0800
Message-ID: <1219889006.29375.26.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6713 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753315AbYH1Bxm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Aug 2008 21:53:42 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Andi Kleen <andi@firstfloor.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>, Tejun Heo <htejun@gmail.com>

support _LCK method, which is a optional method for hotplug

Signed-off-by: Shaohua Li <shaohua.li@intel.com> 
---
 drivers/acpi/dock.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

Index: linux/drivers/acpi/dock.c
===================================================================
--- linux.orig/drivers/acpi/dock.c	2008-08-28 09:35:51.000000000 +0800
+++ linux/drivers/acpi/dock.c	2008-08-28 09:40:00.000000000 +0800
@@ -452,6 +452,25 @@ static inline void complete_undock(struc
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
@@ -577,6 +596,7 @@ static int handle_eject_request(struct d
 
 	hotplug_dock_devices(ds, ACPI_NOTIFY_EJECT_REQUEST);
 	undock(ds);
+	dock_lock(ds, 0);
 	eject_dock(ds);
 	if (dock_present(ds)) {
 		printk(KERN_ERR PREFIX "Unable to undock!\n");
@@ -617,6 +637,7 @@ static void dock_notify(acpi_handle hand
 			hotplug_dock_devices(ds, event);
 			complete_dock(ds);
 			dock_event(ds, event, DOCK_EVENT);
+			dock_lock(ds, 1);
 		}
 		break;
 	case ACPI_NOTIFY_DEVICE_CHECK:


