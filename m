From: Len Brown <lenb@kernel.org>
Subject: [PATCH 26/98] ACPICA: Fix parameter validation for acpi_read/write
Date: Sat, 28 Mar 2009 00:31:01 -0400
Message-ID: <ac0c84502697114a378057eed83a9baba879cfc9.1238214618.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:34735 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbZC1Ecj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:39 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700EBK8MC9XV1@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:37 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Now return AE_BAD_PARAMETER if the input register pointer is
null, and AE_BAD_ADDRESS if the register has an address of zero.
Previously, these cases simply returned AE_OK. For optional
registers such as PM1B status/enable/control, the caller should
check for a valid register address before calling.  ACPICA BZ 748.

http://www.acpica.org/bugzilla/show_bug.cgi?id=748

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/hwxface.c |   18 ++++++++----------
 include/acpi/acexcep.h        |    6 ++++--
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index ae597c0..f67562e 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -107,19 +107,18 @@ acpi_status acpi_read(u32 *value, struct acpi_generic_address *reg)
 	ACPI_FUNCTION_NAME(acpi_read);
 
 	/*
-	 * Must have a valid pointer to a GAS structure, and
-	 * a non-zero address within. However, don't return an error
-	 * because the PM1A/B code must not fail if B isn't present.
+	 * Must have a valid pointer to a GAS structure, and a non-zero address
+	 * within.
 	 */
 	if (!reg) {
-		return (AE_OK);
+		return (AE_BAD_PARAMETER);
 	}
 
 	/* Get a local copy of the address. Handles possible alignment issues */
 
 	ACPI_MOVE_64_TO_64(&address, &reg->address);
 	if (!address) {
-		return (AE_OK);
+		return (AE_BAD_ADDRESS);
 	}
 
 	/* Supported widths are 8/16/32 */
@@ -187,19 +186,18 @@ acpi_status acpi_write(u32 value, struct acpi_generic_address *reg)
 	ACPI_FUNCTION_NAME(acpi_write);
 
 	/*
-	 * Must have a valid pointer to a GAS structure, and
-	 * a non-zero address within. However, don't return an error
-	 * because the PM1A/B code must not fail if B isn't present.
+	 * Must have a valid pointer to a GAS structure, and a non-zero address
+	 * within.
 	 */
 	if (!reg) {
-		return (AE_OK);
+		return (AE_BAD_PARAMETER);
 	}
 
 	/* Get a local copy of the address. Handles possible alignment issues */
 
 	ACPI_MOVE_64_TO_64(&address, &reg->address);
 	if (!address) {
-		return (AE_OK);
+		return (AE_BAD_ADDRESS);
 	}
 
 	/* Supported widths are 8/16/32 */
diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index eda0454..473d584 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -103,8 +103,9 @@
 #define AE_BAD_OCTAL_CONSTANT           (acpi_status) (0x0006 | AE_CODE_PROGRAMMER)
 #define AE_BAD_DECIMAL_CONSTANT         (acpi_status) (0x0007 | AE_CODE_PROGRAMMER)
 #define AE_MISSING_ARGUMENTS            (acpi_status) (0x0008 | AE_CODE_PROGRAMMER)
+#define AE_BAD_ADDRESS                  (acpi_status) (0x0009 | AE_CODE_PROGRAMMER)
 
-#define AE_CODE_PGM_MAX                 0x0008
+#define AE_CODE_PGM_MAX                 0x0009
 
 /*
  * Acpi table exceptions
@@ -224,7 +225,8 @@ char const *acpi_gbl_exception_names_pgm[] = {
 	"AE_BAD_HEX_CONSTANT",
 	"AE_BAD_OCTAL_CONSTANT",
 	"AE_BAD_DECIMAL_CONSTANT",
-	"AE_MISSING_ARGUMENTS"
+	"AE_MISSING_ARGUMENTS",
+	"AE_BAD_ADDRESS"
 };
 
 char const *acpi_gbl_exception_names_tbl[] = {
-- 
1.6.0.6

