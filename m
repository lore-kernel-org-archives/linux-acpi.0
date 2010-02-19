From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2.6.32.stable] ACPI: fix "acpi=ht" boot option
Date: Thu, 18 Feb 2010 23:07:01 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002182305480.17638@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:32981 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754441Ab0BSEHT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Feb 2010 23:07:19 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KY200FF4M3QP3L0@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 18 Feb 2010 22:07:08 -0600 (CST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stable@kernel.org
Cc: linux-acpi@vger.kernel.org

upstream 49bf83a45fc677db1ed44d0e072e6aaeabe4e124
From: Len Brown <len.brown@intel.com>

We broke "acpi=ht" in 2.6.32 by disabling MADT parsing
for acpi=disabled.  e5b8fc6ac158f65598f58dba2c0d52ba3b412f52
This also broke systems which invoked acpi=ht via DMI blacklist.

acpi=ht is a really ugly hack,
but restore it for those that still use it.

http://bugzilla.kernel.org/show_bug.cgi?id=14886

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/ia64/include/asm/acpi.h |    1 +
 drivers/acpi/tables.c        |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/include/asm/acpi.h b/arch/ia64/include/asm/acpi.h
index 7ae5889..e97b255 100644
--- a/arch/ia64/include/asm/acpi.h
+++ b/arch/ia64/include/asm/acpi.h
@@ -94,6 +94,7 @@ ia64_acpi_release_global_lock (unsigned int *lock)
 #define acpi_noirq 0	/* ACPI always enabled on IA64 */
 #define acpi_pci_disabled 0 /* ACPI PCI always enabled on IA64 */
 #define acpi_strict 1	/* no ACPI spec workarounds on IA64 */
+#define acpi_ht 0	/* no HT-only mode on IA64 */
 #endif
 #define acpi_processor_cstate_check(x) (x) /* no idle limits on IA64 :) */
 static inline void disable_acpi(void) { }
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index f336bca..8a0ed28 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -213,7 +213,7 @@ acpi_table_parse_entries(char *id,
 	unsigned long table_end;
 	acpi_size tbl_size;
 
-	if (acpi_disabled)
+	if (acpi_disabled && !acpi_ht)
 		return -ENODEV;
 
 	if (!handler)
@@ -280,7 +280,7 @@ int __init acpi_table_parse(char *id, acpi_table_handler handler)
 	struct acpi_table_header *table = NULL;
 	acpi_size tbl_size;
 
-	if (acpi_disabled)
+	if (acpi_disabled && !acpi_ht)
 		return -ENODEV;
 
 	if (!handler)
-- 
1.7.0.17.g7e5eb

