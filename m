From: Shaohua Li <shaohua.li@intel.com>
Subject: [patch 9/10] fix for bay in a dock station
Date: Tue, 08 Jul 2008 13:51:01 +0800
Message-ID: <1215496261.17826.43.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:29547 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346AbYGHFnz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Jul 2008 01:43:55 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Andi Kleen <andi@firstfloor.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>

an ATA bay can be in a dock and itself can be ejected separately. The
patch handles such eject bay. Found by Holger.

Signed-off-by: Shaohua Li <shaohua.li@intel.com> 
---
 drivers/acpi/dock.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

Index: linux/drivers/acpi/dock.c
===================================================================
--- linux.orig/drivers/acpi/dock.c	2008-07-07 11:50:34.000000000 +0800
+++ linux/drivers/acpi/dock.c	2008-07-07 11:52:34.000000000 +0800
@@ -606,6 +606,7 @@ register_hotplug_dock_device(acpi_handle
 {
 	struct dock_dependent_device *dd;
 	struct dock_station *dock_station;
+	int ret = -EINVAL;
 
 	if (!dock_station_count)
 		return -ENODEV;
@@ -615,16 +616,21 @@ register_hotplug_dock_device(acpi_handle
 	 * this would include the dock station itself
 	 */
 	list_for_each_entry(dock_station, &dock_stations, sibiling) {
+		/*
+		 * An ATA bay can be in a dock and itself can be ejected
+		 * separately, so there are two 'dock stations' which need the
+		 * ops
+		 */
 		dd = find_dock_dependent_device(dock_station, handle);
 		if (dd) {
 			dd->ops = ops;
 			dd->context = context;
 			dock_add_hotplug_device(dock_station, dd);
-			return 0;
+			ret = 0;
 		}
 	}
 
-	return -EINVAL;
+	return ret;
 }
 
 EXPORT_SYMBOL_GPL(register_hotplug_dock_device);
@@ -1070,8 +1076,8 @@ find_dock(acpi_handle handle, u32 lvl, v
 static acpi_status
 find_bay(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
-	/* If bay is in a dock, it's already handled */
-	if (is_ejectable_bay(handle) && !is_dock_device(handle))
+	/* If bay is a dock, it's already handled */
+	if (is_ejectable_bay(handle) && !is_dock(handle))
 		dock_add(handle);
 	return AE_OK;
 }


