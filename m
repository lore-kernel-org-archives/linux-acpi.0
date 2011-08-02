From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/27] ACPICA: Load operator: re-instate most restrictions on
 incoming table signature
Date: Tue, 02 Aug 2011 16:53:03 -0400
Message-ID: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
References: <1312318409-29363-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:49219 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755313Ab1HBUx5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Aug 2011 16:53:57 -0400
Received: from localhost.localdomain ([unknown] [65.175.195.226])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LPB0092UJDDMMV5@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 02 Aug 2011 15:53:43 -0500 (CDT)
In-reply-to: <1312318409-29363-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Now, only allow "SSDT" "OEM", and a null signature.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/tbinstal.c |   27 ++++++++++++++++++++++-----
 1 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 48db094..62365f6 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -126,12 +126,29 @@ acpi_tb_add_table(struct acpi_table_desc *table_desc, u32 *table_index)
 	}
 
 	/*
-	 * Originally, we checked the table signature for "SSDT" or "PSDT" here.
-	 * Next, we added support for OEMx tables, signature "OEM".
-	 * Valid tables were encountered with a null signature, so we've just
-	 * given up on validating the signature, since it seems to be a waste
-	 * of code. The original code was removed (05/2008).
+	 * Validate the incoming table signature.
+	 *
+	 * 1) Originally, we checked the table signature for "SSDT" or "PSDT".
+	 * 2) We added support for OEMx tables, signature "OEM".
+	 * 3) Valid tables were encountered with a null signature, so we just
+	 *    gave up on validating the signature, (05/2008).
+	 * 4) We encountered non-AML tables such as the MADT, which caused
+	 *    interpreter errors and kernel faults. So now, we once again allow
+	 *    only "SSDT", "OEMx", and now, also a null signature. (05/2011).
 	 */
+	if ((table_desc->pointer->signature[0] != 0x00) &&
+	    (!ACPI_COMPARE_NAME(table_desc->pointer->signature, ACPI_SIG_SSDT))
+	    && (ACPI_STRNCMP(table_desc->pointer->signature, "OEM", 3))) {
+		ACPI_ERROR((AE_INFO,
+			    "Table has invalid signature [%4.4s] (0x%8.8X), must be SSDT or OEMx",
+			    acpi_ut_valid_acpi_name(*(u32 *)table_desc->
+						    pointer->
+						    signature) ? table_desc->
+			    pointer->signature : "????",
+			    *(u32 *)table_desc->pointer->signature));
+
+		return_ACPI_STATUS(AE_BAD_SIGNATURE);
+	}
 
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 
-- 
1.7.6.396.ge0613

