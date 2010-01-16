From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/8] sony-laptop - remove private workqueue, use keventd instead
Date: Sat, 16 Jan 2010 02:34:09 -0500
Message-ID: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1263627201.git.len.brown@intel.com>
References: <1263627256-21501-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:34016 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898Ab0APHe3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Jan 2010 02:34:29 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KWB006U4X169JDB@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 Jan 2010 01:34:19 -0600 (CST)
In-reply-to: <1263627256-21501-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, Len Brown <len.brown@intel.com>

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

If we reschedule work instead of having work function sleep for 10 msecs
between reads from kfifo we can safely use the main workqueue (keventd)
and not bother with creating driver-private one.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/sony-laptop.c |   71 ++++++++++++++++++++----------------
 1 files changed, 39 insertions(+), 32 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 5af5334..c42d35b 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -145,7 +145,6 @@ struct sony_laptop_input_s {
 	struct input_dev	*key_dev;
 	struct kfifo		fifo;
 	spinlock_t		fifo_lock;
-	struct workqueue_struct	*wq;
 };
 
 static struct sony_laptop_input_s sony_laptop_input = {
@@ -301,18 +300,28 @@ static int sony_laptop_input_keycode_map[] = {
 /* release buttons after a short delay if pressed */
 static void do_sony_laptop_release_key(struct work_struct *work)
 {
+	struct delayed_work *dwork =
+			container_of(work, struct delayed_work, work);
 	struct sony_laptop_keypress kp;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sony_laptop_input.fifo_lock, flags);
 
-	while (kfifo_out_locked(&sony_laptop_input.fifo, (unsigned char *)&kp,
-			sizeof(kp), &sony_laptop_input.fifo_lock)
-			== sizeof(kp)) {
-		msleep(10);
+	if (kfifo_out(&sony_laptop_input.fifo,
+		      (unsigned char *)&kp, sizeof(kp)) == sizeof(kp)) {
 		input_report_key(kp.dev, kp.key, 0);
 		input_sync(kp.dev);
 	}
+
+	/* If there is something in the fifo schedule next release. */
+	if (kfifo_len(&sony_laptop_input.fifo) != 0)
+		schedule_delayed_work(dwork, msecs_to_jiffies(10));
+
+	spin_unlock_irqrestore(&sony_laptop_input.fifo_lock, flags);
 }
-static DECLARE_WORK(sony_laptop_release_key_work,
-		do_sony_laptop_release_key);
+
+static DECLARE_DELAYED_WORK(sony_laptop_release_key_work,
+			    do_sony_laptop_release_key);
 
 /* forward event to the input subsystem */
 static void sony_laptop_report_input_event(u8 event)
@@ -366,13 +375,13 @@ static void sony_laptop_report_input_event(u8 event)
 		/* we emit the scancode so we can always remap the key */
 		input_event(kp.dev, EV_MSC, MSC_SCAN, event);
 		input_sync(kp.dev);
-		kfifo_in_locked(&sony_laptop_input.fifo,
-			  (unsigned char *)&kp, sizeof(kp),
-			  &sony_laptop_input.fifo_lock);
 
-		if (!work_pending(&sony_laptop_release_key_work))
-			queue_work(sony_laptop_input.wq,
-					&sony_laptop_release_key_work);
+		/* schedule key release */
+		kfifo_in_locked(&sony_laptop_input.fifo,
+				(unsigned char *)&kp, sizeof(kp),
+				&sony_laptop_input.fifo_lock);
+		schedule_delayed_work(&sony_laptop_release_key_work,
+				      msecs_to_jiffies(10));
 	} else
 		dprintk("unknown input event %.2x\n", event);
 }
@@ -390,27 +399,18 @@ static int sony_laptop_setup_input(struct acpi_device *acpi_device)
 
 	/* kfifo */
 	spin_lock_init(&sony_laptop_input.fifo_lock);
-	error =
-	 kfifo_alloc(&sony_laptop_input.fifo, SONY_LAPTOP_BUF_SIZE, GFP_KERNEL);
+	error = kfifo_alloc(&sony_laptop_input.fifo,
+			    SONY_LAPTOP_BUF_SIZE, GFP_KERNEL);
 	if (error) {
 		printk(KERN_ERR DRV_PFX "kfifo_alloc failed\n");
 		goto err_dec_users;
 	}
 
-	/* init workqueue */
-	sony_laptop_input.wq = create_singlethread_workqueue("sony-laptop");
-	if (!sony_laptop_input.wq) {
-		printk(KERN_ERR DRV_PFX
-				"Unable to create workqueue.\n");
-		error = -ENXIO;
-		goto err_free_kfifo;
-	}
-
 	/* input keys */
 	key_dev = input_allocate_device();
 	if (!key_dev) {
 		error = -ENOMEM;
-		goto err_destroy_wq;
+		goto err_free_kfifo;
 	}
 
 	key_dev->name = "Sony Vaio Keys";
@@ -473,9 +473,6 @@ err_unregister_keydev:
 err_free_keydev:
 	input_free_device(key_dev);
 
-err_destroy_wq:
-	destroy_workqueue(sony_laptop_input.wq);
-
 err_free_kfifo:
 	kfifo_free(&sony_laptop_input.fifo);
 
@@ -486,12 +483,23 @@ err_dec_users:
 
 static void sony_laptop_remove_input(void)
 {
-	/* cleanup only after the last user has gone */
+	struct sony_laptop_keypress kp = { NULL };
+
+	/* Cleanup only after the last user has gone */
 	if (!atomic_dec_and_test(&sony_laptop_input.users))
 		return;
 
-	/* flush workqueue first */
-	flush_workqueue(sony_laptop_input.wq);
+	cancel_delayed_work_sync(&sony_laptop_release_key_work);
+
+	/*
+	 * Generate key-up events for remaining keys. Note that we don't
+	 * need locking since nobody is adding new events to the kfifo.
+	 */
+	while (kfifo_out(&sony_laptop_input.fifo,
+			 (unsigned char *)&kp, sizeof(kp)) == sizeof(kp)) {
+		input_report_key(kp.dev, kp.key, 0);
+		input_sync(kp.dev);
+	}
 
 	/* destroy input devs */
 	input_unregister_device(sony_laptop_input.key_dev);
@@ -502,7 +510,6 @@ static void sony_laptop_remove_input(void)
 		sony_laptop_input.jog_dev = NULL;
 	}
 
-	destroy_workqueue(sony_laptop_input.wq);
 	kfifo_free(&sony_laptop_input.fifo);
 }
 
-- 
1.6.0.6

