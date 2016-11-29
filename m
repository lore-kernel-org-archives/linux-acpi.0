From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/2] acpi/video_detect: Add force_native quirk for HP Pavilion dv6
Date: Tue, 29 Nov 2016 15:30:16 +0100
Message-ID: <20161129143016.6670-2-hdegoede@redhat.com>
References: <20161129143016.6670-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40666 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755083AbcK2OaW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Nov 2016 09:30:22 -0500
In-Reply-To: <20161129143016.6670-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

The HP Pavilion dv6 has a non-working acpi_video0 backlight interface
and an intel_backlight interface which works fine. Add a force_native
quirk for it so that the non-working acpi_video0 interface does not get
registered.

Note that there are quite a few HP Pavilion dv6 variants, some
woth ATI and some with NVIDIA hybrid gfx, both seem to need this
quirk to have working backlight control. There are also some versions
with only Intel integrated gfx, these may not need this quirk, but it
should not hurt there.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1204476
BugLink: https://bugs.launchpad.net/ubuntu/+source/linux-lts-trusty/+bug/1416940
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 7f48156..02ded25 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -305,6 +305,17 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Dell System XPS L702X"),
 		},
 	},
+	{
+	/* https://bugzilla.redhat.com/show_bug.cgi?id=1204476 */
+	/* https://bugs.launchpad.net/ubuntu/+source/linux-lts-trusty/+bug/1416940 */
+	.callback = video_detect_force_native,
+	.ident = "HP Pavilion dv6",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dv6 Notebook PC"),
+		},
+	},
+
 	{ },
 };
 
-- 
2.9.3

