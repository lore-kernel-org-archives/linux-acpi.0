From: Karim Eshapa <karim.eshapa@gmail.com>
Subject: [PATCH] acpi: acpica: dbfileio: Use strlcpy to Copy a C-string into a sized buffer
Date: Wed, 24 May 2017 01:25:53 +0200
Message-ID: <1495581953-5523-1-git-send-email-karim.eshapa@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33434 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966651AbdEWX0D (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 May 2017 19:26:03 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: robert.moore@intel.com
Cc: lv.zheng@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org, Karim Eshapa <karim.eshapa@gmail.com>

Use strlcpy with sized buffer instead of strncpy to
avoid non NUL-terminated source strings problems.

Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
---
 drivers/acpi/acpica/dbfileio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/dbfileio.c b/drivers/acpi/acpica/dbfileio.c
index 4d81ea2..f0f22f1 100644
--- a/drivers/acpi/acpica/dbfileio.c
+++ b/drivers/acpi/acpica/dbfileio.c
@@ -99,7 +99,7 @@ void acpi_db_open_debug_file(char *name)
 	}
 
 	acpi_os_printf("Debug output file %s opened\n", name);
-	strncpy(acpi_gbl_db_debug_filename, name,
+	strlcpy(acpi_gbl_db_debug_filename, name,
 		sizeof(acpi_gbl_db_debug_filename));
 	acpi_gbl_db_output_to_file = TRUE;
 }
-- 
2.7.4

