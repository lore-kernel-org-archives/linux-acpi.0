From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 16/35] acpi-video: Fix acpi_video _register vs _unregister_backlight race
Date: Tue, 16 Jun 2015 16:27:54 +0200
Message-ID: <1434464893-3529-17-git-send-email-hdegoede@redhat.com>
References: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51136 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754349AbbFPO31 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jun 2015 10:29:27 -0400
In-Reply-To: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Darren Hart <dvhart@infradead.org>
Cc: Aaron Lu <aaron.lu@intel.com>, Ben Skeggs <bskeggs@redhat.com>, Lee Chun-Yi <jlee@suse.com>, Peter Feuerer <peter@piie.net>, Corentin Chary <corentin.chary@gmail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Jonathan Woithe <jwoithe@just42.net>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Azael Avalos <coproscefalo@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, ibm-acpi-devel@lists.sourceforge.net, Hans de Goede <hdegoede@redhat.com>

It is possible for a native backlight driver to load while
acpi_video_register is running, which may lead to
acpi_video_unregister_backlight being called while acpi_video_register
is running and the 2 racing against eachother.

The register_count variable protects against this, but not in a thread
safe manner, this commit adds locking to make this thread safe.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_video.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index efa0ab5..5b877a1 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -82,6 +82,7 @@ static int disable_backlight_sysfs_if = -1;
 module_param(disable_backlight_sysfs_if, int, 0444);
 
 static int register_count;
+static DEFINE_MUTEX(register_count_mutex);
 static struct mutex video_list_lock;
 static struct list_head video_bus_head;
 static int acpi_video_bus_add(struct acpi_device *device);
@@ -1964,14 +1965,15 @@ static int __init intel_opregion_present(void)
 
 int acpi_video_register(void)
 {
-	int ret;
+	int ret = 0;
 
+	mutex_lock(&register_count_mutex);
 	if (register_count) {
 		/*
 		 * if the function of acpi_video_register is already called,
 		 * don't register the acpi_vide_bus again and return no error.
 		 */
-		return 0;
+		goto leave;
 	}
 
 	mutex_init(&video_list_lock);
@@ -1981,7 +1983,7 @@ int acpi_video_register(void)
 
 	ret = acpi_bus_register_driver(&acpi_video_bus);
 	if (ret)
-		return ret;
+		goto leave;
 
 	/*
 	 * When the acpi_video_bus is loaded successfully, increase
@@ -1989,24 +1991,20 @@ int acpi_video_register(void)
 	 */
 	register_count = 1;
 
-	return 0;
+leave:
+	mutex_unlock(&register_count_mutex);
+	return ret;
 }
 EXPORT_SYMBOL(acpi_video_register);
 
 void acpi_video_unregister(void)
 {
-	if (!register_count) {
-		/*
-		 * If the acpi video bus is already unloaded, don't
-		 * unload it again and return directly.
-		 */
-		return;
+	mutex_lock(&register_count_mutex);
+	if (register_count) {
+		acpi_bus_unregister_driver(&acpi_video_bus);
+		register_count = 0;
 	}
-	acpi_bus_unregister_driver(&acpi_video_bus);
-
-	register_count = 0;
-
-	return;
+	mutex_unlock(&register_count_mutex);
 }
 EXPORT_SYMBOL(acpi_video_unregister);
 
@@ -2014,13 +2012,14 @@ void acpi_video_unregister_backlight(void)
 {
 	struct acpi_video_bus *video;
 
-	if (!register_count)
-		return;
-
-	mutex_lock(&video_list_lock);
-	list_for_each_entry(video, &video_bus_head, entry)
-		acpi_video_bus_unregister_backlight(video);
-	mutex_unlock(&video_list_lock);
+	mutex_lock(&register_count_mutex);
+	if (register_count) {
+		mutex_lock(&video_list_lock);
+		list_for_each_entry(video, &video_bus_head, entry)
+			acpi_video_bus_unregister_backlight(video);
+		mutex_unlock(&video_list_lock);
+	}
+	mutex_unlock(&register_count_mutex);
 }
 EXPORT_SYMBOL(acpi_video_unregister_backlight);
 
-- 
2.3.6

