From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] Current brightness level got not set correctly in video
	module, fix it.
Date: Tue, 16 Oct 2007 17:41:58 +0200
Message-ID: <1192549319.9847.623.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:41525 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932984AbXJPPmI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Oct 2007 11:42:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: Christian Birchinger <joker@netswarm.net>, Len Brown <lenb@kernel.org>

Hi,

Len, this should be a rather safe and obvious one. Can you apply it,
pls.

Without this one, one should get NULL pointer when cap.BQC is not set as
device->brightness should not be allocated then.

Christian: This should fix up the wrong initial 0 entry for the current
brightness you saw.

Patch is against Len's git test tree and compile tested only.

Thanks,

   Thomas

------------

Current brightness level got not set correctly in video module, fix it.


Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/acpi/video.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

Index: lenb/drivers/acpi/video.c
===================================================================
--- lenb.orig/drivers/acpi/video.c
+++ lenb/drivers/acpi/video.c
@@ -428,11 +428,15 @@ static int
 acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
 					unsigned long *level)
 {
-	if (device->cap._BQC)
-		return acpi_evaluate_integer(device->dev->handle, "_BQC", NULL,
-					     level);
-	*level = device->brightness->curr;
-	return AE_OK;
+	acpi_status status = AE_OK;
+
+	if (device->cap._BQC){
+		status = acpi_evaluate_integer(device->dev->handle, "_BQC",
+					       NULL, level);
+		if (ACPI_SUCCESS(status) && device->brightness)
+			device->brightness->curr = *level;
+	}
+	return status;
 }
 
 static int


