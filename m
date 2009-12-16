From: Len Brown <lenb@kernel.org>
Subject: [PATCH 053/103] dell-laptop: fix rfkill memory leak on unload and
 failure paths
Date: Wed, 16 Dec 2009 03:36:04 -0500
Message-ID: <4311bb230e0f7e4daa5fd5bc0cc536e2bd1eff20.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:41516 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760855AbZLPKF7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 05:05:59 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ00A4HPDO02XA@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 04:05:54 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Len Brown <len.brown@intel.com>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

rfkill_unregister() should always be followed by rfkill_destroy().

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Acked-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/dell-laptop.c |   30 ++++++++++++++++++------------
 1 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
index d791ef9..94139d5 100644
--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -268,6 +268,22 @@ err_wifi:
 	return ret;
 }
 
+static void dell_cleanup_rfkill(void)
+{
+	if (wifi_rfkill) {
+		rfkill_unregister(wifi_rfkill);
+		rfkill_destroy(wifi_rfkill);
+	}
+	if (bluetooth_rfkill) {
+		rfkill_unregister(bluetooth_rfkill);
+		rfkill_destroy(bluetooth_rfkill);
+	}
+	if (wwan_rfkill) {
+		rfkill_unregister(wwan_rfkill);
+		rfkill_destroy(wwan_rfkill);
+	}
+}
+
 static int dell_send_intensity(struct backlight_device *bd)
 {
 	struct calling_interface_buffer buffer;
@@ -370,12 +386,7 @@ static int __init dell_init(void)
 	return 0;
 
 fail_backlight:
-	if (wifi_rfkill)
-		rfkill_unregister(wifi_rfkill);
-	if (bluetooth_rfkill)
-		rfkill_unregister(bluetooth_rfkill);
-	if (wwan_rfkill)
-		rfkill_unregister(wwan_rfkill);
+	dell_cleanup_rfkill();
 fail_rfkill:
 	kfree(da_tokens);
 	return ret;
@@ -384,12 +395,7 @@ fail_rfkill:
 static void __exit dell_exit(void)
 {
 	backlight_device_unregister(dell_backlight_device);
-	if (wifi_rfkill)
-		rfkill_unregister(wifi_rfkill);
-	if (bluetooth_rfkill)
-		rfkill_unregister(bluetooth_rfkill);
-	if (wwan_rfkill)
-		rfkill_unregister(wwan_rfkill);
+	dell_cleanup_rfkill();
 }
 
 module_init(dell_init);
-- 
1.6.0.6

