From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/30] eeepc-laptop: use netlink interface
Date: Sat, 07 Feb 2009 01:41:22 -0500
Message-ID: <2b25c9f01aa58d48129b2f93748dfb5d1f7ab0a2.1233988825.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:50597 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584AbZBGGl4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Feb 2009 01:41:56 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-2.01 (built Jun 13 2007; 32bit))
 with ESMTPA id <0KEO00H5ZNV5JJL2@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Feb 2009 00:40:19 -0600 (CST)
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

To be prepared for /proc/acpi/event removal we export events
also through generic netlink interface.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 66655d2..4348d99 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -560,8 +560,9 @@ static void eeepc_hotk_notify(acpi_handle handle, u32 event, void *data)
 		return;
 	if (event >= NOTIFY_BRN_MIN && event <= NOTIFY_BRN_MAX)
 		notify_brn();
-	acpi_bus_generate_proc_event(ehotk->device, event,
-				     ehotk->event_count[event % 128]++);
+	acpi_bus_generate_netlink_event(ehotk->device->pnp.device_class,
+					dev_name(&ehotk->device->dev), event,
+					ehotk->event_count[event % 128]++);
 	if (ehotk->inputdev) {
 		key = eepc_get_entry_by_scancode(event);
 		if (key) {
-- 
1.5.6.6

