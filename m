From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 10/10] eeepc-laptop: use netlink interface
Date: Tue, 20 Jan 2009 16:17:49 +0100
Message-ID: <1232464669-29619-11-git-send-email-corentincj@iksaif.net>
References: <1232464669-29619-1-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:59557 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757181AbZATPR6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jan 2009 10:17:58 -0500
In-Reply-To: <1232464669-29619-1-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>

To be prepared for /proc/acpi/event removal we export events
also through generic netlink interface.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
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
1.6.1

