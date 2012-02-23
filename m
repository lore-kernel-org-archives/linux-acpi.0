From: Julian Anastasov <ja@ssi.bg>
Subject: [PATCH] ACPICA: Fix regression in FADT revision checks
Date: Thu, 23 Feb 2012 22:40:43 +0200
Message-ID: <1330029643-1777-1-git-send-email-ja@ssi.bg>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ja.ssi.bg ([178.16.129.10]:34755 "EHLO ja.ssi.bg"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756347Ab2BWUmE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Feb 2012 15:42:04 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

	commit 64b3db22c04586997ab4be46dd5a5b99f8a2d390 (2.6.39),
"Remove use of unreliable FADT revision field" causes regression
for old P4 systems because now cst_control and other fields are
not reset to 0.

	The effect is that acpi_processor_power_init will notice
cst_control != 0 and a write to CST_CNT register is performed
that should not happen. As result, the system oopses after the
"No _CST, giving up" message, sometimes in acpi_ns_internalize_name,
sometimes in acpi_ns_get_type, usually at random places. May be
during migration to CPU 1 in acpi_processor_get_throttling.

	Every one of these settings help to avoid this problem:
 - acpi=off
 - processor.nocst=1
 - maxcpus=1

	The fix is to update acpi_gbl_FADT.header.length after
the original value is used to check for old revisions.

Signed-off-by: Julian Anastasov <ja@ssi.bg>
---
 drivers/acpi/acpica/tbfadt.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index c5d8704..4c9c760 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -363,10 +363,6 @@ static void acpi_tb_convert_fadt(void)
 	u32 address32;
 	u32 i;
 
-	/* Update the local FADT table header length */
-
-	acpi_gbl_FADT.header.length = sizeof(struct acpi_table_fadt);
-
 	/*
 	 * Expand the 32-bit FACS and DSDT addresses to 64-bit as necessary.
 	 * Later code will always use the X 64-bit field. Also, check for an
@@ -408,6 +404,10 @@ static void acpi_tb_convert_fadt(void)
 		acpi_gbl_FADT.boot_flags = 0;
 	}
 
+	/* Update the local FADT table header length */
+
+	acpi_gbl_FADT.header.length = sizeof(struct acpi_table_fadt);
+
 	/*
 	 * Expand the ACPI 1.0 32-bit addresses to the ACPI 2.0 64-bit "X"
 	 * generic address structures as necessary. Later code will always use
-- 
1.7.3.4

