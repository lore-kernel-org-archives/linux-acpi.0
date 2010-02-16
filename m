From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/10] ACPI: fix "acpi=ht" boot option
Date: Tue, 16 Feb 2010 04:46:07 -0500
Message-ID: <f543ebdcbca887886417793ded9e8b71b4436e55.1266313501.git.len.brown@intel.com>
References: <1266313570-6490-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:57033 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756829Ab0BPJqR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2010 04:46:17 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KXX00H8QHT4YVJ0@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 16 Feb 2010 03:46:17 -0600 (CST)
In-reply-to: <1266313570-6490-1-git-send-email-lenb@kernel.org>
In-reply-to: <0406ad336c066190770cbf350b552d608e43ed09.1266313501.git.len.brown@intel.com>
References: <0406ad336c066190770cbf350b552d608e43ed09.1266313501.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

We broke "acpi=ht" in 2.6.32 by disabling MADT parsing
for acpi=disabled.  e5b8fc6ac158f65598f58dba2c0d52ba3b412f52
This also broke systems which invoked acpi=ht via DMI blacklist.

acpi=ht is a really ugly hack,
but restore it for those that still use it.

http://bugzilla.kernel.org/show_bug.cgi?id=14886

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/tables.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

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
1.6.0.6

