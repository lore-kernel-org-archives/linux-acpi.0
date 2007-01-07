From: malattia@linux.it
Subject: [PATCH 11/11] initialize the brighness value at device registration
Date: Sun,  7 Jan 2007 18:54:43 +0100
Message-ID: <11681924831516-git-send-email-malattia@linux.it>
References: <1168192483500-git-send-email-malattia@linux.it> <11681924832840-git-send-email-malattia@linux.it> <1168192483207-git-send-email-malattia@linux.it> <11681924833947-git-send-email-malattia@linux.it> <11681924832264-git-send-email-malattia@linux.it> <11681924831582-git-send-email-malattia@linux.it> <11681924831482-git-send-email-malattia@linux.it> <11681924833473-git-send-email-malattia@linux.it> <11681924833091-git-send-email-malattia@linux.it> <11681924831019-git-send-email-malattia@linux.it> <11681924832600-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa011msr.fastwebnet.it ([85.18.95.71]:46679 "EHLO
	aa011msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964801AbXAGRzW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Jan 2007 12:55:22 -0500
In-Reply-To: <11681924832600-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

From: Mattia Dongili <malattia@linux.it>

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/acpi/sony_acpi.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/sony_acpi.c b/drivers/acpi/sony_acpi.c
index c65f589..8c69282 100644
--- a/drivers/acpi/sony_acpi.c
+++ b/drivers/acpi/sony_acpi.c
@@ -357,6 +357,8 @@ static int sony_acpi_add(struct acpi_device *device)
 	        if (IS_ERR(sony_backlight_device)) {
         	        printk(LOG_PFX "unable to register backlight device\n");
 		}
+		sony_backlight_properties.brightness =
+			sony_backlight_get_brightness(sony_backlight_device);
 	}
 
 	for (item = sony_acpi_values; item->name; ++item) {
-- 
1.4.4.2

