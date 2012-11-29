From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [FIX PATCH] acpi/video_detect: Add "Asus UL30VT" to acpi video detect blacklist
Date: Thu, 29 Nov 2012 14:15:37 +0800
Message-ID: <1354169737-28558-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The ACPI video driver can't control backlight correctly on Asus UL30VT.
Vent driver(asus-laptop) can work. This patch is to add "Asus UL30VT"
to acpi video detect blacklist in order to use vent driver for video
control on the "Asus UL30VT" rather than ACPI video driver.

https://bugzilla.kernel.org/show_bug.cgi?id=32592

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/video_detect.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index b728880..4ac2593 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -156,6 +156,14 @@ static struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_BOARD_NAME, "X360"),
 		},
 	},
+	{
+	.callback = video_detect_force_vendor,
+	.ident = "Asus UL30VT",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "UL30VT"),
+		},
+	},
 	{ },
 };
 
-- 
1.7.9.5

