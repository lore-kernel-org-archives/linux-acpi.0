From: Len Brown <lenb@kernel.org>
Subject: [PATCH 37/98] ACPICA: Update table header print function
Date: Sat, 28 Mar 2009 00:31:12 -0400
Message-ID: <b6bc342dd543f40b6feccbaf6719d9f836c9964a.1238214619.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:22330 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752985AbZC1Ecq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:46 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH7006EZ8MINV6I@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:43 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Cleanup table header output.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/tbutils.c |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/tbutils.c b/drivers/acpi/acpica/tbutils.c
index dc45b49..ef7d2c2 100644
--- a/drivers/acpi/acpica/tbutils.c
+++ b/drivers/acpi/acpica/tbutils.c
@@ -177,19 +177,23 @@ acpi_tb_print_table_header(acpi_physical_address address,
 			   struct acpi_table_header *header)
 {
 
+	/*
+	 * The reason that the Address is cast to a void pointer is so that we
+	 * can use %p which will work properly on both 32-bit and 64-bit hosts.
+	 */
 	if (ACPI_COMPARE_NAME(header->signature, ACPI_SIG_FACS)) {
 
-		/* FACS only has signature and length fields of common table header */
+		/* FACS only has signature and length fields */
 
-		ACPI_INFO((AE_INFO, "%4.4s %08lX, %04X",
-			   header->signature, (unsigned long)address,
+		ACPI_INFO((AE_INFO, "%4.4s %p %05X",
+			   header->signature, ACPI_CAST_PTR(void, address),
 			   header->length));
 	} else if (ACPI_COMPARE_NAME(header->signature, ACPI_SIG_RSDP)) {
 
 		/* RSDP has no common fields */
 
-		ACPI_INFO((AE_INFO, "RSDP %08lX, %04X (r%d %6.6s)",
-			   (unsigned long)address,
+		ACPI_INFO((AE_INFO, "RSDP %p %05X (v%.2d %6.6s)",
+			   ACPI_CAST_PTR (void, address),
 			   (ACPI_CAST_PTR(struct acpi_table_rsdp, header)->
 			    revision >
 			    0) ? ACPI_CAST_PTR(struct acpi_table_rsdp,
@@ -202,8 +206,8 @@ acpi_tb_print_table_header(acpi_physical_address address,
 		/* Standard ACPI table with full common header */
 
 		ACPI_INFO((AE_INFO,
-			   "%4.4s %08lX, %04X (r%d %6.6s %8.8s %8X %4.4s %8X)",
-			   header->signature, (unsigned long)address,
+			   "%4.4s %p %05X (v%.2d %6.6s %8.8s %08X %4.4s %08X)",
+			   header->signature, ACPI_CAST_PTR (void, address),
 			   header->length, header->revision, header->oem_id,
 			   header->oem_table_id, header->oem_revision,
 			   header->asl_compiler_id,
-- 
1.6.0.6

