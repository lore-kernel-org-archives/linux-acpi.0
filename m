From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/8] sony-laptop - switch from workqueue to a timer
Date: Sat, 16 Jan 2010 02:34:11 -0500
Message-ID: <cffdde993a016bedbc2f5eb60d00c3a766ffb612.1263627201.git.len.brown@intel.com>
References: <1263627256-21501-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:58770 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab0APHe0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Jan 2010 02:34:26 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KWB008PNX17P4Y2@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 Jan 2010 01:34:24 -0600 (CST)
In-reply-to: <1263627256-21501-1-git-send-email-lenb@kernel.org>
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1263627201.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1263627201.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, Len Brown <len.brown@intel.com>

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

The function that is executing in workqueue context does not need
to sleep so let's switch to a timer which is more lightweight.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/sony-laptop.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index b7aa959..cc7172e 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -145,6 +145,7 @@ struct sony_laptop_input_s {
 	struct input_dev	*key_dev;
 	struct kfifo		fifo;
 	spinlock_t		fifo_lock;
+	struct timer_list	release_key_timer;
 };
 
 static struct sony_laptop_input_s sony_laptop_input = {
@@ -298,10 +299,8 @@ static int sony_laptop_input_keycode_map[] = {
 };
 
 /* release buttons after a short delay if pressed */
-static void do_sony_laptop_release_key(struct work_struct *work)
+static void do_sony_laptop_release_key(unsigned long unused)
 {
-	struct delayed_work *dwork =
-			container_of(work, struct delayed_work, work);
 	struct sony_laptop_keypress kp;
 	unsigned long flags;
 
@@ -315,14 +314,12 @@ static void do_sony_laptop_release_key(struct work_struct *work)
 
 	/* If there is something in the fifo schedule next release. */
 	if (kfifo_len(&sony_laptop_input.fifo) != 0)
-		schedule_delayed_work(dwork, msecs_to_jiffies(10));
+		mod_timer(&sony_laptop_input.release_key_timer,
+			  jiffies + msecs_to_jiffies(10));
 
 	spin_unlock_irqrestore(&sony_laptop_input.fifo_lock, flags);
 }
 
-static DECLARE_DELAYED_WORK(sony_laptop_release_key_work,
-			    do_sony_laptop_release_key);
-
 /* forward event to the input subsystem */
 static void sony_laptop_report_input_event(u8 event)
 {
@@ -380,8 +377,8 @@ static void sony_laptop_report_input_event(u8 event)
 		kfifo_in_locked(&sony_laptop_input.fifo,
 				(unsigned char *)&kp, sizeof(kp),
 				&sony_laptop_input.fifo_lock);
-		schedule_delayed_work(&sony_laptop_release_key_work,
-				      msecs_to_jiffies(10));
+		mod_timer(&sony_laptop_input.release_key_timer,
+			  jiffies + msecs_to_jiffies(10));
 	} else
 		dprintk("unknown input event %.2x\n", event);
 }
@@ -406,6 +403,9 @@ static int sony_laptop_setup_input(struct acpi_device *acpi_device)
 		goto err_dec_users;
 	}
 
+	setup_timer(&sony_laptop_input.release_key_timer,
+		    do_sony_laptop_release_key, 0);
+
 	/* input keys */
 	key_dev = input_allocate_device();
 	if (!key_dev) {
@@ -485,7 +485,7 @@ static void sony_laptop_remove_input(void)
 	if (!atomic_dec_and_test(&sony_laptop_input.users))
 		return;
 
-	cancel_delayed_work_sync(&sony_laptop_release_key_work);
+	del_timer_sync(&sony_laptop_input.release_key_timer);
 
 	/*
 	 * Generate key-up events for remaining keys. Note that we don't
-- 
1.6.0.6

