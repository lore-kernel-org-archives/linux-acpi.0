From: Len Brown <lenb@kernel.org>
Subject: [PATCH 18/23] ACPICA: Ignore ACPI table signature for Load() operator
Date: Wed, 11 Jun 2008 03:59:21 -0400
Message-ID: <b9365d858a6b17b7d17edbe538d34f8f5b4e7870.1213171095.git.len.brown@intel.com>
References: <1213171166-3951-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:65151 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753700AbYFKH7k (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jun 2008 03:59:40 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2A00DTGGVBY0H6@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 11 Jun 2008 02:59:35 -0500 (CDT)
In-reply-to: <1213171166-3951-1-git-send-email-lenb@kernel.org>
In-reply-to: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
References: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Only "SSDT" is acceptable to the ACPI spec, but tables are
seen with OEMx and null sigs. Therefore, signature validation
is worthless.  Apparently MS ACPI accepts such signatures, ACPICA
must be compatible.

http://bugzilla.kernel.org/show_bug.cgi?id=10454

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/tables/tbinstal.c |   25 +++++++------------------
 1 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/tables/tbinstal.c b/drivers/acpi/tables/tbinstal.c
index 402f93e..5336ce8 100644
--- a/drivers/acpi/tables/tbinstal.c
+++ b/drivers/acpi/tables/tbinstal.c
@@ -123,24 +123,13 @@ acpi_tb_add_table(struct acpi_table_desc *table_desc,
 		}
 	}
 
-	/* The table must be either an SSDT or a PSDT or an OEMx */
-
-	if (!ACPI_COMPARE_NAME(table_desc->pointer->signature, ACPI_SIG_PSDT)&&
-	    !ACPI_COMPARE_NAME(table_desc->pointer->signature, ACPI_SIG_SSDT)&&
-	    strncmp(table_desc->pointer->signature, "OEM", 3)) {
-		/* Check for a printable name */
-		if (acpi_ut_valid_acpi_name(
-			*(u32 *) table_desc->pointer->signature)) {
-			ACPI_ERROR((AE_INFO, "Table has invalid signature "
-					"[%4.4s], must be SSDT or PSDT",
-				    table_desc->pointer->signature));
-		} else {
-			ACPI_ERROR((AE_INFO, "Table has invalid signature "
-					"(0x%8.8X), must be SSDT or PSDT",
-				    *(u32 *) table_desc->pointer->signature));
-		}
-		return_ACPI_STATUS(AE_BAD_SIGNATURE);
-	}
+	/*
+	 * Originally, we checked the table signature for "SSDT" or "PSDT" here.
+	 * Next, we added support for OEMx tables, signature "OEM".
+	 * Valid tables were encountered with a null signature, so we've just
+	 * given up on validating the signature, since it seems to be a waste
+	 * of code. The original code was removed (05/2008).
+	 */
 
 	(void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
 
-- 
1.5.6.rc2.23.gea81e

