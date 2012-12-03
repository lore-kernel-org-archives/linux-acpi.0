From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI video: ignore BIOS initial backlight value for HP
 Folio 13-2000
Date: Mon, 03 Dec 2012 09:15:36 +0800
Message-ID: <1354497336.1936.18.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, public@stefan-nagy.at, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

>From 117af51d695c78bfdf618a183664f0e9f3769b9a Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Sun, 2 Dec 2012 10:00:41 +0800
Subject: [PATCH] ACPI video: ignore BIOS initial backlight value for HP Folio 13-2000

Or else the laptop will boot with a dimmed screen.

https://bugzilla.kernel.org/show_bug.cgi?id=51141

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by:  Stefan Nagy <public@stefan-nagy.at>
Cc: stable@vger.kernel.org
---
 drivers/acpi/video.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 1e0a9e1..58bddd3 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -389,6 +389,12 @@ static int __init video_set_bqc_offset(const struct dmi_system_id *d)
 	return 0;
 }
 
+static int video_ignore_initial_backlight(const struct dmi_system_id *d)
+{
+	use_bios_initial_backlight = 0;
+	return 0;
+}
+
 static struct dmi_system_id video_dmi_table[] __initdata = {
 	/*
 	 * Broken _BQC workaround http://bugzilla.kernel.org/show_bug.cgi?id=13121
@@ -433,6 +439,14 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 7720"),
 		},
 	},
+	{
+	 .callback = video_ignore_initial_backlight,
+	 .ident = "HP Folio 13-2000",
+	 .matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "HP Folio 13 - 2000 Notebook PC"),
+		},
+	},
 	{}
 };
 
-- 
1.7.9.5
