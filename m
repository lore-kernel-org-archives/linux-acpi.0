From: akpm@linux-foundation.org
Subject: [patch for 2.6.34? 1/1] acpi: video: fix acpi_backlight=video
Date: Wed, 12 May 2010 15:33:57 -0700
Message-ID: <201005122233.o4CMXvi7024758@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34606 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758343Ab0ELWeI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 May 2010 18:34:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, kamal@canonical.com, bjorn.helgaas@hp.com, jkosina@suse.cz, rui.zhang@intel.com, stable@kernel.org

From: Kamal Mostafa <kamal@canonical.com>

Make "acpi_backlight=video" param enable ACPI_VIDEO_BACKLIGHT_FORCE_VIDEO
as intended, instead of incorrectly enabling video output switching.

Addresses http://bugs.launchpad.net/bugs/573120

Signed-off-by: Kamal Mostafa <kamal@canonical.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/video_detect.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/acpi/video_detect.c~acpi-video-fix-acpi_backlight=video drivers/acpi/video_detect.c
--- a/drivers/acpi/video_detect.c~acpi-video-fix-acpi_backlight=video
+++ a/drivers/acpi/video_detect.c
@@ -250,7 +250,7 @@ static int __init acpi_backlight(char *s
 				ACPI_VIDEO_BACKLIGHT_FORCE_VENDOR;
 		if (!strcmp("video", str))
 			acpi_video_support |=
-				ACPI_VIDEO_OUTPUT_SWITCHING_FORCE_VIDEO;
+				ACPI_VIDEO_BACKLIGHT_FORCE_VIDEO;
 	}
 	return 1;
 }
_
