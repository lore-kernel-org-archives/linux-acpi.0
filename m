From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 15/35] acpi-video: Move dmi_check_system from module_init to acpi_video_register
Date: Tue, 16 Jun 2015 16:27:53 +0200
Message-ID: <1434464893-3529-16-git-send-email-hdegoede@redhat.com>
References: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1434464893-3529-1-git-send-email-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Darren Hart <dvhart@infradead.org>
Cc: Aaron Lu <aaron.lu@intel.com>, Ben Skeggs <bskeggs@redhat.com>, Lee Chun-Yi <jlee@suse.com>, Peter Feuerer <peter@piie.net>, Corentin Chary <corentin.chary@gmail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Jonathan Woithe <jwoithe@just42.net>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Azael Avalos <coproscefalo@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, ibm-acpi-devel@lists.sourceforge.net, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-acpi@vger.kernel.org

When builtin there is no guarantee in which order module_init functions
are run, so acpi_video_register() may get called from the i915 driver
(if it is also builtin) before acpi_video_init() gets called, resulting
in the dmi quirks not yet being parsed.

This commit moves the dmi_check_system() call to acpi_video_register(),
so that we can be sure the dmi quirks have always been applied before
probing.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_video.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 23490f0..efa0ab5 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -383,13 +383,13 @@ acpi_video_device_lcd_set_level(struct acpi_video_device *device, int level)
  */
 
 static int bqc_offset_aml_bug_workaround;
-static int __init video_set_bqc_offset(const struct dmi_system_id *d)
+static int video_set_bqc_offset(const struct dmi_system_id *d)
 {
 	bqc_offset_aml_bug_workaround = 9;
 	return 0;
 }
 
-static int __init video_disable_backlight_sysfs_if(
+static int video_disable_backlight_sysfs_if(
 	const struct dmi_system_id *d)
 {
 	if (disable_backlight_sysfs_if == -1)
@@ -397,7 +397,7 @@ static int __init video_disable_backlight_sysfs_if(
 	return 0;
 }
 
-static struct dmi_system_id video_dmi_table[] __initdata = {
+static struct dmi_system_id video_dmi_table[] = {
 	/*
 	 * Broken _BQC workaround http://bugzilla.kernel.org/show_bug.cgi?id=13121
 	 */
@@ -1977,6 +1977,8 @@ int acpi_video_register(void)
 	mutex_init(&video_list_lock);
 	INIT_LIST_HEAD(&video_bus_head);
 
+	dmi_check_system(video_dmi_table);
+
 	ret = acpi_bus_register_driver(&acpi_video_bus);
 	if (ret)
 		return ret;
@@ -2042,8 +2044,6 @@ static int __init acpi_video_init(void)
 	if (acpi_disabled)
 		return 0;
 
-	dmi_check_system(video_dmi_table);
-
 	if (intel_opregion_present())
 		return 0;
 
-- 
2.3.6
