From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI video: handle indexed _BQC correctly
Date: Thu, 09 Apr 2009 14:24:35 +0800
Message-ID: <1239258275.7661.193.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:58067 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755174AbZDIGYR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Apr 2009 02:24:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Thomas Renninger <trenn@suse.de>, Matthew Garrett <mjg59@srcf.ucam.org>, "Zhang, Rui" <rui.zhang@intel.com>

In the current code, for a box with an indexed _BQC method, we
1. get the current brightness level by evaluating _BQC
2. set the value gotten in step 1 to _BCM
3. get the current brightness level again
4. set the _BQC_use_index flag if the results gotten
   in step 1 and in step 3 don't equal.

But this logic doesn't work actually, because the _BQC_use_index=20
is not set when =EF=BB=BFacpi_video_device_lcd_set_level is invoked.
This results in a failure in step 2.
http://bugzilla.kernel.org/show_bug.cgi?id=3D12249#c83

Now, we set the _BQC_use_index flag after invoking _BQC for the first
time. And reevaluate the _BQC to get the correct brightness level.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |   43 ++++++++++++++++++++++--------------------=
-
 1 file changed, 22 insertions(+), 21 deletions(-)

Index: linux-2.6/drivers/acpi/video.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -805,12 +805,19 @@ acpi_video_init_brightness(struct acpi_v
 	br->flags._BCM_use_index =3D br->flags._BCL_use_index;
=20
 	/* _BQC uses INDEX while _BCL uses VALUE in some laptops */
-	br->curr =3D max_level;
+	br->curr =3D level_old =3D max_level;
+
+	if (!device->cap._BQC)
+		goto set_level;
+
 	result =3D acpi_video_device_lcd_get_level_current(device, &level_old=
);
 	if (result)
 		goto out_free_levels;
=20
-	result =3D acpi_video_device_lcd_set_level(device, br->curr);
+	/*
+	 * Set the level to maximum and check if _BQC uses indexed value
+	 */
+	result =3D acpi_video_device_lcd_set_level(device, max_level);
 	if (result)
 		goto out_free_levels;
=20
@@ -818,25 +825,19 @@ acpi_video_init_brightness(struct acpi_v
 	if (result)
 		goto out_free_levels;
=20
-	if ((level !=3D level_old) && !br->flags._BCM_use_index) {
-		/* Note:
-		 * This piece of code does not work correctly if the current
-		 * brightness levels is 0.
-		 * But I guess boxes that boot with such a dark screen are rare
-		 * and no more code is needed to cover this specifial case.
-		 */
-
-		if (level_ac_battery !=3D 2) {
-			/*
-			 * For now, we don't support the _BCL like this:
-			 * 16, 15, 0, 1, 2, 3, ..., 14, 15, 16
-			 * because we may mess up the index returned by _BQC.
-			 * Plus: we have not got a box like this.
-			 */
-			ACPI_ERROR((AE_INFO, "_BCL not supported\n"));
-		}
-		br->flags._BQC_use_index =3D 1;
-	}
+	br->flags._BQC_use_index =3D (level =3D=3D max_level ? 0 : 1);
+
+	if (!br->flags._BQC_use_index)
+		goto set_level;
+
+	if (br->flags._BCL_reversed)
+		level_old =3D (br->count - 1) - level_old;
+	level_old =3D br->levels[level_old];
+
+set_level:
+	result =3D acpi_video_device_lcd_set_level(device, level_old);
+	if (result)
+		goto out_free_levels;
=20
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "found %d brightness levels\n", count - 2));


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
