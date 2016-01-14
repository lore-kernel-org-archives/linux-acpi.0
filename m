From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/4] acpi_video: Revert "ACPI / video: driver must be registered before checking for keypresses"
Date: Thu, 14 Jan 2016 09:41:45 +0100
Message-ID: <1452760908-15965-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36637 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125AbcANIl5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Jan 2016 03:41:57 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Adrien Schildknecht <adrien+dev@schischi.me>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

On systems with an intel video opcode region, the completion used in the
patch this commit reverts will only complete if the i915 driver loads.
If for some reason the i915 driver never loads calls to
acpi_video_handles_brightness_key_presses() may be delayed indefinitely.

This reverts commit aecbd9b1bff6 ("ACPI / video: driver must be registered
before checking for keypresses") fixing this.

This reintroduces a potential NULL pointer deref due to using an
uninitalized mutex, this is fixed differently in a follow-up patch.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_video.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 15863a8..d95aaa5 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -90,8 +90,8 @@ module_param(device_id_scheme, bool, 0444);
 static bool only_lcd = false;
 module_param(only_lcd, bool, 0444);
 
-static DECLARE_COMPLETION(register_done);
-static DEFINE_MUTEX(register_done_mutex);
+static int register_count;
+static DEFINE_MUTEX(register_count_mutex);
 static struct mutex video_list_lock;
 static struct list_head video_bus_head;
 static int acpi_video_bus_add(struct acpi_device *device);
@@ -2058,8 +2058,8 @@ int acpi_video_register(void)
 {
 	int ret = 0;
 
-	mutex_lock(&register_done_mutex);
-	if (completion_done(&register_done)) {
+	mutex_lock(&register_count_mutex);
+	if (register_count) {
 		/*
 		 * if the function of acpi_video_register is already called,
 		 * don't register the acpi_vide_bus again and return no error.
@@ -2080,22 +2080,22 @@ int acpi_video_register(void)
 	 * When the acpi_video_bus is loaded successfully, increase
 	 * the counter reference.
 	 */
-	complete(&register_done);
+	register_count = 1;
 
 leave:
-	mutex_unlock(&register_done_mutex);
+	mutex_unlock(&register_count_mutex);
 	return ret;
 }
 EXPORT_SYMBOL(acpi_video_register);
 
 void acpi_video_unregister(void)
 {
-	mutex_lock(&register_done_mutex);
-	if (completion_done(&register_done)) {
+	mutex_lock(&register_count_mutex);
+	if (register_count) {
 		acpi_bus_unregister_driver(&acpi_video_bus);
-		reinit_completion(&register_done);
+		register_count = 0;
 	}
-	mutex_unlock(&register_done_mutex);
+	mutex_unlock(&register_count_mutex);
 }
 EXPORT_SYMBOL(acpi_video_unregister);
 
@@ -2103,21 +2103,20 @@ void acpi_video_unregister_backlight(void)
 {
 	struct acpi_video_bus *video;
 
-	mutex_lock(&register_done_mutex);
-	if (completion_done(&register_done)) {
+	mutex_lock(&register_count_mutex);
+	if (register_count) {
 		mutex_lock(&video_list_lock);
 		list_for_each_entry(video, &video_bus_head, entry)
 			acpi_video_bus_unregister_backlight(video);
 		mutex_unlock(&video_list_lock);
 	}
-	mutex_unlock(&register_done_mutex);
+	mutex_unlock(&register_count_mutex);
 }
 
 bool acpi_video_handles_brightness_key_presses(void)
 {
 	bool have_video_busses;
 
-	wait_for_completion(&register_done);
 	mutex_lock(&video_list_lock);
 	have_video_busses = !list_empty(&video_bus_head);
 	mutex_unlock(&video_list_lock);
-- 
2.5.0

