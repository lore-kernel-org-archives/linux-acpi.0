From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] ACPI / video: Fix circular lock dependency issue in the video-detect code
Date: Thu, 13 Aug 2015 18:53:37 +0200
Message-ID: <1439484817-2888-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59238 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753174AbbHMQxm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Aug 2015 12:53:42 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Aaron Lu <aaron.lu@intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Sedat Dilek <sedat.dilek@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-acpi@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, Hans de Goede <hdegoede@redhat.com>

Before this commit, the following would happen:

a) acpi_video_get_backlight_type() gets called
b) acpi_video_get_backlight_type() calls acpi_video_init_backlight_type()
c) acpi_video_init_backlight_type() locks its function static init_mutex
d) acpi_video_init_backlight_type() calls backlight_register_notifier()
e) backlight_register_notifier() takes its notifier-chain lock

And when the backlight notifier chain gets called we've:

1) blocking_notifier_call_chain() gets called
2) blocking_notifier_call_chain() takes the notifier-chain lock
3) blocking_notifier_call_chain() calls acpi_video_backlight_notify()
4) acpi_video_backlight_notify() calls acpi_video_get_backlight_type()
5) acpi_video_get_backlight_type() calls acpi_video_init_backlight_type()
6) acpi_video_init_backlight_type() locks its function static init_mutex

So in the first call sequence we have:

a) init_mutex gets locked
b) notifier-chain gets locked

and in the second call sequence we have:

1) notifier-chain gets locked
2) init_mutex gets locked

And we've a circular locking dependency. This specific locking dependency
is fixable without using the big hammer otherwise known as a workqueue,
but further analysis shows a similar problem with the backlight notifier
chain lock vs register_count_mutex from drivers/acpi/acpi_video.c,
and fixing that becomes problematic.

So this commit simply fixes this with the big hammer, performance
wise this is a non issue as we expect the work to get scheduled
exactly zero or one times during normal system use.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 815f75e..2922f1f 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -32,6 +32,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 #include <acpi/video.h>
 
 ACPI_MODULE_NAME("video");
@@ -41,6 +42,7 @@ void acpi_video_unregister_backlight(void);
 
 static bool backlight_notifier_registered;
 static struct notifier_block backlight_nb;
+static struct work_struct backlight_notify_work;
 
 static enum acpi_backlight_type acpi_backlight_cmdline = acpi_backlight_undef;
 static enum acpi_backlight_type acpi_backlight_dmi = acpi_backlight_undef;
@@ -262,6 +264,13 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 	{ },
 };
 
+/* This uses a workqueue to avoid various locking ordering issues */
+static void acpi_video_backlight_notify_work(struct work_struct *work)
+{
+	if (acpi_video_get_backlight_type() != acpi_backlight_video)
+		acpi_video_unregister_backlight();
+}
+
 static int acpi_video_backlight_notify(struct notifier_block *nb,
 				       unsigned long val, void *bd)
 {
@@ -269,9 +278,8 @@ static int acpi_video_backlight_notify(struct notifier_block *nb,
 
 	/* A raw bl registering may change video -> native */
 	if (backlight->props.type == BACKLIGHT_RAW &&
-	    val == BACKLIGHT_REGISTERED &&
-	    acpi_video_get_backlight_type() != acpi_backlight_video)
-		acpi_video_unregister_backlight();
+	    val == BACKLIGHT_REGISTERED)
+		schedule_work(&backlight_notify_work);
 
 	return NOTIFY_OK;
 }
@@ -304,6 +312,8 @@ enum acpi_backlight_type acpi_video_get_backlight_type(void)
 		acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 				    ACPI_UINT32_MAX, find_video, NULL,
 				    &video_caps, NULL);
+		INIT_WORK(&backlight_notify_work,
+			  acpi_video_backlight_notify_work);
 		backlight_nb.notifier_call = acpi_video_backlight_notify;
 		backlight_nb.priority = 0;
 		if (backlight_register_notifier(&backlight_nb) == 0)
-- 
2.4.3

