From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0041/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:36:31 +0800
Message-ID: <20160802103631.16505-1-baolex.ni@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:61343 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754201AbcHBLSr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Aug 2016 07:18:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rui.zhang@intel.com, rjw@rjwysocki.net, lenb@kernel.org, x86@kernel.org, hpa@zytor.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, travis@sgi.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/acpi/acpi_video.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index c1d138e..cec427a 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -65,30 +65,30 @@ MODULE_DESCRIPTION("ACPI Video Driver");
 MODULE_LICENSE("GPL");
 
 static bool brightness_switch_enabled = 1;
-module_param(brightness_switch_enabled, bool, 0644);
+module_param(brightness_switch_enabled, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
 /*
  * By default, we don't allow duplicate ACPI video bus devices
  * under the same VGA controller
  */
 static bool allow_duplicates;
-module_param(allow_duplicates, bool, 0644);
+module_param(allow_duplicates, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
 static int disable_backlight_sysfs_if = -1;
-module_param(disable_backlight_sysfs_if, int, 0444);
+module_param(disable_backlight_sysfs_if, int, S_IRUSR | S_IRGRP | S_IROTH);
 
 #define REPORT_OUTPUT_KEY_EVENTS		0x01
 #define REPORT_BRIGHTNESS_KEY_EVENTS		0x02
 static int report_key_events = -1;
-module_param(report_key_events, int, 0644);
+module_param(report_key_events, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(report_key_events,
 	"0: none, 1: output changes, 2: brightness changes, 3: all");
 
 static bool device_id_scheme = false;
-module_param(device_id_scheme, bool, 0444);
+module_param(device_id_scheme, bool, S_IRUSR | S_IRGRP | S_IROTH);
 
 static bool only_lcd = false;
-module_param(only_lcd, bool, 0444);
+module_param(only_lcd, bool, S_IRUSR | S_IRGRP | S_IROTH);
 
 static int register_count;
 static DEFINE_MUTEX(register_count_mutex);
-- 
2.9.2

