From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/2] sony-laptop - switch from workqueue to a timer
Date: Thu, 17 Dec 2009 22:11:20 -0800
Message-ID: <20091218061120.GB21231@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:35305 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbZLRGL0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Dec 2009 01:11:26 -0500
Received: by pzk1 with SMTP id 1so2010833pzk.33
        for <linux-acpi@vger.kernel.org>; Thu, 17 Dec 2009 22:11:25 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

The function that is executing in workqueue context does not need
to sleep so let's switch to a timer which is more lightweight.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/platform/x86/sony-laptop.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)


diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index acb3933..d161735 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -144,6 +144,7 @@ struct sony_laptop_input_s {
 	struct input_dev	*key_dev;
 	struct kfifo		*fifo;
 	spinlock_t		fifo_lock;
+	struct timer_list	release_key_timer;
 };
 
 static struct sony_laptop_input_s sony_laptop_input = {
@@ -295,10 +296,8 @@ static int sony_laptop_input_keycode_map[] = {
 };
 
 /* release buttons after a short delay if pressed */
-static void do_sony_laptop_release_key(struct work_struct *work)
+static void do_sony_laptop_release_key(unsigned long unused)
 {
-	struct delayed_work *dwork =
-			container_of(work, struct delayed_work, work);
 	struct sony_laptop_keypress kp;
 
 	if (kfifo_get(sony_laptop_input.fifo,
@@ -308,18 +307,16 @@ static void do_sony_laptop_release_key(struct work_struct *work)
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
@@ -376,8 +373,8 @@ static void sony_laptop_report_input_event(u8 event)
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
@@ -404,6 +401,9 @@ static int sony_laptop_setup_input(struct acpi_device *acpi_device)
 		goto err_dec_users;
 	}
 
+	setup_timer(&sony_laptop_input.release_key_timer,
+		    do_sony_laptop_release_key, 0);
+
 	/* input keys */
 	key_dev = input_allocate_device();
 	if (!key_dev) {
@@ -487,7 +487,7 @@ static void sony_laptop_remove_input(void)
 	if (!atomic_dec_and_test(&sony_laptop_input.users))
 		return;
 
-	cancel_delayed_work_sync(&sony_laptop_release_key_work);
+	del_timer_sync(&sony_laptop_input.release_key_timer);
 
 	/* Generate key-up events for remaining keys */
 	while (kfifo_get(sony_laptop_input.fifo,
-- 
Dmitry
