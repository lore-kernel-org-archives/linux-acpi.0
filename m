From: Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPI: video: fix build error when VIDEO_OUTPUT_CONTROL=n
Date: Tue, 30 Nov 2010 18:29:42 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1011301828410.3354@x980>
References: <1288292779-23347-1-git-send-email-jwjstone@fastmail.fm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:48894 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457Ab0K3XaD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Nov 2010 18:30:03 -0500
In-reply-to: <1288292779-23347-1-git-send-email-jwjstone@fastmail.fm>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jack Stone <jwjstone@fastmail.fm>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rui.zhang@intel.com

From: Len Brown <len.brown@intel.com>

drivers/built-in.o: In function `acpi_video_bus_put_devices':
video.c:(.text+0x79663): undefined reference to
`video_output_unregister'
drivers/built-in.o: In function `acpi_video_bus_add':
video.c:(.text+0x7b0b3): undefined reference to `video_output_register'

Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/linux/video_output.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/include/linux/video_output.h b/include/linux/video_output.h
index 2fb46bc..c630194 100644
--- a/include/linux/video_output.h
+++ b/include/linux/video_output.h
@@ -34,9 +34,23 @@ struct output_device {
 	struct device dev;
 };
 #define to_output_device(obj) container_of(obj, struct output_device, dev)
+#ifdef CONFIG_VIDEO_OUTPUT_CONTROL
 struct output_device *video_output_register(const char *name,
 	struct device *dev,
 	void *devdata,
 	struct output_properties *op);
 void video_output_unregister(struct output_device *dev);
+#else
+static struct output_device *video_output_register(const char *name,
+        struct device *dev,
+        void *devdata,
+        struct output_properties *op)
+{
+	return ERR_PTR(-ENODEV);
+}
+static void video_output_unregister(struct output_device *dev)
+{
+	return;
+};
+#endif
 #endif
-- 
1.7.3.2.343.g7d43d

