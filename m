From: Shaohua Li <shaohua.li@intel.com>
Subject: [patch 2/11]fix eject request process
Date: Wed, 27 Aug 2008 11:14:26 +0800
Message-ID: <1219806866.32665.58.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:36651 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752319AbYH0DEp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Aug 2008 23:04:45 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Andi Kleen <andi@firstfloor.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>, Tejun Heo <htejun@gmail.com>

commit 2a7feab28d3fc060d320eaba192e49dad1079b7e introduces a bug.
My thinkpad actually will send an eject_request and we should follow the
eject process to finish the eject, otherwise system still thinks the bay
is present.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---
 drivers/acpi/dock.c |    5 -----
 1 file changed, 5 deletions(-)

Index: linux/drivers/acpi/dock.c
===================================================================
--- linux.orig/drivers/acpi/dock.c	2008-08-27 10:19:30.000000000 +0800
+++ linux/drivers/acpi/dock.c	2008-08-27 10:20:08.000000000 +0800
@@ -575,11 +575,6 @@ static int handle_eject_request(struct d
 	 */
 	dock_event(ds, event, UNDOCK_EVENT);
 
-	if (!dock_present(ds)) {
-		complete_undock(ds);
-		return -ENODEV;
-	}
-
 	hotplug_dock_devices(ds, ACPI_NOTIFY_EJECT_REQUEST);
 	undock(ds);
 	eject_dock(ds);


