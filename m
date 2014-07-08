From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 03/25] ACPICA: Utilities: Fix an issue with non-native ACPI_IS_PRINT()
Date: Tue,  8 Jul 2014 10:06:05 +0800
Message-ID: <a9489d39c37f38641c4531c945eb7621a0f8119a.1404277202.git.lv.zheng@intel.com>
References: <cover.1404277202.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50362 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752477AbaGHCGJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jul 2014 22:06:09 -0400
In-Reply-To: <cover.1404277202.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

An error was found in the ACPICA provided non-native ACPI_IS_PRINT() causing the
following difference with the native isprint() implementation:
  The GNU libc isprint('\n') test result:
   isprint(0x20) is FALSE
  The Linux kernel isprint('\n') test result:
   ACPI: isprint(0x20) is FALSE
  The _acpi_ctype isprint('\n') test result:
   isprint(0x20) is TRUE

The ACPI_IS_PRINT() macro generated for _acpi_ctype is wrong. It should use
_ACPI_XS instead of _ACPI_SP.  _ACPI_XS is white space only. Other space
characters should be non printable.

This patch fixes this issue. For OSPMs that are using native standard
isprint() implementations, this patch is a no-op. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acutils.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 1e256c5..caeb81a 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -257,7 +257,7 @@ extern const u8 _acpi_ctype[];
 #define ACPI_IS_XDIGIT(c) (_acpi_ctype[(unsigned char)(c)] & (_ACPI_XD))
 #define ACPI_IS_UPPER(c)  (_acpi_ctype[(unsigned char)(c)] & (_ACPI_UP))
 #define ACPI_IS_LOWER(c)  (_acpi_ctype[(unsigned char)(c)] & (_ACPI_LO))
-#define ACPI_IS_PRINT(c)  (_acpi_ctype[(unsigned char)(c)] & (_ACPI_LO | _ACPI_UP | _ACPI_DI | _ACPI_SP | _ACPI_PU))
+#define ACPI_IS_PRINT(c)  (_acpi_ctype[(unsigned char)(c)] & (_ACPI_LO | _ACPI_UP | _ACPI_DI | _ACPI_XS | _ACPI_PU))
 #define ACPI_IS_ALPHA(c)  (_acpi_ctype[(unsigned char)(c)] & (_ACPI_LO | _ACPI_UP))
 
 #endif				/* !ACPI_USE_SYSTEM_CLIBRARY */
-- 
1.7.10

