From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH] ACPI / video: Add some samsung models to disable_native_backlight
 list
Date: Mon, 22 Dec 2014 15:18:05 +0800
Message-ID: <5497C5AD.5060803@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:41277 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753184AbaLVHSM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Dec 2014 02:18:12 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Brent Saner <brent.saner@gmail.com>, Vitaliy Filippov <vitalif@yourcmc.ru>, Laszlo KREKACS <laszlo.krekacs.list@gmail.com>, Vladimir Perepechin <vovochka13@gmail.com>

The SAMSUNG 870Z5E/880Z5E/680Z5E and SAMSUNG
370R4E/370R4V/370R5E/3570RE/370R5V do not have a working native
backlight control interface so restore their acpi_videoX interface.

Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=84221
Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=84651
For SAMSUNG 870Z5E/880Z5E/680Z5E:
Reported-and-tested-by: Brent Saner <brent.saner@gmail.com>
Reported-by: Vitaliy Filippov <vitalif@yourcmc.ru>
Reported-by: Laszlo KREKACS <laszlo.krekacs.list@gmail.com>
For SAMSUNG 370R4E/370R4V/370R5E/3570RE/370R5V:
Reported-by: Vladimir Perepechin <vovochka13@gmail.com>
Cc: 3.17+ <stable@vger.kernel.org> # 3.17+
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/acpi/video.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index adf4b4cf0be6..43384360c2b1 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -492,6 +492,23 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "HP ENVY 15 Notebook PC"),
 		},
 	},
+
+	{
+	 .callback = video_disable_native_backlight,
+	 .ident = "SAMSUNG 870Z5E/880Z5E/680Z5E",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "870Z5E/880Z5E/680Z5E"),
+		},
+	},
+	{
+	 .callback = video_disable_native_backlight,
+	 .ident = "SAMSUNG 370R4E/370R4V/370R5E/3570RE/370R5V",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "370R4E/370R4V/370R5E/3570RE/370R5V"),
+		},
+	},
 	{}
 };
 
-- 
1.9.3

