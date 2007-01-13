From: malattia@linux.it
Subject: [PATCH 6/11] Video sysfs support take 2
Date: Sat, 13 Jan 2007 23:04:36 +0100
Message-ID: <11687258813214-git-send-email-malattia@linux.it>
References: <11687258812893-git-send-email-malattia@linux.it> <1168725881764-git-send-email-malattia@linux.it> <11687258811866-git-send-email-malattia@linux.it> <11687258812417-git-send-email-malattia@linux.it> <11687258812248-git-send-email-malattia@linux.it> <11687258811707-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa013msr.fastwebnet.it ([85.18.95.73]:37561 "EHLO
	aa013msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbXAMWGG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jan 2007 17:06:06 -0500
In-Reply-To: <11687258811707-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>

From: Andrew Morton <akpm@osdl.org>

add dev argument for backlight_device_register

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/acpi/sony_acpi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/sony_acpi.c b/drivers/acpi/sony_acpi.c
index fd7d55a..195895c 100644
--- a/drivers/acpi/sony_acpi.c
+++ b/drivers/acpi/sony_acpi.c
@@ -322,7 +322,7 @@ static int sony_acpi_add(struct acpi_device *device)
 
 	if (ACPI_SUCCESS(acpi_get_handle(sony_acpi_handle, "GBRT", &handle))) {
 		sony_backlight_device = backlight_device_register("sony", NULL,
-					&sony_backlight_properties);
+					NULL, &sony_backlight_properties);
 	        if (IS_ERR(sony_backlight_device)) {
         	        printk(LOG_PFX "unable to register backlight device\n");
 		}
-- 
1.4.4.2

