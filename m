From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/6] sony-laptop - simplify keymap initialization
Date: Wed, 30 Dec 2009 02:41:19 -0500
Message-ID: <c45bc9d62c39202b401d1bf7bb2812abb88798a1.1262158615.git.len.brown@intel.com>
References: <1262158882-9713-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:35151 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbZL3Hl1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2009 02:41:27 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KVG00FHFG12RZ36@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 30 Dec 2009 01:41:26 -0600 (CST)
In-reply-to: <1262158882-9713-1-git-send-email-lenb@kernel.org>
In-reply-to: <4c291b9021e33aac046ee8abeb9ea8fe76086342.1262158615.git.len.brown@intel.com>
References: <4c291b9021e33aac046ee8abeb9ea8fe76086342.1262158615.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, Len Brown <len.brown@intel.com>

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Also use input_set_capability() helper instead of manipulating
bits directly.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/sony-laptop.c |   20 ++++++++------------
 1 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index c42d35b..b7aa959 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -419,18 +419,15 @@ static int sony_laptop_setup_input(struct acpi_device *acpi_device)
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
@@ -450,9 +447,8 @@ static int sony_laptop_setup_input(struct acpi_device *acpi_device)
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
1.6.0.6

