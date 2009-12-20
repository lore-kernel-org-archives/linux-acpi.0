From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 2/3] sony-laptop: switch from workqueue to a timer
Date: Sun, 20 Dec 2009 23:17:38 +0900
Message-ID: <1261318659-5980-3-git-send-email-malattia@linux.it>
References: <1261318659-5980-1-git-send-email-malattia@linux.it>
 <1261318659-5980-2-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:54550
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553AbZLTOR6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 20 Dec 2009 09:17:58 -0500
In-Reply-To: <1261318659-5980-2-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, Mattia Dongili <malattia@linux.it>

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

The function that is executing in workqueue context does not need
to sleep so let's switch to a timer which is more lightweight.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/platform/x86/sony-laptop.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 7d15b97..90400f0 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -145,6 +145,7 @@ struct sony_laptop_input_s {
 	struct input_dev	*key_dev;
 	struct kfifo		*fifo;
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
 
 	if (kfifo_get(sony_laptop_input.fifo,
@@ -311,18 +310,16 @@ static void do_sony_laptop_release_key(struct work_struct *work)
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
@@ -379,8 +376,8 @@ static void sony_laptop_report_input_event(u8 event)
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
@@ -407,6 +404,9 @@ static int sony_laptop_setup_input(struct acpi_device *acpi_device)
 		goto err_dec_users;
 	}
 
+	setup_timer(&sony_laptop_input.release_key_timer,
+		    do_sony_laptop_release_key, 0);
+
 	/* input keys */
 	key_dev = input_allocate_device();
 	if (!key_dev) {
@@ -490,7 +490,7 @@ static void sony_laptop_remove_input(void)
 	if (!atomic_dec_and_test(&sony_laptop_input.users))
 		return;
 
-	cancel_delayed_work_sync(&sony_laptop_release_key_work);
+	del_timer_sync(&sony_laptop_input.release_key_timer);
 
 	/* Generate key-up events for remaining keys */
 	while (kfifo_get(sony_laptop_input.fifo,
-- 
1.6.5.7

