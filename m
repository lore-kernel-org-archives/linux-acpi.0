From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/30] asus-laptop: use generic netlink interface
Date: Sat, 07 Feb 2009 01:41:15 -0500
Message-ID: <2a7dc0d8c60325e9bf820900bf919430e5a419ab.1233988823.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:12159 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbZBGGlt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Feb 2009 01:41:49 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-2.01 (built Jun 13 2007; 32bit))
 with ESMTPA id <0KEO00JFANXA6Y92@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Feb 2009 00:41:35 -0600 (CST)
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
 drivers/platform/x86/asus-laptop.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 8fb8b35..1b7a28c 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -738,8 +738,9 @@ static void asus_hotk_notify(acpi_handle handle, u32 event, void *data)
 		lcd_blank(FB_BLANK_POWERDOWN);
 	}
 
-	acpi_bus_generate_proc_event(hotk->device, event,
-				hotk->event_count[event % 128]++);
+	acpi_bus_generate_netlink_event(hotk->device->pnp.device_class,
+					dev_name(&hotk->device->dev), event,
+					hotk->event_count[event % 128]++);
 
 	return;
 }
-- 
1.5.6.6

