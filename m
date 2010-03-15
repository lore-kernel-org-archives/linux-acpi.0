From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/34] sony-laptop - simplify keymap initialization
Date: Sun, 14 Mar 2010 21:40:41 -0400
Message-ID: <c45bc9d62c39202b401d1bf7bb2812abb88798a1.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:46560 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883Ab0COBnX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Mar 2010 21:43:23 -0400
Received: from sony ([unknown] [192.102.209.1]) by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KZA00D9GVG61X00@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 14 Mar 2010 20:43:20 -0500 (CDT)
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
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
1.7.0.2.201.g80978

