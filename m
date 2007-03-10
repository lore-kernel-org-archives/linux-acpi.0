From: Len Brown <len.brown@intel.com>
Subject: [PATCH 02/20] ACPI: ibm-acpi: fix initial status of backlight device
Date: Fri,  9 Mar 2007 22:49:20 -0500
Message-ID: <1173498580364-git-send-email-len.brown@intel.com>
References: <11734985781377-git-send-email-len.brown@intel.com> <11734985791126-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23581 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752808AbXCJDtl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Mar 2007 22:49:41 -0500
In-Reply-To: <11734985791126-git-send-email-len.brown@intel.com>
Message-Id: <adb005818b71e9476581a1de5742e2f427ac9e2b.1173498420.git.len.brown@intel.com>
In-Reply-To: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
References: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

The brightness class core does not update the initial status of the
device's brightness at register time.  Do it by ourselves.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Acked-by: Richard Purdie <rpurdie@rpsys.net>
---
 drivers/acpi/ibm_acpi.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 4cc534e..7c1b418 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -1711,6 +1711,12 @@ static struct backlight_ops ibm_backlight_data = {
 
 static int brightness_init(void)
 {
+	int b;
+
+	b = brightness_get(NULL);
+	if (b < 0)
+		return b;
+
 	ibm_backlight_device = backlight_device_register("ibm", NULL, NULL,
 							 &ibm_backlight_data);
 	if (IS_ERR(ibm_backlight_device)) {
@@ -1718,7 +1724,9 @@ static int brightness_init(void)
 		return PTR_ERR(ibm_backlight_device);
 	}
 
-        ibm_backlight_device->props.max_brightness = 7;
+	ibm_backlight_device->props.max_brightness = 7;
+	ibm_backlight_device->props.brightness = b;
+	backlight_update_status(ibm_backlight_device);
 
 	return 0;
 }
-- 
1.5.0.3.310.g05ef5
