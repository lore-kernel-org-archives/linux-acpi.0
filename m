From: Len Brown <len.brown@intel.com>
Subject: [PATCH 07/16] ACPI: asus-laptop: Fix failure exits
Date: Wed, 25 Jul 2007 01:51:16 -0400
Message-ID: <11853426932522-git-send-email-len.brown@intel.com>
References: <11853426852588-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:62081 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752793AbXGYFve (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2007 01:51:34 -0400
In-Reply-To: <11853426852588-git-send-email-len.brown@intel.com>
Message-Id: <3b0d71170d37878bbb1203ebc3f92e36d6151a80.1185342489.git.len.brown@intel.com>
In-Reply-To: <e9b3aba887f47f9cd64de20fec9c333a932b70dc.1185342489.git.len.brown@intel.com>
References: <e9b3aba887f47f9cd64de20fec9c333a932b70dc.1185342489.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Al Viro <viro@ftp.linux.org.uk>, Al Viro <viro@zeniv.linux.org.uk>, Len Brown <len.brown@intel.com>

From: Al Viro <viro@ftp.linux.org.uk>

> Subject         : drivers/misc/asus-laptop.c:*: error: 'struct led_classdev' has no member named 'class_dev'
> References      : http://lkml.org/lkml/2007/7/22/299
> Submitter       : Gabriel C <nix.or.die@googlemail.com>

Fallout from f8a7c6fe14f556ca8eeddce258cb21392d0c3a2f.  However, looking
at it shows that checks done in ASUS_LED_UNREGISTER() can't trigger
at all (we never get to asus_led_exit() if registration fails) and
if that registration fails, we actually leak stuff.  IOW, it's worse
than just replacing class_dev with dev in there - the tests themselves
had been papering over the lousy cleanup logics.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/asus-laptop.c |   32 +++++++++++++++++++++-----------
 1 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
index f753060..6b89854 100644
--- a/drivers/misc/asus-laptop.c
+++ b/drivers/misc/asus-laptop.c
@@ -1067,19 +1067,16 @@ static void asus_backlight_exit(void)
 }
 
 #define  ASUS_LED_UNREGISTER(object)				\
-	if(object##_led.class_dev				\
-	   && !IS_ERR(object##_led.class_dev))			\
-		led_classdev_unregister(&object##_led)
+	led_classdev_unregister(&object##_led)
 
 static void asus_led_exit(void)
 {
+	destroy_workqueue(led_workqueue);
 	ASUS_LED_UNREGISTER(mled);
 	ASUS_LED_UNREGISTER(tled);
 	ASUS_LED_UNREGISTER(pled);
 	ASUS_LED_UNREGISTER(rled);
 	ASUS_LED_UNREGISTER(gled);
-
-	destroy_workqueue(led_workqueue);
 }
 
 static void __exit asus_laptop_exit(void)
@@ -1135,29 +1132,42 @@ static int asus_led_init(struct device *dev)
 
 	rv = ASUS_LED_REGISTER(mled, dev);
 	if (rv)
-		return rv;
+		goto out;
 
 	rv = ASUS_LED_REGISTER(tled, dev);
 	if (rv)
-		return rv;
+		goto out1;
 
 	rv = ASUS_LED_REGISTER(rled, dev);
 	if (rv)
-		return rv;
+		goto out2;
 
 	rv = ASUS_LED_REGISTER(pled, dev);
 	if (rv)
-		return rv;
+		goto out3;
 
 	rv = ASUS_LED_REGISTER(gled, dev);
 	if (rv)
-		return rv;
+		goto out4;
 
 	led_workqueue = create_singlethread_workqueue("led_workqueue");
 	if (!led_workqueue)
-		return -ENOMEM;
+		goto out5;
 
 	return 0;
+out5:
+	rv = -ENOMEM;
+	ASUS_LED_UNREGISTER(gled);
+out4:
+	ASUS_LED_UNREGISTER(pled);
+out3:
+	ASUS_LED_UNREGISTER(rled);
+out2:
+	ASUS_LED_UNREGISTER(tled);
+out1:
+	ASUS_LED_UNREGISTER(mled);
+out:
+	return rv;
 }
 
 static int __init asus_laptop_init(void)
-- 
1.5.3.rc2.22.g69a9b
