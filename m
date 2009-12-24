From: Len Brown <lenb@kernel.org>
Subject: [PATCH 31/34] dell-wmi: do not keep driver loaded on unsupported boxes
Date: Thu, 24 Dec 2009 01:24:02 -0500
Message-ID: <1fdd407f4e3f2ecb453954cbebb6c22491c61853.1261635793.git.len.brown@intel.com>
References: <1261635845-18306-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37630 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755760AbZLXTbV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 14:31:21 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KV600GDH8VGSH71@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 24 Dec 2009 13:31:03 -0600 (CST)
In-reply-to: <1261635845-18306-1-git-send-email-lenb@kernel.org>
In-reply-to: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
References: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, Len Brown <len.brown@intel.com>

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

There is no point in having the driver loaded in memory if we fail
to locate particular WMI GUID.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Acked-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/dell-wmi.c |   41 ++++++++++++++++++--------------------
 1 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index 6561dfc..916ccb2 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -325,37 +325,34 @@ static int __init dell_wmi_init(void)
 	int err;
 
 	if (wmi_has_guid(DELL_EVENT_GUID)) {
+		printk(KERN_WARNING "dell-wmi: No known WMI GUID found\n");
+		return -ENODEV;
+	}
 
-		dmi_walk(find_hk_type, NULL);
-
-		err = dell_wmi_input_setup();
-
-		if (err)
-			return err;
-
-		err = wmi_install_notify_handler(DELL_EVENT_GUID,
-						 dell_wmi_notify, NULL);
-		if (err) {
-			input_unregister_device(dell_wmi_input_dev);
-			printk(KERN_ERR "dell-wmi: Unable to register"
-			       " notify handler - %d\n", err);
-			return err;
-		}
+	dmi_walk(find_hk_type, NULL);
+	acpi_video = acpi_video_backlight_support();
 
-		acpi_video = acpi_video_backlight_support();
+	err = dell_wmi_input_setup();
+	if (err)
+		return err;
 
-	} else
-		printk(KERN_WARNING "dell-wmi: No known WMI GUID found\n");
+	err = wmi_install_notify_handler(DELL_EVENT_GUID,
+					 dell_wmi_notify, NULL);
+	if (err) {
+		input_unregister_device(dell_wmi_input_dev);
+		printk(KERN_ERR
+			"dell-wmi: Unable to register notify handler - %d\n",
+			err);
+		return err;
+	}
 
 	return 0;
 }
 
 static void __exit dell_wmi_exit(void)
 {
-	if (wmi_has_guid(DELL_EVENT_GUID)) {
-		wmi_remove_notify_handler(DELL_EVENT_GUID);
-		input_unregister_device(dell_wmi_input_dev);
-	}
+	wmi_remove_notify_handler(DELL_EVENT_GUID);
+	input_unregister_device(dell_wmi_input_dev);
 }
 
 module_init(dell_wmi_init);
-- 
1.6.0.6

