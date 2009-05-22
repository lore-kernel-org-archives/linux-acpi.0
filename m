From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] panasonic-laptop: beyond ARRAY_SIZE of pcc->keymap
Date: Fri, 22 May 2009 13:56:33 +0200
Message-ID: <4A1692F1.9010004@gmail.com>
References: <4A15B5CA.9060907@gmail.com> <20090522021933.GA10832@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:40874 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbZEVL4e (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 May 2009 07:56:34 -0400
Received: by ewy24 with SMTP id 24so1786088ewy.37
        for <linux-acpi@vger.kernel.org>; Fri, 22 May 2009 04:56:35 -0700 (PDT)
In-Reply-To: <20090522021933.GA10832@linux-sh.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>, len.brown@intel.com, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org

Do not go beyond ARRAY_SIZE of pcc->keymap

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
> Presumably you meant to send this to linux-acpi or linux-kernel instead
> of linux-sh ;-)

I was not sure, but linux-acpi is cc'ed now.

diff --git a/drivers/misc/panasonic-laptop.c b/drivers/misc/panasonic-laptop.c
index 4a1bc64..d82d1cc 100644
--- a/drivers/misc/panasonic-laptop.c
+++ b/drivers/misc/panasonic-laptop.c
@@ -515,7 +515,7 @@ static void acpi_pcc_generate_keyinput(struct pcc_acpi *pcc)
 
 	hkey_num = result & 0xf;
 
-	if (hkey_num < 0 || hkey_num > ARRAY_SIZE(pcc->keymap)) {
+	if (hkey_num < 0 || hkey_num >= ARRAY_SIZE(pcc->keymap)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
 				  "hotkey number out of range: %d\n",
 				  hkey_num));
