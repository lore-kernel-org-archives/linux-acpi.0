From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/12] ACPI: clean up video.c boundary checks and types
Date: Sat, 07 Nov 2009 21:57:03 -0500
Message-ID: <52a2b11cafb1b14bacfc65a20966da5ba3a863e1.1257648659.git.len.brown@intel.com>
References: <1257649034-7494-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:38483 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132AbZKHC5Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Nov 2009 21:57:25 -0500
Received: from localhost.localdomain ([74.104.150.83])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KSR00ABTS7HOMSH@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Nov 2009 20:57:23 -0600 (CST)
In-reply-to: <1257649034-7494-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Arjan van de Ven <arjan@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Arjan van de Ven <arjan@linux.intel.com>

proc.c and video.c are a bit sloppy around types and style,
confusing gcc for a new feature that'll be in 2.6.33 and will
cause a warning on the current code.

This patch changes

if  (foo + 1 > sizeof bar)

into

if (foo >= sizeof(bar))

which is more kernel-style.

it also changes a variable in proc.c to unsigned; it gets assigned
a value from an unsigned type, and is then only compared for > not
for negative, so using unsigned is just outright the right type

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/proc.c  |    2 +-
 drivers/acpi/video.c |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/proc.c b/drivers/acpi/proc.c
index f8b6f55..d0d25e2 100644
--- a/drivers/acpi/proc.c
+++ b/drivers/acpi/proc.c
@@ -393,7 +393,7 @@ acpi_system_write_wakeup_device(struct file *file,
 	struct list_head *node, *next;
 	char strbuf[5];
 	char str[5] = "";
-	int len = count;
+	unsigned int len = count;
 	struct acpi_device *found_dev = NULL;
 
 	if (len > 4)
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 64e3c58..05dff63 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1223,7 +1223,7 @@ acpi_video_device_write_state(struct file *file,
 	u32 state = 0;
 
 
-	if (!dev || count + 1 > sizeof str)
+	if (!dev || count >= sizeof(str))
 		return -EINVAL;
 
 	if (copy_from_user(str, buffer, count))
@@ -1280,7 +1280,7 @@ acpi_video_device_write_brightness(struct file *file,
 	int i;
 
 
-	if (!dev || !dev->brightness || count + 1 > sizeof str)
+	if (!dev || !dev->brightness || count >= sizeof(str))
 		return -EINVAL;
 
 	if (copy_from_user(str, buffer, count))
@@ -1562,7 +1562,7 @@ acpi_video_bus_write_POST(struct file *file,
 	unsigned long long opt, options;
 
 
-	if (!video || count + 1 > sizeof str)
+	if (!video || count >= sizeof(str))
 		return -EINVAL;
 
 	status = acpi_video_bus_POST_options(video, &options);
@@ -1602,7 +1602,7 @@ acpi_video_bus_write_DOS(struct file *file,
 	unsigned long opt;
 
 
-	if (!video || count + 1 > sizeof str)
+	if (!video || count >= sizeof(str))
 		return -EINVAL;
 
 	if (copy_from_user(str, buffer, count))
-- 
1.6.0.6

