From: Len Brown <lenb@kernel.org>
Subject: [PATCH 13/14] ACPI video: no warning message if
 "acpi_backlight=vendor" is used
Date: Wed, 30 Dec 2009 02:36:36 -0500
Message-ID: <28c32e99bdf5ab838e7179c1aaca5a35a07f2a2b.1262158495.git.len.brown@intel.com>
References: <1262158597-9597-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:64677 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbZL3X1I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2009 18:27:08 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KVH007CENT0HQT5@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 30 Dec 2009 17:27:05 -0600 (CST)
In-reply-to: <1262158597-9597-1-git-send-email-lenb@kernel.org>
In-reply-to: <51b0f1c2b8c32ee44ff01ef74599a1f17e4fc565.1262158495.git.len.brown@intel.com>
References: <51b0f1c2b8c32ee44ff01ef74599a1f17e4fc565.1262158495.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

AML code always sends notifications to ACPI video device,
even if we disable the ACPI backlight control by using
boot option "acpi_backlight=vendor".

In this case we should not print any warning message.
http://bugzilla.kernel.org/show_bug.cgi?id=13671#c14

Sigend-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 05dff63..3b063a6 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1979,6 +1979,10 @@ acpi_video_switch_brightness(struct acpi_video_device *device, int event)
 	unsigned long long level_current, level_next;
 	int result = -EINVAL;
 
+	/* no warning message if acpi_backlight=vendor is used */
+	if (!acpi_video_backlight_support())
+		return 0;
+
 	if (!device->brightness)
 		goto out;
 
-- 
1.6.0.6

