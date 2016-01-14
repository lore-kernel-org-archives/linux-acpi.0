From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] acpi_video: Add disable_backlight_sysfs_if quirk for the Toshiba Satellite R830
Date: Thu, 14 Jan 2016 14:24:39 +0100
Message-ID: <1452777879-31604-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33617 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754138AbcANNYr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Jan 2016 08:24:47 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: To Do <entodoays@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org.#.4.2.x

The Toshiba Satellite R830 needs disable_backlight_sysfs_if=1, just like
the Toshiba Portege R830. Add a quirk for this.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=21012
Cc: stable@vger.kernel.org # 4.2.x
Tested-by: To Do <entodoays@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_video.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 408b014..a76f8be 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -496,6 +496,15 @@ static struct dmi_system_id video_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "PORTEGE R830"),
 		},
 	},
+	{
+	 /* https://bugzilla.kernel.org/show_bug.cgi?id=21012 */
+	 .callback = video_disable_backlight_sysfs_if,
+	 .ident = "Toshiba Satellite R830",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "SATELLITE R830"),
+		},
+	},
 	/*
 	 * Some machine's _DOD IDs don't have bit 31(Device ID Scheme) set
 	 * but the IDs actually follow the Device ID Scheme.
-- 
2.5.0

