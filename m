From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 10/10] thinkpad_acpi: fingers off backlight if video.ko is serving this functionality
Date: Fri,  1 Aug 2008 17:38:03 +0200
Message-ID: <1217605083-31003-11-git-send-email-trenn@suse.de>
References: <1217605083-31003-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:33166 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752003AbYHAPiJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Aug 2008 11:38:09 -0400
In-Reply-To: <1217605083-31003-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: rui.zhang@intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org, Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/misc/thinkpad_acpi.c |   31 ++++++++++++++++++++-----------
 1 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index d3eb790..a71ecd2 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -4922,17 +4922,26 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
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
+				       "Standard ACPI backlight interface "
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
+				       "Standard ACPI backlight interface not "
+				       "available, thinkpad_acpi driver "
+				       "will take over control\n");
+			}
+ 		}
 	}
 
 	if (!brightness_enable) {
-- 
1.5.4.5

