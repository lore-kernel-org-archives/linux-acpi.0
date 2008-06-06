From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH 5/8] fix hotplug race
Date: Fri, 06 Jun 2008 13:22:48 +0800
Message-ID: <1212729768.25188.28.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32034 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066AbYFFFRX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 6 Jun 2008 01:17:23 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>

=EF=BB=BFhotplug notification handler and drivers' notification handler=
 are all
running in one workqueue. Before hotplug removes an acpi device, the
device driver's notification handler is already be recorded to run just
after global notification handler. After hotplug notification handler
runs, acpica will notice a NULL notification handler and crash. This
patch runs hotplug in other workqueue and wait for all acpi notication
handlers finish. This is found in battery hotplug, but actually all
hotplug can be affected.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Shaohua Li <shaohua.li@intel.com>=20
---
 drivers/acpi/dock.c     |   24 +++++++++++++++++++++++-
 drivers/acpi/osl.c      |   44 +++++++++++++++++++++++++++++++++++++++=
-----
 include/acpi/acpiosxf.h |    3 +++
 3 files changed, 65 insertions(+), 6 deletions(-)

Index: linux/drivers/acpi/dock.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/acpi/dock.c	2008-06-06 10:57:59.000000000 +0800
+++ linux/drivers/acpi/dock.c	2008-06-06 10:58:05.000000000 +0800
@@ -745,6 +745,20 @@ static void dock_notify(acpi_handle hand
 	}
 }
=20
+struct dock_data {
+	acpi_handle handle;
+	unsigned long event;
+	struct dock_station *ds;
+};
+
+static void acpi_dock_deferred_cb(void *context)
+{
+	struct dock_data *data =3D (struct dock_data *)context;
+
+	dock_notify(data->handle, data->event, data->ds);
+	kfree(data);
+}
+
 static int acpi_dock_notifier_call(struct notifier_block *this,
 	unsigned long event, void *data)
 {
@@ -756,7 +770,15 @@ static int acpi_dock_notifier_call(struc
 		return 0;
 	list_for_each_entry(dock_station, &dock_stations, sibiling) {
 		if (dock_station->handle =3D=3D handle) {
-			dock_notify(handle, event, dock_station);
+			struct dock_data *dock_data;
+
+			dock_data =3D kmalloc(sizeof(*dock_data), GFP_KERNEL);
+			if (!dock_data)
+				return 0;
+			dock_data->handle =3D handle;
+			dock_data->event =3D event;
+			dock_data->ds =3D dock_station;
+			acpi_os_hotplug_execute(acpi_dock_deferred_cb, dock_data);
 			return 0 ;
 		}
 	}
Index: linux/drivers/acpi/osl.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/acpi/osl.c	2008-06-06 10:57:50.000000000 +0800
+++ linux/drivers/acpi/osl.c	2008-06-06 10:58:05.000000000 +0800
@@ -682,6 +682,22 @@ static void acpi_os_execute_deferred(str
 	return;
 }
=20
+static void acpi_os_execute_hp_deferred(struct work_struct *work)
+{
+	struct acpi_os_dpc *dpc =3D container_of(work, struct acpi_os_dpc, wo=
rk);
+	if (!dpc) {
+		printk(KERN_ERR PREFIX "Invalid (NULL) context\n");
+		return;
+	}
+
+	acpi_os_wait_events_complete(NULL);
+
+	dpc->function(dpc->context);
+	kfree(dpc);
+
+	return;
+}
+
 /*********************************************************************=
**********
  *
  * FUNCTION:    acpi_os_execute
@@ -697,12 +713,13 @@ static void acpi_os_execute_deferred(str
  *
  *********************************************************************=
*********/
=20
-acpi_status acpi_os_execute(acpi_execute_type type,
-			    acpi_osd_exec_callback function, void *context)
+static acpi_status __acpi_os_execute(acpi_execute_type type,
+	acpi_osd_exec_callback function, void *context, int hp)
 {
 	acpi_status status =3D AE_OK;
 	struct acpi_os_dpc *dpc;
 	struct workqueue_struct *queue;
+	int ret;
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 			  "Scheduling function [%p(%p)] for deferred execution.\n",
 			  function, context));
@@ -726,9 +743,16 @@ acpi_status acpi_os_execute(acpi_execute
 	dpc->function =3D function;
 	dpc->context =3D context;
=20
-	INIT_WORK(&dpc->work, acpi_os_execute_deferred);
-	queue =3D (type =3D=3D OSL_NOTIFY_HANDLER) ? kacpi_notify_wq : kacpid=
_wq;
-	if (!queue_work(queue, &dpc->work)) {
+	if (!hp) {
+		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
+		queue =3D (type =3D=3D OSL_NOTIFY_HANDLER) ? kacpi_notify_wq : kacpi=
d_wq;
+		ret =3D queue_work(queue, &dpc->work);
+	} else {
+		INIT_WORK(&dpc->work, acpi_os_execute_hp_deferred);
+		ret =3D schedule_work(&dpc->work);
+	}
+
+	if (!ret) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
 			  "Call to queue_work() failed.\n"));
 		status =3D AE_ERROR;
@@ -737,8 +761,18 @@ acpi_status acpi_os_execute(acpi_execute
 	return_ACPI_STATUS(status);
 }
=20
+acpi_status acpi_os_execute(acpi_execute_type type,
+			    acpi_osd_exec_callback function, void *context)
+{
+	return __acpi_os_execute(type, function, context, 0);
+}
 EXPORT_SYMBOL(acpi_os_execute);
=20
+acpi_status acpi_os_hotplug_execute(acpi_osd_exec_callback function, v=
oid *context)
+{
+	return __acpi_os_execute(0, function, context, 1);
+}
+
 void acpi_os_wait_events_complete(void *context)
 {
 	flush_workqueue(kacpid_wq);
Index: linux/include/acpi/acpiosxf.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/include/acpi/acpiosxf.h	2008-06-06 10:57:50.000000000 +0=
800
+++ linux/include/acpi/acpiosxf.h	2008-06-06 10:58:05.000000000 +0800
@@ -193,6 +193,9 @@ acpi_status
 acpi_os_execute(acpi_execute_type type,
 		acpi_osd_exec_callback function, void *context);
=20
+acpi_status
+acpi_os_hotplug_execute(acpi_osd_exec_callback function, void *context=
);
+
 void acpi_os_wait_events_complete(void *context);
=20
 void acpi_os_sleep(acpi_integer milliseconds);


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
