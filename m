From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH 1/8] avoid check _STA method
Date: Thu, 22 May 2008 14:33:05 +0800
Message-ID: <1211437985.25221.34.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:23785 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755777AbYEVG22 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 May 2008 02:28:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>

In some BIOSes, every _STA method call will send a notification again,
this cause freeze. This tries to avoid calls _STA
=EF=BB=BFhttp://bugzilla.kernel.org/show_bug.cgi?id=3D10431

Signed-off-by: Shaohua Li <shaohua.li@intel.com>=20
---
 drivers/acpi/dock.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux/drivers/acpi/dock.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/acpi/dock.c	2008-05-20 09:14:24.000000000 +0800
+++ linux/drivers/acpi/dock.c	2008-05-22 09:28:10.000000000 +0800
@@ -599,14 +599,16 @@ static int handle_eject_request(struct d
 static void dock_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct dock_station *ds =3D data;
+	struct acpi_device *tmp;
=20
 	switch (event) {
 	case ACPI_NOTIFY_BUS_CHECK:
-		if (!dock_in_progress(ds) && dock_present(ds)) {
+		if (!dock_in_progress(ds) && acpi_bus_get_device(ds->handle, &tmp)) =
{
 			begin_dock(ds);
 			dock(ds);
 			if (!dock_present(ds)) {
 				printk(KERN_ERR PREFIX "Unable to dock!\n");
+				complete_dock(ds);
 				break;
 			}
 			atomic_notifier_call_chain(&dock_notifier_list,


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
