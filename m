From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 2/4] sony-laptop: remove private workqueue, use keventd instead
Date: Thu, 17 Dec 2009 00:08:34 +0900
Message-ID: <1260976116-6369-3-git-send-email-malattia@linux.it>
References: <1260976116-6369-1-git-send-email-malattia@linux.it>
 <1260976116-6369-2-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:38829
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762192AbZLPPIx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 10:08:53 -0500
In-Reply-To: <1260976116-6369-2-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, Mattia Dongili <malattia@linux.it>

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

If we reschedule work instead of having work function sleep for 10 msecs
between reads from kfifo we can safely use the main workqueue (keventd)
and not bother with creating driver-private one.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/platform/x86/sony-laptop.c |   57 +++++++++++++++++++----------------
 1 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 9710f70..b2dccf4 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -144,7 +144,6 @@ struct sony_laptop_input_s {
 	struct input_dev	*key_dev;
 	struct kfifo		*fifo;
 	spinlock_t		fifo_lock;
-	struct workqueue_struct	*wq;
 };
 
 static struct sony_laptop_input_s sony_laptop_input = {
@@ -300,17 +299,28 @@ static int sony_laptop_input_keycode_map[] = {
 /* release buttons after a short delay if pressed */
 static void do_sony_laptop_release_key(struct work_struct *work)
 {
+	struct delayed_work *dwork =
+			container_of(work, struct delayed_work, work);
 	struct sony_laptop_keypress kp;
 
-	while (kfifo_get(sony_laptop_input.fifo, (unsigned char *)&kp,
-			 sizeof(kp)) == sizeof(kp)) {
-		msleep(10);
+	if (kfifo_get(sony_laptop_input.fifo,
+		      (unsigned char *)&kp, sizeof(kp)) == sizeof(kp)) {
 		input_report_key(kp.dev, kp.key, 0);
 		input_sync(kp.dev);
 	}
+
+	/*
+	 * If there is something in the fifo scnhedule nect release.
+	 * We don't care about locking, at worst we may schedule an
+	 * extra "empty" wakeup. This may be improved with the new
+	 * kfifo API.
+	 */
+	if (__kfifo_len(sony_laptop_input.fifo) != 0)
+		schedule_delayed_work(dwork, msecs_to_jiffies(10));
 }
-static DECLARE_WORK(sony_laptop_release_key_work,
-		do_sony_laptop_release_key);
+
+static DECLARE_DELAYED_WORK(sony_laptop_release_key_work,
+			    do_sony_laptop_release_key);
 
 /* forward event to the input subsystem */
 static void sony_laptop_report_input_event(u8 event)
@@ -364,12 +374,12 @@ static void sony_laptop_report_input_event(u8 event)
 		/* we emit the scancode so we can always remap the key */
 		input_event(kp.dev, EV_MSC, MSC_SCAN, event);
 		input_sync(kp.dev);
+
+		/* schedule key release */
 		kfifo_put(sony_laptop_input.fifo,
 			  (unsigned char *)&kp, sizeof(kp));
-
-		if (!work_pending(&sony_laptop_release_key_work))
-			queue_work(sony_laptop_input.wq,
-					&sony_laptop_release_key_work);
+		schedule_delayed_work(&sony_laptop_release_key_work,
+				      msecs_to_jiffies(10));
 	} else
 		dprintk("unknown input event %.2x\n", event);
 }
@@ -396,20 +406,11 @@ static int sony_laptop_setup_input(struct acpi_device *acpi_device)
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
@@ -472,9 +473,6 @@ err_unregister_keydev:
 err_free_keydev:
 	input_free_device(key_dev);
 
-err_destroy_wq:
-	destroy_workqueue(sony_laptop_input.wq);
-
 err_free_kfifo:
 	kfifo_free(sony_laptop_input.fifo);
 
@@ -485,12 +483,20 @@ err_dec_users:
 
 static void sony_laptop_remove_input(void)
 {
+	struct sony_laptop_keypress kp = { NULL };
+
 	/* cleanup only after the last user has gone */
 	if (!atomic_dec_and_test(&sony_laptop_input.users))
 		return;
 
-	/* flush workqueue first */
-	flush_workqueue(sony_laptop_input.wq);
+	cancel_delayed_work_sync(&sony_laptop_release_key_work);
+
+	/* Generate key-up events for remaining keys */
+	while (kfifo_get(sony_laptop_input.fifo,
+			 (unsigned char *)&kp, sizeof(kp)) == sizeof(kp)) {
+		input_report_key(kp.dev, kp.key, 0);
+		input_sync(kp.dev);
+	}
 
 	/* destroy input devs */
 	input_unregister_device(sony_laptop_input.key_dev);
@@ -501,7 +507,6 @@ static void sony_laptop_remove_input(void)
 		sony_laptop_input.jog_dev = NULL;
 	}
 
-	destroy_workqueue(sony_laptop_input.wq);
 	kfifo_free(sony_laptop_input.fifo);
 }
 
-- 
1.6.5.4

