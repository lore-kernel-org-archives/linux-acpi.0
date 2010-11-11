From: Richard Weinberger <richard@nod.at>
Subject: [PATCH] acpi: ENODEV needs errno.h
Date: Thu, 11 Nov 2010 01:15:51 +0100
Message-ID: <1289434551-32507-1-git-send-email-richard@nod.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
List-Id: linux-acpi@vger.kernel.org

This patch fixes a build error when neither CONFIG_ACPI_VIDEO
nor CONFIG_ACPI_VIDEO_MODULE are enabled.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 include/acpi/video.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/acpi/video.h b/include/acpi/video.h
index 551793c..7a0797b 100644
--- a/include/acpi/video.h
+++ b/include/acpi/video.h
@@ -16,6 +16,9 @@ extern void acpi_video_unregister(void);
 extern int acpi_video_get_edid(struct acpi_device *device, int type,
 			       int device_id, void **edid);
 #else
+
+#include <linux/errno.h>
+
 static inline int acpi_video_register(void) { return 0; }
 static inline void acpi_video_unregister(void) { return; }
 static inline int acpi_video_get_edid(struct acpi_device *device, int type,
-- 
1.6.6.1
