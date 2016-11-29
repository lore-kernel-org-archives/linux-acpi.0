From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/2] acpi/video_detect: Add force_native quirk for Dell XPS 17 L702X
Date: Tue, 29 Nov 2016 15:32:15 +0100
Message-ID: <20161129143216.7261-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757660AbcK2OcT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Nov 2016 09:32:19 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org

The Dell XPS 17 L702X has a non-working acpi_video0 backlight interface
and an intel_backlight interface which works fine. Add a force_native
quirk for it so that the non-working acpi_video0 interface does not get
registered.

Note that there also is an issue with the brightnesskeys on this laptop,
they do not generate key-press events in anyway. That is not solved by
this patch.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1123661
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index a6b36fc..7f48156 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -296,6 +296,15 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Vostro V131"),
 		},
 	},
+	{
+	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1123661 */
+	 .callback = video_detect_force_native,
+	 .ident = "Dell XPS 17 L702X",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Dell System XPS L702X"),
+		},
+	},
 	{ },
 };
 
-- 
2.9.3

