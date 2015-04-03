From: Bob Paauwe <bob.j.paauwe@intel.com>
Subject: [PATCH 2/2] Acutally unload a table.
Date: Fri,  3 Apr 2015 09:07:49 -0700
Message-ID: <1428077269-12764-3-git-send-email-bob.j.paauwe@intel.com>
References: <1428077269-12764-1-git-send-email-bob.j.paauwe@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:5396 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752208AbbDCQGC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 3 Apr 2015 12:06:02 -0400
In-Reply-To: <1428077269-12764-1-git-send-email-bob.j.paauwe@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: Bob Paauwe <bob.j.paauwe@intel.com>

Instead of simply marking it as unloaded.  If a table is dynamically
loaded by a module and the module is then unloaded, the table is no
longer valid so it's best to make sure it is unloaded.

Signed-off-by: Bob Paauwe <bob.j.paauwe@intel.com>
---
 drivers/acpi/acpica/tbxfload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxfload.c
index aadb300..ce75ca2 100644
--- a/drivers/acpi/acpica/tbxfload.c
+++ b/drivers/acpi/acpica/tbxfload.c
@@ -408,6 +408,7 @@ acpi_status acpi_unload_parent_table(acpi_handle object)
 
 		status = acpi_tb_release_owner_id(i);
 		acpi_tb_set_table_loaded_flag(i, FALSE);
+		acpi_tb_uninstall_table(&acpi_gbl_root_table_list.tables[i]);
 		break;
 	}
 
-- 
2.1.0

