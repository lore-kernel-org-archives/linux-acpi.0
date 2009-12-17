From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] sony-laptop - switch from workqueue to a timer
Date: Thu, 17 Dec 2009 00:09:07 -0800
Message-ID: <20091217080907.GA12790@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:47711 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbZLQIJN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Dec 2009 03:09:13 -0500
Received: by pzk1 with SMTP id 1so1324974pzk.33
        for <linux-acpi@vger.kernel.org>; Thu, 17 Dec 2009 00:09:13 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

The function that is executing in workqueue context does not need
to sleep so let's switch to a timer which is more lightweight.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

Mattia,

After looking at the sony-laptop driver again I realized that since
we don't sleep in do_sony_laptop_release_key() we don't need to use
workqueue but can simply fire up a timer.

Please consider applying (or maybe folding into the other patch
removing private workqueue).

Thanks.

 drivers/platform/x86/sony-laptop.c |   43 +++++++++++++++++-------------------
 1 files changed, 20 insertions(+), 23 deletions(-)


diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index acb3933..44491b7 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -144,6 +145,7 @@ struct sony_laptop_input_s {
 	struct input_dev	*key_dev;
 	struct kfifo		*fifo;
 	spinlock_t		fifo_lock;
+	struct timer_list	release_key_timer;
 };
 
 static struct sony_laptop_input_s sony_laptop_input = {
@@ -295,10 +297,8 @@ static int sony_laptop_input_keycode_map[] = {
 };
 
 /* release buttons after a short delay if pressed */
-static void do_sony_laptop_release_key(struct work_struct *work)
+static void do_sony_laptop_release_key(unsigned long unused)
 {
-	struct delayed_work *dwork =
-			container_of(work, struct delayed_work, work);
 	struct sony_laptop_keypress kp;
 
 	if (kfifo_get(sony_laptop_input.fifo,
@@ -308,18 +308,16 @@ static void do_sony_laptop_release_key(struct work_struct *work)
 	}
 
 	/*
-	 * If there is something in the fifo scnhedule nect release.
+	 * If there is something in the fifo schedule next release.
 	 * We don't care about locking, at worst we may schedule an
 	 * extra "empty" wakeup. This may be improved with the new
 	 * kfifo API.
 	 */
 	if (__kfifo_len(sony_laptop_input.fifo) != 0)
-		schedule_delayed_work(dwork, msecs_to_jiffies(10));
+		mod_timer(&sony_laptop_input.release_key_timer,
+			  jiffies + msecs_to_jiffies(10));
 }
 
-static DECLARE_DELAYED_WORK(sony_laptop_release_key_work,
-			    do_sony_laptop_release_key);
-
 /* forward event to the input subsystem */
 static void sony_laptop_report_input_event(u8 event)
 {
@@ -376,8 +374,8 @@ static void sony_laptop_report_input_event(u8 event)
 		/* schedule key release */
 		kfifo_put(sony_laptop_input.fifo,
 			  (unsigned char *)&kp, sizeof(kp));
-		schedule_delayed_work(&sony_laptop_release_key_work,
-				      msecs_to_jiffies(10));
+		mod_timer(&sony_laptop_input.release_key_timer,
+			  jiffies + msecs_to_jiffies(10));
 	} else
 		dprintk("unknown input event %.2x\n", event);
 }
@@ -404,6 +402,9 @@ static int sony_laptop_setup_input(struct acpi_device *acpi_device)
 		goto err_dec_users;
 	}
 
+	setup_timer(&sony_laptop_input.release_key_timer,
+		    do_sony_laptop_release_key, 0);
+
 	/* input keys */
 	key_dev = input_allocate_device();
 	if (!key_dev) {
@@ -417,18 +418,15 @@ static int sony_laptop_setup_input(struct acpi_device *acpi_device)
 	key_dev->dev.parent = &acpi_device->dev;
 
 	/* Initialize the Input Drivers: special keys */
-	set_bit(EV_KEY, key_dev->evbit);
-	set_bit(EV_MSC, key_dev->evbit);
-	set_bit(MSC_SCAN, key_dev->mscbit);
+	input_set_capability(key_dev, EV_MSC, MSC_SCAN);
+
+	__set_bit(EV_KEY, key_dev->evbit);
 	key_dev->keycodesize = sizeof(sony_laptop_input_keycode_map[0]);
 	key_dev->keycodemax = ARRAY_SIZE(sony_laptop_input_keycode_map);
 	key_dev->keycode = &sony_laptop_input_keycode_map;
-	for (i = 0; i < ARRAY_SIZE(sony_laptop_input_keycode_map); i++) {
-		if (sony_laptop_input_keycode_map[i] != KEY_RESERVED) {
-			set_bit(sony_laptop_input_keycode_map[i],
-				key_dev->keybit);
-		}
-	}
+	for (i = 0; i < ARRAY_SIZE(sony_laptop_input_keycode_map); i++)
+		__set_bit(sony_laptop_input_keycode_map[i], key_dev->keybit);
+	__clear_bit(KEY_RESERVED, key_dev->keybit);
 
 	error = input_register_device(key_dev);
 	if (error)
@@ -448,9 +446,8 @@ static int sony_laptop_setup_input(struct acpi_device *acpi_device)
 	jog_dev->id.vendor = PCI_VENDOR_ID_SONY;
 	key_dev->dev.parent = &acpi_device->dev;
 
-	jog_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REL);
-	jog_dev->keybit[BIT_WORD(BTN_MOUSE)] = BIT_MASK(BTN_MIDDLE);
-	jog_dev->relbit[0] = BIT_MASK(REL_WHEEL);
+	input_set_capability(jog_dev, EV_KEY, BTN_MIDDLE);
+	input_set_capability(jog_dev, EV_REL, REL_WHEEL);
 
 	error = input_register_device(jog_dev);
 	if (error)
@@ -487,7 +484,7 @@ static void sony_laptop_remove_input(void)
 	if (!atomic_dec_and_test(&sony_laptop_input.users))
 		return;
 
-	cancel_delayed_work_sync(&sony_laptop_release_key_work);
+	del_timer_sync(&sony_laptop_input.release_key_timer);
 
 	/* Generate key-up events for remaining keys */
 	while (kfifo_get(sony_laptop_input.fifo,

