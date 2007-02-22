From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 1/2] ACPI: ibm-acpi: fix initial status of backlight device
Date: Thu, 22 Feb 2007 21:11:16 -0200
Message-ID: <11721858774109-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:43514 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752040AbXBVXLe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Feb 2007 18:11:34 -0500
In-Reply-To: 20070222205520.GA11505@khazad-dum.debian.net
References: 20070222205520.GA11505@khazad-dum.debian.net
In-Reply-To: <20070222205520.GA11505@khazad-dum.debian.net>
References: <20070222205520.GA11505@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

The brightness class core does not update the initial status of the
device's brightness at register time.  Do it by ourselves.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Acked-by: Richard Purdie <rpurdie@rpsys.net>
---
 drivers/acpi/ibm_acpi.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 4cc534e..7c1b418 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -1711,6 +1711,12 @@ static struct backlight_ops ibm_backlight_data = {
 
 static int brightness_init(void)
 {
+	int b;
+
+	b = brightness_get(NULL);
+	if (b < 0)
+		return b;
+
 	ibm_backlight_device = backlight_device_register("ibm", NULL, NULL,
 							 &ibm_backlight_data);
 	if (IS_ERR(ibm_backlight_device)) {
@@ -1718,7 +1724,9 @@ static int brightness_init(void)
 		return PTR_ERR(ibm_backlight_device);
 	}
 
-        ibm_backlight_device->props.max_brightness = 7;
+	ibm_backlight_device->props.max_brightness = 7;
+	ibm_backlight_device->props.brightness = b;
+	backlight_update_status(ibm_backlight_device);
 
 	return 0;
 }
-- 
1.4.4.4

