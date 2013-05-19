From: Bastian Triller <bastian.triller@gmail.com>
Subject: [PATCH] ACPI / video: Add "Asus UL30A" to ACPI video detect blacklist
Date: Sun, 19 May 2013 13:52:33 +0200
Message-ID: <20130519115233.GA4615@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ea0-f180.google.com ([209.85.215.180]:50827 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754289Ab3ESLwg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 19 May 2013 07:52:36 -0400
Received: by mail-ea0-f180.google.com with SMTP id g10so3362387eak.39
        for <linux-acpi@vger.kernel.org>; Sun, 19 May 2013 04:52:35 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org

Like on UL30VT, the ACPI video driver can't control backlight correctly on
Asus UL30A.  Vendor driver (asus-laptop) can work.  This patch is to
add "Asus UL30A" to ACPI video detect blacklist in order to use
asus-laptop for video control on the "Asus UL30A" rather than ACPI
video driver.

Signed-off-by: Bastian Triller <bastian.triller@gmail.com>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 66f6762..e6bd910 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -161,6 +161,14 @@ static struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "UL30VT"),
 		},
 	},
+	{
+	.callback = video_detect_force_vendor,
+	.ident = "Asus UL30A",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "UL30A"),
+		},
+	},
 	{ },
 };
 
-- 
1.8.3.rc2

