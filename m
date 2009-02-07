From: Len Brown <lenb@kernel.org>
Subject: [PATCH 23/30] ACPI: disable ACPI cleanly when bad RSDP found
Date: Sat, 07 Feb 2009 01:41:31 -0500
Message-ID: <9e3a9d1ed8cc8db93e5c53e9a5b09065bd95de8b.1233988826.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:22518 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbZBGGmD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Feb 2009 01:42:03 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KEO00ELZNY0GHP2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Feb 2009 00:42:01 -0600 (CST)
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

When ACPI is disabled in the BIOS of this VIA C3 box,
it invalidates the RSDP, which Linux notices:

ACPI Error (tbxfroot-0218): A valid RSDP was not found [20080926]

Bug Linux neglected to disable ACPI at that stage,
and later scribbled on smp_found_config:

ACPI: No APIC-table, disabling MPS

But this box doesn't run well in legacy PIC mode,
it needed IOAPIC mode to perform correctly:

http://lkml.org/lkml/2009/2/5/39

So exit ACPI mode cleanly when we first detect
that it is hopeless.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/tables.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 775c97a..a885295 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -293,7 +293,12 @@ static void __init check_multiple_madt(void)
 
 int __init acpi_table_init(void)
 {
-	acpi_initialize_tables(initial_tables, ACPI_MAX_TABLES, 0);
+	acpi_status status;
+
+	status = acpi_initialize_tables(initial_tables, ACPI_MAX_TABLES, 0);
+	if (ACPI_FAILURE(status))
+		return 1;
+
 	check_multiple_madt();
 	return 0;
 }
-- 
1.5.6.6

