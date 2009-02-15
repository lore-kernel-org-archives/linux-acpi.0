From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 3/4] eeepc-laptop: restore acpi_generate_proc_event()
Date: Sun, 15 Feb 2009 19:30:20 +0100
Message-ID: <1234722621-14498-4-git-send-email-corentincj@iksaif.net>
References: <1234722621-14498-1-git-send-email-corentincj@iksaif.net>
 <1234722621-14498-2-git-send-email-corentincj@iksaif.net>
 <1234722621-14498-3-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp21.services.sfr.fr ([93.17.128.3]:49473 "EHLO
	smtp21.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754305AbZBOSlH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Feb 2009 13:41:07 -0500
Received: from smtp21.services.sfr.fr (msfrf2119 [10.18.25.33])
	by msfrf2110.sfr.fr (SMTP Server) with ESMTP id 71CE27000A63
	for <linux-acpi@vger.kernel.org>; Sun, 15 Feb 2009 19:33:23 +0100 (CET)
In-Reply-To: <1234722621-14498-3-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, Corentin Chary <corentincj@iksaif.net>

Restore acpi_generate_proc_event() for backward
compatibility with old acpi scripts.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/eeepc-laptop.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 786ed86..6f54fd1 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -557,13 +557,17 @@ static void eeepc_rfkill_notify(acpi_handle handle, u32 event, void *data)
 static void eeepc_hotk_notify(acpi_handle handle, u32 event, void *data)
 {
 	static struct key_entry *key;
+	u16 count;
+
 	if (!ehotk)
 		return;
 	if (event >= NOTIFY_BRN_MIN && event <= NOTIFY_BRN_MAX)
 		notify_brn();
+	count = ehotk->event_count[event % 128]++;
+	acpi_bus_generate_proc_event(ehotk->device, event, count);
 	acpi_bus_generate_netlink_event(ehotk->device->pnp.device_class,
 					dev_name(&ehotk->device->dev), event,
-					ehotk->event_count[event % 128]++);
+					count);
 	if (ehotk->inputdev) {
 		key = eepc_get_entry_by_scancode(event);
 		if (key) {
-- 
1.6.1.2


