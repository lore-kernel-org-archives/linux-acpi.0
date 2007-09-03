From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 2/2] ACPI: VIDEO: Adjust current level to closest available
	one.
Date: Mon, 03 Sep 2007 16:30:08 +0400
Message-ID: <20070903123008.20082.80704.stgit@z61m>
References: <20070903122958.20082.6843.stgit@z61m>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:56224 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752156AbXICMaR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Sep 2007 08:30:17 -0400
In-Reply-To: <20070903122958.20082.6843.stgit@z61m>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Tuttle <linux-kernel@ttuttle.net>, linux-acpi@vger.kernel.org, lenb@kernel.org

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
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

