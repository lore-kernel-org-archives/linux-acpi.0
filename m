From: Len Brown <lenb@kernel.org>
Subject: [PATCH 18/140] ACPI: video: fix LCD monitor seen as CRT
Date: Wed,  7 Feb 2007 13:50:32 -0500
Message-ID: <1170874398386-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:7926 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422716AbXBGSxV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:53:21 -0500
In-Reply-To: <11708743972593-git-send-email-lenb@kernel.org>
Message-Id: <82cae99980c158cb9724415547ca59cf95c58792.1170873816.git.len.brown@intel.com>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Rui Zhang <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Rui Zhang <rui.zhang@intel.com>

http://bugzilla.kernel.org/show_bug.cgi?id=7349

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |   58 +++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 36b37d7..6f760b5 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -57,6 +57,11 @@
 #define ACPI_VIDEO_HEAD_INVALID		(~0u - 1)
 #define ACPI_VIDEO_HEAD_END		(~0u)
 
+#define ACPI_VIDEO_DISPLAY_CRT	1
+#define ACPI_VIDEO_DISPLAY_TV	2
+#define ACPI_VIDEO_DISPLAY_DVI	3
+#define ACPI_VIDEO_DISPLAY_LCD	4
+
 #define _COMPONENT		ACPI_VIDEO_COMPONENT
 ACPI_MODULE_NAME("acpi_video")
 
@@ -133,9 +138,10 @@ struct acpi_video_device_flags {
 	u8 crt:1;
 	u8 lcd:1;
 	u8 tvout:1;
+	u8 dvi:1;
 	u8 bios:1;
 	u8 unknown:1;
-	u8 reserved:3;
+	u8 reserved:2;
 };
 
 struct acpi_video_device_cap {
@@ -668,6 +674,8 @@ static int acpi_video_device_info_seq_show(struct seq_file *seq, void *offset)
 		seq_printf(seq, "LCD\n");
 	else if (dev->flags.tvout)
 		seq_printf(seq, "TVOUT\n");
+	else if (dev->flags.dvi)
+		seq_printf(seq, "DVI\n");
 	else
 		seq_printf(seq, "UNKNOWN\n");
 
@@ -1242,6 +1250,16 @@ static int acpi_video_bus_remove_fs(struct acpi_device *device)
    -------------------------------------------------------------------------- */
 
 /* device interface */
+static struct acpi_video_device_attrib*
+acpi_video_get_device_attr(struct acpi_video_bus *video, unsigned long device_id)
+{
+	int count;
+
+	for(count = 0; count < video->attached_count; count++)
+		if((video->attached_array[count].value.int_val & 0xffff) == device_id)
+			return &(video->attached_array[count].value.attrib);
+	return NULL;
+}
 
 static int
 acpi_video_bus_get_one_device(struct acpi_device *device,
@@ -1250,7 +1268,7 @@ acpi_video_bus_get_one_device(struct acpi_device *device,
 	unsigned long device_id;
 	int status;
 	struct acpi_video_device *data;
-
+	struct acpi_video_device_attrib* attribute;
 
 	if (!device || !video)
 		return -EINVAL;
@@ -1271,20 +1289,30 @@ acpi_video_bus_get_one_device(struct acpi_device *device,
 		data->video = video;
 		data->dev = device;
 
-		switch (device_id & 0xffff) {
-		case 0x0100:
-			data->flags.crt = 1;
-			break;
-		case 0x0400:
-			data->flags.lcd = 1;
-			break;
-		case 0x0200:
-			data->flags.tvout = 1;
-			break;
-		default:
+		attribute = acpi_video_get_device_attr(video, device_id);
+
+		if((attribute != NULL) && attribute->device_id_scheme) {
+			switch (attribute->display_type) {
+			case ACPI_VIDEO_DISPLAY_CRT:
+				data->flags.crt = 1;
+				break;
+			case ACPI_VIDEO_DISPLAY_TV:
+				data->flags.tvout = 1;
+				break;
+			case ACPI_VIDEO_DISPLAY_DVI:
+				data->flags.dvi = 1;
+				break;
+			case ACPI_VIDEO_DISPLAY_LCD:
+				data->flags.lcd = 1;
+				break;
+			default:
+				data->flags.unknown = 1;
+				break;
+			}
+			if(attribute->bios_can_detect)
+				data->flags.bios = 1;
+		} else
 			data->flags.unknown = 1;
-			break;
-		}
 
 		acpi_video_device_bind(video, data);
 		acpi_video_device_find_cap(data);
-- 
1.5.0.rc3.39.gec804
