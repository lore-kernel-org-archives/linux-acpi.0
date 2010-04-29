From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH] acpi: fix early DSDT dmi check warnings on ia64
Date: Thu, 29 Apr 2010 09:42:34 +0800
Message-ID: <1272505354.9950.16.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53861 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754757Ab0D2Bld (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Apr 2010 21:41:33 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, tony.luck@intel.com
Cc: linux-acpi <linux-acpi@vger.kernel.org>

From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH] acpi: fix early DSDT dmi check warnings on ia64

Tony Luck saw a lot of warning messages on ia64:
WARNING: at drivers/firmware/dmi_scan.c:423 dmi_matches+0x70/0x160()
dmi check: not initialized yet.

This is caused by commit aa2110c(ACPI: add boot option acpi=copy_dsdt to fix corrupt DSDT).
DMI is not initialized yet in acpi_early_init.
This patch checks the availability of DMI to avoid the warnings.

Tested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/bus.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 49af19b..047de07 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -847,8 +847,10 @@ void __init acpi_early_init(void)
 	/*
 	 * If the machine falls into the DMI check table,
 	 * DSDT will be copied to memory
+	 * Only check x86, it's too early to check dmi for ia64
 	 */
-	dmi_check_system(dsdt_dmi_table);
+	if (dmi_available)
+		dmi_check_system(dsdt_dmi_table);
 
 	status = acpi_reallocate_root_table();
 	if (ACPI_FAILURE(status)) {


