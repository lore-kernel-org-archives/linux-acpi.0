From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH] asus-laptop: use generic netlink interface
Date: Sun, 18 Jan 2009 19:01:52 +0100
Message-ID: <1232301715-20292-4-git-send-email-corentincj@iksaif.net>
References: <1232301715-20292-1-git-send-email-corentincj@iksaif.net>
 <1232301715-20292-2-git-send-email-corentincj@iksaif.net>
 <1232301715-20292-3-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:58970 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757442AbZARSRN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 18 Jan 2009 13:17:13 -0500
In-Reply-To: <1232301715-20292-3-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, Corentin Chary <corentincj@iksaif.net>

To be prepared for /proc/acpi/event removal we export events
also through generic netlink interface.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
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
1.6.0.6

