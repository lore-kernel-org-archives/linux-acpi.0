From: akpm@linux-foundation.org
Subject: [patch 2/4] drivers/acpi: use kasprintf
Date: Tue, 27 Apr 2010 14:06:04 -0700
Message-ID: <201004272106.o3RL64Y0019658@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46829 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750797Ab0D0VGJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Apr 2010 17:06:09 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, julia@diku.dk

From: Julia Lawall <julia@diku.dk>

kasprintf combines kmalloc and sprintf, and takes care of the size
calculation itself.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression a,flag;
expression list args;
statement S;
@@

  a =
-  \(kmalloc\|kzalloc\)(...,flag)
+  kasprintf(flag,args)
  <... when != a
  if (a == NULL || ...) S
  ...>
- sprintf(a,args);
// </smpl>

[akpm@linux-foundation.org: don't change handling of `count']
Signed-off-by: Julia Lawall <julia@diku.dk>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/video.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff -puN drivers/acpi/video.c~drivers-acpi-use-kasprintf drivers/acpi/video.c
--- a/drivers/acpi/video.c~drivers-acpi-use-kasprintf
+++ a/drivers/acpi/video.c
@@ -1003,11 +1003,11 @@ static void acpi_video_device_find_cap(s
 		result = acpi_video_init_brightness(device);
 		if (result)
 			return;
-		name = kzalloc(MAX_NAME_LEN, GFP_KERNEL);
+		name = kasprintf(GFP_KERNEL, "acpi_video%d", count);
 		if (!name)
 			return;
+		count++;
 
-		sprintf(name, "acpi_video%d", count++);
 		memset(&props, 0, sizeof(struct backlight_properties));
 		props.max_brightness = device->brightness->count - 3;
 		device->backlight = backlight_device_register(name, NULL, device,
@@ -1063,10 +1063,10 @@ static void acpi_video_device_find_cap(s
 		if (device->cap._DCS && device->cap._DSS) {
 			static int count;
 			char *name;
-			name = kzalloc(MAX_NAME_LEN, GFP_KERNEL);
+			name = kasprintf(GFP_KERNEL, "acpi_video%d", count);
 			if (!name)
 				return;
-			sprintf(name, "acpi_video%d", count++);
+			count++;
 			device->output_dev = video_output_register(name,
 					NULL, device, &acpi_output_properties);
 			kfree(name);
_
