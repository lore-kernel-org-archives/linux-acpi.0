From: Len Brown <lenb@kernel.org>
Subject: [PATCH 21/98] ACPICA: Check for non-zero address before being
 converted to GAS
Date: Sat, 28 Mar 2009 00:30:56 -0400
Message-ID: <5e053e77f233342b56fda419d347fd2c958b9849.1238214618.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:64533 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbZC1Ecu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:50 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700MUD8M9TPCX@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:35 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

Reported-by: FreeBSD community
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/tbfadt.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index a8191ef..43fe886 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -618,12 +618,14 @@ static void acpi_tb_setup_fadt_registers(void)
 		    ACPI_ADD_PTR(struct acpi_generic_address, &acpi_gbl_FADT,
 				 fadt_pm_info_table[i].source);
 
-		acpi_tb_init_generic_address(fadt_pm_info_table[i].target,
-					     source64->space_id,
-					     pm1_register_byte_width,
-					     source64->address +
-					     (fadt_pm_info_table[i].
-					      register_num *
-					      pm1_register_byte_width));
+		if (source64->address) {
+			acpi_tb_init_generic_address(fadt_pm_info_table[i].
+						     target, source64->space_id,
+						     pm1_register_byte_width,
+						     source64->address +
+						     (fadt_pm_info_table[i].
+						      register_num *
+						      pm1_register_byte_width));
+		}
 	}
 }
-- 
1.6.0.6

