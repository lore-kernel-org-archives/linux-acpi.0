From: Len Brown <lenb@kernel.org>
Subject: [PATCH 030/103] eeepc-laptop: fix led initialization order
Date: Wed, 16 Dec 2009 03:35:41 -0500
Message-ID: <2b56f1c170fc6338a7d907d6a7132669f9ccdf62.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:62434 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761900AbZLPJGU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 04:06:20 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ0055NMLOFSID@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 03:06:00 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Len Brown <len.brown@intel.com>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

Create the workqueue thread used by tpd_led_set() *before* we register
the led device.  (And vice versa for unregistration).

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 6c982d6..ac45faf 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -1074,10 +1074,10 @@ static void eeepc_hwmon_exit(void)
 
 static void eeepc_led_exit(void)
 {
-	if (led_workqueue)
-		destroy_workqueue(led_workqueue);
 	if (tpd_led.dev)
 		led_classdev_unregister(&tpd_led);
+	if (led_workqueue)
+		destroy_workqueue(led_workqueue);
 }
 
 static int eeepc_new_rfkill(struct rfkill **rfkill,
@@ -1243,14 +1243,14 @@ static int eeepc_led_init(struct device *dev)
 	if (get_acpi(CM_ASL_TPD) == -ENODEV)
 		return 0;
 
-	rv = led_classdev_register(dev, &tpd_led);
-	if (rv)
-		return rv;
-
 	led_workqueue = create_singlethread_workqueue("led_workqueue");
 	if (!led_workqueue)
 		return -ENOMEM;
 
+	rv = led_classdev_register(dev, &tpd_led);
+	if (rv)
+		return rv;
+
 	return 0;
 }
 
-- 
1.6.0.6

