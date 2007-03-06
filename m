From: akpm@linux-foundation.org
Subject: [patch 4/6] sony-laptop fix uninitialised variable
Date: Tue, 06 Mar 2007 02:29:42 -0800
Message-ID: <200703061029.l26ATgUA019125@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:33928 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934012AbXCFKbD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 Mar 2007 05:31:03 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, malattia@linux.it

From: Andrew Morton <akpm@linux-foundation.org>

drivers/misc/sony-laptop.c: In function 'sony_acpi_add':
drivers/misc/sony-laptop.c:456: warning: 'result' may be used uninitialized in this function

The compiler seems to actually be telling the truth this time.

Cc: Mattia Dongili <malattia@linux.it>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/misc/sony-laptop.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/misc/sony-laptop.c~sony-laptop-fix-uninitialised-variable drivers/misc/sony-laptop.c
--- a/drivers/misc/sony-laptop.c~sony-laptop-fix-uninitialised-variable
+++ a/drivers/misc/sony-laptop.c
@@ -453,7 +453,7 @@ static int sony_acpi_resume(struct acpi_
 static int sony_acpi_add(struct acpi_device *device)
 {
 	acpi_status status;
-	int result;
+	int result = 0;
 	acpi_handle handle;
 
 	sony_acpi_acpi_device = device;
_
