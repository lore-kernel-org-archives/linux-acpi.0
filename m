From: akpm@linux-foundation.org
Subject: [patch 5/7] asus-acpi: remove duplicate comparison of asus_model strings
Date: Tue, 02 Feb 2010 14:37:57 -0800
Message-ID: <201002022237.o12MbveE018693@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59585 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932136Ab0BBWjV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2010 17:39:21 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, roel.kluin@gmail.com, corentincj@iksaif.net, sziwan@users.sourceforge.net

From: Roel Kluin <roel.kluin@gmail.com>

These tests already occur elsewhere

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Cc: Corentin Chary <corentincj@iksaif.net>
Cc: Karol Kozimor <sziwan@users.sourceforge.net>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/asus_acpi.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/platform/x86/asus_acpi.c~asus-acpi-remove-duplicate-comparison-of-asus_model-strings drivers/platform/x86/asus_acpi.c
--- a/drivers/platform/x86/asus_acpi.c~asus-acpi-remove-duplicate-comparison-of-asus_model-strings
+++ a/drivers/platform/x86/asus_acpi.c
@@ -1225,9 +1225,8 @@ static int asus_model_match(char *model)
 	else if (strncmp(model, "M2N", 3) == 0 ||
 		 strncmp(model, "M3N", 3) == 0 ||
 		 strncmp(model, "M5N", 3) == 0 ||
-		 strncmp(model, "M6N", 3) == 0 ||
 		 strncmp(model, "S1N", 3) == 0 ||
-		 strncmp(model, "S5N", 3) == 0 || strncmp(model, "W1N", 3) == 0)
+		 strncmp(model, "S5N", 3) == 0)
 		return xxN;
 	else if (strncmp(model, "M1", 2) == 0)
 		return M1A;
_
