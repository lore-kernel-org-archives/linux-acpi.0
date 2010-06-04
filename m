From: Len Brown <lenb@kernel.org>
Subject: [PATCH 13/16] ACPICA: Add signatures for undefined tables: ATKG, GSCI,
 IEIT
Date: Fri, 04 Jun 2010 15:51:43 -0400
Message-ID: <f955beed52f1c552538de2ded3411f2e7aa03ed0.1275680880.git.len.brown@intel.com>
References: <1275681106-8450-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:61797 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756176Ab0FHTmQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jun 2010 15:42:16 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L3P00KKCO2A66I4@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 08 Jun 2010 14:42:15 -0500 (CDT)
In-reply-to: <1275681106-8450-1-git-send-email-lenb@kernel.org>
In-reply-to: <8aa4b14eb023fecaa48d55402e98bdf84b375c4a.1275680880.git.len.brown@intel.com>
References: <8aa4b14eb023fecaa48d55402e98bdf84b375c4a.1275680880.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

These ACPI tables have been seen in the field, but the actual
table definitions are unkown at this time.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/actbl2.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 95f4d0e..0a600b8 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -79,6 +79,15 @@
 #define ACPI_SIG_WDAT           "WDAT"	/* Watchdog Action Table */
 #define ACPI_SIG_WDRT           "WDRT"	/* Watchdog Resource Table */
 
+#ifdef ACPI_UNDEFINED_TABLES
+/*
+ * These tables have been seen in the field, but no definition has been found
+ */
+#define ACPI_SIG_ATKG           "ATKG"
+#define ACPI_SIG_GSCI           "GSCI"	/* GMCH SCI table */
+#define ACPI_SIG_IEIT           "IEIT"
+#endif
+
 /*
  * All tables must be byte-packed to match the ACPI specification, since
  * the tables are provided by the system BIOS.
-- 
1.6.0.6

