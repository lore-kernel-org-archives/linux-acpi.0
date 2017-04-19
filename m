From: Dmitry Frank <mail@dmitryfrank.com>
Subject: [PATCH v3 2/2] ACPI: video: add comments about subtle cases
Date: Wed, 19 Apr 2017 13:36:18 +0300
Message-ID: <20170419103618.20939-3-mail@dmitryfrank.com>
References: <20170418123558.12436-1-mail@dmitryfrank.com>
 <20170419103618.20939-1-mail@dmitryfrank.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from forward8m.cmail.yandex.net ([5.255.216.201]:56414 "EHLO
        forward8m.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933813AbdDSKhO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 Apr 2017 06:37:14 -0400
In-Reply-To: <20170419103618.20939-1-mail@dmitryfrank.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Felipe Contreras <felipe.contreras@gmail.com>, linux-acpi@vger.kernel.org, Dmitry Frank <mail@dmitryfrank.com>

The comment for acpi_video_bqc_quirk is by Felipe Contreras, taken from
the git history.

Signed-off-by: Dmitry Frank <mail@dmitryfrank.com>
---
 drivers/acpi/acpi_video.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 9a607af971e7..e88fe3632dd6 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -73,6 +73,10 @@ module_param(report_key_events, int, 0644);
 MODULE_PARM_DESC(report_key_events,
 	"0: none, 1: output changes, 2: brightness changes, 3: all");
 
+/*
+ * Whether the struct acpi_video_device_attrib::device_id_scheme bit should be
+ * assumed even if not actually set.
+ */
 static bool device_id_scheme = false;
 module_param(device_id_scheme, bool, 0444);
 
@@ -144,7 +148,15 @@ struct acpi_video_device_attrib {
 				   the VGA device. */
 	u32 pipe_id:3;		/* For VGA multiple-head devices. */
 	u32 reserved:10;	/* Must be 0 */
-	u32 device_id_scheme:1;	/* Device ID Scheme */
+
+	/*
+	 * The device ID might not actually follow the scheme described by this
+	 * struct acpi_video_device_attrib. If it does, then this bit
+	 * device_id_scheme is set; otherwise, other fields should be ignored.
+	 *
+	 * (but also see the global flag device_id_scheme)
+	 */
+	u32 device_id_scheme:1;
 };
 
 struct acpi_video_enumerated_device {
@@ -728,7 +740,33 @@ static int acpi_video_bqc_quirk(struct acpi_video_device *device,
 
 	/*
 	 * Some systems always report current brightness level as maximum
-	 * through _BQC, we need to test another value for them.
+	 * through _BQC, we need to test another value for them. However,
+	 * there is a subtlety:
+	 *
+	 * If the _BCL package ordering is descending, the first level
+	 * (br->levels[2]) is likely to be 0, and if the number of levels
+	 * matches the number of steps, we might confuse a returned level to
+	 * mean the index.
+	 *
+	 * For example:
+	 *
+	 *     current_level = max_level = 100
+	 *     test_level = 0
+	 *     returned level = 100
+	 *
+	 * In this case 100 means the level, not the index, and _BCM failed.
+	 * Still, if the _BCL package ordering is descending, the index of
+	 * level 0 is also 100, so we assume _BQC is indexed, when it's not.
+	 *
+	 * This causes all _BQC calls to return bogus values causing weird
+	 * behavior from the user's perspective.  For example:
+	 *
+	 * xbacklight -set 10; xbacklight -set 20;
+	 *
+	 * would flash to 90% and then slowly down to the desired level (20).
+	 *
+	 * The solution is simple; test anything other than the first level
+	 * (e.g. 1).
 	 */
 	test_level = current_level == max_level
 		? br->levels[ACPI_VIDEO_FIRST_LEVEL + 1]
@@ -789,6 +827,11 @@ int acpi_video_get_levels(struct acpi_device *device,
 		goto out;
 	}
 
+	/*
+	 * Note that we have to reserve 2 extra items (ACPI_VIDEO_FIRST_LEVEL),
+	 * in order to account for buggy BIOS which don't export the first two
+	 * special levels (see below)
+	 */
 	br->levels = kmalloc((obj->package.count + ACPI_VIDEO_FIRST_LEVEL) *
 	                     sizeof(*br->levels), GFP_KERNEL);
 	if (!br->levels) {
-- 
2.11.0

