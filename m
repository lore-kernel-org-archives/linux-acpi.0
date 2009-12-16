From: Len Brown <lenb@kernel.org>
Subject: [PATCH 052/103] dell-laptop: fix a use-after-free error on the failure
 path
Date: Wed, 16 Dec 2009 03:36:03 -0500
Message-ID: <71e9dc73cb6b1351bdd5f732cef5dbef411b3219.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:41516 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760057AbZLPKFu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 05:05:50 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ00A4HPDO02XA@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 04:05:50 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Len Brown <len.brown@intel.com>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

dell_setup_rfkill() already cleans up the rfkill devices on failure.
So if it returns an error, we should not try to unregister the rfkill
devices.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Acked-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/dell-laptop.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
index 9061111..d791ef9 100644
--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -330,7 +330,7 @@ static int __init dell_init(void)
 
 	if (ret) {
 		printk(KERN_WARNING "dell-laptop: Unable to setup rfkill\n");
-		goto out;
+		goto fail_rfkill;
 	}
 
 #ifdef CONFIG_ACPI
@@ -358,7 +358,7 @@ static int __init dell_init(void)
 		if (IS_ERR(dell_backlight_device)) {
 			ret = PTR_ERR(dell_backlight_device);
 			dell_backlight_device = NULL;
-			goto out;
+			goto fail_backlight;
 		}
 
 		dell_backlight_device->props.max_brightness = max_intensity;
@@ -368,13 +368,15 @@ static int __init dell_init(void)
 	}
 
 	return 0;
-out:
+
+fail_backlight:
 	if (wifi_rfkill)
 		rfkill_unregister(wifi_rfkill);
 	if (bluetooth_rfkill)
 		rfkill_unregister(bluetooth_rfkill);
 	if (wwan_rfkill)
 		rfkill_unregister(wwan_rfkill);
+fail_rfkill:
 	kfree(da_tokens);
 	return ret;
 }
-- 
1.6.0.6

