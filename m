From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/60] ACPICA: Update math module; no functional change
Date: Mon, 25 Oct 2010 02:20:17 -0400
Message-ID: <e786db75406b30fa74dea095c571c8c164a2f3dd.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:45247 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab0JYGVo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 02:21:44 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU00LSX1O19JX3@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 01:21:38 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Move the 64-bit overlay structures to the utmath module since
they are used nowhere else. Update module comment. ACPICA BZ 829.

http://www.acpica.org/bugzilla/show_bug.cgi?id=829

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/utmath.c |   23 ++++++++++++++++++++---
 include/acpi/actypes.h       |   10 ----------
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpica/utmath.c b/drivers/acpi/acpica/utmath.c
index 35059a1..49cf7b7 100644
--- a/drivers/acpi/acpica/utmath.c
+++ b/drivers/acpi/acpica/utmath.c
@@ -48,11 +48,27 @@
 ACPI_MODULE_NAME("utmath")
 
 /*
- * Support for double-precision integer divide.  This code is included here
- * in order to support kernel environments where the double-precision math
- * library is not available.
+ * Optional support for 64-bit double-precision integer divide. This code
+ * is configurable and is implemented in order to support 32-bit kernel
+ * environments where a 64-bit double-precision math library is not available.
+ *
+ * Support for a more normal 64-bit divide/modulo (with check for a divide-
+ * by-zero) appears after this optional section of code.
  */
 #ifndef ACPI_USE_NATIVE_DIVIDE
+/* Structures used only for 64-bit divide */
+typedef struct uint64_struct {
+	u32 lo;
+	u32 hi;
+
+} uint64_struct;
+
+typedef union uint64_overlay {
+	u64 full;
+	struct uint64_struct part;
+
+} uint64_overlay;
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_short_divide
@@ -69,6 +85,7 @@ ACPI_MODULE_NAME("utmath")
  *              32-bit remainder.
  *
  ******************************************************************************/
+
 acpi_status
 acpi_ut_short_divide(u64 dividend,
 		     u32 divisor, u64 *out_quotient, u32 *out_remainder)
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 864cfae..2b134b6 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -378,16 +378,6 @@ typedef void *acpi_handle;	/* Actually a ptr to a NS Node */
 typedef u8 acpi_owner_id;
 #define ACPI_OWNER_ID_MAX               0xFF
 
-struct uint64_struct {
-	u32 lo;
-	u32 hi;
-};
-
-union uint64_overlay {
-	u64 full;
-	struct uint64_struct part;
-};
-
 #define ACPI_INTEGER_BIT_SIZE           64
 #define ACPI_MAX_DECIMAL_DIGITS         20	/* 2^64 = 18,446,744,073,709,551,616 */
 
-- 
1.7.3.2.90.gd4c43

