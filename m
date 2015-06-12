From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 12/32] acpi-video: Move dmi_check_system from module_init to acpi_video_register
Date: Fri, 12 Jun 2015 13:23:31 +0200
Message-ID: <1434108231-12323-13-git-send-email-hdegoede@redhat.com>
References: <1434108231-12323-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56659 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754674AbbFLLYo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 12 Jun 2015 07:24:44 -0400
In-Reply-To: <1434108231-12323-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ben Skeggs <bskeggs@redhat.com>, Azael Avalos <coproscefalo@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Lee Chun-Yi <jlee@suse.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Mattia Dongili <malattia@linux.it>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, acpi4asus-user@lists.sourceforge.net, dri-devel@lists.freedesktop.org, Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

When builtin there is no guarantee in which order module_init functions
are run, so acpi_video_register() may get called from the i915 driver
(if it is also builtin) before acpi_video_init() gets called, resulting
in the dmi quirks not yet being parsed.

This commit moves the dmi_check_system() call to acpi_video_register(),
so that we can be sure the dmi quirks have always been applied before
probing.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_video.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index f5ffac9..b8053a8 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -380,13 +380,13 @@ acpi_video_device_lcd_set_level(struct acpi_video_device *device, int level)
  */
 
 static int bqc_offset_aml_bug_workaround;
-static int __init video_set_bqc_offset(const struct dmi_system_id *d)
+static int video_set_bqc_offset(const struct dmi_system_id *d)
 {
 	bqc_offset_aml_bug_workaround = 9;
 	return 0;
 }
 
-static struct dmi_system_id video_dmi_table[] __initdata = {
+static struct dmi_system_id video_dmi_table[] = {
 	/*
 	 * Broken _BQC workaround http://bugzilla.kernel.org/show_bug.cgi?id=13121
 	 */
@@ -1944,6 +1944,8 @@ int acpi_video_register(void)
 	mutex_init(&video_list_lock);
 	INIT_LIST_HEAD(&video_bus_head);
 
+	dmi_check_system(video_dmi_table);
+
 	ret = acpi_bus_register_driver(&acpi_video_bus);
 	if (ret)
 		return ret;
@@ -2009,8 +2011,6 @@ static int __init acpi_video_init(void)
 	if (acpi_disabled)
 		return 0;
 
-	dmi_check_system(video_dmi_table);
-
 	if (intel_opregion_present())
 		return 0;
 
-- 
2.4.2

