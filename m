From: Arjan van de Ven <arjan@infradead.org>
Subject: [PATCH] acpi: clean up video.c boundary checks and types
Date: Thu, 1 Oct 2009 15:51:39 -0700
Message-ID: <20091001155139.3b9de603@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:41076 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754230AbZJAWvS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Oct 2009 18:51:18 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org

>From 1e96af755961a028c888ba9e49c1d4c17c8a4442 Mon Sep 17 00:00:00 2001
From: Arjan van de Ven <arjan@linux.intel.com>
Date: Thu, 1 Oct 2009 15:48:40 -0700
Subject: [PATCH] acpi: clean up video.c boundary checks and types

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
---
 drivers/acpi/proc.c  |    2 +-
 drivers/acpi/video.c |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/proc.c b/drivers/acpi/proc.c
index d0d550d..ceff3ad 100644
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
index a4fddb2..2868303 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1218,7 +1218,7 @@ acpi_video_device_write_state(struct file *file,
 	u32 state = 0;
 
 
-	if (!dev || count + 1 > sizeof str)
+	if (!dev || count >= sizeof(str))
 		return -EINVAL;
 
 	if (copy_from_user(str, buffer, count))
@@ -1275,7 +1275,7 @@ acpi_video_device_write_brightness(struct file *file,
 	int i;
 
 
-	if (!dev || !dev->brightness || count + 1 > sizeof str)
+	if (!dev || !dev->brightness || count >= sizeof(str))
 		return -EINVAL;
 
 	if (copy_from_user(str, buffer, count))
@@ -1557,7 +1557,7 @@ acpi_video_bus_write_POST(struct file *file,
 	unsigned long long opt, options;
 
 
-	if (!video || count + 1 > sizeof str)
+	if (!video || count >= sizeof(str))
 		return -EINVAL;
 
 	status = acpi_video_bus_POST_options(video, &options);
@@ -1597,7 +1597,7 @@ acpi_video_bus_write_DOS(struct file *file,
 	unsigned long opt;
 
 
-	if (!video || count + 1 > sizeof str)
+	if (!video || count >= sizeof(str))
 		return -EINVAL;
 
 	if (copy_from_user(str, buffer, count))
-- 
1.6.2.5



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
