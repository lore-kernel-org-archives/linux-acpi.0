From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/15] ACPI: video: fix build for VIDEO_OUTPUT_CONTROL=n
Date: Sat, 11 Dec 2010 02:06:33 -0500
Message-ID: <3353bebe7c89725ab2f476b9d8d618259402d52e.1292051119.git.len.brown@intel.com>
References: <1292051200-13689-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:61817 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262Ab0LKHHG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Dec 2010 02:07:06 -0500
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LD900IEA53SOJT7@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 11 Dec 2010 01:07:06 -0600 (CST)
In-reply-to: <1292051200-13689-1-git-send-email-lenb@kernel.org>
In-reply-to: <212967c69afd348342548272aedbe4d46a9325d6.1292051119.git.len.brown@intel.com>
References: <212967c69afd348342548272aedbe4d46a9325d6.1292051119.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

drivers/built-in.o: In function `acpi_video_bus_put_devices':
video.c:(.text+0x79663): undefined reference to
`video_output_unregister'
drivers/built-in.o: In function `acpi_video_bus_add':
video.c:(.text+0x7b0b3): undefined reference to `video_output_register'

Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/linux/video_output.h |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/include/linux/video_output.h b/include/linux/video_output.h
index 2fb46bc..ed5cdeb 100644
--- a/include/linux/video_output.h
+++ b/include/linux/video_output.h
@@ -23,6 +23,7 @@
 #ifndef _LINUX_VIDEO_OUTPUT_H
 #define _LINUX_VIDEO_OUTPUT_H
 #include <linux/device.h>
+#include <linux/err.h>
 struct output_device;
 struct output_properties {
 	int (*set_state)(struct output_device *);
@@ -34,9 +35,23 @@ struct output_device {
 	struct device dev;
 };
 #define to_output_device(obj) container_of(obj, struct output_device, dev)
+#if	defined(CONFIG_VIDEO_OUTPUT_CONTROL) || defined(CONFIG_VIDEO_OUTPUT_CONTROL_MODULE)
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
+}
+#endif
 #endif
-- 
1.7.3.3.480.g2f76a

