From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC PATCH 3/5] ACPI video: support _BCL packages that don't
	export brightness levels when machine is on AC/Battery
Date: Wed, 11 Mar 2009 09:09:26 +0800
Message-ID: <1236733766.2820.129.camel@rzhang-dt>
References: <1236672209.2820.121.camel@rzhang-dt>
	 <20090310170639.GA2527@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:47244 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753085AbZCKBIb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Mar 2009 21:08:31 -0400
In-Reply-To: <20090310170639.GA2527@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.de>

On Wed, 2009-03-11 at 01:06 +0800, Matthew Garrett wrote:
> On Tue, Mar 10, 2009 at 04:03:29PM +0800, Zhang Rui wrote:
> 
> > +	if (level_ac_battery > 2) {
> > +		ACPI_ERROR((AE_INFO, "Two many duplicates in _BCL package\n"));
> > +		goto out_free_levels;
> 
> Exiting here seems a little excessive? I'd just go with a warning and 
> carry on. In future maybe we could strip duplicates. Also, s/two/too/.
> 
Agree.

> >  	/* don't sort the first two brightness levels */
> >  	sort(&br->levels[2], count - 2, sizeof(br->levels[2]),
> >  		acpi_video_cmp_level, NULL);
> 
> I think the comment here needs to be clarified - it sounds like you'll 
> ignore the first two in the package, even if they're actual values 
> rather than the ac and battery ones.
> 
Agree.

Refreshed patch attached.

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
Acked-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/video.c |   38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

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
@@ -719,16 +724,35 @@ acpi_video_init_brightness(struct acpi_v
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
+	if (level_ac_battery > 2) {
+		ACPI_ERROR((AE_INFO, "Two many duplicates in _BCL package\n"));
+	} else if (level_ac_battery < 2) {
+		level_ac_battery = 2 - level_ac_battery;
+		br->flags._BCL_no_ac_battery_levels = 1;
+		for (i = (count - 1 + level_ac_battery); i >= 2; i--)
+			br->levels[i] = br->levels[i - level_ac_battery];
+		count += level_ac_battery;
+	}
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
 


