From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/3] sony-laptop - simplify keymap initialization
Date: Thu, 24 Dec 2009 00:02:23 -0800
Message-ID: <20091224080222.11511.79737.stgit@localhost.localdomain>
References: <20091224080135.11511.18604.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:63514 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756588AbZLXIC0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 03:02:26 -0500
Received: by pwj9 with SMTP id 9so4830562pwj.21
        for <linux-acpi@vger.kernel.org>; Thu, 24 Dec 2009 00:02:26 -0800 (PST)
In-Reply-To: <20091224080135.11511.18604.stgit@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, =Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org

Also use input_set_capability() helper instead of manipulating
bits directly.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/platform/x86/sony-laptop.c |   20 ++++++++------------
 1 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 5883cc8..a6b7616 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -416,18 +416,15 @@ static int sony_laptop_setup_input(struct acpi_device *acpi_device)
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
@@ -447,9 +444,8 @@ static int sony_laptop_setup_input(struct acpi_device *acpi_device)
 	jog_dev->id.vendor = PCI_VENDOR_ID_SONY;
 	key_dev->dev.parent = &acpi_device->dev;
 
-	jog_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REL);
-	jog_dev->keybit[BIT_WORD(BTN_MOUSE)] = BIT_MASK(BTN_MIDDLE);
-	jog_dev->relbit[0] = BIT_MASK(REL_WHEEL);
+	input_set_capability(jog_dev, EV_KEY, BTN_MIDDLE);
+	input_set_capability(jog_dev, EV_REL, REL_WHEEL);
 
 	error = input_register_device(jog_dev);
 	if (error)

