From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 2/4] asus-laptop: restore acpi_generate_proc_event()
Date: Sun, 15 Feb 2009 19:30:19 +0100
Message-ID: <1234722621-14498-3-git-send-email-corentincj@iksaif.net>
References: <1234722621-14498-1-git-send-email-corentincj@iksaif.net>
 <1234722621-14498-2-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp21.services.sfr.fr ([93.17.128.1]:62695 "EHLO
	smtp21.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754287AbZBOSlN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Feb 2009 13:41:13 -0500
Received: from smtp21.services.sfr.fr (msfrf2119 [10.18.25.33])
	by msfrf2120.sfr.fr (SMTP Server) with ESMTP id 54D477000637
	for <linux-acpi@vger.kernel.org>; Sun, 15 Feb 2009 19:33:23 +0100 (CET)
In-Reply-To: <1234722621-14498-2-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, Corentin Chary <corentincj@iksaif.net>

Restore acpi_generate_proc_event() for backward
compatibility with old acpi scripts.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/asus-laptop.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 56af6cf..eeafc6c 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -815,6 +815,7 @@ static int asus_setkeycode(struct input_dev *dev, int scancode, int keycode)
 static void asus_hotk_notify(acpi_handle handle, u32 event, void *data)
 {
 	static struct key_entry *key;
+	u16 count;
 
 	/* TODO Find a better way to handle events count. */
 	if (!hotk)
@@ -832,9 +833,11 @@ static void asus_hotk_notify(acpi_handle handle, u32 event, void *data)
 		lcd_blank(FB_BLANK_POWERDOWN);
 	}
 
+	count = hotk->event_count[event % 128]++;
+	acpi_bus_generate_proc_event(hotk->device, event, count);
 	acpi_bus_generate_netlink_event(hotk->device->pnp.device_class,
 					dev_name(&hotk->device->dev), event,
-					hotk->event_count[event % 128]++);
+					count);
 
 	if (hotk->inputdev) {
 		key = asus_get_entry_by_scancode(event);
-- 
1.6.1.2


