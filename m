From: Jens Reyer <jens.reyer@gmail.com>
Subject: [PATCH] ACPI / video: Add disable_native_backlight quirk for SAMSUNG
 900X3C/900X3D/900X3E/900X4C/900X4D
Date: Sun, 15 Feb 2015 00:20:50 +0100
Message-ID: <54DFD852.4080000@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030609090205050205080301"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:63446 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754490AbbBNXUy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Feb 2015 18:20:54 -0500
Received: by mail-wg0-f46.google.com with SMTP id a1so23111485wgh.5
        for <linux-acpi@vger.kernel.org>; Sat, 14 Feb 2015 15:20:52 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

This is a multi-part message in MIME format.
--------------030609090205050205080301
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi

The native intel backlight controls do not work correctly on SAMSUNG
900X3C/900X3D/900X3E/900X4C/900X4D laptops as I reported in
https://bugs.freedesktop.org/show_bug.cgi?id=87286 (and
https://bugs.debian.org/772440).

Aaron Lu told me there to speak up here/to Rafael.

Please find attached a patch to disable the native backlight on this
laptop model, like it was already done for some other older models.

I assume this would be the proper commit comments (or should it be
signed-off?):
Bug-Link: https://bugs.freedesktop.org/show_bug.cgi?id=87286.
Reported-and-tested-by: Jens Reyer <jens.reyer@gmail.com>

The patch applies to
https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
branch linux-next, head at
389a8d43d64711b0e7282d227e05a6a71b43753d
Rafael J. Wysocki 2015-02-12 22:43:26

I verified the issues are still present in linux-next and get solved
with this patch.

Just tell me if there is anything else I can do to get this applied.

Thanks
Jens Reyer/jre <jre.winesim@gmail.com>

--------------030609090205050205080301
Content-Type: text/x-patch;
 name="disable_native_backlight_Samsung_900X.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="disable_native_backlight_Samsung_900X.patch"

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 88a4f99..debd309 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -540,6 +540,15 @@ static struct dmi_system_id video_dmi_table[] __initdata = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "730U3E/740U3E"),
 		},
 	},
+	{
+	 /* https://bugs.freedesktop.org/show_bug.cgi?id=87286 */
+	 .callback = video_disable_native_backlight,
+	 .ident = "SAMSUNG 900X3C/900X3D/900X3E/900X4C/900X4D",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "900X3C/900X3D/900X3E/900X4C/900X4D"),
+		},
+	},
 
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1163574 */

--------------030609090205050205080301--
