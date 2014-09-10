From: Stepan Bujnak <stepanbujnak@fastmail.fm>
Subject: [PATCH] ACPI: force vendor backlight on Lenovo Ideapad Z570
Date: Wed, 10 Sep 2014 17:44:43 +0200
Message-ID: <1410363883-6327-1-git-send-email-stepanbujnak@fastmail.fm>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56317 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751445AbaIJPpA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Sep 2014 11:45:00 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by gateway2.nyi.internal (Postfix) with ESMTP id 142BA20782
	for <linux-acpi@vger.kernel.org>; Wed, 10 Sep 2014 11:44:56 -0400 (EDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, Stepan Bujnak <stepanbujnak@fastmail.fm>

Lenovo Ideapad 570 is a pre-win8 laptop where not using vendor backlight causes the backlight controls not to work.

Signed-off-by: Stepan Bujnak <stepanbujnak@fastmail.fm>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index c42feb2..27c4349 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -174,6 +174,14 @@ static struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 5737"),
 		},
 	},
+	{
+	.callback = video_detect_force_vendor,
+	.ident = "Lenovo IdeaPad Z570",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_VERSION, "Ideapad Z570"),
+		},
+	},
 	{ },
 };
 
-- 
1.9.3

