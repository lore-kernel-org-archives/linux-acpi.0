From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 22/26] ACPICA: Split C library prototypes to new header.
Date: Wed,  1 Jul 2015 14:45:18 +0800
Message-ID: <c311714784f666f46e254bb15e55a5f1b4d5c581.1435731597.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com> <cover.1435731597.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:28704 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753618AbbGAGp0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Jul 2015 02:45:26 -0400
In-Reply-To: <cover.1435731597.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit f51bf8497889a94046820639537165bbd7ccdee6

Adds acclib.h

This patch doesn't affect Linux kernel.

Link: https://github.com/acpica/acpica/commit/f51bf849
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/accommon.h |    3 +++
 drivers/acpi/acpica/acutils.h  |   58 ----------------------------------------
 2 files changed, 3 insertions(+), 58 deletions(-)

diff --git a/drivers/acpi/acpica/accommon.h b/drivers/acpi/acpica/accommon.h
index 853aa2d..a8d8092 100644
--- a/drivers/acpi/acpica/accommon.h
+++ b/drivers/acpi/acpica/accommon.h
@@ -59,5 +59,8 @@
 #include "acglobal.h"		/* All global variables */
 #include "achware.h"		/* Hardware defines and interfaces */
 #include "acutils.h"		/* Utility interfaces */
+#ifndef ACPI_USE_SYSTEM_CLIBRARY
+#include "acclib.h"		/* C library interfaces */
+#endif				/* !ACPI_USE_SYSTEM_CLIBRARY */
 
 #endif				/* __ACCOMMON_H__ */
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index ef1e51d..6de0d35 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -205,64 +205,6 @@ acpi_status acpi_ut_hardware_initialize(void);
 
 void acpi_ut_subsystem_shutdown(void);
 
-/*
- * utclib - Local implementations of C library functions
- */
-#ifndef ACPI_USE_SYSTEM_CLIBRARY
-
-acpi_size strlen(const char *string);
-
-char *strchr(const char *string, int ch);
-
-char *strcpy(char *dst_string, const char *src_string);
-
-char *strncpy(char *dst_string, const char *src_string, acpi_size count);
-
-int strncmp(const char *string1, const char *string2, acpi_size count);
-
-int strcmp(const char *string1, const char *string2);
-
-char *strcat(char *dst_string, const char *src_string);
-
-char *strncat(char *dst_string, const char *src_string, acpi_size count);
-
-u32 strtoul(const char *string, char **terminator, u32 base);
-
-char *strstr(char *string1, char *string2);
-
-int memcmp(void *buffer1, void *buffer2, acpi_size count);
-
-void *memcpy(void *dest, const void *src, acpi_size count);
-
-void *memset(void *dest, int value, acpi_size count);
-
-int toupper(int c);
-
-int tolower(int c);
-
-extern const u8 _acpi_ctype[];
-
-#define _ACPI_XA     0x00	/* extra alphabetic - not supported */
-#define _ACPI_XS     0x40	/* extra space */
-#define _ACPI_BB     0x00	/* BEL, BS, etc. - not supported */
-#define _ACPI_CN     0x20	/* CR, FF, HT, NL, VT */
-#define _ACPI_DI     0x04	/* '0'-'9' */
-#define _ACPI_LO     0x02	/* 'a'-'z' */
-#define _ACPI_PU     0x10	/* punctuation */
-#define _ACPI_SP     0x08	/* space, tab, CR, LF, VT, FF */
-#define _ACPI_UP     0x01	/* 'A'-'Z' */
-#define _ACPI_XD     0x80	/* '0'-'9', 'A'-'F', 'a'-'f' */
-
-#define isdigit(c)  (_acpi_ctype[(unsigned char)(c)] & (_ACPI_DI))
-#define isspace(c)  (_acpi_ctype[(unsigned char)(c)] & (_ACPI_SP))
-#define isxdigit(c) (_acpi_ctype[(unsigned char)(c)] & (_ACPI_XD))
-#define isupper(c)  (_acpi_ctype[(unsigned char)(c)] & (_ACPI_UP))
-#define islower(c)  (_acpi_ctype[(unsigned char)(c)] & (_ACPI_LO))
-#define isprint(c)  (_acpi_ctype[(unsigned char)(c)] & (_ACPI_LO | _ACPI_UP | _ACPI_DI | _ACPI_XS | _ACPI_PU))
-#define isalpha(c)  (_acpi_ctype[(unsigned char)(c)] & (_ACPI_LO | _ACPI_UP))
-
-#endif				/* !ACPI_USE_SYSTEM_CLIBRARY */
-
 #define ACPI_IS_ASCII(c)  ((c) < 0x80)
 
 /*
-- 
1.7.10

