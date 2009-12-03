From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 13/33] eeepc-laptop: fix led initialization order
Date: Thu,  3 Dec 2009 08:44:57 +0100
Message-ID: <1259826317-18809-14-git-send-email-corentincj@iksaif.net>
References: <1259826317-18809-1-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-2-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-3-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-4-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-5-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-6-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-7-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-8-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-9-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-10-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-11-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-12-git-send-email-corentincj@iksaif.net>
 <1259826317-18809-13-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:44225 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754096AbZLCHoe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 Dec 2009 02:44:34 -0500
In-Reply-To: <1259826317-18809-13-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

Create the workqueue thread used by tpd_led_set() *before* we register
the led device.  (And vice versa for unregistration).

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
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
1.6.5.3

