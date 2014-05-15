From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4/4] acer-wmi: Add Aspire 5741 to video_vendor_dmi_table
Date: Thu, 15 May 2014 13:22:36 +0200
Message-ID: <1400152956-9053-5-git-send-email-hdegoede@redhat.com>
References: <1400152956-9053-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:18685 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610AbaEOLW7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 May 2014 07:22:59 -0400
In-Reply-To: <1400152956-9053-1-git-send-email-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lee Chun-Yi <jlee@suse.com>, Aaron Lu <aaron.lu@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Matthew Garrett <matthew.garrett@nebula.com>, Massimiliano <massi.ergosum@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

The Aspire 5741 has broken acpi-video backlight control, so add it to the
quirk table.

https://bugzilla.redhat.com/show_bug.cgi?id=1012674

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/acer-wmi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 3a74699..bbf78b2 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -570,6 +570,14 @@ static const struct dmi_system_id video_vendor_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5750"),
 		},
 	},
+	{
+		.callback = video_set_backlight_video_vendor,
+		.ident = "Acer Aspire 5741",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5741"),
+		},
+	},
 	{}
 };
 
-- 
1.9.0

