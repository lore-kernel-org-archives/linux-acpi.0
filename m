From: Len Brown <lenb@kernel.org>
Subject: [PATCH 042/122] acer-wmi: Remove private workqueue
Date: Thu, 23 Oct 2008 02:38:16 -0400
Message-ID: <ae3a1b46099aa87f1662621580c985432ca1c9d9.1224743916.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:51267 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754854AbYJWGj7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:39:59 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9600GNIIIL6G05@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:39:58 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <len.brown@intel.com>

From: Carlos Corbacho <carlos@strangeworlds.co.uk>

As per Dmitry Torokhov's suggestion, acer-wmi doesn't need a private
workqueue, so remove it.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/acer-wmi.c |   18 ++----------------
 1 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/acer-wmi.c b/drivers/misc/acer-wmi.c
index 8708d31..cf4c39f 100644
--- a/drivers/misc/acer-wmi.c
+++ b/drivers/misc/acer-wmi.c
@@ -930,8 +930,6 @@ static void acer_backlight_exit(void)
 /*
  * Rfkill devices
  */
-static struct workqueue_struct *rfkill_workqueue;
-
 static void acer_rfkill_update(struct work_struct *ignored);
 static DECLARE_DELAYED_WORK(acer_rfkill_work, acer_rfkill_update);
 static void acer_rfkill_update(struct work_struct *ignored)
@@ -952,8 +950,7 @@ static void acer_rfkill_update(struct work_struct *ignored)
 				RFKILL_STATE_SOFT_BLOCKED);
 	}
 
-	queue_delayed_work(rfkill_workqueue, &acer_rfkill_work,
-		round_jiffies_relative(HZ));
+	schedule_delayed_work(&acer_rfkill_work, round_jiffies_relative(HZ));
 }
 
 static int acer_rfkill_set(void *data, enum rfkill_state state)
@@ -1018,17 +1015,7 @@ static int acer_rfkill_init(struct device *dev)
 		}
 	}
 
-	rfkill_workqueue = create_singlethread_workqueue("rfkill_workqueue");
-	if (!rfkill_workqueue) {
-		if (has_cap(ACER_CAP_BLUETOOTH)) {
-			kfree(bluetooth_rfkill->data);
-			rfkill_unregister(bluetooth_rfkill);
-		}
-		kfree(wireless_rfkill->data);
-		rfkill_unregister(wireless_rfkill);
-		return -ENOMEM;
-	}
-	queue_delayed_work(rfkill_workqueue, &acer_rfkill_work, HZ);
+	schedule_delayed_work(&acer_rfkill_work, round_jiffies_relative(HZ));
 
 	return 0;
 }
@@ -1036,7 +1023,6 @@ static int acer_rfkill_init(struct device *dev)
 static void acer_rfkill_exit(void)
 {
 	cancel_delayed_work_sync(&acer_rfkill_work);
-	destroy_workqueue(rfkill_workqueue);
 	kfree(wireless_rfkill->data);
 	rfkill_unregister(wireless_rfkill);
 	if (has_cap(ACER_CAP_BLUETOOTH)) {
-- 
1.5.5.1

