From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/37] ACPI: VIDEO: Adjust current level to closest available one.
Date: Wed, 10 Oct 2007 01:06:13 -0400
Message-ID: <1191992804-14965-7-git-send-email-lenb@kernel.org>
References: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:45224 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751073AbXJJFGt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Oct 2007 01:06:49 -0400
In-Reply-To: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Message-Id: <63f0edfc0b7f8058f9d3f9b572615ec97ae011ba.1191992584.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 83aa41c..8a60a3d 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1636,9 +1636,20 @@ static int
 acpi_video_get_next_level(struct acpi_video_device *device,
 			  u32 level_current, u32 event)
 {
-	int min, max, min_above, max_below, i, l;
+	int min, max, min_above, max_below, i, l, delta = 255;
 	max = max_below = 0;
 	min = min_above = 255;
+	/* Find closest level to level_current */
+	for (i = 0; i < device->brightness->count; i++) {
+		l = device->brightness->levels[i];
+		if (abs(l - level_current) < abs(delta)) {
+			delta = l - level_current;
+			if (!delta)
+				break;
+		}
+	}
+	/* Ajust level_current to closest available level */
+	level_current += delta;
 	for (i = 0; i < device->brightness->count; i++) {
 		l = device->brightness->levels[i];
 		if (l < min)
-- 
1.5.3.4.206.g58ba4
