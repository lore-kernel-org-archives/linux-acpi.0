From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] acpi: acpica: utuuid:  Remove unused function
Date: Thu,  1 Jan 2015 20:24:14 +0100
Message-ID: <1420140254-3986-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:58912 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbbAATVO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jan 2015 14:21:14 -0500
Received: by mail-wi0-f175.google.com with SMTP id l15so26832400wiw.14
        for <linux-acpi@vger.kernel.org>; Thu, 01 Jan 2015 11:21:13 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org

Remove the function acpi_ut_convert_string_to_uuid() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/acpi/acpica/acutils.h |    5 -----
 drivers/acpi/acpica/utuuid.c  |   29 -----------------------------
 2 files changed, 34 deletions(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 486d342..18b82cd 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -782,9 +782,4 @@ int acpi_ut_file_vprintf(ACPI_FILE file, const char *format, va_list args);
 int acpi_ut_file_printf(ACPI_FILE file, const char *format, ...);
 #endif
 
-/*
- * utuuid -- UUID support functions
- */
-void acpi_ut_convert_string_to_uuid(char *in_string, u8 *uuid_buffer);
-
 #endif				/* _ACUTILS_H */
diff --git a/drivers/acpi/acpica/utuuid.c b/drivers/acpi/acpica/utuuid.c
index 4dc3313..a829c74 100644
--- a/drivers/acpi/acpica/utuuid.c
+++ b/drivers/acpi/acpica/utuuid.c
@@ -65,32 +65,3 @@ ACPI_MODULE_NAME("utuuid")
 const u8 acpi_gbl_map_to_uuid_offset[UUID_BUFFER_LENGTH] = {
 	6, 4, 2, 0, 11, 9, 16, 14, 19, 21, 24, 26, 28, 30, 32, 34
 };
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ut_convert_string_to_uuid
- *
- * PARAMETERS:  in_string           - 36-byte formatted UUID string
- *              uuid_buffer         - Where the 16-byte UUID buffer is returned
- *
- * RETURN:      None. Output data is returned in the uuid_buffer
- *
- * DESCRIPTION: Convert a 36-byte formatted UUID string to 16-byte UUID buffer
- *
- ******************************************************************************/
-
-void acpi_ut_convert_string_to_uuid(char *in_string, u8 *uuid_buffer)
-{
-	u32 i;
-
-	for (i = 0; i < UUID_BUFFER_LENGTH; i++) {
-		uuid_buffer[i] =
-		    (acpi_ut_ascii_char_to_hex
-		     (in_string[acpi_gbl_map_to_uuid_offset[i]]) << 4);
-
-		uuid_buffer[i] |=
-		    acpi_ut_ascii_char_to_hex(in_string
-					      [acpi_gbl_map_to_uuid_offset[i] +
-					       1]);
-	}
-}
-- 
1.7.10.4

