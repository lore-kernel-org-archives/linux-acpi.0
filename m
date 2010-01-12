From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH] acpi: Export EDID blocks to the kernel
Date: Tue, 12 Jan 2010 14:17:03 -0500
Message-ID: <1263323823-11847-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:37712 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150Ab0ALTRI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jan 2010 14:17:08 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, dri-devel@lists.sourceforge.net, Matthew Garrett <mjg@redhat.com>

The ACPI spec includes a provision for hardware to provide EDID via the
ACPI video extension. In the KMS world it's necessary for a way to obtain
this from within the kernel. Add a function that either returns the EDID
for the provided ACPI display ID or the first display of the provided type.
Also add support for ensuring that devices with legacy IDs are supported.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/video.c |  110 ++++++++++++++++++++++++++++++++++++++++++++++----
 include/acpi/video.h |   16 +++++++
 2 files changed, 118 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 72e76b4..1868b3a 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -43,6 +43,7 @@
 #include <linux/dmi.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
+#include <acpi/video.h>
 
 #define PREFIX "ACPI: "
 
@@ -63,11 +64,6 @@
 
 #define MAX_NAME_LEN	20
 
-#define ACPI_VIDEO_DISPLAY_CRT	1
-#define ACPI_VIDEO_DISPLAY_TV	2
-#define ACPI_VIDEO_DISPLAY_DVI	3
-#define ACPI_VIDEO_DISPLAY_LCD	4
-
 #define _COMPONENT		ACPI_VIDEO_COMPONENT
 ACPI_MODULE_NAME("video");
 
@@ -1724,11 +1720,27 @@ acpi_video_get_device_attr(struct acpi_video_bus *video, unsigned long device_id
 }
 
 static int
+acpi_video_get_device_type(struct acpi_video_bus *video,
+			   unsigned long device_id)
+{
+	struct acpi_video_enumerated_device *ids;
+	int i;
+
+	for (i = 0; i < video->attached_count; i++) {
+		ids = &video->attached_array[i];
+		if ((ids->value.int_val & 0xffff) == device_id)
+			return ids->value.int_val;
+	}
+
+	return 0;
+}
+
+static int
 acpi_video_bus_get_one_device(struct acpi_device *device,
 			      struct acpi_video_bus *video)
 {
 	unsigned long long device_id;
-	int status;
+	int status, device_type;
 	struct acpi_video_device *data;
 	struct acpi_video_device_attrib* attribute;
 
@@ -1773,8 +1785,25 @@ acpi_video_bus_get_one_device(struct acpi_device *device,
 			}
 			if(attribute->bios_can_detect)
 				data->flags.bios = 1;
-		} else
-			data->flags.unknown = 1;
+		} else {
+			/* Check for legacy IDs */
+			device_type = acpi_video_get_device_type(video,
+								 device_id);
+			/* Ignore bits 16 and 18-20 */
+			switch (device_type & 0xffe2ffff) {
+			case ACPI_VIDEO_DISPLAY_LEGACY_MONITOR:
+				data->flags.crt = 1;
+				break;
+			case ACPI_VIDEO_DISPLAY_LEGACY_PANEL:
+				data->flags.lcd = 1;
+				break;
+			case ACPI_VIDEO_DISPLAY_LEGACY_TV:
+				data->flags.tvout = 1;
+				break;
+			default:
+				data->flags.unknown = 1;
+			}
+		}
 
 		acpi_video_device_bind(video, data);
 		acpi_video_device_find_cap(data);
@@ -2008,6 +2037,71 @@ out:
 	return result;
 }
 
+int acpi_video_get_edid(struct acpi_device *device, int type, int device_id,
+			void **edid)
+{
+	struct acpi_video_bus *video;
+	struct acpi_video_device *video_device;
+	union acpi_object *buffer = NULL;
+	acpi_status status;
+	int i, length;
+
+	if (!device || !acpi_driver_data(device))
+		return -EINVAL;
+
+	video = acpi_driver_data(device);
+
+	for (i = 0; i < video->attached_count; i++) {
+		video_device = video->attached_array[i].bind_info;
+		length = 256;
+
+		if (!video_device)
+			continue;
+
+		if (type) {
+			switch (type) {
+			case ACPI_VIDEO_DISPLAY_CRT:
+				if (!video_device->flags.crt)
+					continue;
+				break;
+			case ACPI_VIDEO_DISPLAY_TV:
+				if (!video_device->flags.tvout)
+					continue;
+				break;
+			case ACPI_VIDEO_DISPLAY_DVI:
+				if (!video_device->flags.dvi)
+					continue;
+				break;
+			case ACPI_VIDEO_DISPLAY_LCD:
+				if (!video_device->flags.lcd)
+					continue;
+				break;
+			}
+		} else if (video_device->device_id != device_id) {
+			continue;
+		}
+
+		status = acpi_video_device_EDID(video_device, &buffer, length);
+
+		if (ACPI_FAILURE(status) || !buffer ||
+		    buffer->type != ACPI_TYPE_BUFFER) {
+			length = 128;
+			status = acpi_video_device_EDID(video_device, &buffer,
+							length);
+			if (ACPI_FAILURE(status) || !buffer ||
+			    buffer->type != ACPI_TYPE_BUFFER) {
+				continue;
+			}
+		}
+
+		*edid = buffer->buffer.pointer;
+		return length;
+	}
+
+	return -ENODEV;
+}
+EXPORT_SYMBOL(acpi_video_get_edid);
+
 static int
 acpi_video_bus_get_devices(struct acpi_video_bus *video,
 			   struct acpi_device *device)
diff --git a/include/acpi/video.h b/include/acpi/video.h
index cf7be3d..551793c 100644
--- a/include/acpi/video.h
+++ b/include/acpi/video.h
@@ -1,12 +1,28 @@
 #ifndef __ACPI_VIDEO_H
 #define __ACPI_VIDEO_H
 
+#define ACPI_VIDEO_DISPLAY_CRT  1
+#define ACPI_VIDEO_DISPLAY_TV   2
+#define ACPI_VIDEO_DISPLAY_DVI  3
+#define ACPI_VIDEO_DISPLAY_LCD  4
+
+#define ACPI_VIDEO_DISPLAY_LEGACY_MONITOR 0x0100
+#define ACPI_VIDEO_DISPLAY_LEGACY_PANEL   0x0110
+#define ACPI_VIDEO_DISPLAY_LEGACY_TV      0x0200
+
 #if (defined CONFIG_ACPI_VIDEO || defined CONFIG_ACPI_VIDEO_MODULE)
 extern int acpi_video_register(void);
 extern void acpi_video_unregister(void);
+extern int acpi_video_get_edid(struct acpi_device *device, int type,
+			       int device_id, void **edid);
 #else
 static inline int acpi_video_register(void) { return 0; }
 static inline void acpi_video_unregister(void) { return; }
+static inline int acpi_video_get_edid(struct acpi_device *device, int type,
+				      int device_id, void **edid)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif
-- 
1.6.6

