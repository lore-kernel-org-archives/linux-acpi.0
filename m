From: trenn@suse.de
Subject: [PATCH 8/9] thinkpad_acpi: fingers off backlight if video.ko is serving this functionality
Date: Thu, 10 Jul 2008 16:31:04 +0200
Message-ID: <1215700265-24908-8-git-send-email-trenn@suse.de>
References: <1215700265-24908-1-git-send-email-trenn@suse.de>
 <1215700265-24908-2-git-send-email-trenn@suse.de>
 <1215700265-24908-3-git-send-email-trenn@suse.de>
 <1215700265-24908-4-git-send-email-trenn@suse.de>
 <1215700265-24908-5-git-send-email-trenn@suse.de>
 <1215700265-24908-6-git-send-email-trenn@suse.de>
 <1215700265-24908-7-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:57188 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754497AbYGJObL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Jul 2008 10:31:11 -0400
In-Reply-To: <1215700265-24908-7-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andi@firstfloor.org
Cc: mjg59@srcf.ucam.org, rui.zhang@intel.com, jwoithe@physics.adelaide.edu.au, malattia@linux.it, corentincj@iksaif.net, mzxreary@0pointer.de, hmh@hmh.eng.br, carlos@strangeworlds.co.uk, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org, Thomas Renninger <trenn@suse.de>

From: Thomas Renninger <trenn@suse.de>

---
 drivers/misc/thinkpad_acpi.c |   72 ++++++++++++++++++++++++++++++++++-------
 1 files changed, 59 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index b596929..ba9934d 100644
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
@@ -4750,17 +4775,38 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
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
+				       "Standard, but not supported ACPI "
+				       "backlight interface available,"
+				       " probably an IGD device - handled in"
+				       " legacy way\n");
+			}
+			/* We have an Integrated Graphics Device and
+			 * BIOS won't switch, we have to do it ourselves
+			 * as long as no IGD driver exists
+			 *
+			 * This special case currently is the only part making
+			 * use of acpi_video_support flags and the reason why
+			 * they get exported via acpi.h.
+			*/
+			acpi_video_support = acpi_video_get_capabilities(NULL);
+			if (acpi_video_support & ACPI_VIDEO_IGD)
+				tp_features.bright_igdmode = 1;
+ 		}
 	}
 
 	if (!brightness_enable) {
-- 
1.5.4.5

