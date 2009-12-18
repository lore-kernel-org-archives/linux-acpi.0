From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] dell-wmi - do not keep driver loaded on unsupported boxes
Date: Thu, 17 Dec 2009 22:19:42 -0800
Message-ID: <20091218061941.GD21231@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:49348 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbZLRGTr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Dec 2009 01:19:47 -0500
Received: by pzk1 with SMTP id 1so2014862pzk.33
        for <linux-acpi@vger.kernel.org>; Thu, 17 Dec 2009 22:19:46 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: Matthew Garrett <mjg@redhat.com>, linux-acpi@vger.kernel.org

There is no point in having the driver loaded in memory if we fail
to locate particular WMI GUID.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/platform/x86/dell-wmi.c |   41 ++++++++++++++++++---------------------
 1 files changed, 19 insertions(+), 22 deletions(-)


diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-wmi.c
index 67f3fe7..46244c6 100644
--- a/drivers/platform/x86/dell-wmi.c
+++ b/drivers/platform/x86/dell-wmi.c
@@ -324,37 +324,34 @@ static int __init dell_wmi_init(void)
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
Dmitry
