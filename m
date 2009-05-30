From: Len Brown <lenb@kernel.org>
Subject: [PATCH 13/65] ACPICA: Cleanup byte/word/dword extraction macros,
 fix possible warnings
Date: Fri, 29 May 2009 21:41:51 -0400
Message-ID: <35d7c1cfe5262480d3d8e6ccd7e4caf3a9c8ab39.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:61693 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755503AbZE3Bmt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:42:49 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00K9XOREJRW3@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:51 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Removed unnecessary masking. For the 64-bit macros, removed
the structure overlay. Fixes aliasing warnings seen with gcc 4+
compilers.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/actypes.h |   20 ++++++--------------
 1 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index f555d92..37ba576 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -429,20 +429,12 @@ typedef unsigned long long acpi_integer;
 
 /* Data manipulation */
 
-#define ACPI_LOWORD(l)                  ((u16)(u32)(l))
-#define ACPI_HIWORD(l)                  ((u16)((((u32)(l)) >> 16) & 0xFFFF))
-#define ACPI_LOBYTE(l)                  ((u8)(u16)(l))
-#define ACPI_HIBYTE(l)                  ((u8)((((u16)(l)) >> 8) & 0xFF))
-
-/* Full 64-bit integer must be available on both 32-bit and 64-bit platforms */
-
-struct acpi_integer_overlay {
-	u32 lo_dword;
-	u32 hi_dword;
-};
-
-#define ACPI_LODWORD(integer)           (ACPI_CAST_PTR (struct acpi_integer_overlay, &integer)->lo_dword)
-#define ACPI_HIDWORD(integer)           (ACPI_CAST_PTR (struct acpi_integer_overlay, &integer)->hi_dword)
+#define ACPI_LOBYTE(integer)            ((u8)   (u16)(integer))
+#define ACPI_HIBYTE(integer)            ((u8) (((u16)(integer)) >> 8))
+#define ACPI_LOWORD(integer)            ((u16)  (u32)(integer))
+#define ACPI_HIWORD(integer)            ((u16)(((u32)(integer)) >> 16))
+#define ACPI_LODWORD(integer64)         ((u32)  (u64)(integer64))
+#define ACPI_HIDWORD(integer64)         ((u32)(((u64)(integer64)) >> 32))
 
 #define ACPI_SET_BIT(target,bit)        ((target) |= (bit))
 #define ACPI_CLEAR_BIT(target,bit)      ((target) &= ~(bit))
-- 
1.6.0.6

