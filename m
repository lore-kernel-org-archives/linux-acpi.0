From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/3] sony-laptop - switch from workqueue to a timer
Date: Thu, 24 Dec 2009 00:02:30 -0800
Message-ID: <20091224080228.11511.52984.stgit@localhost.localdomain>
References: <20091224080135.11511.18604.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:63514 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756753AbZLXICc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 03:02:32 -0500
Received: by mail-pw0-f42.google.com with SMTP id 9so4830562pwj.21
        for <linux-acpi@vger.kernel.org>; Thu, 24 Dec 2009 00:02:32 -0800 (PST)
In-Reply-To: <20091224080135.11511.18604.stgit@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, =Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org

The function that is executing in workqueue context does not need
to sleep so let's switch to a timer which is more lightweight.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/platform/x86/sony-laptop.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index a6b7616..8f0455b 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -144,6 +144,7 @@ struct sony_laptop_input_s {
 	struct input_dev	*key_dev;
 	struct kfifo		fifo;
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
 	unsigned long flags;
 
@@ -312,14 +311,12 @@ static void do_sony_laptop_release_key(struct work_struct *work)
 
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
@@ -377,8 +374,8 @@ static void sony_laptop_report_input_event(u8 event)
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
@@ -403,6 +400,9 @@ static int sony_laptop_setup_input(struct acpi_device *acpi_device)
 		goto err_dec_users;
 	}
 
+	setup_timer(&sony_laptop_input.release_key_timer,
+		    do_sony_laptop_release_key, 0);
+
 	/* input keys */
 	key_dev = input_allocate_device();
 	if (!key_dev) {
@@ -482,7 +482,7 @@ static void sony_laptop_remove_input(void)
 	if (!atomic_dec_and_test(&sony_laptop_input.users))
 		return;
 
-	cancel_delayed_work_sync(&sony_laptop_release_key_work);
+	del_timer_sync(&sony_laptop_input.release_key_timer);
 
 	/*
 	 * Generate key-up events for remaining keys. Note that we don't

