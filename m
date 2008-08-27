From: Shaohua Li <shaohua.li@intel.com>
Subject: [patch 3/11]add _LCK support for dock
Date: Wed, 27 Aug 2008 11:14:31 +0800
Message-ID: <1219806871.32665.59.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:22506 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752361AbYH0DEu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Aug 2008 23:04:50 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Andi Kleen <andi@firstfloor.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>, Tejun Heo <htejun@gmail.com>

=EF=BB=BFsupport _LCK method, which is a optional method for hotplug

Signed-off-by: Shaohua Li <shaohua.li@intel.com>=20
---
 drivers/acpi/dock.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

Index: linux/drivers/acpi/dock.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/acpi/dock.c	2008-08-27 10:20:08.000000000 +0800
+++ linux/drivers/acpi/dock.c	2008-08-27 10:22:05.000000000 +0800
@@ -452,6 +452,22 @@ static inline void complete_undock(struc
 	ds->flags &=3D ~(DOCK_UNDOCKING);
 }
=20
+static void dock_lock(struct dock_station *ds, int lock)
+{
+	struct acpi_object_list arg_list;
+	union acpi_object arg;
+	acpi_status status;
+
+	arg_list.count =3D 1;
+	arg_list.pointer =3D &arg;
+	arg.type =3D ACPI_TYPE_INTEGER;
+	arg.integer.value =3D !!lock;
+	status =3D acpi_evaluate_object(ds->handle, "_LCK", &arg_list, NULL);
+	if (ACPI_FAILURE(status) && status !=3D AE_NOT_FOUND)
+		printk(KERN_WARNING PREFIX "%s device failed\n",
+			lock ? "Locking" : "Unlocking");
+}
+
 /**
  * dock_in_progress - see if we are in the middle of handling a dock e=
vent
  * @ds: the dock station
@@ -577,6 +593,7 @@ static int handle_eject_request(struct d
=20
 	hotplug_dock_devices(ds, ACPI_NOTIFY_EJECT_REQUEST);
 	undock(ds);
+	dock_lock(ds, 0);
 	eject_dock(ds);
 	if (dock_present(ds)) {
 		printk(KERN_ERR PREFIX "Unable to undock!\n");
@@ -616,6 +633,7 @@ static void dock_notify(acpi_handle hand
 			hotplug_dock_devices(ds, event);
 			complete_dock(ds);
 			dock_event(ds, event, DOCK_EVENT);
+			dock_lock(ds, 1);
 		}
 		break;
 	case ACPI_NOTIFY_DEVICE_CHECK:


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
