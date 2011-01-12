From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/48] ACPI video: check cap._DDC flag before getting EDID
Date: Wed, 12 Jan 2011 05:19:03 -0500
Message-ID: <82069552555cf951d9ade5c1aec61dd40b0765b5.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:41624 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649Ab1ALKUI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 05:20:08 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEW00379NDIMZ71@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 04:20:08 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

cap._DDC is defined but never used.
Check this flag now and don't try to get EDID for video output devices with this flag cleared.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 81766eb..177b4dd 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1275,6 +1275,9 @@ int acpi_video_get_edid(struct acpi_device *device, int type, int device_id,
 		if (!video_device)
 			continue;
 
+		if (!video_device->cap._DDC)
+			continue;
+
 		if (type) {
 			switch (type) {
 			case ACPI_VIDEO_DISPLAY_CRT:
-- 
1.7.4.rc1.7.g2cf08

