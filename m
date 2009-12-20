From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 3/3] sony-laptop: simplify keymap initialization
Date: Sun, 20 Dec 2009 23:17:39 +0900
Message-ID: <1261318659-5980-4-git-send-email-malattia@linux.it>
References: <1261318659-5980-1-git-send-email-malattia@linux.it>
 <1261318659-5980-2-git-send-email-malattia@linux.it>
 <1261318659-5980-3-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:54554
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761AbZLTOSC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 20 Dec 2009 09:18:02 -0500
In-Reply-To: <1261318659-5980-3-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, Mattia Dongili <malattia@linux.it>

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Also use input_set_capability() helper instead of manipulating
bits directly.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/platform/x86/sony-laptop.c |   20 ++++++++------------
 1 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 90400f0..0d129ef 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -420,18 +420,15 @@ static int sony_laptop_setup_input(struct acpi_device *acpi_device)
 	key_dev->dev.parent = &acpi_device->dev;
 
 	/* Initialize the Input Drivers: special keys */
-	set_bit(EV_KEY, key_dev->evbit);
-	set_bit(EV_MSC, key_dev->evbit);
-	set_bit(MSC_SCAN, key_dev->mscbit);
+	input_set_capability(key_dev, EV_MSC, MSC_SCAN);
+
+	__set_bit(EV_KEY, key_dev->evbit);
 	key_dev->keycodesize = sizeof(sony_laptop_input_keycode_map[0]);
 	key_dev->keycodemax = ARRAY_SIZE(sony_laptop_input_keycode_map);
 	key_dev->keycode = &sony_laptop_input_keycode_map;
-	for (i = 0; i < ARRAY_SIZE(sony_laptop_input_keycode_map); i++) {
-		if (sony_laptop_input_keycode_map[i] != KEY_RESERVED) {
-			set_bit(sony_laptop_input_keycode_map[i],
-				key_dev->keybit);
-		}
-	}
+	for (i = 0; i < ARRAY_SIZE(sony_laptop_input_keycode_map); i++)
+		__set_bit(sony_laptop_input_keycode_map[i], key_dev->keybit);
+	__clear_bit(KEY_RESERVED, key_dev->keybit);
 
 	error = input_register_device(key_dev);
 	if (error)
@@ -451,9 +448,8 @@ static int sony_laptop_setup_input(struct acpi_device *acpi_device)
 	jog_dev->id.vendor = PCI_VENDOR_ID_SONY;
 	key_dev->dev.parent = &acpi_device->dev;
 
-	jog_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REL);
-	jog_dev->keybit[BIT_WORD(BTN_MOUSE)] = BIT_MASK(BTN_MIDDLE);
-	jog_dev->relbit[0] = BIT_MASK(REL_WHEEL);
+	input_set_capability(jog_dev, EV_KEY, BTN_MIDDLE);
+	input_set_capability(jog_dev, EV_REL, REL_WHEEL);
 
 	error = input_register_device(jog_dev);
 	if (error)
-- 
1.6.5.7

