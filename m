From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/3] sony-laptop - remove private workqueue,
	use keventd instead
Date: Thu, 24 Dec 2009 00:02:16 -0800
Message-ID: <20091224080135.11511.18604.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:65054 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754797AbZLXICU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 03:02:20 -0500
Received: by pzk1 with SMTP id 1so1095468pzk.33
        for <linux-acpi@vger.kernel.org>; Thu, 24 Dec 2009 00:02:20 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, =Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org

If we reschedule work instead of having work function sleep for 10 msecs
between reads from kfifo we can safely use the main workqueue (keventd)
and not bother with creating driver-private one.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

These are the same paches that were sent previously, just adjusted to the
new kfifo API.


 drivers/platform/x86/sony-laptop.c |   71 ++++++++++++++++++++----------------
 1 files changed, 39 insertions(+), 32 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 2896ca4..5883cc8 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -144,7 +144,6 @@ struct sony_laptop_input_s {
 	struct input_dev	*key_dev;
 	struct kfifo		fifo;
 	spinlock_t		fifo_lock;
-	struct workqueue_struct	*wq;
 };
 
 static struct sony_laptop_input_s sony_laptop_input = {
@@ -298,18 +297,28 @@ static int sony_laptop_input_keycode_map[] = {
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
@@ -363,13 +372,13 @@ static void sony_laptop_report_input_event(u8 event)
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
@@ -387,27 +396,18 @@ static int sony_laptop_setup_input(struct acpi_device *acpi_device)
 
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
@@ -470,9 +470,6 @@ err_unregister_keydev:
 err_free_keydev:
 	input_free_device(key_dev);
 
-err_destroy_wq:
-	destroy_workqueue(sony_laptop_input.wq);
-
 err_free_kfifo:
 	kfifo_free(&sony_laptop_input.fifo);
 
@@ -483,12 +480,23 @@ err_dec_users:
 
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
@@ -499,7 +507,6 @@ static void sony_laptop_remove_input(void)
 		sony_laptop_input.jog_dev = NULL;
 	}
 
-	destroy_workqueue(sony_laptop_input.wq);
 	kfifo_free(&sony_laptop_input.fifo);
 }
 

