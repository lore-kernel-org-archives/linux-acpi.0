From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] [REGRESSION FIX] Revert "ACPI / video: Add force_native quirk for HP Pavilion dv6"
Date: Sun, 22 Jan 2017 13:24:05 +0100
Message-ID: <20170122122405.760-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751338AbdAVMYP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 22 Jan 2017 07:24:15 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, stable@vger.kernel.org

This reverts commit 6276e53fa8c0 ("ACPI / video: Add force_native quirk for
HP Pavilion dv6").

In the commit message for the quirk this revert removes I wrote:

"Note that there are quite a few HP Pavilion dv6 variants, some
woth ATI and some with NVIDIA hybrid gfx, both seem to need this
quirk to have working backlight control. There are also some versions
with only Intel integrated gfx, these may not need this quirk, but it
should not hurt there."

Unfortunately that seems wrong, I've already received 2 reports of
this commit causing regressions on some dv6 variants (at least one
of which actually has a nvidia GPU). So it seems that HP has made a
mess here by using the same model-name both in marketing and in the
DMI data for many different variants. Some of which need
acpi_backlight=native for functional backlight control (as the
quirk this commit reverts was doing), where as others are broken by
it. So lets get back to the old sitation so as to avoid regressing
on models which used to work without any kernel cmdline arguments
before.

Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 02ded25..7f48156 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -305,17 +305,6 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Dell System XPS L702X"),
 		},
 	},
-	{
-	/* https://bugzilla.redhat.com/show_bug.cgi?id=1204476 */
-	/* https://bugs.launchpad.net/ubuntu/+source/linux-lts-trusty/+bug/1416940 */
-	.callback = video_detect_force_native,
-	.ident = "HP Pavilion dv6",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dv6 Notebook PC"),
-		},
-	},
-
 	{ },
 };
 
-- 
2.9.3

