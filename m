From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI video: dmi check for broken _BQC on Acer Aspire 5720
Date: Fri, 24 Apr 2009 12:17:39 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904241208080.10096@localhost.localdomain>
References: <1240550980.7661.544.camel@rzhang-dt>
 <alpine.LFD.2.00.0904240212540.15843@localhost.localdomain>
 <1240555214.7661.586.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:24466 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162AbZDXQSC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Apr 2009 12:18:02 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIM00IVR59GB3ZO@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 24 Apr 2009 11:17:41 -0500 (CDT)
In-reply-to: <1240555214.7661.586.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "maximlevitsky@gmail.com" <maximlevitsky@gmail.com>

From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI video: dmi check for broken _BQC on Acer Aspire 5720

On Acer Aspire 5720, _BQC always returns a value 9 smaller than
the actual brightness level.  Add dmi quirk for this laptop.

http://bugzilla.kernel.org/show_bug.cgi?id=13121

Tested-by: Maxim Levitsky <maximlevitsky@gmail.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
we can add __init to video_set_bqc_offset

we can delete the flag used to guard the add, and simply add 0 on
non-workaround machines.

we can move the use up with the definition, say, like this?

thanks,
-Len


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
1.6.3.rc1.51.gea0b7


