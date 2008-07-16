From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 10/11] thinkpad_acpi: fingers off backlight if video.ko is serving this functionality
Date: Wed, 16 Jul 2008 12:52:32 +0200
Message-ID: <1216205553-8486-11-git-send-email-trenn@suse.de>
References: <1216205553-8486-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48219 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754382AbYGPKwj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2008 06:52:39 -0400
In-Reply-To: <1216205553-8486-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: mjg59@srcf.ucam.org, jwoithe@physics.adelaide.edu.au, hmh@hmh.eng.br, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it, Thomas Renninger <trenn@suse.de>Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Thomas Renninger <trenn@stravinsky.suse.de>
---
 drivers/misc/thinkpad_acpi.c |   77 ++++++++++++++++++++++++++++++++++-------
 1 files changed, 64 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index b596929..d3ec19e 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -233,6 +233,7 @@ static struct {
 	u32 light_status:1;
 	u32 bright_16levels:1;
 	u32 bright_acpimode:1;
+	u32 bright_igdmode:1;
 	u32 wan:1;
 	u32 fan_ctrl_status_undef:1;
 	u32 input_device_registered:1;
@@ -2299,6 +2300,9 @@ err_exit:
 	return (res < 0)? res : 1;
 }
 
+static struct backlight_device *ibm_backlight_device;
+static int brightness_update_status(struct backlight_device *bd);
+
 static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 {
 	u32 hkey;
@@ -2337,6 +2341,28 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 		case 1:
 			/* 0x1000-0x1FFF: key presses */
 			scancode = hkey & 0xfff;
+			if (tp_features.bright_igdmode) {
+				/* ToDo:
+				 * Is there an already defined key?
+				 */
+				if (hkey == 0x1011) {
+					if (ibm_backlight_device->
+					    props.brightness > 0) {
+						ibm_backlight_device->
+							props.brightness--;
+					}
+				} else if (hkey == 0x1010) {
+					if (ibm_backlight_device->
+					    props.brightness <
+					    ibm_backlight_device->
+					    props.max_brightness) {
+						ibm_backlight_device->
+							props.brightness++;
+					}
+				}
+				brightness_update_status(ibm_backlight_device);
+			}
+
 			if (scancode > 0 && scancode < 0x21) {
 				scancode--;
 				if (!(hotkey_source_mask & (1 << scancode))) {
@@ -4599,7 +4625,6 @@ enum {
 	TP_EC_BACKLIGHT_MAPSW = 0x20,
 };
 
-static struct backlight_device *ibm_backlight_device;
 static int brightness_mode;
 static unsigned int brightness_enable = 2; /* 2 = auto, 0 = no, 1 = yes */
 
@@ -4738,7 +4763,7 @@ static struct backlight_ops ibm_backlight_data = {
 static int __init brightness_init(struct ibm_init_struct *iibm)
 {
 	int b;
-
+	long acpi_video_support;
 	vdbg_printk(TPACPI_DBG_INIT, "initializing brightness subdriver\n");
 
 	mutex_init(&brightness_mutex);
@@ -4750,17 +4775,43 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
 	 */
 	b = tpacpi_check_std_acpi_brightness_support();
 	if (b > 0) {
-		if (thinkpad_id.vendor == PCI_VENDOR_ID_LENOVO) {
-			printk(TPACPI_NOTICE
-			       "Lenovo BIOS switched to ACPI backlight "
-			       "control mode\n");
-		}
-		if (brightness_enable > 1) {
-			printk(TPACPI_NOTICE
-			       "standard ACPI backlight interface "
-			       "available, not loading native one...\n");
-			return 1;
-		}
+
+		if (acpi_video_backlight_support()) {
+			if (brightness_enable > 1) {
+				printk(TPACPI_NOTICE
+				       "standard ACPI backlight interface "
+				       "available, not loading native one.\n");
+				return 1;
+			} else if (brightness_enable == 1) {
+				printk(TPACPI_NOTICE
+				       "Backlight control force, even standard "
+				       "ACPI backlight interface available\n");
+			}
+		} else {
+			if (brightness_enable > 1) {
+				printk(TPACPI_NOTICE
+				       "Standard ACPI backlight interface "
+				       "available, but thinkpad_acpi driver "
+				       "will take over control\n");
+			}
+			/* We have an Integrated Graphics Device and BIOS
+			 * won't switch. By default the IGD driver should take
+			 * care about backlight and display output switching.
+			 * People can still run into this code path and let
+			 * thinkpad_acpi take over control by passing:
+			 * acpi_backlight=vendor or acpi_display_output=vendor
+			 * boot params.
+			 */
+			acpi_video_support = acpi_video_get_capabilities(NULL);
+			vdbg_printk(TPACPI_DBG_INIT, "XXXXXk\n");
+
+			if (acpi_video_support & ACPI_VIDEO_IGD) {
+				vdbg_printk(TPACPI_DBG_INIT, "IGD device"
+					    " detected - take over backlight"
+					    " switching\n");
+				tp_features.bright_igdmode = 1;
+			}
+ 		}
 	}
 
 	if (!brightness_enable) {
-- 
1.5.4.5

