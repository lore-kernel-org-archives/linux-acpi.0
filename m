From: Adrien Schildknecht <adrien+dev@schischi.me>
Subject: [PATCH] ACPI / video: driver must be registered before checking for keypresses
Date: Mon,  4 Jan 2016 23:22:28 +0100
Message-ID: <1451946148-24948-1-git-send-email-adrien+dev@schischi.me>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, rjw@rjwysocki.net, lenb@kernel.org, hdegoede@redhat.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adrien Schildknecht <adrien+dev@schischi.me>
List-Id: linux-acpi@vger.kernel.org

acpi_video_handles_brightness_key_presses() may use an uninitialized mutex.
The error has been reported by lockdep: DEBUG_LOCKS_WARN_ON(l->magic != l).
The function assumes that the video driver has been registered before being
called. As explained in the comment of acpi_video_init(), the registration
of the video class may be defered and thus may not take place in the init
function of the module.

Use completion mechanisms to make sure that
acpi_video_handles_brightness_key_presses() wait for the completion of
acpi_video_register() before using the mutex.
Also get rid of register_count since task completion can replace it.

Signed-off-by: Adrien Schildknecht <adrien+dev@schischi.me>
---
 drivers/acpi/acpi_video.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 80b13d4..06a006f 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -90,8 +90,8 @@ module_param(device_id_scheme, bool, 0444);
 static bool only_lcd = false;
 module_param(only_lcd, bool, 0444);
 
-static int register_count;
-static DEFINE_MUTEX(register_count_mutex);
+static DECLARE_COMPLETION(register_done);
+static DEFINE_MUTEX(register_done_mutex);
 static struct mutex video_list_lock;
 static struct list_head video_bus_head;
 static int acpi_video_bus_add(struct acpi_device *device);
@@ -2049,8 +2049,8 @@ int acpi_video_register(void)
 {
 	int ret = 0;
 
-	mutex_lock(&register_count_mutex);
-	if (register_count) {
+	mutex_lock(&register_done_mutex);
+	if (completion_done(&register_done)) {
 		/*
 		 * if the function of acpi_video_register is already called,
 		 * don't register the acpi_vide_bus again and return no error.
@@ -2071,22 +2071,22 @@ int acpi_video_register(void)
 	 * When the acpi_video_bus is loaded successfully, increase
 	 * the counter reference.
 	 */
-	register_count = 1;
+	complete(&register_done);
 
 leave:
-	mutex_unlock(&register_count_mutex);
+	mutex_unlock(&register_done_mutex);
 	return ret;
 }
 EXPORT_SYMBOL(acpi_video_register);
 
 void acpi_video_unregister(void)
 {
-	mutex_lock(&register_count_mutex);
-	if (register_count) {
+	mutex_lock(&register_done_mutex);
+	if (completion_done(&register_done)) {
 		acpi_bus_unregister_driver(&acpi_video_bus);
-		register_count = 0;
+		reinit_completion(&register_done);
 	}
-	mutex_unlock(&register_count_mutex);
+	mutex_unlock(&register_done_mutex);
 }
 EXPORT_SYMBOL(acpi_video_unregister);
 
@@ -2094,20 +2094,21 @@ void acpi_video_unregister_backlight(void)
 {
 	struct acpi_video_bus *video;
 
-	mutex_lock(&register_count_mutex);
-	if (register_count) {
+	mutex_lock(&register_done_mutex);
+	if (completion_done(&register_done)) {
 		mutex_lock(&video_list_lock);
 		list_for_each_entry(video, &video_bus_head, entry)
 			acpi_video_bus_unregister_backlight(video);
 		mutex_unlock(&video_list_lock);
 	}
-	mutex_unlock(&register_count_mutex);
+	mutex_unlock(&register_done_mutex);
 }
 
 bool acpi_video_handles_brightness_key_presses(void)
 {
 	bool have_video_busses;
 
+	wait_for_completion(&register_done);
 	mutex_lock(&video_list_lock);
 	have_video_busses = !list_empty(&video_bus_head);
 	mutex_unlock(&video_list_lock);
-- 
2.6.4
