From: Len Brown <lenb@kernel.org>
Subject: [PATCH 73/94] ACPI: io_common.c: call acpi_get_table to avoid using
 ACPI_SIG_DSDT
Date: Fri, 09 Jan 2009 04:27:15 -0500
Message-ID: <385c4d98d851bc94ad4f351fe25fe49b70b9cf78.1231492611.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:56372 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039AbZAIJ2l (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:41 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD70043269315D6@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:27:04 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

ACPI_SIG_DSDT is acpica internal used only.
call acpi_get_table to avoid using ACPI_SIG_DSDT.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/ia64/sn/kernel/io_common.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/sn/kernel/io_common.c b/arch/ia64/sn/kernel/io_common.c
index 8a924a5..e1917ed 100644
--- a/arch/ia64/sn/kernel/io_common.c
+++ b/arch/ia64/sn/kernel/io_common.c
@@ -473,7 +473,7 @@ sn_io_early_init(void)
 	{
 		struct acpi_table_header *header = NULL;
 
-		acpi_get_table_by_index(ACPI_TABLE_INDEX_DSDT, &header);
+		acpi_get_table(ACPI_SIG_DSDT, 1, &header);
 		BUG_ON(header == NULL);
 		sn_acpi_rev = header->oem_revision;
 	}
@@ -505,7 +505,7 @@ sn_io_early_init(void)
 
 	{
 		struct acpi_table_header *header;
-		(void)acpi_get_table_by_index(ACPI_TABLE_INDEX_DSDT, &header);
+		(void)acpi_get_table(ACPI_SIG_DSDT, 1, &header);
 		printk(KERN_INFO "ACPI  DSDT OEM Rev 0x%x\n",
 			header->oem_revision);
 	}
-- 
1.5.6.6

