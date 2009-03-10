From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 3/5] ACPI video: support _BCL packages that don't
	export brightness levels when machine is on AC/Battery
Date: Tue, 10 Mar 2009 16:03:29 +0800
Message-ID: <1236672209.2820.121.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52911 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752985AbZCJICi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Mar 2009 04:02:38 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.de>, Matthew Garrett <mjg59@srcf.ucam.org>, "Zhang, Rui" <rui.zhang@intel.com>

Subject: support _BCL packages that don't export brightness levels when machine is on AC/Battery
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

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |   37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
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
 
@@ -701,7 +706,7 @@ acpi_video_init_brightness(struct acpi_v
 		goto out;
 	}
 
-	br->levels = kmalloc(obj->package.count * sizeof *(br->levels),
+	br->levels = kmalloc((obj->package.count + 2) * sizeof *(br->levels),
 				GFP_KERNEL);
 	if (!br->levels)
 		goto out_free;
@@ -719,16 +724,36 @@ acpi_video_init_brightness(struct acpi_v
 		count++;
 	}
 
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
+	if (level_ac_battery > 2) {
+		ACPI_ERROR((AE_INFO, "Two many duplicates in _BCL package\n"));
+		goto out_free_levels;
+	} else if (level_ac_battery < 2) {
+		level_ac_battery = 2 - level_ac_battery;
+		br->flags._BCL_no_ac_battery_levels = 1;
+		for (i = (count - 1 + level_ac_battery); i >= 2; i--)
+			br->levels[i] = br->levels[i - level_ac_battery];
+		count += level_ac_battery;
+	}
+
 	/* don't sort the first two brightness levels */
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
 


