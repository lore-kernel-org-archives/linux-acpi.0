From: Len Brown <lenb@kernel.org>
Subject: [PATCH for 2.6.22] ACPI: fix acpi_osi=!Linux
Date: Mon, 2 Jul 2007 23:57:45 -0400
Message-ID: <200707022357.45836.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42291 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751486AbXGCD6Z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Jul 2007 23:58:25 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, a.biardi@tiscali.it

Need to check for special case "acpi_osi=!Linux"
before general case "acpi_osi=!*",
or it will have no effect.

Signed-off-by: Len Brown <len.brown@intel.com>
---
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 58ceb18..2e7ba61 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -999,11 +999,11 @@ static int __init acpi_osi_setup(char *str)
 	if (str == NULL || *str == '\0') {
 		printk(KERN_INFO PREFIX "_OSI method disabled\n");
 		acpi_gbl_create_osi_method = FALSE;
+	} else if (!strcmp("!Linux", str)) {
+		enable_osi_linux(0);
 	} else if (*str == '!') {
 		if (acpi_osi_invalidate(++str) == AE_OK)
 			printk(KERN_INFO PREFIX "Deleted _OSI(%s)\n", str);
-	} else if (!strcmp("!Linux", str)) {
-		enable_osi_linux(0);
 	} else if (!strcmp("Linux", str)) {
 		enable_osi_linux(1);
 	} else if (*osi_additional_string == '\0') {
