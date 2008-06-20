From: Len Brown <lenb@kernel.org>
Subject: [PATCH 25/70] ACPICA: Update disassembler for DMAR table changes
Date: Fri, 20 Jun 2008 03:43:27 -0400
Message-ID: <ee61cb033678eaf16901813eb6394dafa51e9c85.1213947350.git.len.brown@intel.com>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:35149 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbYFTHog (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:44:36 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K2R003MH4687I83@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:44:33 -0500 (CDT)
In-reply-to: <1213947852-10924-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1213947349.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Now supports the 2007 intel Virtualization Technology for Directed
I/O specification.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acdisasm.h |    1 +
 include/acpi/actbl1.h   |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/acpi/acdisasm.h b/include/acpi/acdisasm.h
index 788f887..f53faca 100644
--- a/include/acpi/acdisasm.h
+++ b/include/acpi/acdisasm.h
@@ -162,6 +162,7 @@ extern struct acpi_dmtable_info acpi_dm_table_info_dmar_hdr[];
 extern struct acpi_dmtable_info acpi_dm_table_info_dmar_scope[];
 extern struct acpi_dmtable_info acpi_dm_table_info_dmar0[];
 extern struct acpi_dmtable_info acpi_dm_table_info_dmar1[];
+extern struct acpi_dmtable_info acpi_dm_table_info_dmar2[];
 extern struct acpi_dmtable_info acpi_dm_table_info_ecdt[];
 extern struct acpi_dmtable_info acpi_dm_table_info_einj[];
 extern struct acpi_dmtable_info acpi_dm_table_info_einj0[];
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 715a489..bc47ce5 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -311,6 +311,10 @@ struct acpi_table_dmar {
 	u8 reserved[10];
 };
 
+/* Flags */
+
+#define ACPI_DMAR_INTR_REMAP        (1)
+
 /* DMAR subtable header */
 
 struct acpi_dmar_header {
-- 
1.5.6

