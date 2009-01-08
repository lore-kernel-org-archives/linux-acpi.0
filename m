From: Zhang Rui <rui.zhang@intel.com>
Subject: [RESEND PATCH 2/2] ACPI: update props.brightness whenever the ACPI
	video backlight is changed
Date: Thu, 08 Jan 2009 14:32:22 +0800
Message-ID: <1231396342.20746.81.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:32316 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544AbZAHGbG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Jan 2009 01:31:06 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, rpurdie@rpsys.net, Matthew Garrett <mjg59@srcf.ucam.org>, "Zhang, Rui" <rui.zhang@intel.com>

Always update the props.brightness
whenever the ACPI video backlight is changed.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -481,6 +481,7 @@ acpi_video_device_lcd_set_level(struct a
 	int status = AE_OK;
 	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
 	struct acpi_object_list args = { 1, &arg0 };
+	int state;
 
 
 	arg0.integer.value = level;
@@ -489,6 +490,10 @@ acpi_video_device_lcd_set_level(struct a
 		status = acpi_evaluate_object(device->dev->handle, "_BCM",
 					      &args, NULL);
 	device->brightness->curr = level;
+	for (state = 2; state < device->brightness->count; state++)
+		if (level == device->brightness->levels[state])
+			device->backlight->props.brightness = state - 2;
+
 	return status;
 }
 


