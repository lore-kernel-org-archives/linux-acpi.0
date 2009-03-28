From: Len Brown <lenb@kernel.org>
Subject: [PATCH 90/98] ACPI video: support _BCL packages that don't export
 brightness levels when machine is on AC/Battery
Date: Sat, 28 Mar 2009 00:32:05 -0400
Message-ID: <d32f69470c2081ffdfd82740ac19f940790f9e93.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:50107 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565AbZC1Edt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:49 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH7006AW8OAWMPA@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:47 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Many buggy BIOSes don't export the brightness levels when machine
is on AC/Battery in the _BCL method.

Reformat the _BCL package for these laptops:
now the elements in device->brightness->levels[] are like:
levels[0]: brightness level when on AC power.
levels[1]: brightness level when on Battery power.
levels[2]: supported brightness level 1.
levels[3]: supported brightness level 2.
...
levels[n]: supported brightness level n-1.
levels[n + 1]: supported brightness level n.
So if there are n supported brightness levels on this laptop,
we will have n+2 entries in device->brightnes->levels[].

level[0] and level[1] are invalid on the laptops that don't
export the brightness levels on AC/Battery.
Fortunately, we never use these two values at all, even for the
valid ones.

http://bugzilla.kernel.org/show_bug.cgi?id=12249

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Matthew Garrett <mjg59@srcf.ucam.org>
Acked-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |   37 ++++++++++++++++++++++++++++++-------
 1 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 52f52b3..398b3ee 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -168,10 +168,15 @@ struct acpi_video_device_cap {
 	u8 _DSS:1;		/*Device state set */
 };
 
+struct acpi_video_brightness_flags {
+	u8 _BCL_no_ac_battery_levels:1;	/* no AC/Battery levels in _BCL */
+};
+
 struct acpi_video_device_brightness {
 	int curr;
 	int count;
 	int *levels;
+	struct acpi_video_brightness_flags flags;
 };
 
 struct acpi_video_device {
@@ -682,7 +687,7 @@ static int
 acpi_video_init_brightness(struct acpi_video_device *device)
 {
 	union acpi_object *obj = NULL;
-	int i, max_level = 0, count = 0;
+	int i, max_level = 0, count = 0, level_ac_battery = 0;
 	union acpi_object *o;
 	struct acpi_video_device_brightness *br = NULL;
 
@@ -701,7 +706,7 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 		goto out;
 	}
 
-	br->levels = kmalloc(obj->package.count * sizeof *(br->levels),
+	br->levels = kmalloc((obj->package.count + 2) * sizeof *(br->levels),
 				GFP_KERNEL);
 	if (!br->levels)
 		goto out_free;
@@ -719,16 +724,34 @@ acpi_video_init_brightness(struct acpi_video_device *device)
 		count++;
 	}
 
-	/* don't sort the first two brightness levels */
+	/*
+	 * some buggy BIOS don't export the levels
+	 * when machine is on AC/Battery in _BCL package.
+	 * In this case, the first two elements in _BCL packages
+	 * are also supported brightness levels that OS should take care of.
+	 */
+	for (i = 2; i < count; i++)
+		if (br->levels[i] == br->levels[0] ||
+		    br->levels[i] == br->levels[1])
+			level_ac_battery++;
+
+	if (level_ac_battery < 2) {
+		level_ac_battery = 2 - level_ac_battery;
+		br->flags._BCL_no_ac_battery_levels = 1;
+		for (i = (count - 1 + level_ac_battery); i >= 2; i--)
+			br->levels[i] = br->levels[i - level_ac_battery];
+		count += level_ac_battery;
+	} else if (level_ac_battery > 2)
+		ACPI_ERROR((AE_INFO, "Too many duplicates in _BCL package\n"));
+
+	/* sort all the supported brightness levels */
 	sort(&br->levels[2], count - 2, sizeof(br->levels[2]),
 		acpi_video_cmp_level, NULL);
 
-	if (count < 2)
-		goto out_free_levels;
-
 	br->count = count;
 	device->brightness = br;
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "found %d brightness levels\n", count));
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			  "found %d brightness levels\n", count - 2));
 	kfree(obj);
 	return max_level;
 
-- 
1.6.0.6

