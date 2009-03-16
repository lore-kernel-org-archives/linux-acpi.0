From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/14] asus-laptop: restore acpi_generate_proc_event()
Date: Mon, 16 Mar 2009 01:23:52 -0400
Message-ID: <6050c8dd70b21a9d927983aeb6357fecffa7fb23.1237181013.git.len.brown@intel.com>
References: <1237181040-24165-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:45332 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbZCPFYI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Mar 2009 01:24:08 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KGL00CZT306VJBO@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 16 Mar 2009 00:24:06 -0500 (CDT)
In-reply-to: <1237181040-24165-1-git-send-email-lenb@kernel.org>
In-reply-to: <a140449584522c3eea1bb381f746d40939e6f62a.1237181013.git.len.brown@intel.com>
References: <a140449584522c3eea1bb381f746d40939e6f62a.1237181013.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

Restore acpi_generate_proc_event() for backward
compatibility with old acpi scripts.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.5.6.6

