From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] fix X[ ARRAY_SIZE(X) ]
Date: Sat, 17 Jan 2009 15:51:27 +0100
Message-ID: <4971F06F.9030309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f12.google.com ([209.85.219.12]:34323 "EHLO
	mail-ew0-f12.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757880AbZAQO7G (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 17 Jan 2009 09:59:06 -0500
Received: by ewy5 with SMTP id 5so268991ewy.13
        for <linux-acpi@vger.kernel.org>; Sat, 17 Jan 2009 06:59:04 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org

Ensure pcc->keymap[ ARRAY_SIZE(pcc->keymap) ] does not occur.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index f30db36..c47a44d 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -507,7 +507,7 @@ static void acpi_pcc_generate_keyinput(struct pcc_acpi *pcc)
 
 	hkey_num = result & 0xf;
 
-	if (hkey_num < 0 || hkey_num > ARRAY_SIZE(pcc->keymap)) {
+	if (hkey_num < 0 || hkey_num >= ARRAY_SIZE(pcc->keymap)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
 				  "hotkey number out of range: %d\n",
 				  hkey_num));
