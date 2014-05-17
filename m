From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 3/3] acer-wmi: Add Aspire 5741 to video_vendor_dmi_table
Date: Sat, 17 May 2014 10:48:03 +0200
Message-ID: <1400316483-6356-4-git-send-email-hdegoede@redhat.com>
References: <1400316483-6356-1-git-send-email-hdegoede@redhat.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1400316483-6356-1-git-send-email-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>, Lee Chun-Yi <jlee@suse.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Matthew Garrett <matthew.garrett@nebula.com>, platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-acpi@vger.kernel.org

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
