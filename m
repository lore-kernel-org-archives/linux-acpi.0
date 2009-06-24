From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI video: ignore buggy _BQC
Date: Wed, 24 Jun 2009 13:09:02 +0800
Message-ID: <1245820142.15520.112.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:21718 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301AbZFXFIR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Jun 2009 01:08:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, showard314@gmail.com, "Zhang, Rui" <rui.zhang@intel.com>

From: Scott Howard <showard314@gmail.com>

_BQC doesn't return a value listed in _BCL method.
http://bugzilla.kernel.org/show_bug.cgi?id=13511

ingore the buggy _BQC method in this case

Signed-off-by: Scott Howard <showard314@gmail.com>
Acked-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -594,6 +594,7 @@ acpi_video_device_lcd_get_level_current(
 					unsigned long long *level)
 {
 	acpi_status status = AE_OK;
+	int i;
 
 	if (device->cap._BQC || device->cap._BCQ) {
 		char *buf = device->cap._BQC ? "_BQC" : "_BCQ";
@@ -609,8 +610,15 @@ acpi_video_device_lcd_get_level_current(
 
 			}
 			*level += bqc_offset_aml_bug_workaround;
-			device->brightness->curr = *level;
-			return 0;
+ 			for (i = 2; i < device->brightness->count; i++)
+ 			        if (device->brightness->levels[i] == *level) {
+ 				        device->brightness->curr = *level;
+ 			                return 0;
+ 			        }
+ 			/* BQC returned an invalid level. Stop using it.  */
+ 			ACPI_WARNING((AE_INFO, "%s returned an invalid level",
+ 				      buf));
+ 			device->cap._BQC = device->cap._BCQ = 0;
 		} else {
 			/* Fixme:
 			 * should we return an error or ignore this failure?


