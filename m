From: Dmitry Frank <mail@dmitryfrank.com>
Subject: [PATCH v2 2/3] ACPI: video: rename the global flag device_id_scheme
Date: Wed, 19 Apr 2017 12:48:08 +0300
Message-ID: <20170419094809.12895-3-mail@dmitryfrank.com>
References: <20170418123558.12436-1-mail@dmitryfrank.com>
 <20170419094809.12895-1-mail@dmitryfrank.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from forward14o.cmail.yandex.net ([37.9.109.194]:35258 "EHLO
        forward14o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1761281AbdDSKEA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 Apr 2017 06:04:00 -0400
In-Reply-To: <20170419094809.12895-1-mail@dmitryfrank.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Dmitry Frank <mail@dmitryfrank.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Felipe Contreras <felipe.contreras@gmail.com>, linux-acpi@vger.kernel.org

This flag forces device_id_scheme bit in the struct
acpi_video_device_attrib to be assumed even if not actually set, so a
better name for the global flag would be "force_device_id_scheme".

Signed-off-by: Dmitry Frank <mail@dmitryfrank.com>
---
 drivers/acpi/acpi_video.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 9a607af971e7..cfd3bed57bed 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -73,8 +73,12 @@ module_param(report_key_events, int, 0644);
 MODULE_PARM_DESC(report_key_events,
 	"0: none, 1: output changes, 2: brightness changes, 3: all");
 
-static bool device_id_scheme = false;
-module_param(device_id_scheme, bool, 0444);
+/*
+ * Whether the struct acpi_video_device_attrib::device_id_scheme bit should be
+ * assumed even if not actually set.
+ */
+static bool force_device_id_scheme = false;
+module_param(force_device_id_scheme, bool, 0444);
 
 static bool only_lcd = false;
 module_param(only_lcd, bool, 0444);
@@ -387,9 +391,9 @@ static int video_disable_backlight_sysfs_if(
 	return 0;
 }
 
-static int video_set_device_id_scheme(const struct dmi_system_id *d)
+static int video_set_force_device_id_scheme(const struct dmi_system_id *d)
 {
-	device_id_scheme = true;
+	force_device_id_scheme = true;
 	return 0;
 }
 
@@ -491,7 +495,7 @@ static struct dmi_system_id video_dmi_table[] = {
 	 */
 	{
 	 /* https://bugzilla.kernel.org/show_bug.cgi?id=104121 */
-	 .callback = video_set_device_id_scheme,
+	 .callback = video_set_force_device_id_scheme,
 	 .ident = "ESPRIMO Mobile M9410",
 	 .matches = {
 		DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
@@ -1111,7 +1115,7 @@ acpi_video_bus_get_one_device(struct acpi_device *device,
 
 	attribute = acpi_video_get_device_attr(video, device_id);
 
-	if (attribute && (attribute->device_id_scheme || device_id_scheme)) {
+	if (attribute && (attribute->device_id_scheme || force_device_id_scheme)) {
 		switch (attribute->display_type) {
 		case ACPI_VIDEO_DISPLAY_CRT:
 			data->flags.crt = 1;
-- 
2.11.0

