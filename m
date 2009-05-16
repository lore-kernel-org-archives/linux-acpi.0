From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/19] ACPI video: dmi check for broken _BQC on Acer Aspire 5720
Date: Sat, 16 May 2009 02:01:58 -0400
Message-ID: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
References: <1242453736-20763-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:16412 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176AbZEPGC1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 May 2009 02:02:27 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KJQ00MQD3FVNNEL@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 May 2009 01:02:20 -0500 (CDT)
In-reply-to: <1242453736-20763-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

On Acer Aspire 5720, _BQC always returns a value 9 smaller than
the actual brightness level.  Add dmi quirk for this laptop.

http://bugzilla.kernel.org/show_bug.cgi?id=13121

Tested-by: Maxim Levitsky <maximlevitsky@gmail.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index cd4fb75..7e8ee49 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -538,6 +538,33 @@ acpi_video_device_lcd_set_level(struct acpi_video_device *device, int level)
 	return -EINVAL;
 }
 
+/*
+ * For some buggy _BQC methods, we need to add a constant value to
+ * the _BQC return value to get the actual current brightness level
+ */
+
+static int bqc_offset_aml_bug_workaround;
+static int __init video_set_bqc_offset(const struct dmi_system_id *d)
+{
+	bqc_offset_aml_bug_workaround = 9;
+	return 0;
+}
+
+static struct dmi_system_id video_dmi_table[] __initdata = {
+	/*
+	 * Broken _BQC workaround http://bugzilla.kernel.org/show_bug.cgi?id=13121
+	 */
+	{
+	 .callback = video_set_bqc_offset,
+	 .ident = "Acer Aspire 5720",
+	 .matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR, "Acer"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5720"),
+		},
+	},
+	{}
+};
+
 static int
 acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
 					unsigned long long *level)
@@ -557,6 +584,7 @@ acpi_video_device_lcd_get_level_current(struct acpi_video_device *device,
 				*level = device->brightness->levels[*level + 2];
 
 			}
+			*level += bqc_offset_aml_bug_workaround;
 			device->brightness->curr = *level;
 			return 0;
 		} else {
@@ -2287,6 +2315,8 @@ EXPORT_SYMBOL(acpi_video_register);
 
 static int __init acpi_video_init(void)
 {
+	dmi_check_system(video_dmi_table);
+
 	if (intel_opregion_present())
 		return 0;
 
-- 
1.6.0.6

